import 'package:dash_port_hand_made/shared/Cache_Helper/cache_helper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String nextPage = "SingInScreen";
  @override
  void initState() {
    initNextPage();
    super.initState();
  }

  initNextPage() async {
    // nextPage = '/singin';

    // bool isonBoarding = CacheHelper().getData(key: "onBoarding") ?? false;
    bool isLogin = CacheHelper().getData(key: "Login") ?? false;
    if (isLogin == true) {
      nextPage = '/home';
    } else {
      nextPage = '/singin';
    }
    // if (FirebaseAuth.instance.currentUser != null) {
    // if (isonBoarding) {
    // if (isLogin) {
    //   nextPage = '/home';
    // }
    //  else {
    // }
    // nextPage = '/login';
    // } else {
    // nextPage = '/onboard';
    // }
    // } else {
    // nextPage = '/login';
    // }

    // if (initscreen == 0 || initscreen == null) {
    //   nextPage = "/onboard";
    // } else {
    //   nextPage = '/login';
    // }

    await Future.delayed(
      const Duration(seconds: 4),
    );
    // Navigator.pushReplacementNamed(context, nextPage);
    Navigator.pushReplacementNamed(context, nextPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Image.asset('assets/images/logo-no-background.png'),
        ),
      ),
    );
  }
}
