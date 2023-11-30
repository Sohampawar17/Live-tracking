import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import '../../constants.dart';
import '../../model/gelocation_model.dart';
import '../../router.router.dart';
import '../../services/checkin_services.dart';

import '../../services/geolocation_services.dart';

class Homeviewmodel extends BaseViewModel {
  String? user;
  String? full_name;
  String? role_profile;
  List<LocationTable> location = [];

  initialise(BuildContext context) async {
    setBusy(true);
    final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    user = prefs.getString("user") ?? "";
    full_name = prefs.getString("full_name") ?? "";
    role_profile = prefs.getString("role_profile") ?? "";
    setBusy(false);
  }

  bool res = false;
  GeolocationModel geolocationdata = GeolocationModel();
  bool isBackgroundTaskRunning = false;

  // Define a timer for the background task.
  Timer? backgroundTask;

  void locationInbutton(BuildContext context) async {
    setBusy(true);
    GeolocationService geolocationService = GeolocationService();
    // Get the user's position using the geolocation service
    Position? currentPosition = await geolocationService.determinePosition();
    location.add(LocationTable(
      longitude: currentPosition?.longitude.toString(),
      latitude: currentPosition?.latitude.toString(),
    ));
    geolocationdata.user = await getUser();
    geolocationdata.locationTable = location;
    Logger().i(geolocationdata.toJson().toString());

    if (currentPosition != null) {
      // Get the placemark using the geolocation service
      res = await CheckinServices().addlocation(geolocationdata);
      if (res) {
        if (context.mounted) {
          setBusy(false);
          setBusy(false);
          Navigator.pushReplacementNamed(context, Routes.homePage);
          Fluttertoast.showToast(msg: 'location Added Successfully');
        }
      }
    } else {
      // Handle case where obtaining location fails
      Fluttertoast.showToast(msg: 'Failed to get location');
      setBusy(false);
    }
    setBusy(false);
  }

  void locationOutbutton(BuildContext context) async {
    setBusy(true);
    GeolocationService geolocationService = GeolocationService();

    String locationid = await getlocationid();
    Logger().i(locationid);

    geolocationdata =
        await CheckinServices().getmember(locationid) ?? GeolocationModel();

    Position? currentPosition = await geolocationService.determinePosition();

    // Initialize the location list if it's not already initialized
    geolocationdata.locationTable ??= [];

    // Add a new location entry to the list
    geolocationdata.locationTable?.add(LocationTable(
      longitude: currentPosition?.longitude.toString(),
      latitude: currentPosition?.latitude.toString(),
    ));

    geolocationdata.user = await getUser();
    Logger().i(geolocationdata.toJson().toString());

    if (currentPosition != null) {
      // Get the placemark using the geolocation service
      res = await CheckinServices().updatelocation(geolocationdata);
      if (res) {
        if (context.mounted) {
          setBusy(false);
          setBusy(false);
          Navigator.pushReplacementNamed(context, Routes.homePage);
          Fluttertoast.showToast(msg: 'Location Updated Successfully');
        }
      }
    } else {
      Fluttertoast.showToast(msg: 'Failed to get location');
      setBusy(false);
    }
    setBusy(false);
  }

  void executeBackgroundTask() {
    // Place the code you want to execute in the background task here
    locationbackgroundbutton();
  }

  Future<void> locationbackgroundbutton() async {
    try {
      GeolocationService geolocationService = GeolocationService();
      String locationid = await getlocationid();
      Logger().i(locationid);
      geolocationdata =
          await CheckinServices().getmember(locationid) ?? GeolocationModel();

      Position? currentPosition = await geolocationService.determinePosition();
      // Initialize the location list if it's not already initialized
      geolocationdata.locationTable ??= [];
      // Add a new location entry to the list
      geolocationdata.locationTable?.add(LocationTable(
        longitude: currentPosition?.longitude.toString(),
        latitude: currentPosition?.latitude.toString(),
      ));
      Logger().i('we add the table');
      geolocationdata.checkData = 'Task executed at ${DateTime.now()}';
      geolocationdata.user = await getUser();
      Logger().i(geolocationdata.toJson().toString());

      if (currentPosition != null) {
        Logger().i('currentposition is not null');
        // Get the placemark using the geolocation service
        res = await CheckinServices().updatelocation(geolocationdata);
        if (res) {
          Logger().i('location updated');
          // Fluttertoast.showToast(msg: 'Location Updated Successfully');
        } else {
          Logger().i("location can't updated");
          // Fluttertoast.showToast(msg: 'Failed to update location');
        }
      } else {
        // Fluttertoast.showToast(msg: 'Failed to get location');
      }
    } catch (e) {
      // Handle exceptions here
      Logger().e('Error in locationbackgroundbutton: $e');
      // Fluttertoast.showToast(msg: 'Error: $e');
    }
  }
}
