import 'package:flutter/material.dart';
import 'package:lap_project/Home.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 150),
            Image.asset(
              "assets/imgs/Splash.jpeg",
              width: 200,
            ),
            SizedBox(height: 150),
            Container(
                child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text("Get Started",
                    style: TextStyle(
                        backgroundColor: Colors.transparent,
                        color: Colors.white,
                        fontSize: 32)),
// c&Io3ILDvJ74^P!$L1ui
              ),
            )),
          ],
        ),
      ),
    );

    // return Container(
    //   color: Colors.white,
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Container(
    //         margin: EdgeInsets.symmetric(vertical: 200),
    //         child: Image.asset(
    //           "assets/imgs/splash.jpg",
    //           width: 300,
    //         ),
    //       ),
    //       ElevatedButton(
    //         onPressed: () {},
    //         child: Padding(
    //           padding: const EdgeInsets.all(5),
    //           child: Text("Get Started",
    //               style: TextStyle(
    //                   backgroundColor: Colors.blue,
    //                   color: Colors.white,
    //                   fontSize: 32)),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }
}
