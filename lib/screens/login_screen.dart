import 'package:coffee_labs_hq/screens/progress_running_screen.dart';
import 'package:coffee_labs_hq/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../enums/login_status.dart';
import '../enums/screens.dart';
import '../providers/login_screen_provider.dart';
import '../providers/main_screen_provider.dart';
import '../services/application_navigator.dart';
import '../services/application_service.dart';

import '../utilities/slide_right_route.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailAddressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: This should be initialized somewhere else to be optimized.
    context.read<LoginScreenProvider>().initializeWidgets();
    _emailAddressController.text = context.read<LoginScreenProvider>().getEmailAddress;
    _passwordController.text = context.read<LoginScreenProvider>().getPassword;

    return WillPopScope(
      onWillPop: () async => false,
      child: Consumer<LoginScreenProvider>(builder: (context, loginScreenProvider, child) {
        return Stack(
          children: [
            Container(decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/background.jpg"), fit: BoxFit.cover))),
            Container(color: Colors.black.withOpacity(.6),),
            Scaffold(
                key: _scaffoldKey,
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  title: Text(
                    'Log In',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontSize: 30),
                  ),
                ),
                body: loginScreenProvider.isLoading
                    ? ProgressRunningScreen()
                    : Center(
                        child: Form(
                          autovalidateMode: AutovalidateMode.always,
                          key: _formKey,
                          child: Container(
                              constraints: BoxConstraints.expand(),
                              padding: EdgeInsets.fromLTRB(35, 20, 35, 10),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.solidCircleUser,
                                          color: Theme.of(context).primaryColor,
                                          size: 100,
                                        ),
                                        SizedBox(height: 30.0),
                                        Container(
                                            width: 350,
                                            padding: EdgeInsets.all(0.0),
                                            child: TextFormField(
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(RegExp(r'[0-9@a-zA-Z._!@#$%^&*-]')),
                                              ],
                                              controller: _emailAddressController,
                                              onChanged: (text) => loginScreenProvider.setEmailAddress = text,
                                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white, fontSize: 30),
                                              //increases the height of cursor
                                              cursorColor: Theme.of(context).primaryColor,
                                              maxLength: 100,
                                              //prevent the user from further typing when maxLength is reached
                                              decoration: const InputDecoration(
                                                //labelText: "User ID",
                                                hintText: 'User ID',
                                              ),
                                              validator: (value) => value!.length < 2 ? 'User name not long enough' : null,
                                            )),
                                        Container(
                                            width: 350,
                                            padding: const EdgeInsets.all(0.0),
                                            child: TextFormField(
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter.allow(RegExp(r'[0-9@a-zA-Z._!@#$%^&*-]')),
                                              ],
                                              obscureText: loginScreenProvider.isObscure,
                                              controller: _passwordController,
                                              onChanged: (text) => loginScreenProvider.setPassword = text,
                                              style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white, fontSize: 30),
                                              //increases the height of cursor
                                              maxLength: 100,
                                              decoration: InputDecoration(
                                                  //labelText: 'Password',
                                                  hintText: 'Password',
                                                  // this button is used to toggle the password visibility
                                                  suffixIcon: IconButton(
                                                      icon: Icon(loginScreenProvider.isObscure ? Icons.visibility : Icons.visibility_off),
                                                      onPressed: () {
                                                        loginScreenProvider.setObscure = !loginScreenProvider.isObscure;
                                                      })),
                                              validator: (value) => value!.length < 2 ? 'Password not long enough' : null,
                                            )),
                                        Container(
                                            color: Colors.transparent,
                                            child: CheckboxListTile(
                                              contentPadding: EdgeInsets.all(0),
                                              title: Text(
                                                "Remember Me?",
                                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
                                              ),
                                              value: loginScreenProvider.isRememberMe ?? false,
                                              onChanged: (bool? value) {
                                                loginScreenProvider.isRememberMe = value!;
                                              },
                                              controlAffinity: ListTileControlAffinity.leading, //  <-- leading Checkbox
                                            )),
                                      ],
                                    ),
                                    const SizedBox(height: 25.0),
                                    Container(
                                      width: double.infinity,
                                      height: 50,
                                      child: TextButton(
                                          onPressed: () async {
                                            final form = _formKey.currentState;
                                            if (form!.validate()) {
                                              // Set flag for the progress indicator
                                              loginScreenProvider.setLoading = true;
                                              // Make sure to wait here until the model is retrieved before moving on.
                                              try {
                                                // Preferences
                                                if (loginScreenProvider.isRememberMe) {
                                                  loginScreenProvider.updatePreferences();
                                                } else {
                                                  loginScreenProvider.removePreferences();
                                                }
                                                HttpService.login(loginScreenProvider.getEmailAddress, loginScreenProvider.getPassword).then((value) {
                                                  ApplicationService.instance.setLoginStatus = LoginStatus.loggedIn;
                                                  context.read<MainScreenProvider>().setNavigationScreen = Screens.Cupping;
                                                  ApplicationNavigator.instance.removeAndPush('/main');
                                                });
                                                // Navigate to Summary screen
                                                context.read<MainScreenProvider>().refreshScreen();
                                              } catch (e) {
                                                loginScreenProvider.setLoading = false;
                                                const loginFailedSnackBar = SnackBar(
                                                  content: Text('Login failed.  Please try again.'),
                                                  backgroundColor: Colors.red,
                                                  elevation: 10,
                                                  behavior: SnackBarBehavior.floating,
                                                  margin: EdgeInsets.all(5),
                                                );
                                                ScaffoldMessenger.of(context).showSnackBar(loginFailedSnackBar);
                                              }
                                            }
                                          },
                                          style: TextButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, minimumSize: Size(200, 65)),
                                          child: Text(
                                            'Log In',
                                            style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 22),
                                          )),
                                    ),
                                    const SizedBox(height: 30.0),
                                    GestureDetector(
                                      onTap: () => ApplicationNavigator.instance.navigateTo("/create_account"),
                                      child: Text(
                                        "No account yet? Create one.",
                                        style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ),
                      ))
          ],
        );
      }),
    );
  }
}
