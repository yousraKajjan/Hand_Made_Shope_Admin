import 'package:dash_port_hand_made/firebase_options.dart';
import 'package:dash_port_hand_made/screens/allCategory/allCategory.dart';
import 'package:dash_port_hand_made/screens/allProducts/allProducts.dart';
import 'package:dash_port_hand_made/screens/auth/SingInScreen.dart';
import 'package:dash_port_hand_made/screens/category/addCategory.dart';
import 'package:dash_port_hand_made/screens/category/editCategory.dart';
import 'package:dash_port_hand_made/screens/dash_board_screen.dart';
import 'package:dash_port_hand_made/screens/products/addProducts.dart';
import 'package:dash_port_hand_made/screens/products/editProduct.dart';
import 'package:dash_port_hand_made/screens/splashScreen.dart';
import 'package:dash_port_hand_made/screens/usersScreen.dart';
import 'package:dash_port_hand_made/shared/Cache_Helper/cache_helper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HandMade Store',
        theme: ThemeData(
          fontFamily: 'NotoSerif',
          textTheme: const TextTheme(
            // bodyLarge: TextStyle(fontSize: 25.0),
            bodyMedium: TextStyle(fontSize: 20.0),
            // قم بتحديد الحجم هنا لكل الأنماط المستخدمة في التطبيق
            labelLarge: TextStyle(fontSize: 17.0),
            // bodySmall: TextStyle(fontSize: 25.0),
            // displayLarge: TextStyle(fontSize: 25.0),
            // displayMedium: TextStyle(fontSize: 25.0),
            // displaySmall: TextStyle(fontSize: 25.0),
            // headlineMedium: TextStyle(fontSize: 25.0),
            // headlineSmall: TextStyle(fontSize: 25.0),
            // titleLarge: TextStyle(fontSize: 25.0),
            // labelSmall: TextStyle(fontSize: 25.0),
            titleMedium: TextStyle(fontSize: 15.0),
            // titleSmall: TextStyle(fontSize: 25.0),
          ),
          // textTheme: GoogleFonts.notoSerifTextTheme(), // استخدام خط "NotoSerif"

          // textTheme: const TextTheme(
          //   bodyMedium: TextStyle(
          //       color: Colors.black,
          //       fontSize: 17,
          //       letterSpacing: 1,
          //       fontFamily: 'NotoSerif'),
          // ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        routes: {
          '/': (context) => const SplashScreen(),
          '/singin': (context) => const LoginScreen(),
          '/addProd': (context) => const AddProducts(),
          '/addCategory': (context) => const AddCategory(),
          '/EditCategory': (context) => const EditCategory(),
          '/EditProducts': (context) => const EditProducts(),
          '/home': (context) => const DashboardScreen(),
          '/allProducts': (context) => const AllProducts(),
          '/allCategory': (context) => const AllCategory(),
          '/usersPage': (context) => const UsersScreen(),
        },

        // home: const SingInScreen(),
      ),
    );
  }
}
