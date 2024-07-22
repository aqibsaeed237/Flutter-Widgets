import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class UserMetadataController {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<void> saveUserMetadata(User user) async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      int buildNumber = int.parse(packageInfo.buildNumber);

      final lastSignInTimeInMillis = user.metadata.lastSignInTime?.millisecondsSinceEpoch;

      if (lastSignInTimeInMillis != null) {
        final lastSignInDateTime = DateTime.fromMillisecondsSinceEpoch(lastSignInTimeInMillis);
        final formattedLastSignInTime = DateFormat('dd/MM/yyyy HH:mm:ss').format(lastSignInDateTime);

        print('Formatted Last Sign In Time: $formattedLastSignInTime');

        final userRef = _firestore.collection('users').doc(user.uid).collection('loginInfo').doc(user.uid);
        final snapshot = await userRef.get();

        if (snapshot.exists) {
          await userRef.update({
            'last_login': formattedLastSignInTime,
            'build_number': buildNumber,
            'online_status': 'online', // Update online status
          });
        } else {
          await userRef.set({
            'last_login': formattedLastSignInTime,
            'build_number': buildNumber,
            'online_status': 'online', // Update online status
          });
        }

        await _saveDevice(user);
      } else {
        print('Last sign in time is null or not available.');
      }
    } catch (e) {
      print('Error saving user metadata: $e');
      throw e; // Propagate error for handling
    }
  }

  static Future<void> _saveDevice(User user) async {
    try {
      DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
      String? deviceId;
      Map<String, dynamic>? deviceData;

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await devicePlugin.androidInfo;
        deviceId = androidInfo.id;
        deviceData = {
          'os_version': androidInfo.version.sdkInt.toString(),
          'platform': 'android',
          'model': androidInfo.model,
          'device': androidInfo.device,
        };
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await devicePlugin.iosInfo;
        deviceId = iosInfo.identifierForVendor;
        deviceData = {
          'os_version': iosInfo.systemVersion,
          'platform': 'ios',
          'model': iosInfo.model,
          'device': iosInfo.name,
        };
      }

      if (deviceId != null) {
        final now = DateTime.now();
        final formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
        final formatted = formatter.format(now);

        final deviceRef = _firestore.collection('users').doc(user.uid).collection('devices').doc(deviceId);

        if ((await deviceRef.get()).exists) {
          await deviceRef.update({
            'updated_at': formatted,
            'uninstalled': false,
            'last_seen': formatted, // Update last seen
          });
        } else {
          await deviceRef.set({
            'id': deviceId,
            'created_at': formatted,
            'updated_at': formatted,
            'last_seen': formatted, // Update last seen
            ...deviceData!,
          });
        }
      }
    } catch (e) {
      print('Error saving device info: $e');
      throw e; // Propagate error for handling
    }
  }

  static Future<void> updateOnlineStatus(User user, bool isOnline) async {
    try {
      final userRef = _firestore.collection('users').doc(user.uid).collection('loginInfo').doc(user.uid);
      await userRef.update({
        'online_status': isOnline ? 'online' : 'offline',
      });
    } catch (e) {
      print('Error updating online status: $e');
      throw e; // Propagate error for handling
    }
  }
}
