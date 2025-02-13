import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final connectivityStreamProvider = StreamProvider<ConnectivityResult>((ref) {
  return Connectivity().onConnectivityChanged.map((list) {
    // Check if any valid connection is present
    if (list.contains(ConnectivityResult.wifi)) {
      return ConnectivityResult.wifi; // User is connected via WiFi
    } else if (list.contains(ConnectivityResult.mobile)) {
      return ConnectivityResult.mobile;
    } else if (list.contains(ConnectivityResult.ethernet)) {
      return ConnectivityResult.ethernet;
    } else if (list.contains(ConnectivityResult.bluetooth)) {
      return ConnectivityResult.bluetooth;
    } else if (list.contains(ConnectivityResult.other)) {
      return ConnectivityResult.other;
    } else {
      return ConnectivityResult.none; // No connection (None)
    }
  });
});
