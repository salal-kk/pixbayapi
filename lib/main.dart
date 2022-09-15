import 'package:flutter/material.dart';
import 'package:machine_test_pixbay_api/service/provider.dart';
import 'package:provider/provider.dart';

import 'view/homepage.dart';

main() {
  // ignore: prefer_const_constructors
  runApp(
    MultiProvider(providers: providers,
   child:  MaterialApp(debugShowCheckedModeBanner: false,
  
    home:  Homepage(),
  )));
}
