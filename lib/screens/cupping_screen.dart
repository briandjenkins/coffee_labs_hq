

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cupping_screen_provider.dart';

class CuppingScreen extends StatelessWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async => false,
      child: Consumer<CuppingScreenProvider>(builder: (context, cuppingScreenProvider, child) {
        return Stack(
          children: [
            Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/background.jpg"), fit: BoxFit.cover))),
            Scaffold(
                key: _scaffoldKey,
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  title: Text(
                    'Cupping',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                body: Container())
          ],
        );
      }),
    );
  }
  
  
}