
import 'package:BikeCrossing/models/profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfileNotifier extends StateNotifier<UserProfileModel> {
  UserProfileNotifier() : super(UserProfileModel.defaultUser);

  Future<void> getCurrentProfile() async {
    //TODO: get current user profile from supabase
    await Future.delayed(const Duration(seconds: 1));
    state = UserProfileModel.sampleUser;
  }
}

final userProfileProvider = StateNotifierProvider<UserProfileNotifier,UserProfileModel>(
        (ref) => UserProfileNotifier());
