import 'package:flutter/material.dart';
import 'package:app_invoices/models/login_menu_option.dart';
import 'package:app_invoices/screens/screens.dart';

class WorkPopupMenu {
  static final menuOptions = <LoginMenuOption>[
    LoginMenuOption(
        name: 'Abrir', route: WorkScreen.routerName, icon: Icons.arrow_forward),
    LoginMenuOption(
        name: 'Imprimir', route: SettingsScreen.routerName, icon: Icons.print),
    LoginMenuOption(
        name: 'Borrar', route: SettingsScreen.routerName, icon: Icons.delete),
  ];
}
