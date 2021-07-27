import 'package:custom_dropdown_view/custom_dropdown_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> list = ["Brazil", "Italia", "Tunisia", 'Canada'];
  int indexSelected = -1;
  bool isDropdownOpened = false;
  bool isNeedCloseDropDown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: CustomDropdownView(
                isNeedCloseDropdown: isNeedCloseDropDown,
                elevationShadow: 20,
                decorationDropdown: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                defaultWidget: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Color(0xFFF0F1F3),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Text(
                        indexSelected != -1 ? list[indexSelected] : "Click custom dropdown",
                        style: TextStyle(color: Color(0xFF969CA8), fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Icon(
                        isDropdownOpened ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: Color(0xFF737579),
                      ),
                    ],
                  ),
                ),
                onTapDropdown: (bool _isDropdownOpened) async {
                  await Future.delayed(Duration.zero);
                  setState(() {
                    isDropdownOpened = _isDropdownOpened;
                    if (_isDropdownOpened == false) isNeedCloseDropDown = false;
                  });
                },
                listWidgetItem: List.generate(list.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        indexSelected = index;
                        isNeedCloseDropDown = true;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: index == 0 ? Radius.circular(4) : Radius.zero,
                          bottom: index == list.length - 1 ? Radius.circular(4) : Radius.zero,
                        ),
                        color: indexSelected == index ? Color(0xFFE8EFFF) : Colors.white,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            list[index],
                            style: TextStyle(color: Color(0xFF27292F), fontSize: 14, fontWeight: FontWeight.w800),
                          ),
                          SizedBox(
                            height: 9,
                          ),
                          index == list.length - 1
                              ? Container()
                              : Divider(
                                  height: 1,
                                  color: Color(0xFFEDEFF3),
                                )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
