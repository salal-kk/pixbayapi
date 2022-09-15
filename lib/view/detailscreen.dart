// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:machine_test_pixbay_api/control/apicall.dart';
import 'package:machine_test_pixbay_api/model/modelclass.dart';

class Detailsscreen extends StatefulWidget {
  Detailsscreen({Key? key, required this.index, this.keyvalue});
  int? index = 0;
  String? keyvalue = "";
  @override
  State<Detailsscreen> createState() => _DetailsscreenState();
}

class _DetailsscreenState extends State<Detailsscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Pixbay>(
            future: getPictureFromApi(searchkeyword: widget.keyvalue),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: Image.network(snapshot
                              .data?.hits![widget.index ?? 0].largeImageURL ??
                          "",fit: BoxFit.cover,),
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            })),
      ),
    );
  }
}
