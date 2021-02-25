import 'dart:typed_data';

import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Model/academic_student_model.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/widge.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';

class AddAcademicStudent extends StatefulWidget {
  final String yearId;
  final int year;
  AddAcademicStudent(this.yearId,this.year);
  @override
  _AddAcademicStudentState createState() => _AddAcademicStudentState();
}

class _AddAcademicStudentState extends State<AddAcademicStudent> {
  int selectedIndex;
  String classId;
  String className;
  String preClassId;
  List<AcademicStudentModel> academicStudentModel =[];
  final _formKey = GlobalKey<FormState>();
  Uint8List bytesFromPicker;
  String firstName;
  String middleName;
  String lastName;
  String rollNo;
  String fatherName;
  String motherName;
  String motherContact;
  String fatherContact;
  String motherDesignation;
  String fatherDesignation;
  String password;
  String confirmPassword;
  String address;
  String emailAddress;
  String studentID;
  String dateOfBirth = DateTime.now().toString();
  String contact;
  String gender = 'Male';
  String imageUrl;
  String imagePath;

  List <String> getGender = [
    'Male',
    'Female',
    'Other',
  ] ;
  DateTime currentDateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 35),
        child: Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .7,
              width:MediaQuery.of(context).size.width * .6,
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
              child: Column(
                children: [
                  Container(
                    height: 70,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),),
                      color: AppColors.indigo700,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        children: [
                          Spacer(flex: 1,),
                          Text("Student ID: ",
                            style: TextStyle(
                                fontFamily: 'ProductSans',
                                color: AppColors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),),
                          Spacer(flex: 4,),
                          Text("Student Form",
                            style: TextStyle(
                                fontFamily: 'ProductSans',
                                color: AppColors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            ),),
                          Spacer(flex: 3,),
                          Text("Admission No:   ",
                            style: TextStyle(
                                fontFamily: 'ProductSans',
                                color: AppColors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          Spacer(flex: 2,),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 50),
                    child: Row(
                      children: [
                        // Tooltip(
                        //   message:'Tap to insert or edit image',
                        //   margin: EdgeInsets.only(top: 10),
                        //   padding: EdgeInsets.all(4),
                        //   child: GestureDetector(
                        //     onTap:  () async{
                        //       Uint8List bytesPicker =
                        //       await ImagePickerWeb.getImage(outputType: ImageType.bytes);
                        //
                        //       if (bytesPicker != null) {
                        //         setState(() {
                        //           bytesFromPicker = bytesPicker;
                        //         });
                        //
                        //       }
                        //     },
                        //     child:Container(
                        //       width: 129.0,
                        //       height: 129.0,
                        //       decoration: new BoxDecoration(
                        //         shape: BoxShape.circle,
                        //         color:AppColors.indigo700,
                        //       ),
                        //       alignment: Alignment.center,
                        //       child: Container(
                        //         width: 125.0,
                        //         height: 125.0,
                        //         decoration: new BoxDecoration(
                        //           shape: BoxShape.circle,
                        //           color:AppColors.white,
                        //         ),
                        //         alignment: Alignment.center,
                        //         child:bytesFromPicker != null ? ClipRRect(
                        //             borderRadius: BorderRadius.circular(80),
                        //             child: Image.memory(
                        //               bytesFromPicker,
                        //               fit:BoxFit.fill,width: 125,height: 125,
                        //               filterQuality: FilterQuality.high,
                        //             )):Icon(
                        //           Icons.add,
                        //           size: 48,
                        //           color: AppColors.indigo700,),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        Spacer(flex: 5,),
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
                            Text("Middle Name",
                          style: TextStyle(
                              fontFamily: 'ProductSans',
                              color: AppColors.textColorBlack,
                              fontSize: 25,
                              fontWeight: FontWeight.normal
                          ),),
                            SizedBox(height: 35,),
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
                        Spacer(flex: 1,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            ///First Name
                            inputField(
                              onChanged: (value){
                                firstName = value;
                              },

                            ),
                            SizedBox(height: 35,),
                            ///MiddleNAme
                            inputField(
                              onChanged: (value){

                                middleName = value;

                              },
                            ),
                            SizedBox(height: 35,),
                            /// LastName
                            inputField(
                              onChanged: (value){

                                lastName  = value;

                              },
                            ),
                            SizedBox(height: 35,),
                            ///class
                            inputField(
                                onChanged: (value){


                                  classId = value;

                                }
                            ),
                            SizedBox(height: 35,),

                            ///email
                            inputField(
                                onChanged: (value){


                                  emailAddress = value;

                                }
                            ),
                            SizedBox(height: 35,),
                          ],
                        ),
                        Spacer(flex: 3,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text("Date Of Birth",
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
                            Text("Gender",
                              style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  color: AppColors.textColorBlack,
                                  fontSize: 25,
                                  fontWeight: FontWeight.normal
                              ),),
                            SizedBox(height: 35,),
                            Text("StudentId",
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
                        Spacer(flex: 1,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            ///DOB
                            Tooltip(
                              message: 'Select Date',
                              decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient:LinearGradient(colors: [AppColors.redAccent,AppColors.loginBackgroundColor,]),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  currentDateTime = await  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(3000),
                                    currentDate:DateTime.now(),
                                  );
                                  if(currentDateTime  != null){
                                    setState(() {

                                    });
                                  }
                                  else{
                                    currentDateTime = DateTime.now();
                                    setState(() {

                                    });
                                  }

                                },
                                child: Container(
                                  width: 203,
                                  height: 27,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: AppColors.white100,
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color(0xff707070).withOpacity(.4),
                                            offset: Offset(1, 1),
                                            blurRadius: 1),
                                      ]
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(toHumanReadableDate(currentDateTime),style: TextStyle(
                                      color: Color(0xff263859),fontSize: 20,fontWeight: FontWeight.bold
                                  ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 35,),
                            ///Contact
                            inputField(
                              onChanged: (value){
                                contact= value;

                                contact= value;

                              },),
                            SizedBox(height: 35,),
                            ///Gender
                            Container(
                              height: 30,
                              width: 203,
                              decoration: BoxDecoration(
                                color: Color(0xFFE2E8F0),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.fromLTRB(25, 0, 4, 0),
                                  child: DropdownButton<String>(
                                    value: gender,
                                    icon: Padding(
                                      padding: const EdgeInsets.only(left: 70),
                                      child: Icon(Icons.arrow_drop_down),
                                    ),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(color: Colors.red, fontSize: 18),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.transparent,
                                    ),
                                    onChanged: (String data) {
                                      setState(() {
                                        gender = data;
                                      });
                                    },
                                    items: getGender.map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value,
                                          style: TextStyle(
                                              fontFamily: 'ProductSans',
                                              color: AppColors.textColorBlack,
                                              fontSize: 20,
                                              fontWeight: FontWeight.normal
                                          )
                                          ,),
                                      );

                                    }).toList(),
                                  )
                              ),
                            ),
                            SizedBox(height: 35,),
                            ///StudentId
                            inputField(
                                onChanged: (value){


                                  studentID = value;

                                }
                            ),
                            SizedBox(height: 35,),
                            ///password
                            inputField(
                                onChanged: (value){


                                  password = value;

                                }
                            ),
                            SizedBox(height: 35,),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              height: MediaQuery.of(context).size.height * .7,
              width:MediaQuery.of(context).size.width * .25,
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
            ),
          ],
        ),
      ),
    );
  }

  Widget inputField({Function onChanged,double width,double height,Function validator}){
    width = width == null ?203:width;
    height = height == null ? 27:height;
    return SizedBox(
      height: height,
      width: width,
      child: TextField(

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
}
