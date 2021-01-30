import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Screen/DashBoard/Notifier/screen_notifier.dart';
import 'package:academia_admin_panel/Screen/DashBoard/src/navigation_bar.dart';
import 'package:academia_admin_panel/Screen/DashBoard/src/organization_name_logo.dart';
import 'package:academia_admin_panel/Screen/Home/home_page.dart';
import 'package:academia_admin_panel/Screen/ManageClass/manage_class_screen.dart';
import 'package:academia_admin_panel/Screen/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashBoardPage extends StatefulWidget {
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: AppColors.appBackgroundColor,
        body: SafeArea(
          child:  ChangeNotifierProvider<NavIndex>(
            create: (_) => NavIndex(),
            child: Container(
              child: Stack(
                children: [
                  OrganizationName(),
                  NavigationBar(),
                  Positioned(
                    left: 139,
                      top: 75,
                      right: 100,
                      child: Container(
                        color: AppColors.indigo700,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Consumer<NavIndex>(
                            builder: (context,navIndex,child){
                              if(navIndex.getIndex() == 0){
                                return HomePage();
                              }
                              else if(navIndex.getIndex() == 1){
                                return ManageClassPage();
                              }
                              return Login();
                            })),
                      )
                ],
              ),
            ),
          ),
        ));
  }
}
