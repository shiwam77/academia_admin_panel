import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Screen/DashBoard/Notifier/screen_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavBarItem extends StatefulWidget {
  final IconData icon;
  final Function touched;
  final bool active;
  final int index;
  NavBarItem({
    this.icon,
    this.touched,
    this.active,
    this.index
  });
  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Consumer<NavIndex>(
        builder: (context,navIndex,child){

          return InkWell(
            onTap: () {
              navIndex.changeIndex(widget.index);
              widget.touched();
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
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: Duration(milliseconds: 375),
                          height: 35.0,
                          width: 5.0,
                          decoration: BoxDecoration(
                            color: widget.active ? AppColors.indigo700 : Colors.transparent,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Icon(
                            widget.icon,
                            color: widget.active ? AppColors.indigo700 : AppColors.gray,
                            size: 22.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}