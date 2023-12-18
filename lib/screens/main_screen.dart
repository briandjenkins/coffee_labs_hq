import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../enums/screens.dart';
import '../providers/main_screen_provider.dart';
import '../utilities/hide_navbar_utility.dart';
import 'login_screen.dart';


final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: () async => true,
      child: Stack(
        children: <Widget>[
          Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/background.jpg"), fit: BoxFit.cover))),
          Consumer<MainScreenProvider>(builder: (context, mainProvider, child) {
            return Scaffold(
                key: _scaffoldKey,
                backgroundColor: Colors.transparent,
                bottomNavigationBar: ValueListenableBuilder(
                  valueListenable: HideNavbarUtility.instance.getVisisble,
                  builder: (context, bool value, child) => AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    height: value ? kBottomNavigationBarHeight : 0.0,
                    child: Wrap(
                      children: <Widget>[
                        Container(
                          color: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                            child: GNav(
                              selectedIndex: context.read<MainScreenProvider>().getScreenNavigationIndex,
                              backgroundColor: Theme.of(context).primaryColor.withOpacity(.5),
                              color: Colors.white,
                              activeColor: Colors.white,
                              tabBackgroundColor: Colors.grey.shade500,
                              padding: EdgeInsets.all(7),
                              gap: 8,
                              tabs: const [
                                GButton(icon: FontAwesomeIcons.tags, text: 'Dashboard'),
                                GButton(icon: FontAwesomeIcons.star, text: 'Favorites'),
                                GButton(icon: FontAwesomeIcons.lightbulb, text: 'Insights'),
                                GButton(icon: FontAwesomeIcons.ellipsis, text: 'More'),
                              ],
                              onTabChange: (index) {

                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                body: navigateToScreen(mainProvider.getNavigationScreen, context));
          })
        ],
      ),
    );
  }

  Widget navigateToScreen(Enum screen, BuildContext context) {
    switch (screen) {
      case Screens.Login:
        return LoginScreen();
      // case Screens.Dashboard:
      //   return DashboardScreen();
      // case Screens.Favorites:
      //   return FavoritesScreen();
      // case Screens.Insights:
      //   return InsightsScreen();
      // case Screens.Alerts:
      //   return AlertsScreen();
      // case Screens.CallUs:
      //   return CallUsScreen();
      // case Screens.AccountSummary:
      //   return AccountSummaryScreen();
      // case Screens.Positions:
      //   return PositionsScreen();
      // case Screens.History:
      //   return HistoryScreen();
      // case Screens.LivePrices:
      //   return PricesScreen();
      // case Screens.Settings:
      //   return AccountSettingsScreen();
      default:
        return SizedBox();
    }
  }
}
