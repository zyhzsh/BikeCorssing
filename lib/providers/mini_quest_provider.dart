import 'dart:io';
import 'dart:math';
import 'package:BikeCrossing/models/mini_quest_model.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var uuid = Uuid();

class MiniQuestNotifier extends StateNotifier<List<MiniQuestModel>> {
  MiniQuestNotifier() : super(MiniQuestModel.getSampleMiniQuests('bikeId'));
  void getMiniQuests(String bikeId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final miniQuests = MiniQuestModel.getSampleMiniQuests(bikeId);
    state = miniQuests;
  }
  void finishMiniQuest(MiniQuestModel miniQuest) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final miniQuests = MiniQuestModel.modifyMiniQuests(miniQuest.bikeId, miniQuest.typeOfRecord);
    state = miniQuests;
  }
}

final miniQuestProvider = StateNotifierProvider<MiniQuestNotifier, List<MiniQuestModel>>(
        (ref) => MiniQuestNotifier());
