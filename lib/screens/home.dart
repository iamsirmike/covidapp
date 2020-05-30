import 'package:advanced_covid/services/networkhelper.dart';
import 'package:advanced_covid/utils/utils.dart';
import 'package:advanced_covid/widgets/button.dart';
import 'package:advanced_covid/widgets/countries.dart';
import 'package:advanced_covid/widgets/navigation.dart';
import 'package:advanced_covid/widgets/prevention.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
// import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedCountry = 'Ghana';
  List<DropdownMenuItem> getDRopDownItems() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String card in countryList) {
      var newItem = DropdownMenuItem(child: Text(card), value: card);
      dropdownItems.add(newItem);
    }
    return dropdownItems;
  }

  var cases;
  var death;
  var recovered;
  var active;
  var critical;
  var country;
  var flag;

  var allcases;
  var alldeath;
  var allrecovered;
  var allactive;
  var allcritical;

  bool loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVirus();
  }

  void getVirus() async {
    try {
      loading = true;
      NetworkHelper networkHelper = NetworkHelper(
          'https://corona.lmao.ninja/v2/countries/$selectedCountry');
      var data = await networkHelper.getCases();

      NetworkHelper2 networkHelper2 =
          NetworkHelper2('https://corona.lmao.ninja/v2/all');
      var data2 = await networkHelper2.getAllCases();

      setState(() {
        cases = data['cases'];
        death = data['deaths'];
        recovered = data['recovered'];
        active = data['active'];
        critical = data['critical'];
        country = data['country'];
        flag = data['countryInfo']['flag'];

        allcases = data2['cases'];
        alldeath = data2['deaths'];
        allrecovered = data2['recovered'];
        allactive = data2['active'];
        allcritical = data2['critical'];

        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: screenHeight(context, 0.35),
                    width: screenWidth(context, 1),
                    decoration: BoxDecoration(
                      color: UIColors.color1,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.sort,
                                color: UIColors.color2,
                                size: 25,
                              ),
                              // Spacer(),
                              // Icon(
                              //   Icons.notifications_none,
                              //   color: UIColors.color2,
                              //   size: 25,
                              // ),
                            ],
                          ),
                          Spacer(),
                          Row(
                            children: <Widget>[
                              Text(
                                'Covid-19',
                                style: TextStyle(
                                    color: UIColors.color2,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Container(
                                width: screenWidth(context, 0.35),
                                height: screenHeight(context, 0.07),
                                decoration: BoxDecoration(
                                  color: UIColors.color2,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0,
                                    ),
                                    child: DropdownButtonFormField(
                                      isExpanded: true,
                                      value: selectedCountry,
                                      items: getDRopDownItems(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectedCountry = value;
                                          getVirus();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Text(
                            'Are you feeling sick?',
                            style: TextStyle(
                              color: UIColors.color2,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'If you feel sick with any of covid-19 symptoms please call or SMS us immediately for help.',
                            style: TextStyle(
                              color: Color(0xffBEBCD9),
                              fontSize: 13,
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: <Widget>[
                              Button(
                                icon: Icons.call,
                                label: 'Call Now',
                                color: UIColors.color3,
                              ),
                              Spacer(),
                              Button(
                                icon: Icons.message,
                                label: 'Send SMS',
                                color: UIColors.color4,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Prevention',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Prevention(
                          img: 'assets/images/distancing.png',
                          label: 'Avoid close \n contact',
                        ),
                        Spacer(),
                        Prevention(
                          img: 'assets/images/hands.png',
                          label: 'Clean your \n hands often',
                        ),
                        Spacer(),
                        Prevention(
                          img: 'assets/images/mask.png',
                          label: 'Wear a \n facemask',
                        ),
                      ],
                    ),
                    SizedBox(height: 40),
                    Container(
                      height: screenHeight(context, 0.2),
                      width: screenWidth(context, 1),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            UIColors.color1,
                            Color(0xff948AD1),
                          ],
                        ),
                      ),
                      child: Stack(
                        overflow: Overflow.visible,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 120),
                            width: screenWidth(context, 0.5),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal: 2.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Do your own test!',
                                    style: TextStyle(
                                      color: UIColors.color2,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    'Follow the intsructions to do your own test',
                                    style: TextStyle(
                                      color: UIColors.color2,
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 40,
                            child: SvgPicture.asset(
                              'assets/images/msg.svg',
                              height: 120,
                              width: 50,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        inAsyncCall: loading,
      ),
      bottomNavigationBar: NavigationBar(
          cases: cases,
          recovered: recovered,
          death: death,
          active: active,
          critical: critical,
          country: country,
          flag: flag,
          allcases: allcases,
          allrecovered: allrecovered,
          alldeath: alldeath,
          allactive: allactive,
          allcritical: allcritical,
          ),
    );
  }
}
