import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/widge.dart';
import 'package:flutter/material.dart';

class SportsField extends StatefulWidget {
  @override
  _SportsFieldState createState() => _SportsFieldState();
}

class _SportsFieldState extends State<SportsField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 704,
      width: MediaQuery.of(context).size.width * .39,
      color: AppColors.appBackgroundColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
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
                InkWell(
                  onTap: () async{
                   // await addStudentInput(context);
                  },
                  child: Container(
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
                ),
              ],),
          ),
          boxContainer(context: context),
        ],
      ),
    );
  }
}
