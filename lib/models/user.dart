class UserModel {
  final String id;
  final String name;
  final String? profileImage;
  final int? age;
  final String? bio;
  final String? city;
  int bookBuddyCount;

  UserModel({
    required this.id,
    required this.name,
    this.profileImage,
    this.age,
    this.bio,
    this.city,
    this.bookBuddyCount = 0,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      profileImage: json['profileImage'],
      age: json['age'],
      bio: json['bio'],
      city: json['city'],
      bookBuddyCount: json['bookBuddyCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profileImage': profileImage,
      'age': age,
      'bio': bio,
      'city': city,
    };
  }
}

class BookBuddy {
  final UserModel userInfo;
  final DateTime requestTime;
  final int commonSubjectCount;

  BookBuddy({
    required this.userInfo,
    required this.requestTime,
    required this.commonSubjectCount,
  });

  factory BookBuddy.fromJson(Map<String, dynamic> json) {
    return BookBuddy(
      userInfo: UserModel.fromJson(json['userResponse']),
      requestTime: DateTime.parse(json['timestamp']),
      commonSubjectCount: json['commonSubjectCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userResponse': userInfo.toJson(),
      'timestamp': requestTime.toIso8601String(),
      'commonSubjectCount': commonSubjectCount,
    };
  }  

}

class GetBookBuddy {
  final String id;
  final String name;
  final int age;
  final String bio;
  final String city;
  final String profileImage;
  final int commonSubjectCount;

  GetBookBuddy({
    required this.id,
    required this.name,
    required this.age,
    required this.bio,
    required this.city,
    required this.profileImage,
    required this.commonSubjectCount,
  });

  factory GetBookBuddy.fromJson(Map<String, dynamic> json) {
    return GetBookBuddy(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      bio: json['bio'],
      city: json['city'],
      profileImage: json['profileImage'],
      commonSubjectCount: json['commonSubjectCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'bio': bio,
      'city': city,
      'profileImage': profileImage,
      'commonSubjectCount': commonSubjectCount,
    };
  }
}
