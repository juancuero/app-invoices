import 'package:flutter/material.dart';
import 'package:app_invoices/models/login_menu_option.dart';
import 'package:app_invoices/screens/screens.dart';

class LoginPopupMenu {
  static final menuOptions = <LoginMenuOption>[
    LoginMenuOption(
        name: 'Settings',
        route: SettingsScreen.routerName,
        icon: Icons.settings),
    LoginMenuOption(
        name: 'Parameters',
        route: SettingsScreen.routerName,
        icon: Icons.download),
  ];
}
