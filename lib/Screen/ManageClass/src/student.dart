import 'dart:typed_data';

import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Model/academic_student_model.dart';
import 'package:academia_admin_panel/Screen/ManageClass/ApiEndPoint/student_api.dart';
import 'package:academia_admin_panel/Screen/ManageClass/Notifier/class_notifier.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/widge.dart';
import 'package:academia_admin_panel/Screen/ManageClass/vm/manage_student_vm.dart';
import 'package:academia_admin_panel/error.dart';
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:academia_admin_panel/vm_service/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

import 'package:image_picker_web/image_picker_web.dart';
import 'package:provider/provider.dart';

class StudentField extends StatefulWidget {
  @override
  _StudentFieldState createState() => _StudentFieldState();
}

class _StudentFieldState extends State<StudentField> {
  int selectedIndex;
  String classId;
  String preClassId;
  List<AcademicStudentModel> academicStudentModel =[];
  final _formKey = GlobalKey<FormState>();
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
              child: Consumer<ClassNotifier>(
                 builder: (context,classNotifier,child){
                 classId = classNotifier.getModelId();
                  print("classId = $classId");
                   return  BaseView<ManageStudentVm>(
                     loaderWidget: Center(child: CircularProgressIndicator()),
                     onVMReady: (ManageStudentVm vm){
                       vm.init(classId);
                     },
                     builder: (_, vm, child) {
                       if(classId == preClassId){
                         if(vm.isError == false){
                           academicStudentModel = vm.academicStudentModel;
                           return studentListBuilder(academicStudentModel);
                         }
                         return SizedBox();
                       }
                       else{
                         preClassId = classId;
                         vm.refresh(classId);
                         return SizedBox();
                       }

                     }
                 );
                  }),
              ),
        ],
      ),
    );
  }
   Widget studentListBuilder(List<AcademicStudentModel> listOfStudents){
     if(listOfStudents != null && listOfStudents.isNotEmpty){
       return  Padding(
         padding: const EdgeInsets.only(bottom: 20),
         child: ListView.builder(
             scrollDirection: Axis.vertical,
             itemCount: academicStudentModel.length,
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
                             Text('${academicStudentModel[index].firstName}',style: TextStyle(
                                 fontFamily: 'ProductSans',
                                 fontSize: 30,
                                 fontWeight: FontWeight.normal,
                                 color: AppColors.textColorBlack
                             ),),
                             Row(children: [
                               InkWell(
                                 onTap: ()async{
                                   await editStudentInput(context,academicStudentModel[index]);
                                 },
                                   child: Icon(Icons.edit,size: 30,)),
                               SizedBox(width: 50,),
                               InkWell(
                                 onTap: () async {
                                   try{
                                     var response = await deleteAcademicStudent(academicStudentModel[index].id);
                                     if(response["httpStatusCode"] == 204){
                                       setState(() {
                                         academicStudentModel.removeAt(index);
                                       });
                                     }
                                     else if(response["httpStatusCode"] == 500){
                                       String message = response["responseJson"]['message'];
                                       showToast(context, message);
                                     }
                                   }
                                   catch(error){
                                     showToast(context, 'something went wrong!');
                                   }
                                 },
                                   child: Icon(Icons.delete,size: 30,),
                               )
                             ],)
                           ],
                         ),
                       ),
                     ),
                   ),
                 ),
               );
             }),
       );
     }
     return Center(child: Text("No data"),);
   }
  addStudentInput(BuildContext context){
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
        return  StatefulBuilder(
        key: GlobalKey(),
        builder: (context,StateSetter studentState){
          return  Container(
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

            child:  Form(
              key: _formKey,
              child: Stack(
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
                          Text("Admission No:   ${academicStudentModel.length + 1}",
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
                                  ///First Name
                                  inputField(
                                    onChanged: (value){

                                      studentState(() {
                                        firstName = value;
                                      });
                                    },
                                    validator: (value){

                                    }
                                  ),
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
                                            studentState(() {
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
                                  ///Contact
                                  inputField(
                                    onChanged: (value){
                                     contact= value;
                                     studentState(() {
                                       contact= value;
                                     });
                                  },),
                                  SizedBox(height: 35,),
                                  ///Email
                                  inputField(
                                   onChanged: (value){

                                     studentState(() {
                                       emailAddress = value;
                                     });
                                   }
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
                                  Text("Address",
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
                                  ///MiddleNAme
                                  inputField(
                                    onChanged: (value){
                                     studentState(() {
                                       middleName = value;
                                     });
                                    },
                                  ),
                                  SizedBox(height: 35,),
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
                                          studentState(() {

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
                                  ///Address
                                   inputField(
                                     onChanged: (value){
                                       studentState(() {
                                         address = value;
                                       });

                                     },
                                   ),
                                  SizedBox(height: 35,),
                                  ///Password
                                   inputField(
                                     onChanged: (value){
                                       studentState(() {
                                        password = value;
                                      });
                                     },
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
                                  Text("Roll No",
                                    style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        color: AppColors.textColorBlack,
                                        fontSize: 25,
                                        fontWeight: FontWeight.normal
                                    ),),
                                  SizedBox(height: 35,),
                                  Text("StudentID",
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
                                  /// LastName
                                  inputField(
                                    onChanged: (value){
                                     studentState(() {
                                       lastName  = value;
                                     });
                                    },
                                  ),
                                  SizedBox(height: 35,),
                                  ///RollNo
                                  inputField(
                                    onChanged: (value){
                                      studentState(() {
                                        rollNo = value;
                                      });


                                    },
                                  ),
                                  SizedBox(height: 35,),
                                  ///StudentId
                                  inputField(
                                    onChanged: (value){
                                      studentState(() {
                                        studentID = value;
                                        print(studentID);
                                      });
                                    },
                                  ),
                                  SizedBox(height: 35,),
                                  ///ConfirmPassword
                                  inputField(
                                    onChanged: (value){
                                    studentState(() {
                                      confirmPassword = value;
                                    });
                                    },
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
                                      /// father NAme
                                      inputField(width: 380,
                                      onChanged: (value){
                                        studentState(() {
                                          fatherName = value;
                                        });
                                      }),
                                      SizedBox(height: 35,),
                                      /// father contact
                                      inputField(width: 300,
                                          onChanged: (value){

                                            studentState(() {
                                              fatherContact = value;
                                            });
                                          }),
                                      SizedBox(height: 35,),
                                      ///fatherDesignation
                                      inputField(width: 300,
                                          onChanged: (value){
                                            studentState(() {
                                              fatherDesignation = value;
                                            });

                                          }),
                                      SizedBox(height: 35,),
                                    ],
                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      Text("Mother's Name",
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
                                      inputField(width: 380,
                                          onChanged: (value){
                                            studentState(() {
                                              motherName = value;
                                            });

                                          }),
                                      SizedBox(height: 35,),
                                      inputField(width: 300,
                                          onChanged: (value){
                                            studentState(() {
                                              motherContact = value;
                                            });

                                          }),
                                      SizedBox(height: 35,),
                                      inputField(width: 300,
                                          onChanged: (value){
                                            studentState(() {
                                              motherDesignation = value;
                                            });

                                          }),
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
                          InkWell(
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
                          Spacer(flex: 5,),
                          Text("Edit",
                            style:TextStyle(
                                fontFamily: 'ProductSans',
                                color: AppColors.indigo700,
                                fontSize: 25,

                            ),),
                          Spacer(flex: 1,),
                          InkWell(
                            onTap: () async{
                              try{
                                  AcademicStudentModel newStudent = AcademicStudentModel(
                                    classId: classId,
                                    firstName: firstName,
                                    middleName: middleName,
                                    lastName: lastName,
                                    gender: gender,
                                    dateOfBirth: currentDateTime.toString(),
                                    rollNo: rollNo,
                                    contact: contact,
                                    address: address,
                                    email: emailAddress,
                                    password: password,
                                    confirmPassword: confirmPassword,
                                    fatherName: fatherName,
                                    fatherContact: fatherContact,
                                    fatherDesignation: fatherDesignation,
                                    motherName: motherName,
                                    motherContact: motherContact,
                                    motherDesignation: motherDesignation,
                                  );
                                  print(newStudent.fatherName);
                                  var response = await createAcademicStudent(newStudent.toJson());
                                  print("responce $response");
                                  if(response["httpStatusCode"] == 201){
                                    String id = response["responseJson"]["data"]["id"];
                                    newStudent.id = id;
                                    setState(() {
                                      academicStudentModel.add(newStudent);
                                    });
                                    Navigator.of(context).pop();
                                  }
                                  else if(response["httpStatusCode"] == 500){
                                    String message = response["responseJson"]['message'];
                                    showToast(context, message);
                                  }
                              }
                              catch(error){
                                if (error is ApiError) {
                                  logger.e("Api Error: ${error.toString()}");
                                  print(error);
                                } else {
                                  // logCrashlyticsError(error, stacktrace: stackTrace);
                                  // reportErrorToSentry(error, stacktrace: stackTrace);
                                  showToast(context, 'Something went wrong!');
                                }

                              }


                            },
                            child: Container(
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

  editStudentInput(BuildContext context, AcademicStudentModel student){
    Uint8List bytesFromPicker;
    String firstName = student.firstName;
    String middleName = student.middleName;
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
        return  StatefulBuilder(
            key: GlobalKey(),
            builder: (context,StateSetter studentState){
              return  Container(
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

                child:  Form(
                  key: _formKey,
                  child: Stack(
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
                              Text("Admission No:   ${academicStudentModel.length + 1}",
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
                                      ///First Name
                                      inputField(
                                        initialText: student.firstName,
                                          onChanged: (value){

                                            studentState(() {
                                              firstName = value;
                                            });
                                          },
                                          validator: (value){

                                          }
                                      ),
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
                                                studentState(() {
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
                                      ///Contact
                                      inputField(
                                        initialText: student.contact,
                                        onChanged: (value){
                                          contact= value;
                                          studentState(() {
                                            contact= value;
                                          });
                                        },),
                                      SizedBox(height: 35,),
                                      ///Email
                                      inputField(
                                          initialText: student.email,
                                          onChanged: (value){

                                            studentState(() {
                                              emailAddress = value;
                                            });
                                          }
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
                                      Text("Address",
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
                                      ///MiddleNAme
                                      inputField(
                                        initialText: student.middleName,
                                        onChanged: (value){
                                          studentState(() {
                                            middleName = value;
                                          });
                                        },
                                      ),
                                      SizedBox(height: 35,),
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
                                              studentState(() {

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
                                      ///Address
                                      inputField(
                                        initialText: student.address,
                                        onChanged: (value){
                                          studentState(() {
                                            address = value;
                                          });

                                        },
                                      ),
                                      SizedBox(height: 35,),
                                      ///Password
                                      inputField(
                                        initialText: student.password,
                                        onChanged: (value){
                                          studentState(() {
                                            password = value;
                                          });
                                        },
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
                                      Text("Roll No",
                                        style: TextStyle(
                                            fontFamily: 'ProductSans',
                                            color: AppColors.textColorBlack,
                                            fontSize: 25,
                                            fontWeight: FontWeight.normal
                                        ),),
                                      SizedBox(height: 35,),
                                      Text("StudentID",
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
                                      /// LastName
                                      inputField(
                                        initialText: student.lastName,
                                        onChanged: (value){
                                          studentState(() {
                                            lastName  = value;
                                          });
                                        },
                                      ),
                                      SizedBox(height: 35,),
                                      ///RollNo
                                      inputField(
                                        initialText: student.rollNo,
                                        onChanged: (value){
                                          studentState(() {
                                            rollNo = value;
                                          });


                                        },
                                      ),
                                      SizedBox(height: 35,),
                                      ///StudentId
                                      inputField(
                                        //initialText: student.,
                                        onChanged: (value){
                                          studentState(() {
                                            studentID = value;
                                            print(studentID);
                                          });
                                        },
                                      ),
                                      SizedBox(height: 35,),
                                      ///ConfirmPassword
                                      inputField(
                                        initialText: student.password,
                                        onChanged: (value){
                                          studentState(() {
                                            confirmPassword = value;
                                          });
                                        },
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
                                        /// father NAme
                                        inputField(width: 380,
                                            initialText: student.fatherName,
                                            onChanged: (value){
                                              fatherName = value;
                                              studentState(() {
                                                fatherName = value;
                                              });
                                            }),
                                        SizedBox(height: 35,),
                                        /// father contact
                                        inputField(width: 300,
                                            initialText: student.fatherContact,
                                            onChanged: (value){

                                              studentState(() {
                                                fatherContact = value;
                                              });
                                            }),
                                        SizedBox(height: 35,),
                                        ///fatherDesignation
                                        inputField(width: 300,
                                            initialText: student.fatherDesignation,
                                            onChanged: (value){
                                              studentState(() {
                                                fatherDesignation = value;
                                              });

                                            }),
                                        SizedBox(height: 35,),
                                      ],
                                    ),

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                        Text("Mother's Name",
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
                                        ///motherName
                                        inputField(width: 380,
                                            initialText: student.motherName,
                                            onChanged: (value){
                                              studentState(() {
                                                motherName = value;
                                              });

                                            }),
                                        SizedBox(height: 35,),
                                        ///mother contact
                                        inputField(width: 300,
                                            initialText: student.motherContact,
                                            onChanged: (value){
                                              studentState(() {
                                                motherContact = value;
                                              });

                                            }),
                                        SizedBox(height: 35,),
                                        ///motherDesignation
                                        inputField(width: 300,
                                            initialText: student.motherDesignation,
                                            onChanged: (value){
                                              studentState(() {
                                                motherDesignation = value;
                                              });

                                            }),
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
                              InkWell(
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
                              Spacer(flex: 5,),
                              Text("Edit",
                                style:TextStyle(
                                  fontFamily: 'ProductSans',
                                  color: AppColors.indigo700,
                                  fontSize: 25,

                                ),),
                              Spacer(flex: 1,),
                              InkWell(
                                onTap: () async{
                                  try{
                                    AcademicStudentModel newStudent = AcademicStudentModel(
                                      classId: classId,
                                      firstName: firstName,
                                      middleName: middleName,
                                      lastName: lastName,
                                      gender: gender,
                                      dateOfBirth: currentDateTime.toString(),
                                      rollNo: rollNo,
                                      contact: contact,
                                      address: address,
                                      email: emailAddress,
                                      password: password,
                                      confirmPassword: confirmPassword,
                                      fatherName: fatherName,
                                      fatherContact: fatherContact,
                                      fatherDesignation: fatherDesignation,
                                      motherName: motherName,
                                      motherContact: motherContact,
                                      motherDesignation: motherDesignation,
                                    );
                                    print(newStudent.fatherName);
                                    var response = await createAcademicStudent(newStudent.toJson());
                                    print("responce $response");
                                    if(response["httpStatusCode"] == 201){
                                      String id = response["responseJson"]["data"]["id"];
                                      newStudent.id = id;
                                      setState(() {
                                        academicStudentModel.add(newStudent);
                                      });
                                      Navigator.of(context).pop();
                                    }
                                    else if(response["httpStatusCode"] == 500){
                                      String message = response["responseJson"]['message'];
                                      showToast(context, message);
                                    }
                                  }
                                  catch(error){
                                    if (error is ApiError) {
                                      logger.e("Api Error: ${error.toString()}");
                                      print(error);
                                    } else {
                                      // logCrashlyticsError(error, stacktrace: stackTrace);
                                      // reportErrorToSentry(error, stacktrace: stackTrace);
                                      showToast(context, 'Something went wrong!');
                                    }

                                  }


                                },
                                child: Container(
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

  Widget inputField({Function onChanged,double width,double height,Function validator,String initialText}){
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

}
