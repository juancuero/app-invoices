import 'package:app_invoices/providers/app_state.dart';
import 'package:app_invoices/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class NotRequirementsScreen extends StatelessWidget {
  static const String routerName = 'NotRequirements';
  const NotRequirementsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<AppState>(context, listen: true);

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(children: [
        Container(
          width: double.infinity,
          height: size.height * 0.6,
          child: Lottie.asset('assets/lotties/not_services.json'),
        ),
        Column(
          children: const [
            Text(
              "Servicios No Disponibles",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              textAlign: TextAlign.center,
              "Para el correcto funcionamiento de esta aplicación los siguientes servicios deben estar activos.",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(9),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.location_pin),
                title: const Text("Ubicación"),
                trailing: locationProvider.locationServiceActive
                    ? const Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
              ),
              ListTile(
                // locationProvider.cellularDataState
                leading: const Icon(Icons.sim_card),
                title: const Text("Datos SIM "),
                subtitle: const Text("No es necesario plan de datos."),
                trailing: locationProvider.cellularDataState
                    ? const Icon(
                        Icons.check,
                        color: Colors.green,
                      )
                    : const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  // onPressed: () => (locationProvider.locationServiceActive &&
                  //         locationProvider.cellularDataState)
                  //     ? Navigator.pushNamed(context, LoginScreen.routerName)
                  //     : null,
                  onPressed: (locationProvider.locationServiceActive &&
                          locationProvider.cellularDataState)
                      ? () => Navigator.pushReplacementNamed(
                          context, LoginScreen.routerName)
                      : null,

                  // () {
                  //   if (locationProvider.locationServiceActive &&
                  //       locationProvider.cellularDataState) {
                  //     Future.delayed(const Duration(milliseconds: 500));
                  //     Navigator.pushNamed(context, LoginScreen.routerName);
                  //   }
                  // },
                  child: const SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: Center(child: Text('Continuar'))))
            ],
          ),
        )
      ]),
    );
  }
}
