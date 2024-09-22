import 'package:firebase_remote_config/firebase_remote_config.dart';

class FirebaseRemoteService {
  FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  Future<String> fetchCountryCode() async {
    try {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: Duration.zero));

      await remoteConfig.fetchAndActivate();
      final code = remoteConfig.getString('country_code');
      return code;
    } catch (e) {
      throw Exception("Error occured while fetching the country_code");
    }
  }
}
