import 'dart:typed_data';

import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Model/academic_student_model.dart';
import 'package:academia_admin_panel/Screen/ManageClass/ApiEndPoint/student_api.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/widge.dart';
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

viewStudentInput(BuildContext context, AcademicStudentModel student,String className){
  Uint8List bytesFromPicker;
  String firstName = student.firstName;
  String middleName = student.middleName ?? "";
  String lastName = student.lastName ?? "";
  String rollNo = student.rollNo ?? "";
  String fatherName = student.fatherName ?? "";
  String motherName =  student.motherName ?? "";
  String motherContact =  student.motherContact ?? "";
  String fatherContact =  student.fatherContact ?? "";
  String motherDesignation =  student.motherDesignation ?? "";
  String fatherDesignation =  student.fatherDesignation ?? "";
  String password =  student.password ?? "";
  String confirmPassword = student.password ?? "";
  String address  =  student.address ??"";
  String emailAddress =  student.email ??"";
  String studentID = student.studentID ??"";
  String contact =  student.contact ?? "";
  String gender=  student.gender ?? "";
  String imageUrl =  student.imageUrl ?? "";
  int admissionNo = student.admissionNo ?? 0;
  String dateOfBirth = student.dateOfBirth;
  DateTime currentDateTime = DateTime.parse(student.dateOfBirth);
  return showPopupWindow(
    context,
    gravity: KumiPopupGravity.leftBottom,
    bgColor: Colors.grey.withOpacity(0.5),
    clickOutDismiss: false,
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
      return  Container(
        key: GlobalKey(),
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
                    Text("Student ID:  $studentID",
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
                    Text("Admission No:   $admissionNo",
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

            Positioned(
              top: 150,
              left: 50,
              child: Container(
                height: 200,
                width: 200,
                alignment: Alignment.center,
                child: Container(
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
                        borderRadius: BorderRadius.circular(100),
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
            Positioned(
              top: 140,
              left: 300,
              right: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 20,),
                child: Column(
                  children: [
                    Container(
                      height: 312,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.appBackgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff707070).withOpacity(.4),
                              offset: Offset(0, 0),
                              blurRadius: 6,
                            )
                          ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 40),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text("Name :",
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: Color(0xff434445),
                                    fontSize: 30,
                                  ),),
                                Text("Date of Birth :",
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: Color(0xff434445),
                                    fontSize: 30,
                                  ),),
                                Text("Contact :",
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: Color(0xff434445),
                                    fontSize: 30,
                                  ),),
                                Text("Email :",
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: Color(0xff434445),
                                    fontSize: 30,
                                  ),),
                                Text("Address :",
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: Color(0xff434445),
                                    fontSize: 30,
                                  ),)
                              ],
                            ),
                            Spacer(flex: 1,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text("$firstName $middleName $lastName",
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: AppColors.indigo700,
                                    fontSize: 30,
                                  ),),
                                Text(dateOfBirth,
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: AppColors.indigo700,
                                    fontSize: 30,
                                  ),),
                                Text(contact,
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: AppColors.indigo700,
                                    fontSize: 30,
                                  ),),
                                Text(emailAddress,
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: AppColors.indigo700,
                                    fontSize: 30,
                                  ),),
                                Text(address,
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: AppColors.indigo700,
                                    fontSize: 30,
                                  ),)
                              ],
                            ),
                            Spacer(flex: 4,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text("Gender :",
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: Color(0xff434445),
                                    fontSize: 30,
                                  ),),
                                Text("Class :",
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: Color(0xff434445),
                                    fontSize: 30,
                                  ),),
                                Text("Batch :",
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: Color(0xff434445),
                                    fontSize: 30,
                                  ),),
                                Text("Password :",
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: Color(0xff434445),
                                    fontSize: 30,
                                  ),),
                                SizedBox(),
                              ],
                            ),
                            Spacer(flex: 1,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(gender,
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: AppColors.indigo700,
                                    fontSize: 30,
                                  ),),
                                Text(className,
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: AppColors.indigo700,
                                    fontSize: 30,
                                  ),),
                                Text("Batch",
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: AppColors.indigo700,
                                    fontSize: 30,
                                  ),),
                                Text(password,
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: AppColors.indigo700,
                                    fontSize: 30,
                                  ),),
                                SizedBox(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 245,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.appBackgroundColor,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff707070).withOpacity(.4),
                              offset: Offset(0, 0),
                              blurRadius: 6,
                            )
                          ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 40),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text("Father's Name :",
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: Color(0xff434445),
                                    fontSize: 30,
                                  ),),
                                Text("Father's Contact : ",
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: Color(0xff434445),
                                    fontSize: 30,
                                  ),),
                                Text("Designation : ",
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: Color(0xff434445),
                                    fontSize: 30,
                                  ),),
                              ],
                            ),
                            Spacer(flex: 1,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text("$fatherName",
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: AppColors.indigo700,
                                    fontSize: 30,
                                  ),),
                                Text(fatherContact,
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: AppColors.indigo700,
                                    fontSize: 30,
                                  ),),
                                Text(fatherDesignation,
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: AppColors.indigo700,
                                    fontSize: 30,
                                  ),),
                              ],
                            ),
                            Spacer(flex: 4,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text("Mother's Name :",
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: Color(0xff434445),
                                    fontSize: 30,
                                  ),),
                                Text("Mother's Contact : ",
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: Color(0xff434445),
                                    fontSize: 30,
                                  ),),
                                Text("Designation : ",
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: Color(0xff434445),
                                    fontSize: 30,
                                  ),),
                              ],
                            ),
                            Spacer(flex: 1,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text("$motherName",
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: AppColors.indigo700,
                                    fontSize: 30,
                                  ),),
                                Text(motherContact,
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: AppColors.indigo700,
                                    fontSize: 30,
                                  ),),
                                Text(motherDesignation,
                                  style:  TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: AppColors.indigo700,
                                    fontSize: 30,
                                  ),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child:Padding(
                padding: const EdgeInsets.only(right: 20,bottom: 20),
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text("Cancel",
                    style:  TextStyle(
                      fontFamily: 'ProductSans',
                      color: AppColors.indigo700,
                      fontSize: 25,
                    ),),
                ),
              ),
            ),

            // Positioned(child: child)
          ],
        ),
      );
    },
  );

}


Widget editInputField({Function onChanged,double width,double height,Function validator,String initialText}){
  width = width == null ?203:width;
  height = height == null ? 27:height;
  return SizedBox(
    height: height,
    width: width,
    child: TextField(
      controller: TextEditingController(text: initialText),
      onChanged: onChanged,
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
      // validator: validator,
    ),
  );
}