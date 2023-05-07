class UserProfileModel {
  final String id;
  final String userName;
  final String avatarUrl;
  final int remainingPoints;
  final List<String> favoriteBikes;
  const UserProfileModel({
    required this.id,
    required this.userName,
    required this.avatarUrl,
    required this.remainingPoints,
    required this.favoriteBikes,
  });
  static UserProfileModel sampleUser = const UserProfileModel(
    id: 'sample-1',
    userName: 'John Doe',
    avatarUrl:
        'https://images.unsplash.com/photo-1507035895480-2b3156c31fc8',
    remainingPoints: 1200,
    favoriteBikes: [],
  );
  static UserProfileModel defaultUser = const UserProfileModel(
    id: 'sample-1',
    userName: 'John Doe',
    avatarUrl:
    'https://images.unsplash.com/photo-1507035895480-2b3156c31fc8',
    remainingPoints: 2250,
    favoriteBikes: [],
  );
}