import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/clutural_activities.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/sport.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/student.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/subject.dart';
import 'package:flutter/material.dart';

class ManageClassPage extends StatefulWidget {
  @override
  _ManageClassPageState createState() => _ManageClassPageState();
}

class _ManageClassPageState extends State<ManageClassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.only(top: 10,),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Manage Class',
                      style: TextStyle(
                          fontFamily: 'ProductSans',
                          color: AppColors.indigo700,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          height: 52,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
                            color: AppColors.white,
                          ),
                          child: ClassListViewBuilder(),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.indigo700
                      ),
                      child: Icon(Icons.add,size: 23,color: AppColors.white,),
                    )
                  ],
                ),
              ),
              SizedBox(height: 50,),
              Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 65),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Subject',
                            style: TextStyle(
                                fontFamily: 'ProductSans',
                                color: AppColors.textColorBlack,
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Row(
                            children: [
                            Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                  color: AppColors.textColorBlack,
                                  width: 2,
                              ),
                              color: AppColors.appBackgroundColor,
                            ),
                            child: Icon(Icons.add,size: 18,color: AppColors.textColorBlack,),),

                              SizedBox(width:  MediaQuery.of(context).size.width * .13,),
                              Text('Student',
                                style: TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: AppColors.textColorBlack,
                                    fontSize:30,
                                    fontWeight: FontWeight.bold
                                ),
                              ),

                            ],
                          ),
                          Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: AppColors.textColorBlack,
                                width: 2
                              ),
                              color: AppColors.appBackgroundColor,
                            ),
                            child: Icon(Icons.add,size: 18,color: AppColors.textColorBlack,),),

                      ],),
                    ),
                    SizedBox(height: 20,),
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
                    SizedBox(height: 50,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 65),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Sports',
                            style: TextStyle(
                                fontFamily: 'ProductSans',
                                color: AppColors.textColorBlack,
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Spacer(),
                          SizedBox(width: MediaQuery.of(context).size.width * .21,),
                          Text('Cultural Activites',
                            style: TextStyle(
                                fontFamily: 'ProductSans',
                                color: AppColors.textColorBlack,
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Spacer()
                        ],),
                    ),
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


class ClassListViewBuilder extends StatefulWidget {
  @override
  _ClassListViewBuilderState createState() => _ClassListViewBuilderState();
}

class _ClassListViewBuilderState extends State<ClassListViewBuilder> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 15,
      itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          child: InkWell(
            onTap: (){
              setState(() {
                selectedIndex = index;
              });

            },
            splashColor: Colors.white,
            hoverColor: Colors.white12,
            child: Container(
              width: 108,
              height: 39,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color:  selectedIndex == index ? AppColors.white100:AppColors.white,
              ),
              child: Text('Class ${index + 1}',
                style: TextStyle(
                    fontFamily: 'ProductSans',
                    color:  selectedIndex == index ? AppColors.textColorBlack:AppColors.textColorBlack,
                    fontSize:25,
                    fontWeight: selectedIndex == index ? FontWeight.w700 : FontWeight.normal
                ),
              ),
            ),
          ),
        );
      },);
  }
}
