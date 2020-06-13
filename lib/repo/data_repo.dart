import 'dart:convert';

import 'package:chatapp/json/profile_response.dart';
import 'package:chatapp/models/profile_res.dart';

/// once we get the real api this the file that need to be changed
/// we can make this singleton if methods increase for it's fine
class DataRepo {
  static Future<Profile> loadProfileData() async {
//    make network request
    Profile userProfile = Profile.fromJson(jsonDecode(profileResponse));
//    wait fod the api call to complete
    await Future.delayed(Duration(seconds: 2));
    return userProfile;
  }
}
