import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  final int age;
  final List<Map<String, dynamic>> imageUrls;
  final List<dynamic>? interests;
  final String bio;
  final String jobTitle;
  final String location;
  final String gender;
  final List<String>? swipeRight;
  final List<String>? swipeLeft;
  final List<Map<String, dynamic>>? matches;
  final List<dynamic>? genderPrefered;
  final List<dynamic>? agePrefered;

  const User(
      {required this.id,
      required this.name,
      required this.age,
      required this.imageUrls,
      required this.bio,
      this.interests = const [],
      required this.jobTitle,
      required this.location,
      required this.gender,
      this.swipeRight,
      this.swipeLeft,
      this.matches,
      this.genderPrefered,
      this.agePrefered});

  List<Object?> get props => [
        id,
        name,
        age,
        imageUrls,
        interests,
        bio,
        jobTitle,
        location,
        swipeLeft,
        swipeRight,
        matches
      ];

  static User fromSnapshot(DocumentSnapshot snap) {
    var data = snap.data() as Map<String, dynamic>?;
    List<dynamic> userGenderPrefered = [];
    List<dynamic> userAgePrefered = [];

    if (data != null) {
      userGenderPrefered = (data['genderPrefered'] == null)
          ? ['Male']
          : ((data['genderPrefered'] ?? []) as List)
              .map((gender) => gender as String)
              .toList();

      userAgePrefered = (data['agePrefered'] == null)
          ? [19, 40]
          : ((data['agePrefered'] ?? []) as List)
              .map((age) => age as int)
              .toList();
    }
    User user = User(
        id: snap.id,
        name: snap['name'],
        age: snap['age'],
        imageUrls: (snap['imageUrls'] as List)
            .map((img) => img as Map<String, dynamic>)
            .toList(),
        interests: snap['interests'],
        bio: snap['bio'],
        jobTitle: snap['jobTitle'],
        location: snap['location'],
        gender: snap['gender'],
        swipeLeft: (snap['swipeLeft'] as List)
            .map((swipeLeft) => swipeLeft as String)
            .toList(),
        swipeRight: (snap['swipeRight'] as List)
            .map((swipeRight) => swipeRight as String)
            .toList(),
        matches: (snap['matches'] as List)
            .map((matches) => matches as Map<String, dynamic>)
            .toList(),
        genderPrefered: userGenderPrefered,
        agePrefered: userAgePrefered);
    return user;
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'imageUrls': imageUrls,
      'interests': interests,
      'bio': bio,
      'jobTitle': jobTitle,
      'location': location,
      'swipeLeft': swipeLeft,
      'swipeRight': swipeRight,
      'matches': matches,
      'genderPrefered': genderPrefered,
      'agePrefered': agePrefered
    };
  }

  User copyWith(
      {String? id,
      String? name,
      int? age,
      String? gender,
      List<Map<String, dynamic>>? imageUrls,
      List<dynamic>? interests,
      String? bio,
      String? jobTitle,
      String? location,
      List<String>? swipeLeft,
      List<String>? swipeRight,
      List<Map<String, dynamic>>? matches,
      List<String>? genderPrefered,
      List<int>? agePrefered}) {
    return User(
        id: id ?? this.id,
        name: name ?? this.name,
        age: age ?? this.age,
        gender: gender ?? this.gender,
        imageUrls: imageUrls ?? this.imageUrls,
        interests: interests ?? this.interests,
        bio: bio ?? this.bio,
        jobTitle: jobTitle ?? this.jobTitle,
        location: location ?? this.location,
        swipeLeft: swipeLeft ?? this.swipeLeft,
        swipeRight: swipeRight ?? this.swipeRight,
        matches: matches ?? this.matches,
        genderPrefered: genderPrefered ?? this.genderPrefered,
        agePrefered: agePrefered ?? this.agePrefered);
  }

  static const User empty = User(
      id: '',
      name: "",
      age: 0,
      imageUrls: [],
      bio: "",
      interests: [],
      jobTitle: "",
      location: "",
      matches: [],
      swipeLeft: [],
      swipeRight: [],
      genderPrefered: [],
      agePrefered: [19, 40],
      gender: "");
}
