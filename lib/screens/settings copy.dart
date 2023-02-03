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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Form(
          child: Column(
            children: [
              DropdownSearch<String>(
                asyncItems: (String filter) => getData(filter),
                filterFn: (item, filter) {
                  print("Sale");
                  print(item);
                  return item.contains(filter);
                },
                popupProps: const PopupProps.menu(
                  showSearchBox: true,
                ),
                dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                  labelText: "Servidor",
                )),
                onChanged: (String? data) => print(data),
              ),
              // DropdownSearch<String>(
              //   items: const [
              //     "Brazil",
              //     "Italia (Disabled)",
              //     "Tunisia",
              //     'Canada'
              //   ],
              //   dropdownDecoratorProps: const DropDownDecoratorProps(
              //       dropdownSearchDecoration: InputDecoration(
              //     labelText: "Menu mode",
              //     hintText: "country in menu mode",
              //   )),
              //   onChanged: print,
              //   selectedItem: "Brazil",
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Servidor: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      items: const [
                        DropdownMenuItem(
                            value: 'www.app-incoives.com',
                            child: Text('Producción')),
                        DropdownMenuItem(
                            value: 'localhost:8000', child: Text('Local')),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Fotos: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      items: const [
                        DropdownMenuItem(
                            value: 'www.app-incoives.com',
                            child: Text('Producción')),
                        DropdownMenuItem(
                            value: 'localhost:8000', child: Text('Local')),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Usuario: ",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      items: const [
                        DropdownMenuItem(
                            value: 'jcuero', child: Text('Juan Cuero')),
                        DropdownMenuItem(
                            value: 'lportillo',
                            child: Text('Luisa Fernanda Portillo')),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}

Future<List<String>> getData(String filter) async {
  List<String> values = ["fotos", "test", "no"];

  return values;
}
