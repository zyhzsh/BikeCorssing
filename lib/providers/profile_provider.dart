import 'package:BikeCrossing/models/profile_model.dart';
import 'package:BikeCrossing/models/rental_contract_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class UserProfileNotifier extends StateNotifier<UserProfileModel> {
  UserProfileNotifier() : super(UserProfileModel.defaultUser);

  Future<void> getCurrentProfile() async {
    final user = Supabase.instance.client.auth.currentUser;
    //TODO: get current user profile from Backend API
    //Mocking Data Fetch
    await Future.delayed(Duration(milliseconds: 200));
    final id = user!.id;
    final userName = user.userMetadata!['name'];
    final avatarUrl = user.userMetadata!['avatar_url'];
    state = UserProfileModel(
      id: id,
      userName: userName,
      avatarUrl: avatarUrl,
      remainingPoints: 2200,
      favoriteBikes: [],
      rentalContracts: [],
    );
  }

  void updateFavoriteBike(String bikeId) {
    final isFavoriteBike = state.favoriteBikes.contains(bikeId);
    final favoriteBikes = [...state.favoriteBikes];
    if (isFavoriteBike) {
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
      rentalContracts: state.rentalContracts,
    );
    state = newState;
  }

  Future<UserProfileModel> getProfileById(String donorId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final profile = UserProfileModel.sampleUsers
        .firstWhere((profile) => profile.id == donorId);
    return profile;
  }

  void assignRentalContract(RentalContractModel contract) async {
    //TODO API call to Approval RentalContract;
    await Future.delayed(Duration(milliseconds: 200));
    final upDatedRentalContracts = [...state.rentalContracts];
    contract.updateContractStatus(ContractStatus.approved);
    upDatedRentalContracts.add(contract);
    final newState = UserProfileModel(
      id: state.id,
      userName: state.userName,
      avatarUrl: state.avatarUrl,
      remainingPoints: state.remainingPoints,
      favoriteBikes: state.favoriteBikes,
      rentalContracts: upDatedRentalContracts,
      currentContract: contract
    );
    state = newState;
  }

  void terminatedRentalContract()async{
    final upDatedCurrentContract = state.currentContract;
    if(upDatedCurrentContract!=null){
      //TODO API call to Terminated RentalContract;
      upDatedCurrentContract.updateContractStatus(ContractStatus.terminated);
      final upDatedRentalContracts = [...state.rentalContracts.map((contract) {
        if(contract.id == contract.id){
          return upDatedCurrentContract;
        }
        return contract;
      })];
      final newState = UserProfileModel(
        id: state.id,
        userName: state.userName,
        avatarUrl: state.avatarUrl,
        remainingPoints: state.remainingPoints,
        favoriteBikes: state.favoriteBikes,
        rentalContracts: upDatedRentalContracts,
        currentContract: null,
      );
      state = newState;
    }
  }

  void activeRentalContract()async{
    //TODO API call to Active RentalContract;
    final upDatedCurrentContract = state.currentContract;
    upDatedCurrentContract!.updateContractStatus(ContractStatus.active);
    final upDatedRentalContracts = [...state.rentalContracts.map((contract) {
      if(contract.id == contract.id){
        return upDatedCurrentContract;
      }
      return contract;
    })];
    final newState = UserProfileModel(
      id: state.id,
      userName: state.userName,
      avatarUrl: state.avatarUrl,
      remainingPoints: state.remainingPoints,
      favoriteBikes: state.favoriteBikes,
      rentalContracts: upDatedRentalContracts,
      currentContract: upDatedCurrentContract!,
    );
     state = newState;
  }
}

final userProfileProvider =
    StateNotifierProvider<UserProfileNotifier, UserProfileModel>(
        (ref) => UserProfileNotifier());
