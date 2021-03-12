import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/class.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/clutural_activities.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/sport.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/student.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/subject.dart';
import 'package:flutter/material.dart';


class ManageClassPage extends StatefulWidget {
  final String yearId;
  final int year;
  ManageClassPage(this.yearId,this.year);
  @override
  _ManageClassPageState createState() => _ManageClassPageState();
}

class _ManageClassPageState extends State<ManageClassPage> {

  ScrollController _controller;


  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print("change");
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 10,),
          child: Column(
            children: [
              SizedBox(height: 20,),

              ClassField(widget.yearId),

              SizedBox(height: 20,),

              Expanded(
                child: Scrollbar(
                  controller: _controller,
                  child: ListView(
                    controller: _controller,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SubjectField(),
                            StudentField(widget.year),
                          ],
                        ),
                      ),
                      // OverflowBar(
                      //   spacing: 100,
                      //   overflowSpacing: 20,
                      //   children: [
                      //     SubjectField(),
                      //     StudentField(),
                      //   ],
                      // ),
                      SizedBox(height: 50,),

                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                           SportsField(),
                            CulturalActivitiesField(),
                          ],
                        ),
                      ),
                      SizedBox(height: 300,),

                    ],
                  ),
                ),
              ),

            ],
          ),
        ));
  }

  Widget topBarContainer(){
    return Container(
      height: 67,
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

                  Text('2011',
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
    );
  }


}


