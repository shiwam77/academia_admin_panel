import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Screen/DashBoard/src/nab_bar.dart';
import 'package:academia_admin_panel/Screen/DashBoard/src/nav_bar_item.dart';
import 'package:academia_admin_panel/Screen/login.dart';
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class NavigationBar extends StatefulWidget {
  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  bool isLogoutClicked =  false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .75,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColors.white,
            ),
            width: 55.0,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: NavBar(),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child:  InkWell(
                    onTap: () {
                      logout();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login()
                          )
                      );
                    },
                    splashColor: Colors.white,
                    hoverColor: Colors.white12,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 3.0),
                      child: Row(
                        children: [
                          Container(
                            height: 60.0,
                            width: 40.0,
                            child:  Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Icon(
                                Feather.log_out,
                                color: isLogoutClicked ? AppColors.indigo700 : AppColors.gray,
                                size: 22.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}