import 'package:flutter/material.dart';

class ProgressRunningScreen extends StatelessWidget {
  const ProgressRunningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness == Brightness.light;
    ;
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ),
      ),
      backgroundColor: brightness
          ? Colors.white.withOpacity(0.70)
          : Colors.black.withOpacity(0.70), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
    );
  }
}
