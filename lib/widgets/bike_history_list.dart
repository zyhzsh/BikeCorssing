import 'package:BikeCrossing/utilities/bike_history_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/history_record_model.dart';
import '../models/profile_model.dart';
import '../providers/profile_provider.dart';

class BikeHistoryList extends ConsumerWidget {
  const BikeHistoryList({
    super.key,
    required this.historyRecords,
  });

  final List<HistoryRecordModel> historyRecords;

  Map<String, List<HistoryRecordModel>> getHistoryChunk() {
    Map<String, List<HistoryRecordModel>> historyChunk = {};
    List<String> userIds = [];
    List<HistoryRecordModel> tempHrs;
    String currentUserId = '';
    historyRecords.forEach((hr) {
      if (hr.userId != currentUserId) {
        userIds.add(hr.userId);
        currentUserId = hr.userId;
      }
    });
    for (String userId in userIds) {
      tempHrs = [];
      for (HistoryRecordModel hr in historyRecords) {
        if (hr.userId == userId) {
          tempHrs.add(hr);
        }
        historyChunk[userId] = tempHrs;
      }
    }
    return historyChunk;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double currentWidth = MediaQuery.of(context).size.width;
    double currentHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
        child: Column(
          children: [
            ...getHistoryChunk().keys.map((userId) {
              final getUser =
              ref.read(userProfileProvider.notifier).getProfileById(userId);
              return Column(children: [
                Row(
                  children: [
                    FutureBuilder(
                        future: getUser,
                        builder: (ctx, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            UserProfileModel user =
                            snapshot.data as UserProfileModel;
                            return Row(
                              children: [
                                SizedBox(width: currentWidth * 0.02),
                                CircleAvatar(
                                  backgroundImage: NetworkImage(user.avatarUrl),
                                ),
                                SizedBox(width: currentWidth * 0.02),
                                Text(user.userName,
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold)),
                              ],
                            );
                          }
                          return Text('...');
                        }),
                  ],
                ),
                ...getHistoryChunk()[userId]!.map((hr) {
                  return Card(
                    elevation: 7,
                    margin: EdgeInsets.symmetric(
                        horizontal: currentWidth * 0.02,
                        vertical: currentHeight * 0.01),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          // trailing: Text(hr.location.address),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              hr.recordType.getIcon(),
                              SizedBox(width: currentWidth * 0.02),
                              Text(hr.createdAt.year.toString() +
                                  '-' +
                                  hr.createdAt.month.toString() +
                                  '-' +
                                  hr.createdAt.day.toString()),
                            ],
                          ),
                          subtitle: Text(hr.content,style: Theme.of(context).textTheme.bodyLarge,),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: currentWidth * 0.03),
                          child: Row(
                            children: [
                              Icon(Icons.location_on_outlined),
                              Text(hr.location.address,style: Theme.of(context).textTheme.labelSmall!.copyWith(),),
                            ],
                          ),
                        ),
                        hr.imgUrls.length > 0
                            ? Container(
                          height: currentHeight * 0.3,
                          padding: EdgeInsets.symmetric(
                              horizontal: currentWidth * 0.02,
                              vertical: currentHeight * 0.01),
                          child: ListView.separated(
                            separatorBuilder: (ctx, index) =>
                                SizedBox(width: currentWidth * 0.02),
                            scrollDirection: Axis.horizontal,
                            itemCount: hr.imgUrls.length,
                            itemBuilder: (ctx, index) {
                              double width = hr.imgUrls.length == 1
                                  ? currentWidth
                                  : hr.imgUrls.length == 2
                                  ? currentWidth * 0.5
                                  : currentWidth * 0.3;
                              return Container(
                                width: width,
                                child: FadeInImage(
                                  placeholder: MemoryImage(kTransparentImage),
                                  image: NetworkImage(hr.imgUrls[index]),
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                        )
                            : SizedBox(height: currentHeight * 0.01),
                      ],
                    ),
                  );
                }).toList(),
              ]);
            }),
            SizedBox(height: currentHeight * 0.1),
          ],
        ));
  }
}

