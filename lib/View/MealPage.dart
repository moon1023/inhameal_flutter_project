import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:inhameal_flutter_project/Model/DayMeal.dart';
import 'package:inhameal_flutter_project/View/SettingPage.dart';
import 'package:inhameal_flutter_project/View/component/MenuBoardView.dart';

class MealPage extends StatefulWidget {
  Cafeteria cafe;

  Map<String, List<Meal>> category = {
    'brunch': [],
    'lunch': [],
    'dinner': [],
  };

  MealPage({Key? key, required this.cafe}) : super(key: key) {
    cafe.meals?.forEach((meal) {
      category[meal.category]!.add(meal);
    });
  }

  @override
  State<MealPage> createState() => _MealPageState();
}

class _MealPageState extends State<MealPage> {

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowIndicator();
        return true;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          return Future<void>.delayed(const Duration(seconds: 1));
        },

        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              for (var item in widget.category.entries)
                  MenuBoardView(name: item.key, meals: item.value),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
