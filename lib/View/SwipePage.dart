import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inhameal_flutter_project/View/SettingPage.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

import '../Controller/DataController.dart';
import '../Model/DayMeal.dart';
import 'MealPage.dart';

class SwipePage extends StatefulWidget {
  final DayMeal dayMeal;

  SwipePage({Key? key, required this.dayMeal}) : super(key: key);

  @override
  State<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  final PageController _pageController = PageController(initialPage: 0, viewportFraction: 0.9);
  final DataController _dataController = DataController();

  late int selectedPage = 0;

  late final List<Widget> _pages;
  List<String> cafes = ['기숙사식당', '학생식당', '교직원식당'];

  @override
  void initState() {
    super.initState();
    initPages();
  }


  void initPages(){
    final Map<String, Widget> cafepages = {
      "dorm": MealPage(cafe: widget.dayMeal.dormCafe),
      "student": MealPage(cafe: widget.dayMeal.studentCafe),
      "staff": MealPage(cafe: widget.dayMeal.staffCafe),
    };

    List<Widget> tmp = [];
    _dataController.cafeList.forEach((name) {
      tmp.add(cafepages[name]!); // !를 빼는 방법이 없을까?
    });
    _pages = tmp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("8월 27일"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingPage()));
            },
          )
        ],
      ),
      body: Container(
        color: Colors.lightBlue[50],
        child: Column(
          children: [
            Container(
              color: Colors.lightBlue[100],
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < _pages.length; i++)
                    Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: selectedPage == i ? Colors.blue : Colors.white,
                      ),
                      child: Text(
                        cafes[i],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                        ),
                      ),
                    )
                ],
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) {
                  setState(() {
                    selectedPage = page;
                  });
                },
                children: List.generate(_pages.length, (index) {
                  return _pages[index];
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

