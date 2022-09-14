import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:machine_test_pixbay_api/control/apicall.dart';
import 'package:machine_test_pixbay_api/model/modelclass.dart';

class Detailsscreen extends StatefulWidget {
  Detailsscreen({Key? key, required this.index});
  int index=0;
  @override
  State<Detailsscreen> createState() => _DetailsscreenState();
}

class _DetailsscreenState extends State<Detailsscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<Pixbay>(
            future: getPictureFromApi(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                return Center(
                  child: Container(
                    child: Image.network(
                        snapshot.data?.hits![widget.index].largeImageURL ?? ""),
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            })),
      ),
    );
  }
}
