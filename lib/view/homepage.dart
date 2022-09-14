// ignore_for_file: unnecessary_constf

import 'package:flutter/material.dart';
import 'package:machine_test_pixbay_api/control/apicall.dart';
import 'package:machine_test_pixbay_api/model/modelclass.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late FocusNode myFocusNode;
  String searchkeyword = "";
  final editingcontroller = TextEditingController();
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    focusNode: myFocusNode,
                    cursorColor: Colors.black,
                    controller: editingcontroller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintText: 'Enter the image keyword to search',
                    ),
                  ),
                ),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                    onPressed: () {
                      searchkeyword = editingcontroller.text;

                      setState(() {
                        getPictureFromApi(searchkeyword: searchkeyword);
                      });
                    },
                    icon: const Icon(Icons.search_outlined),
                    label: const Text("Search Here")),
                FutureBuilder<Pixbay>(
                  future:
                      getPictureFromApi(searchkeyword: editingcontroller.text),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.hits?.length,
                        itemBuilder: ((context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            color: Colors.black,
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Image.network(
                                          snapshot.data?.hits![index]
                                                  .previewURL ??
                                              "",
                                          fit: BoxFit.fitWidth,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          //   likes
                                          const Icon(
                                            Icons.favorite_border,
                                            color: Colors.white,
                                          ),
                                          Text(
                                            snapshot.data?.hits![index].likes
                                                    .toString() ??
                                                "",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          // favorites
                                          const Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            // ignore: unnecessary_const
                                            child: const Icon(
                                                Icons.download_done,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            snapshot.data?.hits![index]
                                                    .downloads
                                                    .toString() ??
                                                "",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          // comments
                                          const Padding(
                                            padding: EdgeInsets.only(left: 8.0),
                                            child: Icon(
                                                Icons.chat_bubble_outline,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            snapshot.data?.hits![index].comments
                                                    .toString() ??
                                                "",
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
