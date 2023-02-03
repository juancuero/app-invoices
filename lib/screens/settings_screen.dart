import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class SettingsScreen extends StatelessWidget {
  static const String routerName = 'Settings';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
        child: Form(
          child: Column(
            children: [
              DropdownSearch<String>(
                asyncItems: (String filter) => getData(filter),
                filterFn: (item, filter) => item.contains(filter),
                dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                  labelText: "Servidor Data",
                )),
                onChanged: (String? data) => print(data),
              ),
              const SizedBox(
                height: 30,
              ),
              DropdownSearch<String>(
                asyncItems: (String filter) => getData(filter),
                filterFn: (item, filter) => item.contains(filter),
                dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                  labelText: "Servidor Fotos",
                )),
                onChanged: (String? data) => print(data),
              ),
              const SizedBox(
                height: 30,
              ),
              DropdownSearch<String>(
                asyncItems: (String filter) => getDataUsers(filter),
                filterFn: (item, filter) => item.contains(filter),
                popupProps: const PopupProps.menu(
                  showSearchBox: true,
                ),
                dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                  labelText: "Usuario",
                )),
                onChanged: (String? data) => print(data),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      )),
    );
  }
}

Future<List<String>> getData(String filter) async {
  List<String> values = ["Producción", "Local"];

  return values;
}

Future<List<String>> getDataUsers(String filter) async {
  List<String> values = ["Juan Cuero Ortega", "Luisa Fernanda Romero Portillo"];

  return values;
}
