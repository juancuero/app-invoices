import 'package:flutter/material.dart' show IconData;

class LoginMenuOption {
  final String name;
  final IconData icon;
  final String route;

  LoginMenuOption(
      {required this.icon, required this.name, required this.route});
}
