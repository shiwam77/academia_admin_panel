import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/class.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/clutural_activities.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/sport.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/student.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/subject.dart';
import 'package:flutter/material.dart';


class ManageClassPage extends StatefulWidget {
  final String yearId;
  ManageClassPage(this.yearId);
  @override
  _ManageClassPageState createState() => _ManageClassPageState();
}

class _ManageClassPageState extends State<ManageClassPage> {

  ScrollController _controller;
  double _offset = 0;

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
          child: Stack(
            children: [
              Column(
                children: [
                  SizedBox(height: 20,),

                  ClassField(widget.yearId),

                  SizedBox(height: 20,),

                  Expanded(
                    child: ListView(
                      controller: _controller,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SubjectField(),
                              StudentField(),
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

                ],
              ),
              /// ScrollBar
              // Positioned(
              //   right: 10,
              //   child: Container(
              //       alignment: Alignment.centerRight,
              //       height: MediaQuery.of(context).size.height,
              //       width: 20.0,
              //       margin: EdgeInsets.only(left: MediaQuery.of(context).size.width - 20.0),
              //       decoration: BoxDecoration(color: Colors.black12),
              //       child: Container(
              //         alignment: Alignment.topCenter,
              //         child: GestureDetector(
              //           child: Container(
              //             height: 40.0,
              //             width: 15.0,
              //             margin:
              //             EdgeInsets.only(left: 5.0, right: 5.0, top: _offset),
              //             decoration: BoxDecoration(
              //                 color: Colors.grey,
              //                 borderRadius: BorderRadius.all(Radius.circular(3.0))),
              //           ),
              //           onVerticalDragUpdate: (dragUpdate) {
              //             _controller.position.moveTo(dragUpdate.globalPosition.dy * .8);
              //
              //             setState(() {
              //               if(dragUpdate.globalPosition.dy >= 0) {
              //                 _offset = dragUpdate.globalPosition.dy;
              //               }
              //               print("View offset ${_controller.offset} scroll-bar offset ${_offset}");
              //             });
              //           },
              //         ),
              //       )
              //   ),
              // ),
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


