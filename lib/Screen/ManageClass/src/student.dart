import 'dart:typed_data';

import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/widge.dart';
import 'package:flutter/material.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

import 'package:image_picker_web/image_picker_web.dart';


class StudentField extends StatefulWidget {
  @override
  _StudentFieldState createState() => _StudentFieldState();
}

class _StudentFieldState extends State<StudentField> {
  int selectedIndex;
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
                Text('Student',
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      color: AppColors.textColorBlack,
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                ),
                InkWell(
                  onTap: () async{
                    await addStudentInput(context);
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
          boxContainer(context: context,
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
                           
                            onTap: () async{
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
                                    Text('Student',style: TextStyle(
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
              )),
        ],
      ),
    );
  }

  addStudentInput(BuildContext context){
    Uint8List bytesFromPicker;
    return showPopupWindow(
      context,
      gravity: KumiPopupGravity.leftBottom,
      bgColor: Colors.grey.withOpacity(0.5),
      clickOutDismiss: true,
      clickBackDismiss: true,
      customAnimation: false,
      customPop: false,
      customPage: false,
      //targetRenderBox: (btnKey.currentContext.findRenderObject() as RenderBox),
      //childSize: null,
      underStatusBar: false,
      underAppBar: true,
      offsetX: 200,
      offsetY: 50,
      duration: Duration(milliseconds: 200),
      childFun: (pop) {
        return  StatefulBuilder(
        key: GlobalKey(),
        builder: (context,StateSetter studentState){
          return  InteractiveViewer(
            alignPanAxis: true,
            minScale: .5,
            child: Container(
              height: MediaQuery.of(context).size.height * .8,
              width:MediaQuery.of(context).size.width * .8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff707070).withOpacity(.4),
                      offset: Offset(0, 0),
                      blurRadius: 6,
                    )
                  ]),

              child:  Stack(
                children: [
                  Container(
                    height: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),),
                      color: AppColors.indigo700,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          Spacer(flex: 1,),
                          Text("Student ID:",
                            style: TextStyle(
                                fontFamily: 'ProductSans',
                                color: AppColors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold
                            ),),
                          Spacer(flex: 4,),
                          Text("Student Form",
                            style: TextStyle(
                                fontFamily: 'ProductSans',
                                color: AppColors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.bold
                            ),),
                          Spacer(flex: 3,),
                          Text("Admission No:",
                            style: TextStyle(
                              fontFamily: 'ProductSans',
                              color: AppColors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          ),
                          ),
                          Spacer(flex: 2,),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close,color: AppColors.white,),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 50,
                    child: Container(
                      height: 200,
                      width: 200,
                      alignment: Alignment.center,
                      child: Tooltip(
                        message:'Tap to insert or edit image',
                        margin: EdgeInsets.only(top: 10),
                        padding: EdgeInsets.all(4),
                        child: GestureDetector(
                          onTap:  () async{
                            Uint8List bytesPicker =
                            await ImagePickerWeb.getImage(outputType: ImageType.bytes);

                            if (bytesPicker != null) {
                              studentState(() {
                                bytesFromPicker = bytesPicker;
                              });

                            }
                          },
                          child:Container(
                            width: 185.0,
                            height: 185.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              color:AppColors.indigo700,
                            ),
                            alignment: Alignment.center,
                            child: Container(
                              width: 180.0,
                              height: 180.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                color:AppColors.white,
                              ),
                              alignment: Alignment.center,
                              child:bytesFromPicker != null ? ClipRRect(
                                  borderRadius: BorderRadius.circular(90),
                                  child: Image.memory(
                                    bytesFromPicker,
                                    fit:BoxFit.fill,width: 180,height: 180,
                                    filterQuality: FilterQuality.high,
                                  )):Icon(
                                Icons.add,
                                size: 48,
                                color: AppColors.indigo700,),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 140,
                    left: 300,
                    right: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20,),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text("First Name",
                                    style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        color: AppColors.textColorBlack,
                                        fontSize: 25,
                                        fontWeight: FontWeight.normal
                                    ),),
                                  SizedBox(height: 35,),
                                  Text("Gender",
                                    style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        color: AppColors.textColorBlack,
                                        fontSize: 25,
                                        fontWeight: FontWeight.normal
                                    ),),
                                  SizedBox(height: 35,),
                                  Text("Contact",
                                    style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        color: AppColors.textColorBlack,
                                        fontSize: 25,
                                        fontWeight: FontWeight.normal
                                    ),),
                                  SizedBox(height: 35,),
                                  Text("Email",
                                    style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        color: AppColors.textColorBlack,
                                        fontSize: 25,
                                        fontWeight: FontWeight.normal
                                    ),),
                                  SizedBox(height: 35,),
                                ],
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  SizedBox(
                                    height: 27,
                                    width: 203,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.white100,
                                        focusColor: AppColors.white100,
                                        hoverColor: AppColors.white100,
                                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                                        border: OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                            borderSide: BorderSide(color: AppColors.transparent)
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),

                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 35,),
                                  SizedBox(
                                    height: 27,
                                    width: 203,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.white100,
                                        focusColor: AppColors.white100,
                                        hoverColor: AppColors.white100,
                                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                                        border: OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                            borderSide: BorderSide(color: AppColors.transparent)
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),

                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 35,),
                                  SizedBox(
                                    height: 27,
                                    width: 203,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.white100,
                                        focusColor: AppColors.white100,
                                        hoverColor: AppColors.white100,
                                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                                        border: OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                            borderSide: BorderSide(color: AppColors.transparent)
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),

                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 35,),
                                  SizedBox(
                                    height: 27,
                                    width: 203,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.white100,
                                        focusColor: AppColors.white100,
                                        hoverColor: AppColors.white100,
                                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                                        border: OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                            borderSide: BorderSide(color: AppColors.transparent)
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),

                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 35,),
                                ],
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text("Middle Name",
                                    style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        color: AppColors.textColorBlack,
                                        fontSize: 25,
                                        fontWeight: FontWeight.normal
                                    ),),
                                  SizedBox(height: 35,),
                                  Text("Date Of Birth",
                                    style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        color: AppColors.textColorBlack,
                                        fontSize: 25,
                                        fontWeight: FontWeight.normal
                                    ),),
                                  SizedBox(height: 35,),
                                  Text("First Name",
                                    style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        color: AppColors.textColorBlack,
                                        fontSize: 25,
                                        fontWeight: FontWeight.normal
                                    ),),
                                  SizedBox(height: 35,),
                                  Text("Password",
                                    style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        color: AppColors.textColorBlack,
                                        fontSize: 25,
                                        fontWeight: FontWeight.normal
                                    ),),
                                  SizedBox(height: 35,),
                                ],
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  SizedBox(
                                    height: 27,
                                    width: 203,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.white100,
                                        focusColor: AppColors.white100,
                                        hoverColor: AppColors.white100,
                                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                                        border: OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                            borderSide: BorderSide(color: AppColors.transparent)
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),

                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 35,),
                                  SizedBox(
                                    height: 27,
                                    width: 203,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.white100,
                                        focusColor: AppColors.white100,
                                        hoverColor: AppColors.white100,
                                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                                        border: OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                            borderSide: BorderSide(color: AppColors.transparent)
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),

                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 35,),
                                  SizedBox(
                                    height: 27,
                                    width: 203,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.white100,
                                        focusColor: AppColors.white100,
                                        hoverColor: AppColors.white100,
                                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                                        border: OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                            borderSide: BorderSide(color: AppColors.transparent)
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),

                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 35,),
                                  SizedBox(
                                    height: 27,
                                    width: 203,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.white100,
                                        focusColor: AppColors.white100,
                                        hoverColor: AppColors.white100,
                                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                                        border: OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                            borderSide: BorderSide(color: AppColors.transparent)
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),

                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 35,),
                                ],
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  Text("Last Name",
                                    style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        color: AppColors.textColorBlack,
                                        fontSize: 25,
                                        fontWeight: FontWeight.normal
                                    ),),
                                  SizedBox(height: 35,),
                                  Text("Class",
                                    style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        color: AppColors.textColorBlack,
                                        fontSize: 25,
                                        fontWeight: FontWeight.normal
                                    ),),
                                  SizedBox(height: 35,),
                                  Text("Address",
                                    style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        color: AppColors.textColorBlack,
                                        fontSize: 25,
                                        fontWeight: FontWeight.normal
                                    ),),
                                  SizedBox(height: 35,),
                                  Text("Confirm Password",
                                    style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        color: AppColors.textColorBlack,
                                        fontSize: 25,
                                        fontWeight: FontWeight.normal
                                    ),),
                                  SizedBox(height: 35,),
                                ],
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                textBaseline: TextBaseline.alphabetic,
                                children: [
                                  SizedBox(
                                    height: 27,
                                    width: 203,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.white100,
                                        focusColor: AppColors.white100,
                                        hoverColor: AppColors.white100,
                                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                                        border: OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                            borderSide: BorderSide(color: AppColors.transparent)
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),

                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 35,),
                                  SizedBox(
                                    height: 27,
                                    width: 203,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.white100,
                                        focusColor: AppColors.white100,
                                        hoverColor: AppColors.white100,
                                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                                        border: OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                            borderSide: BorderSide(color: AppColors.transparent)
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),

                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 35,),
                                  SizedBox(
                                    height: 27,
                                    width: 203,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.white100,
                                        focusColor: AppColors.white100,
                                        hoverColor: AppColors.white100,
                                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                                        border: OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                            borderSide: BorderSide(color: AppColors.transparent)
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),

                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 35,),
                                  SizedBox(
                                    height: 27,
                                    width: 203,
                                    child: TextField(
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.white100,
                                        focusColor: AppColors.white100,
                                        hoverColor: AppColors.white100,
                                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                                        border: OutlineInputBorder(
                                            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                            borderSide: BorderSide(color: AppColors.transparent)
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                          borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                        ),

                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 35,),
                                ],
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 180,
                      top: 400,
                      right: 50,
                      child:Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              SizedBox(height: 35,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text("Father's Name",
                                        style: TextStyle(
                                            fontFamily: 'ProductSans',
                                            color: AppColors.textColorBlack,
                                            fontSize: 25,
                                            fontWeight: FontWeight.normal
                                        ),),
                                      SizedBox(height: 35,),
                                      Text("Contact",
                                        style: TextStyle(
                                            fontFamily: 'ProductSans',
                                            color: AppColors.textColorBlack,
                                            fontSize: 25,
                                            fontWeight: FontWeight.normal
                                        ),),
                                      SizedBox(height: 35,),
                                      Text("Designation",
                                        style: TextStyle(
                                            fontFamily: 'ProductSans',
                                            color: AppColors.textColorBlack,
                                            fontSize: 25,
                                            fontWeight: FontWeight.normal
                                        ),),
                                      SizedBox(height: 35,),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      SizedBox(
                                        height: 27,
                                        width: 380,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: AppColors.white100,
                                            focusColor: AppColors.white100,
                                            hoverColor: AppColors.white100,
                                            contentPadding: EdgeInsets.only(top: 5,left: 10),
                                            border: OutlineInputBorder(
                                                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                                borderSide: BorderSide(color: AppColors.transparent)
                                            ),
                                            enabledBorder: const OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                              borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                            ),
                                            focusedBorder: const OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                              borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                            ),

                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 35,),
                                      SizedBox(
                                        height: 27,
                                        width: 300,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: AppColors.white100,
                                            focusColor: AppColors.white100,
                                            hoverColor: AppColors.white100,
                                            contentPadding: EdgeInsets.only(top: 5,left: 10),
                                            border: OutlineInputBorder(
                                                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                                borderSide: BorderSide(color: AppColors.transparent)
                                            ),
                                            enabledBorder: const OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                              borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                            ),
                                            focusedBorder: const OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                              borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                            ),

                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 35,),
                                      SizedBox(
                                        height: 27,
                                        width: 300,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: AppColors.white100,
                                            focusColor: AppColors.white100,
                                            hoverColor: AppColors.white100,
                                            contentPadding: EdgeInsets.only(top: 5,left: 10),
                                            border: OutlineInputBorder(
                                                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                                borderSide: BorderSide(color: AppColors.transparent)
                                            ),
                                            enabledBorder: const OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                              borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                            ),
                                            focusedBorder: const OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                              borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                            ),

                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 35,),
                                    ],
                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text("Father's Name",
                                        style: TextStyle(
                                            fontFamily: 'ProductSans',
                                            color: AppColors.textColorBlack,
                                            fontSize: 25,
                                            fontWeight: FontWeight.normal
                                        ),),
                                      SizedBox(height: 35,),
                                      Text("Contact",
                                        style: TextStyle(
                                            fontFamily: 'ProductSans',
                                            color: AppColors.textColorBlack,
                                            fontSize: 25,
                                            fontWeight: FontWeight.normal
                                        ),),
                                      SizedBox(height: 35,),
                                      Text("Designation",
                                        style: TextStyle(
                                            fontFamily: 'ProductSans',
                                            color: AppColors.textColorBlack,
                                            fontSize: 25,
                                            fontWeight: FontWeight.normal
                                        ),),
                                      SizedBox(height: 35,),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      SizedBox(
                                        height: 27,
                                        width: 380,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: AppColors.white100,
                                            focusColor: AppColors.white100,
                                            hoverColor: AppColors.white100,
                                            contentPadding: EdgeInsets.only(top: 5,left: 10),
                                            border: OutlineInputBorder(
                                                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                                borderSide: BorderSide(color: AppColors.transparent)
                                            ),
                                            enabledBorder: const OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                              borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                            ),
                                            focusedBorder: const OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                              borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                            ),

                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 35,),
                                      SizedBox(
                                        height: 27,
                                        width: 300,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: AppColors.white100,
                                            focusColor: AppColors.white100,
                                            hoverColor: AppColors.white100,
                                            contentPadding: EdgeInsets.only(top: 5,left: 10),
                                            border: OutlineInputBorder(
                                                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                                borderSide: BorderSide(color: AppColors.transparent)
                                            ),
                                            enabledBorder: const OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                              borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                            ),
                                            focusedBorder: const OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                              borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                            ),

                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 35,),
                                      SizedBox(
                                        height: 27,
                                        width: 300,
                                        child: TextField(
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: AppColors.white100,
                                            focusColor: AppColors.white100,
                                            hoverColor: AppColors.white100,
                                            contentPadding: EdgeInsets.only(top: 5,left: 10),
                                            border: OutlineInputBorder(
                                                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                                borderSide: BorderSide(color: AppColors.transparent)
                                            ),
                                            enabledBorder: const OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                              borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                            ),
                                            focusedBorder: const OutlineInputBorder(
                                              borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                                              borderSide: const BorderSide(color: AppColors.transparent, width: 0.0),
                                            ),

                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 35,),
                                    ],
                                  ),
                                ],
                              ),
                     ],
                   ),
                  )),
                  Positioned(
                    top: 700,
                      left: 100,
                      right: 50,
                      child: Row(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Cancel",
                          style:  TextStyle(
                              fontFamily: 'ProductSans',
                              color: AppColors.indigo700,
                              fontSize: 25,
                          ),),
                          Spacer(flex: 5,),
                          Text("Edit",
                            style:TextStyle(
                                fontFamily: 'ProductSans',
                                color: AppColors.indigo700,
                                fontSize: 25,

                            ),),
                          Spacer(flex: 1,),
                          Container(
                            height: 53,
                            width: 260,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: AppColors.blue,
                            ),
                            child: Text("Save",style:
                            TextStyle(
                                fontFamily: 'ProductSans',
                                color: AppColors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.bold
                            ),
                            ),
                          )
                        ],))
                 // Positioned(child: child)
                ],
              ),
            ),
          );
        });
      },
    );

  }

}
