import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/widge.dart';
import 'package:flutter/material.dart';

class SubjectField extends StatefulWidget {
  @override
  _SubjectFieldState createState() => _SubjectFieldState();
}

class _SubjectFieldState extends State<SubjectField> {
  int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return boxContainer(
        context: context,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
          itemBuilder: (context,index){
        return LimitedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 10),
            child: InkWell(
              onTap: (){
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                color:selectedIndex == index?AppColors.appBackgroundColor:AppColors.transparent ,
                height: 86,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Subject',style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 30,
                        fontWeight: FontWeight.normal,
                        color: AppColors.textColorBlack
                      ),),
                      Row(children: [
                        Icon(Icons.edit,size: 30,),
                        SizedBox(width: 50,),
                        Icon(Icons.delete,size: 30,)
                      ],)
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    ));
  }
}
