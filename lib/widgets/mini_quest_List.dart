import 'dart:io';
import 'dart:math';

import 'package:BikeCrossing/providers/bikes_provider.dart';
import 'package:BikeCrossing/providers/location_provider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import '../models/history_record_model.dart';
import '../models/mini_quest_model.dart';
import '../providers/mini_quest_provider.dart';
import '../providers/profile_provider.dart';
import 'image_input.dart';

class MiniQuestList extends ConsumerStatefulWidget {
  const MiniQuestList({Key? key}) : super(key: key);

  @override
  ConsumerState<MiniQuestList> createState() => _MiniQuestListState();
}

class _MiniQuestListState extends ConsumerState<MiniQuestList> {
  List<MiniQuestModel> miniQuests = [];
  List<bool> expansionStatus = [];

  void onFinishedMiniQuest(MiniQuestModel quest) {
    ref.read(miniQuestProvider.notifier).finishMiniQuest(quest);
    setState(() {
      miniQuests.remove(quest);
    });
  }

  void getMiniQuests() async {
    final bikeId = ref.read(userProfileProvider).currentContract!.bikeId;
    final quests = MiniQuestModel.getSampleMiniQuests(bikeId);
    setState(() {
      miniQuests = quests.where((element) {
        expansionStatus.add(false);
        return element.completionStatus == false;
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getMiniQuests();
  }

  @override
  Widget build(BuildContext context) {


    return SingleChildScrollView(
      child: Column(
        children: [
          ExpansionPanelList(
            expandedHeaderPadding: EdgeInsets.zero,
            expansionCallback: (i, isOpen) => {
              setState(() {
                expansionStatus[i] = !isOpen;
              })
            },
            children: [
              ...miniQuests.mapIndexed(
                (index, quest) => ExpansionPanel(
                    canTapOnHeader: true,
                    headerBuilder: (context, isExpanded) => Row(
                          children: [
                            const SizedBox(width: 5),
                            quest.icon,
                            // Icon(Icons.circle,
                            //     color: Theme.of(context).colorScheme.primary),
                            const SizedBox(width: 5),
                            Text(quest.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    )),
                            const Spacer(),
                            Text('+ ${quest.earningPoints}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold)),
                          ],
                        ),
                    body: Column(
                      children: [
                        Row(children: [
                          const SizedBox(width: 10),
                          Text(quest.subtitle,
                              style: Theme.of(context).textTheme.bodySmall),
                        ]),
                        quest.typeOfRecord == TypeOfRecord.repairMaintenance
                            ? const _RepairMaintenanceForm()
                            : quest.typeOfRecord == TypeOfRecord.selfMaintenance
                                ? const _SelfMaintenanceForm()
                                : quest.typeOfRecord == TypeOfRecord.storyShare
                                    ? _StoryShareForm(
                                        quest: quest,
                                        onFinished: onFinishedMiniQuest)
                                    : const SizedBox(),
                      ],
                    ),
                    isExpanded: expansionStatus[index]),
              )
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _SelfMaintenanceForm extends StatelessWidget {
  const _SelfMaintenanceForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _RepairMaintenanceForm extends StatelessWidget {
  const _RepairMaintenanceForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _StoryShareForm extends ConsumerStatefulWidget {
  const _StoryShareForm({
    required this.onFinished,
    required this.quest,
    super.key,
  });

  final MiniQuestModel quest;
  final void Function(MiniQuestModel quest) onFinished;

  @override
  _StoryShareFormState createState() => _StoryShareFormState();
}

class _StoryShareFormState extends ConsumerState<_StoryShareForm> {
  final _textContentController = TextEditingController();
  List<File> images = [];
  bool _isSubmittedAble = true;

  @override
  void dispose() {
    _textContentController.dispose();
    super.dispose();
  }

  void _addImage(File pickedImage) {
    setState(() {
      images.add(pickedImage);
    });
  }

  void _removeImage(File pickedImage) {
    setState(() {
      images.remove(pickedImage);
    });
  }

  void _submitForm() async {
    final user = ref.read(userProfileProvider.notifier).state;
    final bikeId = user.currentContract!.bikeId;
    final textContent = _textContentController.text;
    List<String> uploadedImages = [];

    if (textContent.isEmpty || images.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'To finish this quest, please enter some text and add some images.'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }
    try {
      setState(() {
        _isSubmittedAble = false;
      });
      uploadedImages = await ref
          .read(bikesProvider.notifier)
          .uploadBikeImages(bikeId, images);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload images.'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
      return;
    }
    final location =
        await ref.read(userLocationProvider.notifier).getCurrentLocation();
    final newRecord = HistoryRecordModel(
      location: location,
      bikeId: bikeId,
      userId: user.id,
      recordType: TypeOfRecord.storyShare,
      imgUrls: uploadedImages,
      content: textContent,
    );
    try {
      await ref.read(bikesProvider.notifier).addBikeHistoryRecord(newRecord);
      widget.onFinished(widget.quest);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit quest.'),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSubmittedAble = true;
        });
      }
    }

    //Wait for submit

    //update UI
  }

  @override
  Widget build(BuildContext context) {
    Widget imageInputs = ListView.separated(
      scrollDirection: Axis.horizontal,
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(width: 10);
      },
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index) {
        return ImageInput(
          width: 100,
          height: 100,
          currentImage: images[index],
          onSelectImage: _addImage,
          onRemoveImage: _removeImage,
        );
      },
    );
    if (images.length <= 3) {
      imageInputs = ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(width: 10);
        },
        itemCount: images.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == images.length) {
            return ImageInput(
              width: 100,
              height: 100,
              onSelectImage: _addImage,
              onRemoveImage: _removeImage,
            );
          }
          return ImageInput(
            width: 100,
            height: 100,
            currentImage: images[index],
            onSelectImage: _addImage,
            onRemoveImage: _removeImage,
          );
        },
      );
    }
    if (images.isEmpty) {
      imageInputs = ImageInput(
        width: 100,
        height: 100,
        onSelectImage: _addImage,
        onRemoveImage: _removeImage,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          height: 100,
          child: imageInputs,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(10),
          ),
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: _textContentController,
            maxLength: 150,
            maxLines: 10,
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: 'Share your story.'),
          ),
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _isSubmittedAble ? _submitForm : null,
                child: const Text('Submit')),
            const SizedBox(width: 10),
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
