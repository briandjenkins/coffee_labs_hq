import 'package:flutter/material.dart';

///
/// Singleton class that services to facilitate navigation without the existence of a
/// build context.  Thus, navigation can occur high up in the widget tree (i.e., main).
///
class ApplicationNavigator {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static final ApplicationNavigator _instance = ApplicationNavigator._();

  // Private constructor
  ApplicationNavigator._();

  static ApplicationNavigator get instance => _instance;

  /* Navigate to another screen using route name  */
  Future<dynamic>? navigateTo(String routeName) {
    return navigatorKey.currentState?.pushNamed(routeName);
  }

  /* Navigate to one step back  */
  void goBack() => navigatorKey.currentState?.pop();

  /* Remove all screens from the stack until we reach the mentioned route in the stack  */
  void removeUntil(String routeName) {
    navigatorKey.currentState!.popUntil(ModalRoute.withName(routeName));
  }

  /* Go back one step and push the route onto the stack  */
  Future<dynamic>? removeAndPush(String routeName) {
    return navigatorKey.currentState?.popAndPushNamed(routeName);
  }

  /* Replace mentioned route with current route being displayed  */
  Future<dynamic>? replaceWith(String routeName) {
    navigatorKey.currentState?.pushReplacementNamed(routeName);
  }

  /* Push mentioned route in the stack and remove all other routes from the stack  */
  Future<dynamic>? removeAllAndNavigateTo(String routeName) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(routeName, (Route<dynamic> route) => false);
  }








}