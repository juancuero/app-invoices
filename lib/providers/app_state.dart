import 'dart:async';

import 'package:app_invoices/screens/not_requirements_screen.dart';
import 'package:app_invoices/services/navigation_service.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'package:geolocator/geolocator.dart' as Geo;
import 'package:permission_handler/permission_handler.dart';
import 'package:sim_data/sim_data.dart';
import 'package:telephony/telephony.dart';

class AppState with ChangeNotifier {
  bool locationServiceActive = false;
  bool showScreenRequirements = false;
  var cellularDataState = false;
  var dataNetworkType = null;
  Geo.Position? position;
  bool haspermission = false;
  late Geo.LocationPermission permission;
  String long = "", lat = "";

  AppState() {
    checkGps();
    _getUserLocation();
    // _checkMobileData2();
    //_getBatteryLevel();
    _test1();
  }

  checkGps() async {
    locationServiceActive = await Geo.Geolocator.isLocationServiceEnabled();
    if (locationServiceActive) {
      permission = await Geo.Geolocator.checkPermission();

      if (permission == Geo.LocationPermission.denied) {
        permission = await Geo.Geolocator.requestPermission();
        if (permission == Geo.LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == Geo.LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }
    notifyListeners();
    if (!locationServiceActive) {
      NavigationService().replaceScreen(const NotRequirementsScreen());
    }
  }

  _getUserLocation() async {
    Geo.Geolocator.getServiceStatusStream().listen((Geo.ServiceStatus status) {
      print("getServiceStatusStream");
      print(status);
      locationServiceActive =
          status == Geo.ServiceStatus.disabled ? false : true;
      notifyListeners();
      if (!locationServiceActive) {
        NavigationService().replaceScreen(const NotRequirementsScreen());
      }
    });

    position = await Geo.Geolocator.getCurrentPosition(
        desiredAccuracy: Geo.LocationAccuracy.high);
    print("Actual ...............");
    print(position?.longitude);
    print(position?.latitude);

    Geo.LocationSettings locationSettings = const Geo.LocationSettings(
      accuracy: Geo.LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 5, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    Geo.Geolocator.getPositionStream(locationSettings: locationSettings)
        .listen((Geo.Position positionNew) {
      print("Escuchando...............");

      print(positionNew == null
          ? 'Unknown'
          : '${positionNew.latitude.toString()}, ${positionNew.longitude.toString()}');
    });
  }

  _checkMobileData2() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      print("I am connected to a mobile network.");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      print("I am connected to a wifi network.");
    }

    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print('Current connectivity status: $result');
    });
  }

  _checkMobileData() async {
    SimData simData;
    try {
      var status = await Permission.phone.status;
      if (!status.isGranted) {
        bool isGranted = await Permission.phone.request().isGranted;
        if (!isGranted) return;
      }

      try {
        simData = await SimDataPlugin.getSimData();
        for (var s in simData.cards) {
          // ignore: avoid_print
          print('Serial number: ${s.serialNumber}');
          print('isDataRoaming: ${s.isDataRoaming}');
          print('isNetworkRoaming: ${s.isNetworkRoaming}');
          print('mcc: ${s.mcc}');
          print('mnc: ${s.mnc}');
          print('slotIndex: ${s.slotIndex}');
          print('serialNumber: ${s.serialNumber}');
          print('displayName: ${s.displayName}');
          print('carrierName: ${s.carrierName}');
          print('countryCode: ${s.countryCode}');
        }
      } on PlatformException catch (e) {
        debugPrint("error! code: ${e.code} - message: ${e.message}");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  _getBatteryLevel() async {
    const platform = MethodChannel('samples.flutter.dev/battery');
    String batteryLevel;
    try {
      final int result = await platform.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
      print(batteryLevel);
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }
  }

  _test1() async {
    final telephony = Telephony.instance;
    final bool? result = await telephony.requestPhoneAndSmsPermissions;
    print("--------------- _test1 --------------");
    if (result != null && result) {
      SimState simState = await telephony.simState;

      Timer.periodic(const Duration(seconds: 2), (timer) async {
        cellularDataState =
            await telephony.cellularDataState == DataState.CONNECTED
                ? true
                : false;
        notifyListeners();
        if (!cellularDataState && !showScreenRequirements) {
          showScreenRequirements = true;
          NavigationService().replaceScreen(const NotRequirementsScreen());
        } else {
          if (cellularDataState) {
            showScreenRequirements = false;
          }
        }
      });
    }
    print("--------------- _test1 --------------");
  }
}
