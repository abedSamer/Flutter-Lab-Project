// import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lap_project/Home.dart';
import 'package:lap_project/Splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

// // this function from internet to convert normal Color item to Material Color
//   MaterialColor buildMaterialColor(Color color) {
//     List strengths = <double>[.05];
//     Map<int, Color> swatch = {};
//     final int r = color.red, g = color.green, b = color.blue;

//     for (int i = 1; i < 10; i++) {
//       strengths.add(0.1 * i);
//     }
//     strengths.forEach((strength) {
//       final double ds = 0.5 - strength;
//       swatch[(strength * 1000).round()] = Color.fromRGBO(
//         r + ((ds < 0 ? r : (255 - r)) * ds).round(),
//         g + ((ds < 0 ? g : (255 - g)) * ds).round(),
//         b + ((ds < 0 ? b : (255 - b)) * ds).round(),
//         1,
//       );
//     });
//     return MaterialColor(color.value, swatch);
//   }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note App',
      theme: ThemeData(
        // fontFamily: 'Open Sans',
        primarySwatch: Colors.blue,
      ),
      home:
          // Splash()
          AnimatedSplashScreen(
              splashIconSize: 700,
              splash: Splash(),
              nextScreen: MyHomePage(),
              duration: 5000),
    );
  }
}
