
import 'package:BikeCrossing/models/profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfileNotifier extends StateNotifier<UserProfileModel> {
  UserProfileNotifier() : super(UserProfileModel.defaultUser);

  Future<void> getCurrentProfile() async {
    //TODO: get current user profile from supabase
    await Future.delayed(const Duration(seconds: 1));
    state = UserProfileModel.sampleUser;
  }

  void updateFavoriteBike(String bikeId) {
    final isFavoriteBike = state.favoriteBikes.contains(bikeId);
    final favoriteBikes = [...state.favoriteBikes];
    if(isFavoriteBike) {
      favoriteBikes.remove(bikeId);
    } else {
      favoriteBikes.add(bikeId);
    }
   final newState = UserProfileModel(
      id: state.id,
      userName: state.userName,
      avatarUrl: state.avatarUrl,
      remainingPoints: state.remainingPoints,
      favoriteBikes: favoriteBikes,
    );
    state = newState;
  }
}

final userProfileProvider = StateNotifierProvider<UserProfileNotifier,UserProfileModel>(
        (ref) => UserProfileNotifier(
        ));
