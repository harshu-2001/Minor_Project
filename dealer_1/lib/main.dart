import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dealer_1/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance;
  await SharedPreferences.getInstance();
  
  await FirebaseAppCheck.instance.activate(webRecaptchaSiteKey:'A7A1BBF8-3BDC-4460-BE36-2050E6732514');
  
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
    ));

}