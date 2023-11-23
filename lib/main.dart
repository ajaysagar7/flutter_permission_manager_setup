import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_permission_manager/services/permission_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Request Permission Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  RequestPermissionManager(PermissionType.storage)
                      .onPermissionDenied(() async {
                    // Handle permission denied for location
                    await Permission.storage.request();
                    print('storage permission denied');
                  }).onPermissionGranted(() {
                    // Handle permission granted for location
                    print('storage permission granted');
                  }).onPermissionPermanentlyDenied(() {
                    // Handle permission permanently denied for location
                    print('storage permission permanently denied');
                    openAppSettings();
                  }).execute();
                },
                child: const Text("Request storage Permission")),
            ElevatedButton(
                onPressed: () {
                  RequestPermissionManager(PermissionType.readContacts)
                      .onPermissionDenied(() async {
                    await Permission.contacts.request();
                    // Handle permission denied for location
                    print('Contacts permission denied');
                  }).onPermissionGranted(() {
                    // Handle permission granted for location
                    print('Contacts permission granted');
                  }).onPermissionPermanentlyDenied(() {
                    // Handle permission permanently denied for location
                    print('Contacts permission permanently denied');
                    openAppSettings();
                  }).execute();
                },
                child: const Text("Request contacts Permission")),
            ElevatedButton(
                onPressed: () {
                  RequestPermissionManager(PermissionType.whenInUseLocation)
                      .onPermissionDenied(() async {
                    // Handle permission denied for location
                    print('Location permission denied');
                    await Permission.location.request();
                  }).onPermissionGranted(() {
                    // Handle permission granted for location
                    print('Location permission granted');
                  }).onPermissionPermanentlyDenied(() {
                    // Handle permission permanently denied for location
                    print('Location permission permanently denied');
                    Fluttertoast.showToast(
                        msg: "Please enable location permission from settings");
                    openAppSettings();
                  }).execute();
                },
                child: const Text("Request location Permission")),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
