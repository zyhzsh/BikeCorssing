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

  static UserProfileModel defaultUser = const UserProfileModel(
    id: 'sample-0',
    userName: 'John Doe',
    avatarUrl:
    'https://placebear.com/250/250',
    remainingPoints: 2250,
    favoriteBikes: [],
  );
  static UserProfileModel sampleUser = const UserProfileModel(
    id: 'sample-1',
    userName: 'Tommy',
    avatarUrl:
    'https://i.pravatar.cc/250?u=mail@ashallendesign.co.uk',
    remainingPoints: 2250,
    favoriteBikes: [],
  );
  static UserProfileModel sampleUser2 = const UserProfileModel(
    id: 'sample-2',
    userName: 'Kimmy',
    avatarUrl:
    'https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250',
    remainingPoints: 100,
    favoriteBikes: [],
  );


  static List<UserProfileModel> sampleUsers = [
    defaultUser,
    sampleUser,
    sampleUser2,
  ];
}