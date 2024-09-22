import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteService {
  FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  Future<String> fetchCountryCode() async {
    try {
      await remoteConfig.fetchAndActivate();
      final code = remoteConfig.getString('country_code');
      print("From firebase remote service");
      print(code);
      return code;
    } catch (e) {
      return 'us';
    }
  }
}
