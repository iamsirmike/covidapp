import 'package:advanced_covid/screens/stats.dart';
import 'package:advanced_covid/utils/utils.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({
    this.cases,
    this.death,
    this.recovered,
    this.active,
    this.critical,
    this.allcases,
    this.alldeath,
    this.allrecovered,
    this.allactive,
    this.allcritical,
    this.country,
    this.flag,
  });
  final int cases;
  final int death;
  final int recovered;
  final int active;
  final int critical;
  final int allcases;
  final int alldeath;
  final int allrecovered;
  final int allactive;
  final int allcritical;
  final String country;
  final String flag;

  @override
  Widget build(BuildContext context) {
    Color color = UIColors.color11;
    return Container(
      height: 60,
      child: ButtonBar(
        alignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Icon(
            Icons.home,
            color: color,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Stats(
                  cases: cases,
                  death: death,
                  recovered: recovered,
                  critical: critical,
                  active: active,
                  country: country,
                  flag: flag,
                  allcases: allcases,
                  alldeath: alldeath,
                  allrecovered: allrecovered,
                  allcritical: allcritical,
                  allactive: allactive,
                );
              }));
            },
            child: Icon(
              Icons.insert_chart,
              color: color,
            ),
          ),
          Icon(
            Icons.event_note,
            color: color,
          ),
          Icon(
            Icons.notifications_none,
            color: color,
          ),
        ],
      ),
    );
  }
}
