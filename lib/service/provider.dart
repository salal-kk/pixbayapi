import 'package:machine_test_pixbay_api/control/providercall.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';



final List<SingleChildWidget> providers=[
  ChangeNotifierProvider(create: (_)=>DataFetchProvider())
];