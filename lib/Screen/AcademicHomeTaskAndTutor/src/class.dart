

import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Model/academic_class_model.dart';
import 'package:academia_admin_panel/Screen/ManageClass/Notifier/class_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassListViewBuilder extends StatefulWidget {
  final List<AcademicClassModel> listOfClass;
  ClassListViewBuilder(this.listOfClass);
  @override
  _ClassListViewBuilderState createState() => _ClassListViewBuilderState();
}

class _ClassListViewBuilderState extends State<ClassListViewBuilder> {
  int selectedIndex;
  String classId;
  @override
  Widget build(BuildContext context) {
    var classNotifierProvider = Provider.of<ClassNotifier>(context);

    if(widget.listOfClass != null && widget.listOfClass.isNotEmpty){
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:widget.listOfClass.length,
        itemBuilder: (context,index){
          return Padding(

            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: InkWell(

              onTap: (){
                setState(() {
                  classId = widget.listOfClass[index].id;
                  String className = widget.listOfClass[index].className;
                  print(className);
                  classNotifierProvider.setModelId(classId);
                  classNotifierProvider.setClassName(className);
                  selectedIndex = index;
                });
              },
              splashColor: Colors.white,
              hoverColor: Colors.white12,
              child: LimitedBox(
                child: Container(
                  height: 39,
                  margin: EdgeInsets.only(left: 15),
                  padding: EdgeInsets.only(left: 15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color:  selectedIndex == index ? AppColors.white100:AppColors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${widget.listOfClass[index].className}',
                        style: TextStyle(
                            fontFamily: 'ProductSans',
                            color:  selectedIndex == index ? AppColors.textColorBlack:AppColors.textColorBlack,
                            fontSize:25,
                            fontWeight: selectedIndex == index ? FontWeight.w700 : FontWeight.normal
                        ),
                      ),
                      SizedBox(width: 15,)
                    ],
                  ),
                ),
              ),
            ),
          );
        },);
    }
    return Center(child: Text("Please create the class in Manage Class Screen"),);
  }
}