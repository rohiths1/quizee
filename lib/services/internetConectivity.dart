import 'package:flutter/material.dart';
import "package:internet_connection_checker/internet_connection_checker.dart";
import 'package:overlay_support/overlay_support.dart';

class internetConnection {
  bool connected = false;

  checkInternetConnection() async {
    connected = await InternetConnectionChecker().hasConnection;
    final msg = connected ? "Connected to internet" : "No internet connection";
    showSimpleNotification(Text("$msg"));
  }
}
