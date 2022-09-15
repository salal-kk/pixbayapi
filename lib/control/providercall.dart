import 'package:flutter/cupertino.dart';
import 'package:machine_test_pixbay_api/control/apicall.dart';
import 'package:machine_test_pixbay_api/model/modelclass.dart';

class DataFetchProvider extends ChangeNotifier {
  late Future<Pixbay> data ;
  
  String clickedImageUrl = "";
  fetchData(context, searchKey) {
    data = getPictureFromApi(searchkeyword: searchKey);
    notifyListeners();
  }

  // int currentIndex=0;
  setImageUrl({imageUrl, context}) {
    clickedImageUrl = imageUrl;
    notifyListeners();
  }
}
