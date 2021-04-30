
 import 'dart:io';
import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Model/academic_class_model.dart';
import 'package:academia_admin_panel/Model/academic_hometask_model.dart';
import 'package:academia_admin_panel/Model/academic_subject_model.dart';
import 'package:academia_admin_panel/Screen/AcademicHomeTaskAndTutor/endpoint.dart';
import 'package:academia_admin_panel/Screen/AcademicHomeTaskAndTutor/notifier/subjectNotifier.dart';
import 'package:academia_admin_panel/Screen/AcademicHomeTaskAndTutor/src/class.dart';
import 'package:academia_admin_panel/Screen/AcademicHomeTaskAndTutor/vm/home_task_vm.dart';
import 'package:academia_admin_panel/Screen/ManageClass/Notifier/class_notifier.dart';
import 'package:academia_admin_panel/Screen/ManageClass/vm/manage_class_vm.dart';
import 'package:academia_admin_panel/Screen/ManageClass/vm/manage_subject_vm.dart';
import 'package:academia_admin_panel/services/service.dart';
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:academia_admin_panel/vm_service/base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

import 'package:provider/provider.dart';


class HomeTask extends StatefulWidget {
  final String yearId;
  HomeTask(this.yearId);
  @override
  _HomeTaskState createState() => _HomeTaskState();
}

