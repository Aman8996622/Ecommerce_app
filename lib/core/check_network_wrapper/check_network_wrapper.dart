import 'package:internet_connection_checker/internet_connection_checker.dart';

class CheckNetworkWrapper {
  CheckNetworkWrapper._();
  static final CheckNetworkWrapper _singleton = CheckNetworkWrapper._();
  factory CheckNetworkWrapper() => _singleton;

  static Future<bool> isInternetWorking() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }
}
