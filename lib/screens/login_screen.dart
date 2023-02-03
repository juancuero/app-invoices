import 'package:app_invoices/models/login_menu_option.dart';
import 'package:app_invoices/providers/app_state.dart';
import 'package:app_invoices/providers/first_example_provider.dart';
import 'package:app_invoices/router/login_popup_menu.dart';
import 'package:app_invoices/screens/screens.dart';
import 'package:app_invoices/theme/theme_app.dart';
import 'package:app_invoices/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  static const String routerName = 'Login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firstExampleProvider =
        Provider.of<FirstExampleProvider>(context, listen: true);

    final locationProvider = Provider.of<AppState>(context, listen: true);

    final myValue = firstExampleProvider.myValue;

    final locationServiceActive = locationProvider.locationServiceActive;

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        // title: Text('App Invoices'),
        centerTitle: true,
        elevation: 0,
        //toolbarHeight: 50,
        actions: [
          PopupMenuButton(onSelected: (route) {
            print(route as String);
            Navigator.pushNamed(context, route as String);
          }, itemBuilder: (context) {
            return LoginPopupMenu.menuOptions.map((LoginMenuOption choice) {
              return PopupMenuItem(
                value: choice.route,
                child: Row(
                  children: [
                    Icon(
                      choice.icon,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(choice.name),
                  ],
                ),
              );
            }).toList();
          }
              // itemBuilder: (context) => [
              //       PopupMenuItem(
              //         child: Text("First"),
              //         value: 1,
              //       ),
              //       PopupMenuItem(
              //         child: Text("Second"),
              //         value: 2,
              //       )
              //     ]
              )
        ],
      ),
      body: Container(
        height: double.infinity,
        color: AppTheme.primary,
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              width: double.infinity,
              color: AppTheme.primary,
              child: Container(
                child: const FlutterLogo(
                  size: 140,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: size.height * 0.7,
              decoration: const BoxDecoration(
                color: AppTheme.colorContainer,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    topLeft: Radius.circular(30.0)),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Form(
                    child: Column(
                  children: [
                    Text(
                      "Login $myValue GPS: $locationServiceActive",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    const CustomInputField(
                      labelText: 'Usuario',
                      hintText: 'Usuario',
                      formProperty: 'last_name',
                      formValues: {},
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const CustomInputField(
                      labelText: 'Contraseña',
                      hintText: 'Contraseña',
                      formProperty: 'password',
                      obscureText: true,
                      formValues: {},
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          firstExampleProvider.myValue =
                              firstExampleProvider.myValue + 1;
                          Navigator.pushNamed(context, HomeScreen.routerName);
                        },
                        child: const SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Center(child: Text('Guardar'))))
                  ],
                )),
              ),
            )
          ],
        )),
      ),
    );
  }
}
