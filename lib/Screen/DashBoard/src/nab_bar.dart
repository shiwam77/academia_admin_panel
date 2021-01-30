import 'package:academia_admin_panel/Screen/DashBoard/src/nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';


class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  List<bool> selected = [true, false, false, false, false,false,false,false];
  void select(int n) {
    for (int i = 0; i < 8; i++) {
      if (i != n) {
        selected[i] = false;
      } else {
        selected[i] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          NavBarItem(
            index: 0,
            icon: Icons.house,
            active: selected[0],
            touched: () {
              setState(() {
                select(0);
              });
            },
          ),
          NavBarItem(
            index: 1,
            icon: Icons.class__sharp,
            active: selected[1],
            touched: () {
              setState(() {
                select(1);
              });
            },
          ),
          NavBarItem(
            index: 2,
            icon: Icons.person_add_alt_1_sharp,
            active: selected[2],
            touched: () {
              setState(() {
                select(2);
              });
            },
          ),
          NavBarItem(
            index: 3,
            icon:Icons.format_list_bulleted,
            active: selected[3],
            touched: () {
              setState(() {
                select(3);
              });
            },
          ),
          NavBarItem(
            index: 4,
            icon:Feather.book_open,
            active: selected[4],
            touched: () {
              setState(() {
                select(4);
              });
            },
          ),

          NavBarItem(
            index: 5,
            icon: Icons.supervisor_account_sharp,
            active: selected[5],
            touched: () {
              setState(() {
                select(5);
              });
            },
          ),

          NavBarItem(
            index: 6,
            icon: Icons.notifications,
            active: selected[6],
            touched: () {
              setState(() {
                select(6);
              });
            },
          ),

          NavBarItem(
            index: 7,
            icon: Icons.settings,
            active: selected[7],
            touched: () {
              setState(() {
                select(7);
              });
            },
          ),
        ],
      ),
    );
  }
}