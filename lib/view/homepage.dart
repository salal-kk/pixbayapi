// ignore_for_file: unnecessary_constf, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:machine_test_pixbay_api/control/apicall.dart';
import 'package:machine_test_pixbay_api/control/providercall.dart';
import 'package:machine_test_pixbay_api/model/modelclass.dart';
import 'package:machine_test_pixbay_api/view/detailscreen.dart';
import 'package:provider/provider.dart';

// class Homepage extends StatefulWidget {
//   const Homepage({Key? key}) : super(key: key);

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

class Homepage extends StatelessWidget {
   FocusNode myFocusNode = FocusNode();
  
  final ScrollController _controller = ScrollController();
  final editingcontroller = TextEditingController();

  var searchkeyWord;

  Homepage({Key? key}) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            child: Consumer<DataFetchProvider>(builder: (context, consumerData, _) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      autofocus: false,
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
                        searchkeyWord = editingcontroller.text;
                        consumerData.fetchData(context, searchkeyWord);
                      },
                      icon: const Icon(Icons.search_outlined),
                      label: const Text("Search Here")),
                  searchkeyWord != null
                      ? FutureBuilder<Pixbay>(
                          future: consumerData.data,
                          builder: (context, snapshot) {
                            if (snapshot.hasData &&
                                editingcontroller.text != "") {
                              return ListView.builder(
                                controller: _controller,
                                shrinkWrap: true,
                                itemCount: snapshot.data!.hits?.length,
                                itemBuilder: ((context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      consumerData.setImageUrl(imageUrl: snapshot.data!.hits![index].largeImageURL);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Detailsscreen(
                                      )));
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      color: Colors.black,
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                              width: double.infinity,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Image.network(
                                                    snapshot.data?.hits![index]
                                                            .previewURL ??
                                                        "Loading....",
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
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
                                                      snapshot
                                                              .data
                                                              ?.hits![index]
                                                              .likes
                                                              .toString() ??
                                                          "",
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    // favorites
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8.0),
                                                      // ignore: unnecessary_const
                                                      child: const Icon(
                                                          Icons.download_done,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      snapshot
                                                              .data
                                                              ?.hits![index]
                                                              .downloads
                                                              .toString() ??
                                                          "",
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    // comments
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 8.0),
                                                      child: Icon(
                                                          Icons
                                                              .chat_bubble_outline,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      snapshot
                                                              .data
                                                              ?.hits![index]
                                                              .comments
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
                                    ),
                                  );
                                }),
                              );
                            } else {
                              if (editingcontroller.text == "") {
                                return const Text("Field cant be empty");
                              } else {
                                return Text("Loading.....");
                              }
                            }
                          },
                        )
                      : const Center(
                          child: Text("Please Enter Any Keyword To Search"),
                        )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
