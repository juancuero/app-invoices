import 'dart:io';

import 'package:app_invoices/theme/theme_app.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../widgets/widgets.dart';

class WorkScreen extends StatelessWidget {
  static const String routerName = 'Work';

  const WorkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          bottom: TabBar(
            labelColor: AppTheme.primary,
            unselectedLabelColor: Colors.white60,
            indicator: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
                color: Colors.white),
            tabs: [
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Información"),
                    Icon(Icons.note_add_rounded)
                  ],
                ),
              ),
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [Text("Fotos"), Icon(Icons.photo_album)],
                ),
              ),
            ],
          ),
          title: const Text('8229978128'),
        ),
        body: const TabBarView(
          children: [
            UserDetails(),
            WorkPhotos(),
          ],
        ),
        // bottomNavigationBar: BottomAppBar(
        //   shape: const CircularNotchedRectangle(),
        //   child: Container(height: 50.0),
        // ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // FloatingActionButton(
              //   backgroundColor: Colors.white,
              //   onPressed: () {},
              //   child: const Icon(
              //     Icons.arrow_back,
              //     color: AppTheme.primary,
              //   ),
              // ),
              FloatingActionButton(
                onPressed: () async {
                  await Permission.manageExternalStorage.request();
                  var status = await Permission.manageExternalStorage.status;
                  if (status.isDenied) {
                    // We didn't ask for permission yet or the permission has been denied   before but not permanently.
                    return;
                  }

                  // You can can also directly ask the permission about its status.
                  if (await Permission.storage.isRestricted) {
                    // The OS restricts access, for example because of parental controls.
                    return;
                  }
                  if (status.isGranted) {
                    //here you add the code to store the file

                    final directory =
                        Directory('/storage/emulated/0/yourFolder/images')
                            .create(recursive: true);

                    final path = '/storage/emulated/0/yourFolder/images';

                    final picker = ImagePicker();

                    final pickedFile = (await picker.pickImage(
                        source: ImageSource.camera, imageQuality: 100));

                    if (pickedFile == null) {
                      return;
                    }

                    File savedImage = await File(pickedFile.path)
                        .copy('$path/saved_image.jpg');
                  }
                },
                child: const Icon(Icons.camera_enhance),
              ),
              // FloatingActionButton(
              //   backgroundColor: Colors.white,
              //   onPressed: () {},
              //   child: const Icon(
              //     Icons.arrow_forward,
              //     color: AppTheme.primary,
              //   ),
              // ),
            ],
          ),
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

class UserDetails extends StatelessWidget {
  const UserDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 8,
          shadowColor: AppTheme.primary.withOpacity(0.6),
          child: Column(
            children: [
              const ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.account_circle,
                  color: AppTheme.primary,
                ),
                title: Text('Juan Manuel Cuero Ortega'),
              ),
              const ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.home,
                  color: AppTheme.primary,
                ),
                title: Text('Calle Falsa 123'),
                subtitle: Text('Villavicencio'),
              ),
              const ListTile(
                visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                leading: Icon(
                  Icons.dynamic_form,
                  color: AppTheme.primary,
                ),
                title: Text('8229978128'),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Form(
                    child: Column(
                  children: [
                    const CustomInputField(
                      labelText: 'Recibe',
                      hintText: 'Recibe',
                      formProperty: 'recibe',
                      formValues: {},
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const CustomInputField(
                      labelText: 'Celular',
                      hintText: 'Celular',
                      keyboardType: TextInputType.phone,
                      formProperty: 'celular',
                      formValues: {},
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    DropdownSearch<String>(
                      asyncItems: (String filter) =>
                          getMethodDeliveries(filter),
                      filterFn: (item, filter) => item.contains(filter),
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                      ),
                      dropdownDecoratorProps: const DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                        labelText: "Método de entrega",
                      )),
                      onChanged: (String? data) => print(data),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () {},
                        child: const SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: Center(child: Text('Guardar'))))
                  ],
                )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<String>> getMethodDeliveries(String filter) async {
    List<String> values = [
      "Personalmente",
      "Bajo Puerta",
      "En Ventana",
      "Celador",
    ];

    return values;
  }
}

class WorkPhotos extends StatelessWidget {
  const WorkPhotos({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 8,
        shadowColor: AppTheme.primary.withOpacity(0.6),
        child: Text("hola"),
      ),
    );
  }
}
