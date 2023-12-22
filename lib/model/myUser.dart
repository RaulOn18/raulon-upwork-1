import 'package:dplus/model/login_type.dart';
import 'package:dplus/service/userUtil.dart';

class MyUser {
  String uid;
  LoginType loginType;
  bool isProfileSetup;
  String id;
  String name;
  String email;
  String language;
  int timestamp;
  String photo;
  String dob; //ddMMyyyy
  String nationality;
  String location;
  String phoenixRating;
  String dartLiveRating;
  DartSetting mydartsetting;
  List<String> favoriteDartsPlayers;

  MyUser({
    required this.uid,
    required this.loginType,
    required this.isProfileSetup,
    required this.language,
    required this.timestamp,
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
    required this.dob,
    required this.nationality,
    required this.location,
    required this.phoenixRating,
    required this.dartLiveRating,
    required this.mydartsetting,
    required this.favoriteDartsPlayers,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'loginType': loginType.toString(), // Convert enum to string
      'isProfileSetup': isProfileSetup,
      'id': id,
      'name': name,
      'email': email,
      'photo': photo,
      'dob': dob,
      'nationality': nationality,
      'location': location,
      'language': language,
      'timestamp': timestamp,
      'phoenixRating': phoenixRating,
      'dartLiveRating': dartLiveRating,
      'mydartsetting': {
        'barrel': mydartsetting.barrel,
        'shaft': mydartsetting.shaft,
        'plate': mydartsetting.plate,
        'tip': mydartsetting.tip,
      },
      'favoriteDartsPlayers': favoriteDartsPlayers,
      // Add other fields as needed
    };
  }

  //before setup progile. save user info
  factory MyUser.createfirstTimeUser(String id, String email) {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    return MyUser(
      uid: id,
      loginType: LoginType.na,
      isProfileSetup: false,
      language: "English/en",
      id: '',
      name: '',
      timestamp: currentTime,
      email: email,
      photo: '',
      dob: '',
      nationality: '',
      location: '',
      phoenixRating: "0",
      dartLiveRating: "0",
      mydartsetting: DartSetting(
        barrel: '',
        shaft: '',
        plate: '',
        tip: '',
      ),
      favoriteDartsPlayers: List<String>.from(
        <String>[],
      ),
    );
  }

  factory MyUser.fromFirestore(String id, Map<String, dynamic> data) {
    return MyUser(
      uid: id,
      loginType: UserUtil().parseLoginType(data['loginType']),
      isProfileSetup: data['isProfileSetup'] ?? false,
      id: data['id'] ?? '',
      language: data['language'],
      timestamp: data['timestamp'],
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      photo: data['photo'] ?? '',
      dob: data['dob'] ?? '',
      nationality: data['nationality'] ?? '',
      location: data['location'] ?? '',
      phoenixRating: data['phoenixRating'] ?? 0,
      dartLiveRating: data['dartLiveRating'] ?? 0,
      mydartsetting: DartSetting(
        barrel: data['mydartsetting']['barrel'] ?? '',
        shaft: data['mydartsetting']['shaft'] ?? '',
        plate: data['mydartsetting']['plate'] ?? '',
        tip: data['mydartsetting']['tip'] ?? '',
      ),
      favoriteDartsPlayers: List<String>.from(
        data['favoriteDartsPlayers'] ?? <String>[],
      ),
    );
  }
}

class DartSetting {
  String barrel;
  String shaft;
  String plate;
  String tip;

  DartSetting({
    required this.barrel,
    required this.shaft,
    required this.plate,
    required this.tip,
  });
}
