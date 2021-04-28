import 'package:flutter/material.dart';
import 'package:healthycheck/models/meal.dart';
import 'package:healthycheck/ui/pages/meal_details_screen.dart';

import '../../auth.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  //  Map<String, dynamic> _profile;
  //  bool _loading = false;
  //  @override
  // void initState() {
  //   super.initState();
  //   authService.profile.listen((state) => setState(() => _profile = state));
  //   authService.loading.listen((state) => setState(() => _loading = state));
  // }
  

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E9),
      
      body: Stack(
            children: <Widget>[
              Positioned(
                top: 0,
                height: height * 0.35,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: const Radius.circular(40),
                  ),
                  child: Container(
                    color: Colors.white,
                    //child: Text("This the container"),
                    //child: Text(_profile.toString()),
                  ),
                ),
              ),
              Positioned(
                top: height * 0.38,
                left: 0,
                right: 0,
                child: Container(
                  height: height * 0.55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 8,
                          left: 32,
                          right: 16,
                        ),
                        child: Text(
                          "MEALS FOR TODAY",
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 32,
                              ),
                              //printing data on the mealcard
                              for (int i = 0; i < meals.length; i++)
                                _MealCard(
                                  meal: meals[i],
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(
                              bottom: 10, left: 32, right: 32),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color(0xff2000bb),
                                const Color(0xff2000b7),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
      );
    
  }
}

class _MealCard extends StatelessWidget {
  final Meal meal;
  const _MealCard({Key key, @required this.meal}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 20,
        bottom: 10,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MealScreenDetails(meal: meal),
            ),
          );
        },
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                fit: FlexFit.tight,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Image.asset(
                      meal.imagePath,
                      width: 150,
                      fit: BoxFit.fill,
                    )),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          meal.mealTime,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Text(
                          meal.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: Colors.black45,
                          ),
                        ),
                        Text(
                          "${meal.kiloCaloriesBurnt} kcal",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.blueGrey,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Colors.black12,
                              size: 15,
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "${meal.timeTaken} min",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: Colors.blueGrey,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
