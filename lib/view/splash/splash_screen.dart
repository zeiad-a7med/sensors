import 'package:flutter/material.dart';
import 'package:weather/res/images/image_assets.dart';
import 'package:weather/view/home/home_screen.dart';
import 'package:weather/view/login/pages/login_view.dart';
import 'package:weather/view_model/services/cache_helper.dart';
import 'package:weather/view_model/services/splash_services/splash_services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (CacheHelper.getData(key: 'email') != null) {
      Future.delayed(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            )),
      );
    } else {
      Future.delayed(
        Duration(seconds: 2),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginView(),
            )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          ImageAssets.nightStarRain,
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