class _HomeTaskState extends State<HomeTask> {
  List<AcademicClassModel> listOfClass =[];
  List<HomeTaskModel> listOfHomeTaskModel =[];
  List<AcademicSubjectModel> academicSubjectModel =[];
  String classId;
  String preClassId;
  String subjectId;
  String preSubjectId;
  DateTime currentDateTime = DateTime.now();
  DateTime preDateTime ;
  int selectedDeleteIndex;
  int selectedEditIndex;
  bool isCursor = false;
  Widget deleteAnimatedIcon = EmptyDeleteIcon();
  Widget editAnimatedIcon = EmptyEditIcon();
  final GlobalKey<AnimatedListState> homeTaskListKey = GlobalKey<AnimatedListState>();



  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30,right: 50),
            child: Row(children: [
              Text('Home Task',
                style: TextStyle(
                    fontFamily: 'ProductSans',
                    color: AppColors.indigo700,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    height: 52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      color: AppColors.white,
                    ),
                    child: classApiBuilder(),
                  ),
                ),
              ),
            ],),
          ),
          SizedBox(height: 40,),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 686,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(27),
              color: AppColors.white,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 50, 40, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          currentDateTime = await  showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(3000),
                            currentDate:DateTime.now(),
                          );
                          if(currentDateTime  == null){
                            setState(() {
                              currentDateTime = DateTime.now();
                            });
                          }
                          setState(() {

                          });

                        },
                          child: Icon(Icons.calendar_today,size: 30,color: AppColors.textColorBlack,)),
                      Expanded(
                        child: Consumer<ClassNotifier>(
                             builder: (context,classNotifier,child){
                             classId = classNotifier.getModelId();
                             return Container(
                               height: 60,
                                 child: subjectApiBuilder(classId));
                             }),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 0),
                  child: Container(
                    padding: const EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width * 8,
                    height: 502,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(27),
                      color: AppColors.appBackgroundColor,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40,top: 40),
                            child: InkWell(
                              onTap: () async{
                                DateTime date = DateTime(currentDateTime.year,currentDateTime.month,currentDateTime.day,00,00,00,00,00);
                               listOfClass.length > 0  && academicSubjectModel.length > 0 &&  subjectId != null && classId != null ? await addHomeTaskAndTutor(context,date,subjectId):  showToast(context, "Subject is not selected!");
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
                          ),
                        ),
                        Consumer<SubjectNotifier>(
                            builder: (context,classNotifier,child){
                              subjectId = classNotifier.getModelId();
                            return homeTaskBuilder(subjectId);
                          }
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget classApiBuilder(){
    return BaseView<ManageClassVm>(
        loaderWidget: Center(child: CircularProgressIndicator()),
        onVMReady: (ManageClassVm vm){
          vm.init(widget.yearId);
        },
        builder: (_, vm, child) {
          if(vm.isError == false){
            listOfClass = vm.academicClassModel;
            return ClassListViewBuilder(listOfClass);
          }
          return SizedBox();
        }
    );
  }

  Widget subjectApiBuilder(String classId){
    return BaseView<ManageSubjectVm>(
        loaderWidget: Center(child: CircularProgressIndicator()),
        onVMReady: (ManageSubjectVm vm){
          vm.init(classId);
        },
        builder: (_, vm, child) {
          if(classId != null) {
            if (classId == preClassId) {
              if (vm.isError == false) {
                academicSubjectModel = vm.academicSubjectModel;
                return SubjectListViewBuilder(academicSubjectModel);
              }
              return SizedBox();
            }
            else {
              preClassId = classId;
              vm.refresh(classId);
              return SizedBox();
            }
          }
          else{
            return SizedBox(
                height: 60,
                child: Center(child: Text("Please select the Class!",
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                )));
          }

        }
    );
  }

  Widget homeTaskBuilder( String subjectId){
    DateTime date = DateTime(currentDateTime.year,currentDateTime.month,currentDateTime.day,00,00,00,00,00);
    return BaseView<HomeTaskVm>(
        loaderWidget: Center(child: CircularProgressIndicator()),
        onVMReady: (HomeTaskVm vm){
          print(subjectId);
          vm.init(subjectId,date);
        },
        builder: (_, vm, child) {
          if(subjectId != null){
            if(subjectId == preSubjectId && currentDateTime == preDateTime){
              if(vm.isError == false){
                listOfHomeTaskModel = vm.homeTaskModel;
                return homeTaskListView(listOfHomeTaskModel);
              }
              return SizedBox();
            }
            else{
              preSubjectId = subjectId;
              preDateTime = currentDateTime;
              vm.refresh(subjectId,date);
              return SizedBox();
            }
          }
          return SizedBox(
              height: 60,
              child: Center(child: Text("Please select the subject!",
                maxLines: 2,
                softWrap: true,
                overflow: TextOverflow.clip,
              )));
        }
    );
  }

  Widget homeTaskListView([List<HomeTaskModel> listOfHomeTask = const []]){
    if(listOfHomeTask.isNotEmpty && listOfHomeTask.isNotEmpty){
      return  Expanded(
        child: AnimatedList(
          key: homeTaskListKey,
          initialItemCount: listOfHomeTask.length,
          itemBuilder: (context,index,animation){
            return homeTaskItemBuilder(context,listOfHomeTask[index],animation,index:index);
          },
        ),
      );
    }
    return SizedBox(
        height: 60,
        child: Center(child: Text("No data!",
          maxLines: 2,
          softWrap: true,
          overflow: TextOverflow.clip,
        )));
  }

  Widget homeTaskItemBuilder( BuildContext context, HomeTaskModel homeTask, Animation<double> animation,
      {int index}){
    return ScaleTransition(
      scale: animation,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Container(
          width: MediaQuery.of(context).size.width * .7,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 200),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 35),
                      child: Icon(Icons.videocam,size: 25,color: AppColors.indigo700,),
                    ),
                    SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text("${homeTask.topic}",
                          style: TextStyle(
                            fontFamily: 'ProductSans',
                            color:AppColors.textColorBlack,
                            fontSize:30,

                          ),),
                        Text("20:25 min.mp4",style: TextStyle(
                          fontFamily: 'ProductSans',
                          color:AppColors.gray,
                          fontSize:20,

                        ),),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 23),
                  child: Text("By ${homeTask.teacherName}",
                    style: TextStyle(
                      fontFamily: 'ProductSans',
                      color:AppColors.gray,
                      fontSize:30,

                    ),),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      MouseRegion(
                        onEnter: (value){
                          setState(() {
                            selectedEditIndex = index;
                          });

                        },
                        onExit: (value){
                          setState(() {
                            selectedEditIndex = null;
                          });

                        },
                        child: InkWell(
                          onTap: (){
                            DateTime date = DateTime(currentDateTime.year,currentDateTime.month,currentDateTime.day,00,00,00,00,00);
                            updateHomeTaskAndTutor(context,homeTask,index);
                          },
                          child: AnimatedSwitcher(
                            duration: Duration(seconds: 1),
                            child: selectedEditIndex == index  ? FilledEditIcon():EmptyEditIcon(),
                          ),
                        ),
                      ),
                      SizedBox(width: 40,),
                      MouseRegion(
                        onEnter: (value){
                          setState(() {
                            selectedDeleteIndex = index;
                          });

                        },
                        onExit: (value){
                          setState(() {
                            selectedDeleteIndex = null;
                          });

                        },
                        child: InkWell(
                          onTap: () async {
                            try{
                              var response = await deleteAcademicHomeTasks(homeTask.id);
                              if(response["httpStatusCode"] == 204){

                                listOfHomeTaskModel.removeAt(index);
                                homeTaskListKey.currentState.removeItem(
                                  index,
                                      (BuildContext context, Animation<double> animation) => homeTaskItemBuilder(context, homeTask, animation,),
                                  duration: const Duration(milliseconds: 250),
                                );

                              }
                              else if(response["httpStatusCode"] == 500){
                                String message = response["responseJson"]['message'];
                                showToast(context, message);
                              }
                            }catch(error){

                            }
                          },
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 100),
                            child:  selectedDeleteIndex == index ? FilledDeleteIcon() : EmptyDeleteIcon(),
                          ),
                        ),
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
  }
  addHomeTaskAndTutor(BuildContext context,DateTime date,String subjectId){
     var notifierProvider = Provider.of<SubjectNotifier>(context,listen: false);
    String subjectName = notifierProvider.getName(), teacherName,topic,chapter,description,comment,fileName;
    dynamic file;
    return showPopupWindow(
      context,
      gravity: KumiPopupGravity.leftBottom,
      bgColor: Colors.grey.withOpacity(0.5),
      clickOutDismiss: false,
      clickBackDismiss: true,
      customAnimation: false,
      customPop: false,
      customPage: false,
      underStatusBar: false,
      underAppBar: true,
      offsetX: 200,
      offsetY: 100,
      duration: Duration(milliseconds: 200),
      childFun: (pop) {
        return  StatefulBuilder(
            key: GlobalKey(),
            builder: (context,StateSetter taskState){
              return  Container(
                height: 700,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Container(
                      height: 686,
                      width:MediaQuery.of(context).size.width * .8,
                      margin: EdgeInsets.only(top: 20,right: 10),
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20,left: 80,right: 30),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    // file =
                                    // await ImagePickerWeb.getImage(outputType: ImageType.file);
                                    //  print(file);
                                      File _image;
                                     final picker = ImagePicker();   
                                     final pickedFile = await picker.getImage(source: ImageSource.gallery);
                                      

                                    if (pickedFile != null) {
                                     
                                      taskState(() {
                                        fileName = pickedFile.path.split("/").last;
                                      });
                                      try{
                                       // await uploadImage( file : pickedFile);
                                       await uploadImages(pickedFile.path, await pickedFile.readAsBytes());

                                      }
                                      catch(er){
                                        print(er);
                                      }

                                    }
                                  },
                                  child: Container(
                                    height: 245,
                                    width:470,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color:AppColors.appBackgroundColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.insert_drive_file,color: AppColors.gray,size: 55,),
                                        fileName != null  ? Text(fileName):SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 50,right: 100),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 40),
                                              child: Text("Subject",
                                                style: TextStyle(
                                                    fontFamily: 'ProductSans',
                                                    color: AppColors.textColorBlack,
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.normal
                                                ),),
                                            ),

                                            Flexible(
                                              flex: 1,
                                              child: TextField(
                                                controller: TextEditingController(text: subjectName),
                                                onChanged: (value){
                                                  subjectName =value;
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: AppColors.white,
                                                  focusColor: AppColors.white,
                                                  hoverColor: AppColors.white,
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(right: 30,left: 30),
                                              child: Text("Teacher",
                                                style: TextStyle(
                                                    fontFamily: 'ProductSans',
                                                    color: AppColors.textColorBlack,
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.normal
                                                ),),
                                            ),

                                            Flexible(
                                              flex: 1,
                                              child: TextField(
                                                onChanged: (value){
                                                  teacherName = value;
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: AppColors.white,
                                                  focusColor: AppColors.white,
                                                  hoverColor: AppColors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 35,),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 70),
                                              child: Text("Topic",
                                                style: TextStyle(
                                                    fontFamily: 'ProductSans',
                                                    color: AppColors.textColorBlack,
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.normal
                                                ),),
                                            ),
                                            Flexible(
                                              flex: 1,
                                              child: TextField(
                                                onChanged: (value){
                                                  topic = value;
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: AppColors.white,
                                                  focusColor: AppColors.white,
                                                  hoverColor: AppColors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 35,),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 30),
                                              child: Text("Chapter",
                                                style: TextStyle(
                                                    fontFamily: 'ProductSans',
                                                    color: AppColors.textColorBlack,
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.normal
                                                ),),
                                            ),
                                            Flexible(
                                              flex: 1,
                                              child: TextField(
                                                onChanged: (value){
                                                  chapter = value;
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: AppColors.white,
                                                  focusColor: AppColors.white,
                                                  hoverColor: AppColors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50,right: 100),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 6,
                                    child: Container(
                                      height: 240,
                                      //width:MediaQuery.of(context).size.width * .5,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: AppColors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.gray400,
                                              offset: Offset(0, 0),
                                              blurRadius: 6,
                                            )
                                          ]),
                                      child: TextField(
                                        maxLines: 10,
                                        onChanged: (value){
                                          description = value;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Write a short description....",
                                          hintStyle: TextStyle(fontSize: 20,color: AppColors.gray),
                                          filled: true,
                                          fillColor: AppColors.white,
                                          focusColor: AppColors.white,
                                          hoverColor: AppColors.white,
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
                                          // prefixIcon: Padding(
                                          //   padding: const EdgeInsets.only(bottom: 200,left: 20,right: 20),
                                          //   child: Text("Description",style: TextStyle(fontSize: 20,color: AppColors.gray),),
                                          // )
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 3,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 50),
                                      height: 240,
                                      // width:357,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: AppColors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.gray400,
                                              offset: Offset(0, 0),
                                              blurRadius: 6,
                                            )
                                          ]),
                                      child: TextField(
                                        maxLines: 10,
                                        onChanged: (value){
                                          comment = value;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Comments",
                                          hintStyle: TextStyle(fontSize: 20,color: AppColors.gray),
                                          filled: true,
                                          fillColor: AppColors.white,
                                          focusColor: AppColors.white,
                                          hoverColor: AppColors.white,
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
                                          // prefixIcon: Padding(
                                          //   padding: const EdgeInsets.only(bottom: 200,left: 20,right: 20),
                                          //   child: Text("Description",style: TextStyle(fontSize: 20,color: AppColors.gray),),
                                          // )
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50,right: 100),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel",
                                      style:  TextStyle(
                                          fontFamily: 'ProductSans',
                                          color: AppColors.indigo700,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  ),

                                  InkWell(
                                    onTap: () async {
                                     
                                      HomeTaskModel homeWork = HomeTaskModel(
                                          subjectId: subjectId ,
                                          subjectName: subjectName,
                                          teacherName: teacherName,
                                          description: description,
                                          chapter: chapter,
                                          date: date.toString(),
                                          topic: topic,
                                          comment: comment
                                      );
                                      try{
                                        var response = await createAcademicHomeTasks(homeWork.toJson());
                                        if(response["httpStatusCode"] == 201){
                                          String id = response["responseJson"]["data"]["id"];
                                          homeWork.id = id;
                                          print(listOfHomeTaskModel.length);
                                            listOfHomeTaskModel.add(homeWork);
                                            if(listOfHomeTaskModel.length == 1){
                                              setState(() {

                                              });
                                            }
                                            else{
                                              int getIndex = listOfHomeTaskModel.indexOf(homeWork);
                                              homeTaskListKey.currentState.insertItem(getIndex,
                                                  duration: const Duration(milliseconds: 250));
                                            }
                                          Navigator.pop(context);
                                        }
                                        else {
                                          String message = response["responseJson"]['message'];
                                          showToast(context, message);
                                        }
                                      }
                                      catch(error){
                                        print(error);
                                        showToast(context, "Something went wrong!");
                                      }

                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 100),
                                      height: 36,
                                      width: 174,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.blue,
                                      ),
                                      child: Text("Save",style:
                                      TextStyle(
                                          fontFamily: 'ProductSans',
                                          color: AppColors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),
                                      ),
                                    ),
                                  )
                                ],),
                            )
                          ],
                        ),
                      ),

                    ),
                    Positioned(
                      top: 15,
                      right: 0,
                      child:  InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.cancel_outlined,size: 35,color: Colors.black26 ,)),
                    ),
                  ],
                ),
              );
            });
      },
    );

  }


  updateHomeTaskAndTutor(BuildContext context,HomeTaskModel homeTask,int index){
    String date = homeTask.date,id = homeTask.id,subjectId = homeTask.subjectId , fileName = homeTask.file;
    String subjectName = homeTask.subjectName;
    String teacherName = homeTask.teacherName;
    String  topic = homeTask.topic;
    String chapter = homeTask.chapter;
    String description = homeTask.description;
    String  comment = homeTask.comment;


    dynamic file;
    return showPopupWindow(
      context,
      gravity: KumiPopupGravity.leftBottom,
      bgColor: Colors.grey.withOpacity(0.5),
      clickOutDismiss: false,
      clickBackDismiss: true,
      customAnimation: false,
      customPop: false,
      customPage: false,
      underStatusBar: false,
      underAppBar: true,
      offsetX: 200,
      offsetY: 100,
      duration: Duration(milliseconds: 200),
      childFun: (pop) {
        return  StatefulBuilder(
            key: GlobalKey(),
            builder: (context,StateSetter taskState){
              return  Container(
                height: 700,
                color: Colors.transparent,
                child: Stack(
                  children: [
                    Container(
                      height: 686,
                      width:MediaQuery.of(context).size.width * .8,
                      margin: EdgeInsets.only(top: 20,right: 10),
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
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20,left: 80,right: 30),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    file =
                                    await ImagePickerWeb.getImage(outputType: ImageType.file);
                                    print(file.name);

                                    if (file != null) {
                                      taskState(() {
                                        fileName = file.name;
                                      });

                                    }
                                  },
                                  child: Container(
                                    height: 245,
                                    width:470,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      color:AppColors.appBackgroundColor,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.insert_drive_file,color: AppColors.gray,size: 55,),
                                        fileName != null  ? Text(fileName):SizedBox(),
                                      ],
                                    ),
                                  ),
                                ),

                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 50,right: 100),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [

                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 40),
                                              child: Text("Subject",
                                                style: TextStyle(
                                                    fontFamily: 'ProductSans',
                                                    color: AppColors.textColorBlack,
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.normal
                                                ),),
                                            ),

                                            Flexible(
                                              flex: 1,
                                              child: TextField(
                                                controller: TextEditingController(text: subjectName),
                                                onChanged: (value){
                                                  subjectName = value;
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: AppColors.white,
                                                  focusColor: AppColors.white,
                                                  hoverColor: AppColors.white,
                                                ),
                                              ),
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.only(right: 30,left: 30),
                                              child: Text("Teacher",
                                                style: TextStyle(
                                                    fontFamily: 'ProductSans',
                                                    color: AppColors.textColorBlack,
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.normal
                                                ),),
                                            ),

                                            Flexible(
                                              flex: 1,
                                              child: TextField(
                                                controller: TextEditingController(text: teacherName),
                                                onChanged: (value){
                                                teacherName = value;
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: AppColors.white,
                                                  focusColor: AppColors.white,
                                                  hoverColor: AppColors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 35,),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 70),
                                              child: Text("Topic",
                                                style: TextStyle(
                                                    fontFamily: 'ProductSans',
                                                    color: AppColors.textColorBlack,
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.normal
                                                ),),
                                            ),
                                            Flexible(
                                              flex: 1,
                                              child: TextField(
                                                controller: TextEditingController(text: topic),
                                                onChanged: (value){
                                                 topic = value;
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: AppColors.white,
                                                  focusColor: AppColors.white,
                                                  hoverColor: AppColors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 35,),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(right: 30),
                                              child: Text("Chapter",
                                                style: TextStyle(
                                                    fontFamily: 'ProductSans',
                                                    color: AppColors.textColorBlack,
                                                    fontSize: 35,
                                                    fontWeight: FontWeight.normal
                                                ),),
                                            ),
                                            Flexible(
                                              flex: 1,
                                              child: TextField(
                                                controller: TextEditingController(text: chapter),
                                                onChanged: (value){
                                                  chapter = value;
                                                },
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: AppColors.white,
                                                  focusColor: AppColors.white,
                                                  hoverColor: AppColors.white,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50,right: 100),
                              child: Row(
                                children: [
                                  Flexible(
                                    flex: 6,
                                    child: Container(
                                      height: 240,
                                      //width:MediaQuery.of(context).size.width * .5,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: AppColors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.gray400,
                                              offset: Offset(0, 0),
                                              blurRadius: 6,
                                            )
                                          ]),
                                      child: TextField(
                                        maxLines: 10,
                                        controller: TextEditingController(text: description),
                                        onChanged: (value){
                                          description = value;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Write a short description....",
                                          hintStyle: TextStyle(fontSize: 20,color: AppColors.gray),
                                          filled: true,
                                          fillColor: AppColors.white,
                                          focusColor: AppColors.white,
                                          hoverColor: AppColors.white,
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
                                          // prefixIcon: Padding(
                                          //   padding: const EdgeInsets.only(bottom: 200,left: 20,right: 20),
                                          //   child: Text("Description",style: TextStyle(fontSize: 20,color: AppColors.gray),),
                                          // )
                                        ),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    flex: 3,
                                    child: Container(
                                      margin: EdgeInsets.only(left: 50),
                                      height: 240,
                                      // width:357,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          color: AppColors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.gray400,
                                              offset: Offset(0, 0),
                                              blurRadius: 6,
                                            )
                                          ]),
                                      child: TextField(
                                        maxLines: 10,
                                        controller: TextEditingController(text: comment),
                                        onChanged: (value){
                                          comment = value;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Comments",
                                          hintStyle: TextStyle(fontSize: 20,color: AppColors.gray),
                                          filled: true,
                                          fillColor: AppColors.white,
                                          focusColor: AppColors.white,
                                          hoverColor: AppColors.white,
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
                                          // prefixIcon: Padding(
                                          //   padding: const EdgeInsets.only(bottom: 200,left: 20,right: 20),
                                          //   child: Text("Description",style: TextStyle(fontSize: 20,color: AppColors.gray),),
                                          // )
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 50,right: 100),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: Text("Cancel",
                                      style:  TextStyle(
                                          fontFamily: 'ProductSans',
                                          color: AppColors.indigo700,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),),
                                  ),

                                  InkWell(
                                    onTap: () async {
                                      HomeTaskModel homeWork = HomeTaskModel(
                                          id: id,
                                          subjectId: subjectId ,
                                          subjectName: subjectName,
                                          teacherName: teacherName,
                                          description: description,
                                          chapter: chapter,
                                          date: date.toString(),
                                          topic: topic,
                                          comment: comment
                                      );
                                      Map d = homeWork.toJson();
                                      print(d);
                                      try{
                                        var response = await updateAcademicHomeTasks(id,homeWork.toJson());
                                        if(response["httpStatusCode"] == 200){
                                          setState(() {
                                            listOfHomeTaskModel.removeAt(index);
                                            listOfHomeTaskModel.insert(index, homeWork);

                                          });
                                          Navigator.pop(context);
                                          showToast(context, "HomeTask updated!");
                                        }
                                        else if(response["httpStatusCode"] == 500){
                                          String message = response["responseJson"]['message'];
                                          showToast(context, message);
                                        }
                                      }
                                      catch(error,stackTrace){
                                        print(error);
                                        print(stackTrace);
                                        showToast(context, "Something went wrong!");
                                      }

                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 100),
                                      height: 36,
                                      width: 174,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: AppColors.blue,
                                      ),
                                      child: Text("Update",style:
                                      TextStyle(
                                          fontFamily: 'ProductSans',
                                          color: AppColors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                      ),
                                      ),
                                    ),
                                  )
                                ],),
                            )
                          ],
                        ),
                      ),

                    ),
                    Positioned(
                      top: 15,
                      right: 0,
                      child:  InkWell(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.cancel_outlined,size: 35,color: Colors.black26 ,)),
                    ),
                  ],
                ),
              );
            });
      },
    );

  }

  Widget inputField({Function onChanged,double width,double height,}){
    width = width == null ?203:width;
    return Container(
      width: width,
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.white,
          focusColor: AppColors.white,
          hoverColor: AppColors.white,
        ),
      ),
    );
  }
}
class EmptyDeleteIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Icon(Icons.delete_outline,size: 28,color: AppColors.gray,);
  }
}
class FilledDeleteIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Icon(Icons.delete,size: 28,color: AppColors.indigo700,);
  }
}
class EmptyEditIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Icon(Icons.edit_outlined,size: 28,color: AppColors.gray,);
  }
}

class FilledEditIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Icon(Icons.edit,size: 28,color: AppColors.indigo700,);
  }
}

 class SubjectListViewBuilder extends StatefulWidget {
   final List<AcademicSubjectModel> listOfSubjects;
   SubjectListViewBuilder(this.listOfSubjects);
   @override
   _SubjectListViewBuilderState createState() => _SubjectListViewBuilderState();
 }

 class _SubjectListViewBuilderState extends State<SubjectListViewBuilder> {
   int selectedIndex;
   String subjectId;
   @override
   Widget build(BuildContext context) {
     var notifierProvider = Provider.of<SubjectNotifier>(context,listen: false);
     if(widget.listOfSubjects != null && widget.listOfSubjects.isNotEmpty){
       return ListView.builder(
         scrollDirection: Axis.horizontal,
         itemCount:widget.listOfSubjects.length,
         itemBuilder: (context,index){
           return Padding(

             padding: const EdgeInsets.symmetric(horizontal: 15,),
             child: InkWell(

               onTap: (){
                 setState(() {
                   subjectId = widget.listOfSubjects[index].id;
                   String subjectName = widget.listOfSubjects[index].subjectName;
                   print(subjectId);
                   selectedIndex = index;
                   notifierProvider.setModelId(subjectId);
                   notifierProvider.setClassName(subjectName);
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
                     borderRadius: BorderRadius.vertical(top:Radius.circular(7)),
                     color:  selectedIndex == index ? AppColors.white100:AppColors.white,
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     mainAxisSize: MainAxisSize.min,
                     children: [
                       Text('${widget.listOfSubjects[index].subjectName}',
                         style: TextStyle(
                             fontFamily: 'ProductSans',
                             color:  selectedIndex == index ? AppColors.textColorBlack:AppColors.textColorBlack,
                             fontSize:30,

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
     return SizedBox(
         height: 60,
         child: Center(child: Text("Please create the subject in Manage Class Screen!",
           maxLines: 2,
           softWrap: true,
           overflow: TextOverflow.clip,
         )));
   }
 }



