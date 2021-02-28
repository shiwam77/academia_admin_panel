import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Model/academic_class_model.dart';
import 'package:academia_admin_panel/Model/academic_subject_model.dart';
import 'package:academia_admin_panel/Screen/AcademicHomeTaskAndTutor/src/class.dart';
import 'package:academia_admin_panel/Screen/AcademicHomeTaskAndTutor/widget.dart';
import 'package:academia_admin_panel/Screen/ManageClass/Notifier/class_notifier.dart';
import 'package:academia_admin_panel/Screen/ManageClass/vm/manage_class_vm.dart';
import 'package:academia_admin_panel/Screen/ManageClass/vm/manage_subject_vm.dart';
import 'package:academia_admin_panel/vm_service/base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';
import 'package:provider/provider.dart';
import 'package:sentry/sentry.dart';

class HomeTask extends StatefulWidget {
  final String yearId;
  HomeTask(this.yearId);
  @override
  _HomeTaskState createState() => _HomeTaskState();
}

class _HomeTaskState extends State<HomeTask> {
  List<AcademicClassModel> listOfClass =[];
  List<AcademicSubjectModel> academicSubjectModel =[];
  String classId;
  String preClassId;
  DateTime currentDateTime = DateTime.now();
  int selectedDeleteIndex;
  int selectedEditIndex;
  bool isCursor = false;
  Widget deleteAnimatedIcon = EmptyDeleteIcon();
  Widget editAnimatedIcon = EmptyEditIcon();
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
                               await addHomeTaskAndTutor(context);
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
                        Expanded(
                          child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (context,index){
                              return Padding(
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
                                                Text("Theory of Relativity",
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
                                          child: Text("By Shiwam Karn",
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
                                                    addHomeTaskAndTutor(context);
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
                                                child: AnimatedSwitcher(
                                                  duration: Duration(milliseconds: 100),
                                                  child:  selectedDeleteIndex == index ? FilledDeleteIcon() : EmptyDeleteIcon(),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
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
                child: Center(child: Text("Please select the subject!",
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.clip,
                )));
          }

        }
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
                   String className = widget.listOfSubjects[index].subjectName;
                   print(className);
                   // classNotifierProvider.setModelId(subjectId);
                   // classNotifierProvider.setClassName(className);
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



