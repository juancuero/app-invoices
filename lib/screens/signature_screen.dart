import 'dart:io';
import 'dart:typed_data';

import 'package:app_invoices/theme/theme_app.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:signature/signature.dart';

class SignaturePage extends StatefulWidget {
  static const String routerName = 'Signature';
  const SignaturePage({Key? key}) : super(key: key);

  @override
  State<SignaturePage> createState() => _SignaturePageState();
}

class _SignaturePageState extends State<SignaturePage> {
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 3,
    // penColor: Colors.black,
    // exportBackgroundColor: Colors.white,
    // exportPenColor: Colors.black,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => print('Value changed'));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: <Widget>[
            Signature(
              height: size.height * 0.8,
              controller: _controller,
              backgroundColor: Colors.white,
            ),
            const SizedBox(
              height: 20,
            ),
            buildButtons(context),
          ],
        ),
      ),
    );
  }

  Widget buildButtons(BuildContext context) => Container(
        // color: Colors.black,
        decoration: BoxDecoration(
          color: AppTheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            buildCheck(context),
            buildClear(),
          ],
        ),
      );
  Widget buildCheck(BuildContext context) => IconButton(
        iconSize: 36,
        icon: Icon(Icons.check, color: Colors.green),
        onPressed: () async {
          if (_controller.isNotEmpty) {
            final signature = await exportSignature();

            storeSignature(signature);

            // await Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => SignaturePreviewPage(signature: signature),
            // ));

            _controller.clear();
          }
        },
      );

  Widget buildClear() => IconButton(
        iconSize: 36,
        icon: Icon(Icons.clear, color: Colors.red),
        onPressed: () => _controller.clear(),
      );

  Future<Uint8List?> exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 2,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
      points: _controller.points,
    );

    final signature = await exportController.toPngBytes();
    exportController.dispose();

    return signature;
  }

  Future storeSignature(Uint8List? signature) async {
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

      Directory('/storage/emulated/0/yourFolder').create(recursive: true);

      //qr image file saved to general downloads folder
      File userSignature =
          await File('/storage/emulated/0/yourFolder/user_signature.jpg')
              .create();
      await userSignature.writeAsBytes(signature!);
    }

    // var dir = await getExternalStorageDirectory();
    // print(dir!.path);
    // if (!Directory("${dir.path}/myapp").existsSync()) {
    //   Directory("${dir.path}/myapp").createSync(recursive: true);
    // }

    // final time = DateTime.now().toIso8601String().replaceAll('.', ':');
    // final name = '1fsdfsdf.png';

    // final result = await ImageGallerySaver.saveImage(signature!, name: name);
    // final isSuccess = result['isSuccess'];

    // if (isSuccess) {
    // } else {}
  }
}
