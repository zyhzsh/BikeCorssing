
import 'package:BikeCrossing/models/profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class UserProfileNotifier extends StateNotifier<UserProfileModel> {
  UserProfileNotifier() : super(UserProfileModel.defaultUser);

  Future<void> getCurrentProfile() async {
    //TODO: get current user profile from supabase
    await Future.delayed(const Duration(milliseconds: 200));
    final user = await Supabase.instance.client.auth.currentUser;
    final id = user!.id;
    final userName = user.userMetadata!['name'];
    final avatarUrl = user.userMetadata!['avatar_url'];
    state =
      UserProfileModel(
        id: id,
        userName: userName,
        avatarUrl: avatarUrl,
        remainingPoints: 2200,
        favoriteBikes: [],
      );
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

  Future<UserProfileModel> getProfileById(String donorId) async{
    await Future.delayed(const Duration(milliseconds: 200));
    final profile = UserProfileModel.sampleUsers.firstWhere((profile) => profile.id == donorId);
    return profile;
  }
}

final userProfileProvider = StateNotifierProvider<UserProfileNotifier,UserProfileModel>(
        (ref) => UserProfileNotifier(
        ));
