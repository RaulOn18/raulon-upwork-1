class UserModel {
  String email;
  String language;
  int time;

  UserModel({
    required this.email,
    required this.language,
    required this.time,
  });
}

class ChatModel {
  List image;
  String profileImage;
  String sender;
  String contents;
  String translation;
  bool isTranslatorOn = false;
  int time;
  set translations(String translatedText) {
    translation = translatedText;
  }

  ChatModel({
    required this.image,
    required this.profileImage,
    required this.sender,
    required this.contents,
    required this.translation,
    required this.isTranslatorOn,
    required this.time,
  });
}

class LanguageModel {
  final String translatedlanguage;

  LanguageModel({required this.translatedlanguage});
}

class IndividualChatModel {
  final String image;
  final String profileImage;
  final String username;
  final String contents;
  final String translation;
  final int time;

  IndividualChatModel({
    required this.image,
    required this.profileImage,
    required this.username,
    required this.contents,
    required this.translation,
    required this.time,
  });
}

class GroupChatModel {
  final String image;
  final String profileImage;
  final String username;
  final String contents;
  final String translation;
  final int time;

  GroupChatModel({
    required this.image,
    required this.profileImage,
    required this.username,
    required this.contents,
    required this.translation,
    required this.time,
  });
}
