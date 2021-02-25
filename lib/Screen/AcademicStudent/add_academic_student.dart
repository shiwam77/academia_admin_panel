import 'dart:typed_data';

import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Model/academic_class_model.dart';
import 'package:academia_admin_panel/Model/academic_student_model.dart';
import 'package:academia_admin_panel/Model/user_model.dart';
import 'package:academia_admin_panel/Screen/ManageClass/ApiEndPoint/student_api.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/widge.dart';
import 'package:academia_admin_panel/Screen/ManageClass/vm/manage_class_vm.dart';
import 'package:academia_admin_panel/error.dart';
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:academia_admin_panel/vm_service/base_view.dart';
import 'package:academia_admin_panel/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

class AddAcademicStudent extends StatefulWidget {
  final String yearId;
  final int year;
  AddAcademicStudent(this.yearId,this.year);
  @override
  _AddAcademicStudentState createState() => _AddAcademicStudentState();
}

class _AddAcademicStudentState extends State<AddAcademicStudent> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController rollNoController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController fatherContactController = TextEditingController();
  TextEditingController motherContactController = TextEditingController();
  TextEditingController fatherDesignationController = TextEditingController();
  TextEditingController motherDesignationController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailAddressController = TextEditingController();
  TextEditingController studentIDController = TextEditingController();
  TextEditingController contactController = TextEditingController();

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
  List<AcademicClassModel> academicClassModel =[];
  AcademicClassModel classes;
  List <String> getGender = [
    'Male',
    'Female',
    'Other',
  ] ;
  DateTime currentDateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BaseView<ManageClassVm>(
        loaderWidget: Center(child: CircularProgressIndicator()),
        onVMReady: (ManageClassVm vm){
          vm.init(widget.yearId);
        },
        builder: (_, vm, child) {
          if(vm.isError == false){
            academicClassModel = vm.academicClassModel;
            return body(academicClassModel);
          }
          return SizedBox();
        }
    );
  }
  Widget body(List<AcademicClassModel> academicClassModel){
    if(academicClassModel != null && academicClassModel.length > 0){
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Row(
            children: [
              Container(
                height: 756,
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
                      padding: const EdgeInsets.only(top: 50,left: 50,right: 50),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 450),
                            child: Tooltip(
                              message:'Tap to insert or edit image',
                              margin: EdgeInsets.only(top: 10),
                              padding: EdgeInsets.all(4),
                              child: GestureDetector(
                                onTap:  () async{
                                  Uint8List bytesPicker =
                                  await ImagePickerWeb.getImage(outputType: ImageType.bytes);

                                  if (bytesPicker != null) {
                                    setState(() {
                                      bytesFromPicker = bytesPicker;
                                    });

                                  }
                                },
                                child:Container(
                                  width: 129.0,
                                  height: 129.0,
                                  decoration: new BoxDecoration(
                                    shape: BoxShape.circle,
                                    color:AppColors.indigo700,
                                  ),
                                  alignment: Alignment.center,
                                  child: Container(
                                    width: 125.0,
                                    height: 125.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:AppColors.white,
                                    ),
                                    alignment: Alignment.center,
                                    child:bytesFromPicker != null ? ClipRRect(
                                        borderRadius: BorderRadius.circular(80),
                                        child: Image.memory(
                                          bytesFromPicker,
                                          fit:BoxFit.fill,width: 125,height: 125,
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
                              Text("Address",
                                style: TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: AppColors.textColorBlack,
                                    fontSize: 25,
                                    fontWeight: FontWeight.normal
                                ),),
                              SizedBox(height: 35,),
                              Text("Father Name",
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

                          SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              ///First Name
                              inputField(
                                controller: firstNameController,
                                onChanged: (value){
                                  firstName = value;
                                },

                              ),
                              SizedBox(height: 35,),
                              ///MiddleNAme
                              inputField(
                                controller:middleNameController,
                                onChanged: (value){

                                  middleName = value;

                                },
                              ),
                              SizedBox(height: 35,),
                              /// LastName
                              inputField(
                                controller:lastNameController,
                                onChanged: (value){

                                  lastName  = value;

                                },
                              ),
                              SizedBox(height: 35,),
                              ///class
                              Container(
                                height: 30,
                                width: 203,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE2E8F0),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(25, 0, 4, 0),
                                    child: DropdownButton<AcademicClassModel>(
                                      value: classes,
                                      hint: Text("Select class"),
                                      icon: Padding(
                                        padding: const EdgeInsets.only(left: 50),
                                        child: Icon(Icons.arrow_drop_down),
                                      ),
                                      iconSize: 24,
                                      elevation: 16,
                                      style: TextStyle(color: Colors.red, fontSize: 18),
                                      underline: Container(
                                        height: 2,
                                        color: Colors.transparent,
                                      ),
                                      onChanged: (AcademicClassModel data) {
                                        setState(() {
                                          classes = data;
                                          classId = data.id;
                                        });
                                      },
                                      items: academicClassModel.map<DropdownMenuItem<AcademicClassModel>>((AcademicClassModel value) {
                                        return DropdownMenuItem<AcademicClassModel>(
                                          value: value,
                                          child: Text(value.className,
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

                              ///email
                              inputField(
                                  controller:emailAddressController,
                                  onChanged: (value){


                                    emailAddress = value;

                                  }
                              ),
                              SizedBox(height: 35,),

                              ///address
                              inputField(
                                controller:addressController,
                                onChanged: (value){
                                  address = value;
                                },),
                              SizedBox(height: 35,),
                              ///Father Name
                              inputField(
                                controller:fatherNameController,
                                onChanged: (value){
                                  fatherName = value;
                                },

                              ),
                              SizedBox(height: 35,),
                              ///FatherContact
                              inputField(
                                controller:fatherContactController,
                                onChanged: (value){

                                  fatherContact = value;

                                },
                              ),
                              SizedBox(height: 35,),
                              /// fatherDesignation
                              inputField(
                                controller:fatherDesignationController,
                                onChanged: (value){

                                  fatherDesignation  = value;

                                },
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
                              Text("RollNo",
                                style: TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: AppColors.textColorBlack,
                                    fontSize: 25,
                                    fontWeight: FontWeight.normal
                                ),),
                              SizedBox(height: 35,),
                              Text("Mother Name",
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

                          SizedBox(width: 20,),
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
                                controller: contactController,
                                onChanged: (value){
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
                                    child: SizedBox(
                                      height: 203,
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
                                      ),
                                    )
                                ),
                              ),
                              SizedBox(height: 35,),
                              ///StudentId
                              inputField(
                                  controller: studentIDController,
                                  onChanged: (value){


                                    studentID = value;

                                  }
                              ),
                              SizedBox(height: 35,),
                              ///password
                              inputField(
                                  controller: passwordController,
                                  onChanged: (value){


                                    password = value;

                                  }
                              ),
                              SizedBox(height: 35,),

                              ///RollNo
                              inputField(
                                controller: rollNoController,
                                onChanged: (value){
                                  rollNo = value;
                                },

                              ),
                              SizedBox(height: 35,),

                              ///Mother Name
                              inputField(
                                controller: motherNameController,
                                onChanged: (value){
                                  motherName = value;
                                },

                              ),
                              SizedBox(height: 35,),
                              ///MotherContact
                              inputField(
                                controller: motherContactController,
                                onChanged: (value){

                                  motherContact = value;

                                },
                              ),
                              SizedBox(height: 35,),
                              /// MotherDesignation
                              inputField(
                                controller: motherDesignationController,
                                onChanged: (value){

                                  motherDesignation  = value;

                                },
                              ),
                              SizedBox(height: 35,),
                            ],
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: (){
                              clearField();
                            },
                            child: Text("Cancel",
                              style:  TextStyle(
                                fontFamily: 'ProductSans',
                                color: AppColors.indigo700,
                                fontSize: 16,
                              ),),
                          ),
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
                                    //admissionNo: admissionNo,
                                    studentID: studentID
                                );
                                Map<String,String> user ={
                                  "email":emailAddress,
                                  "password":password,
                                  "passwordConfirm":password,
                                  "name":"$firstName $middleName $lastName",
                                  "userType":"user"
                                };
                                var studentAsUserResponse = await createStudentAsUser(user);
                                if(studentAsUserResponse["httpStatusCode"] == 201){

                                  var user = GetUserAuth.fromJson(studentAsUserResponse["responseJson"]);
                                  print(user.userId);
                                  newStudent.studentAsUserId = user.userId;
                                  var response = await createAcademicStudent(newStudent.toJson());
                                  if(response["httpStatusCode"] == 201){
                                    String id = response["responseJson"]["data"]["id"];
                                    newStudent.id = id;
                                    clearField();
                                    setState(() {
                                      academicStudentModel.add(newStudent);
                                    });

                                  }
                                  else {
                                    String message = response["responseJson"]['message'];
                                    showToast(context, message);
                                  }
                                }
                                else {
                                  String message = studentAsUserResponse["responseJson"]['message'];
                                  showToast(context, message);
                                }
                              }
                              catch(error){
                                if (error is ApiError) {
                                  logger.e("Api Error: ${error.toString()}");

                                } else {
                                  showToast(context, 'Something went wrong!');
                                }

                              }finally{


                              }

                            },
                            child: Container(
                              height: 36,
                              width: 175,
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                height: 756,
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
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),),
                        color: AppColors.indigo700,
                      ),
                      child: Text("Recently Added",
                        style: TextStyle(
                            fontFamily: 'ProductSans',
                            color: AppColors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                        ),),
                    ),
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount:academicClassModel.length,
                        itemBuilder: (context,index){
                          List<AcademicStudentModel> classWiseStudent = academicStudentModel.where((student) => student.classId == academicClassModel[index].id).toList();
                          return classWiseStudent.length != 0 ? LimitedBox(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 30),
                              child: Container(
                                height: 200,
                                width: MediaQuery.of(context).size.width * .25,
                                child: Column(
                                  children: [
                                    SizedBox(height: 10,),
                                    Text("${academicClassModel[index].className}",
                                      style:  TextStyle(
                                        fontFamily: 'ProductSans',
                                        color: AppColors.textColorBlack,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                    ),),
                                    SizedBox(height: 10,),
                                    Container(
                                      height: 150,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                          itemCount: classWiseStudent.length,
                                          itemBuilder: (context,index){
                                        return LimitedBox(
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 20),
                                            child: Container(
                                              height: 130,
                                              width: 350,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(30),
                                                  color: AppColors.appBackgroundColor,
                                                 ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.fromLTRB(10, 30, 40, 0),
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 75.0,
                                                            decoration: new BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color:AppColors.indigo700,
                                                            ),
                                                            alignment: Alignment.center,
                                                            child: Container(
                                                              width: 70,
                                                              height: 70,
                                                              decoration: new BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                color:AppColors.white,
                                                              ),
                                                              alignment: Alignment.center,
                                                              child:bytesFromPicker != null ? ClipRRect(
                                                                  borderRadius: BorderRadius.circular(40),
                                                                  child: Image.memory(
                                                                    bytesFromPicker,
                                                                    fit:BoxFit.fill,width: 70,height: 70,
                                                                    filterQuality: FilterQuality.high,
                                                                  )):Icon(
                                                                Icons.add,
                                                                size: 48,
                                                                color: AppColors.indigo700,),
                                                            ),
                                                          ),
                                                          SizedBox(width: 40,),
                                                          Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            crossAxisAlignment: CrossAxisAlignment.baseline,
                                                            textBaseline: TextBaseline.alphabetic,
                                                            children: [
                                                              Text("${classWiseStudent[index].firstName ?? ""} ${classWiseStudent[index].middleName ?? ""} ${classWiseStudent[index].lastName ?? ""}",
                                                               maxLines: 3,
                                                                style:  TextStyle(
                                                                  fontFamily: 'ProductSans',
                                                                  color: AppColors.indigo700,
                                                                  fontSize: 23,
                                                                  fontWeight: FontWeight.bold
                                                                ),),
                                                              Text("31,${classWiseStudent[index].gender}",
                                                                style:  TextStyle(
                                                                    fontFamily: 'ProductSans',
                                                                    color: Color(0xff9D949C),
                                                                    fontSize: 15,
                                                                ),),
                                                               SizedBox(height: 25,),
                                                              Row(
                                                                children: [
                                                                  InkWell(
                                                                    onTap: (){
                                                                      editStudentInput(context,classWiseStudent[index],index,classes.id);
                                                                    },
                                                                    child: Text("Edit",
                                                                      style:  TextStyle(
                                                                        fontFamily: 'ProductSans',
                                                                        color: AppColors.textColorBlack,
                                                                        fontSize: 12,
                                                                      ),),
                                                                  ),
                                                                  SizedBox(width: 10,),
                                                                  InkWell(
                                                                    onTap: (){
                                                                      viewStudentInput(context,classWiseStudent[index],classes.className);
                                                                    },
                                                                    child: Text("View",
                                                                      style:  TextStyle(
                                                                        fontFamily: 'ProductSans',
                                                                        color: AppColors.indigo600,
                                                                        fontSize: 12,
                                                                      ),),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                    SizedBox(height: 10,),
                                  ],
                                ),
                              ),
                            ),
                          ):SizedBox();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Center(
      child: Text("Please create class in manage class screen"),
    );
  }
  clearField(){
    firstNameController.clear();
    middleNameController.clear();
    lastNameController.clear();
    rollNoController.clear();
    fatherNameController.clear();
    motherNameController.clear();
    fatherContactController.clear();
    motherContactController.clear();
    fatherDesignationController.clear();
    motherDesignationController.clear();
    passwordController.clear();
    addressController.clear();
    emailAddressController.clear();
    studentIDController.clear();
    contactController.clear();
    firstName = null;
    middleName = null;
    lastName = null;
    rollNo = null;
    fatherName = null;
    motherName=null;
    fatherDesignation = null;
    motherDesignation = null;
    fatherContact = null;
    motherContact = null;
    password = null;
    studentID = null;
    contact = null;
    emailAddress = null;
    address = null;
  }
  Widget inputField({Function onChanged,double width,double height,Function validator,TextEditingController controller}){
    width = width == null ?203:width;
    height = height == null ? 30:height;
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        controller: controller,
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
  editStudentInput(BuildContext context, AcademicStudentModel student,int index,String classId){
    Uint8List bytesFromPicker;
    String firstName = student.firstName;
    String middleName = student.middleName;
    String lastName = student.lastName;
    String rollNo = student.rollNo;
    String fatherName = student.fatherName;
    String motherName =  student.motherName;
    String motherContact =  student.motherContact;
    String fatherContact =  student.fatherContact;
    String motherDesignation =  student.motherDesignation;
    String fatherDesignation =  student.fatherDesignation;
    String password =  student.password;
    String confirmPassword = student.password;
    String address  =  student.address;
    String emailAddress =  student.email;
    String studentID = student.studentID;
    String contact =  student.contact;
    String gender=  student.gender;
    String imageUrl =  student.imageUrl;
    int admissionNo = student.admissionNo;
    List <String> getGender = [
      'Male',
      'Female',
      'Other',
    ] ;

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
        return  StatefulBuilder(
            key: GlobalKey(),
            builder: (context,StateSetter editStudentState){
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
                                editStudentState(() {
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
                                    editInputField(
                                        initialText: firstName,
                                        onChanged: (value){
                                          firstName = value;
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
                                              editStudentState(() {
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
                                    editInputField(
                                      initialText: student.contact,
                                      onChanged: (value){
                                        contact= value;

                                        contact= value;

                                      },),
                                    SizedBox(height: 35,),
                                    ///Email
                                    editInputField(
                                        initialText: emailAddress,
                                        onChanged: (value){


                                          emailAddress = value;

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
                                    editInputField(
                                      initialText: middleName,
                                      onChanged: (value){

                                        middleName = value;

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
                                            editStudentState(() {

                                            });
                                          }else{
                                            editStudentState(() {
                                              currentDateTime = DateTime.now();
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
                                    editInputField(
                                      initialText: address,
                                      onChanged: (value){

                                        address = value;


                                      },
                                    ),
                                    SizedBox(height: 35,),
                                    ///Password
                                    editInputField(
                                      initialText: password,
                                      onChanged: (value){

                                        password = value;

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
                                    editInputField(
                                      initialText: lastName,
                                      onChanged: (value){

                                        lastName  = value;

                                      },
                                    ),
                                    SizedBox(height: 35,),
                                    ///RollNo
                                    editInputField(
                                      initialText: rollNo,
                                      onChanged: (value){

                                        rollNo = value;



                                      },
                                    ),
                                    SizedBox(height: 35,),
                                    ///StudentId
                                    editInputField(
                                      initialText: studentID,
                                      onChanged: (value){

                                        studentID = value;

                                      },
                                    ),
                                    SizedBox(height: 35,),
                                    ///ConfirmPassword
                                    editInputField(
                                      initialText: confirmPassword,
                                      onChanged: (value){
                                        confirmPassword = null;
                                        confirmPassword = value;
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
                                      editInputField(width: 380,
                                          initialText: fatherName,
                                          onChanged: (value){
                                            fatherName = value;

                                            fatherName = value;

                                          }),
                                      SizedBox(height: 35,),
                                      /// father contact
                                      editInputField(width: 300,
                                          initialText: fatherContact,
                                          onChanged: (value){


                                            fatherContact = value;

                                          }),
                                      SizedBox(height: 35,),
                                      ///fatherDesignation
                                      editInputField(width: 300,
                                          initialText: fatherDesignation,
                                          onChanged: (value){

                                            fatherDesignation = value;


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
                                      editInputField(width: 380,
                                          initialText: motherName,
                                          onChanged: (value){

                                            motherName = value;


                                          }),
                                      SizedBox(height: 35,),
                                      ///mother contact
                                      editInputField(width: 300,
                                          initialText: motherContact,
                                          onChanged: (value){

                                            motherContact = value;


                                          }),
                                      SizedBox(height: 35,),
                                      ///motherDesignation
                                      editInputField(width: 300,
                                          initialText: motherDesignation,
                                          onChanged: (value){

                                            motherDesignation = value;


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
                                    id: student.id,
                                    classId: classId,
                                    firstName: firstName,
                                    middleName: middleName ??"",
                                    lastName: lastName ?? "",
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
                                    studentID: studentID,
                                    motherDesignation: motherDesignation,
                                    studentAsUserId: student.studentAsUserId,
                                    admissionNo: student.admissionNo,
                                  );
                                  print(newStudent.toJson());
                                  // Map<String,String> user ={
                                  //   "email":emailAddress,
                                  //   "password":password,
                                  //   "passwordConfirm":confirmPassword,
                                  //   "name":"$firstName $middleName $lastName",
                                  //   "userType":"user"
                                  // };
                                  // var studentAsUserResponse = await updateStudentAsUser(student.studentAsUserId,user);
                                  //   print("user updated");
                                  //   if(studentAsUserResponse["httpStatusCode"] == 200){
                                  var response = await updateAcademicStudent(student.id,newStudent.toJson());

                                  if(response["httpStatusCode"] == 200){
                                    academicStudentModel.removeAt(index);
                                    setState(() {
                                      academicStudentModel.add(newStudent);
                                    });
                                    Navigator.of(context).pop();
                                  }
                                  else if(response["httpStatusCode"] == 500){
                                    String message = response["responseJson"]['message'];
                                    showToast(context, message);
                                  }
                                  // }
                                  //   else{
                                  //     String message = studentAsUserResponse["responseJson"]['message'];
                                  //     showToast(context, message);
                                  //   }
                                }
                                catch(error){
                                  showToast(context, '$error!');
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
                                child: Text("Update",style:
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
              );
            });
      },
    );

  }
}
