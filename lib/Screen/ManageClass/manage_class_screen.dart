import 'package:academia_admin_panel/Color.dart';
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
          padding: const EdgeInsets.only(top: 20,),
          child: Column(
            children: [

              Container(
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
                            Text('Academic year',
                          style: TextStyle(
                              color: AppColors.gray,
                              fontSize:10,
                              fontWeight: FontWeight.bold
                          ),
                            ),

                            Text('2011',
                              style: TextStyle(
                                  color: AppColors.textColorBlack,
                                  fontSize:23,
                                  fontWeight: FontWeight.w500
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
                            child:  Text('24, January',
                              style: TextStyle(
                                  color: AppColors.textColorBlack,
                                  fontSize:23,
                                  fontWeight: FontWeight.w500
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
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Text('Manage Class',
                     style: TextStyle(
                       color: AppColors.indigo700,
                       fontSize: MediaQuery.of(context).size.width * .018,
                       fontWeight: FontWeight.w700
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
            ],
          ),
        ));
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
              child: Text('Class $index',
                style: TextStyle(
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
