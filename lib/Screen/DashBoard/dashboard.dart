import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Screen/AcademicAttendance/attendance.dart';

import 'package:academia_admin_panel/Screen/AcademicHomeTaskAndTutor/home_task.dart';
import 'package:academia_admin_panel/Screen/AcademicHomeTaskAndTutor/notifier/subjectNotifier.dart';
import 'package:academia_admin_panel/Screen/AcademicHomeTaskAndTutor/tutor.dart';
import 'package:academia_admin_panel/Screen/AcademicStudent/add_academic_student.dart';

import 'package:academia_admin_panel/Screen/DashBoard/Notifier/screen_notifier.dart';
import 'package:academia_admin_panel/Screen/DashBoard/src/navigation_bar.dart';
import 'package:academia_admin_panel/Screen/DashBoard/src/organization_name_logo.dart';
import 'package:academia_admin_panel/Screen/Home/home_page.dart';
import 'package:academia_admin_panel/Screen/ManageClass/Notifier/class_notifier.dart';
import 'package:academia_admin_panel/Screen/ManageClass/manage_class_screen.dart';
import 'package:academia_admin_panel/Screen/TimeTable/routine_table.dart';
import 'package:academia_admin_panel/Screen/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DashBoardPage extends StatefulWidget {
  final String yearId;
  final int year;

  DashBoardPage(this.yearId,this.year);
  @override
  _DashBoardPageState createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: AppColors.appBackgroundColor,
        body: SafeArea(
          child:  MultiProvider(
            providers: [
              ChangeNotifierProvider<NavIndex>(create: (_) => NavIndex()),
              ChangeNotifierProvider<ClassNotifier>(create: (_) => ClassNotifier()),
              ChangeNotifierProvider<SubjectNotifier>(create: (_) => SubjectNotifier()),
              // Provider<NavIndex>(create: (_) => NavIndex()),
              // Provider<ClassNotifier>(create: (_) => ClassNotifier()),
            ],
            child: Container(
              child: Stack(
                children: [
                  OrganizationName(),
                  Positioned(
                    top: 90,
                    left: 139,
                    right: 100,
                    child: Container(
                      height: 67,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(34),
                        color: AppColors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 86,
                              height: 47,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:  AppColors.white100,
                              ),
                              child: Column(
                                children: [
                                  SizedBox(height: 3,),
                                  Text('Academic year',
                                    style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        color: AppColors.gray,
                                        fontSize:10,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),

                                  Text('${widget.year}',
                                    style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        color: AppColors.textColorBlack,
                                        fontSize:23,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 149,
                                  height: 39,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:  AppColors.appBackgroundColor,
                                  ),
                                  child:  Text('24,January',

                                    style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        color: AppColors.textColorBlack,
                                        fontSize:23,
                                        fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ),
                                SizedBox(width: 50,),
                                Container(
                                  height: 40,
                                  width: 40,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: AppColors.appBackgroundColor,
                                  ),
                                  child: Icon(Icons.arrow_back_ios,size: 15,color: AppColors.lineSeparatorColor,),)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  NavigationBar(),
                  Positioned(
                    left: 139,
                      top: 160,
                      right: 100,
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Consumer<NavIndex>(
                            builder: (context,navIndex,child){
                              print(navIndex.getIndex());
                              if(navIndex.getIndex() == 0){
                                return HomePage();
                              }
                              else if(navIndex.getIndex() == 1){
                                return ManageClassPage(widget.yearId,widget.year);
                              }
                              else if(navIndex.getIndex() == 2){
                                return AddAcademicStudent(widget.yearId,widget.year);
                              }  else if(navIndex.getIndex() == 3){
                                return RoutineTable(yearId:widget.yearId);
                              } else if(navIndex.getIndex() == 4){
                                return HomeTask(widget.yearId);
                              } else if(navIndex.getIndex() == 5){
                                return AttendanceScreen(widget.yearId);
                              }
                              else if(navIndex.getIndex() == 6){
                                return AcademicTutor(widget.yearId);
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
