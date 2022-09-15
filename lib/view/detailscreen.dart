// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:machine_test_pixbay_api/control/apicall.dart';
import 'package:machine_test_pixbay_api/control/providercall.dart';
import 'package:machine_test_pixbay_api/model/modelclass.dart';
import 'package:provider/provider.dart';



class Detailsscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(context.read<DataFetchProvider>().clickedImageUrl),
                  ),
                )),
      )
    ;
  }
}
