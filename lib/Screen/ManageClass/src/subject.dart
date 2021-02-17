import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Model/academic_subject_model.dart';
import 'package:academia_admin_panel/Screen/ManageClass/ApiEndPoint/subject_api.dart';
import 'package:academia_admin_panel/Screen/ManageClass/Notifier/class_notifier.dart';
import 'package:academia_admin_panel/Screen/ManageClass/src/widge.dart';
import 'package:academia_admin_panel/Screen/ManageClass/vm/manage_subject_vm.dart';
import 'package:academia_admin_panel/error.dart';
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:academia_admin_panel/vm_service/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';
import 'package:provider/provider.dart';

class SubjectField extends StatefulWidget {
  @override
  _SubjectFieldState createState() => _SubjectFieldState();
}

class _SubjectFieldState extends State<SubjectField> {
  int selectedIndex;
  String classId;
  String preClassId;
  List<AcademicSubjectModel> academicSubjectModel =[];
  final _formKey = GlobalKey<FormState>();
  bool isEditable = false;
  bool isReadOnly = true;
  int clickedEditIndex;
  @override
  Widget build(BuildContext context) {
    return Consumer<ClassNotifier>(
        builder: (context,classNotifier,child){
          classId = classNotifier.getModelId();

          return Container(
            height: 704,
            width: MediaQuery.of(context).size.width * .39,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Text('Subject',
                      style: TextStyle(
                          fontFamily: 'ProductSans',
                          color: AppColors.textColorBlack,
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    InkWell(
                      onTap: ()async {
                        await addSubjectInput(context);
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
                  child: BaseView<ManageSubjectVm>(
                      loaderWidget: Center(child: CircularProgressIndicator()),
                      onVMReady: (ManageSubjectVm vm){
                        vm.init(classId);
                      },
                      builder: (_, vm, child) {
                        if(classId == preClassId){
                          if(vm.isError == false){
                            academicSubjectModel = vm.academicSubjectModel;
                            return getSubjectField(academicSubjectModel);
                          }
                          return SizedBox();
                        }
                        else{
                          preClassId = classId;
                          vm.refresh(classId);
                          return SizedBox();
                        }

                      }
                  ),
                ),
              ],
            ),
          );
        });
  }
  addSubjectInput(BuildContext context){

    TextEditingController _textEditingController = TextEditingController();
    String subject;
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
      offsetX: 250,
      offsetY: 575,
      duration: Duration(milliseconds: 200),
      childFun: (pop) {
        return  Container(
          key: GlobalKey(),
          padding: EdgeInsets.all(10),
          height: 160,
          width: 600,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xff707070).withOpacity(.4),
                  offset: Offset(0, 0),
                  blurRadius: 10,
                )
              ]),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: (){
                    Navigator.pop(context);
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
                      color: AppColors.white,
                    ),
                    child: Icon(Icons.close,size: 25,color: AppColors.textColorBlack,),),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30,left: 20,right: 20),
                child: Column(
                  children: [
                    Container(
                      child:Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: _textEditingController,
                          decoration: InputDecoration(
                            hintText: "Add Subject",
                          ),
                          onChanged: (value){
                            setState(() {
                              subject = value;
                            });
                          },
                          validator: (value){
                            if (value.isEmpty || value == "") {
                              return 'Please provide subject name';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          height: 50.0,
                          minWidth:150,
                          color:AppColors.indigo700,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Save',
                            style: TextStyle(fontSize: 25),
                          ),
                          onPressed: () async {
                            if(_formKey.currentState.validate()){
                              AcademicSubjectModel newSubject = AcademicSubjectModel(classId: classId,subjectName: subject);
                              try{
                                var response =  await createAcademicSubject(newSubject.toJson());
                                if(response["httpStatusCode"] == 201){
                                  String id = response["responseJson"]["data"]["id"];
                                  newSubject.id = id;
                                  setState(() {
                                    academicSubjectModel.add(newSubject);
                                  });
                                  Navigator.of(context).pop();
                                }
                              }
                              catch(error){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Something went wrong!'),
                                    ));
                              }

                            }

                          },
                        ),
                      ],
                    ),

                  ],
                ),
              )
            ],
          ),
        );
      },
    );

  }

  Widget getSubjectField(List<AcademicSubjectModel> listOfSubjects){
    if(listOfSubjects != null && listOfSubjects.isNotEmpty){
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: listOfSubjects.length,
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
                            // Text('${listOfSubjects[index].subjectName}',style: TextStyle(
                            //     fontFamily: 'ProductSans',
                            //     fontSize: 30,
                            //     fontWeight: FontWeight.normal,
                            //     color: AppColors.textColorBlack
                            // ),),
                            Container(
                              width: 170,
                              height: 55,
                              padding: EdgeInsets.only(left: 10,top: 5),
                              decoration:  clickedEditIndex == index ? BoxDecoration(
                                border:Border.all(
                                  color: AppColors.indigo700, //                   <--- border color
                                  width: 2.0,
                                ),
                              ):BoxDecoration(),
                              child: EditableText(
                                cursorHeight: 40,
                                autofocus: isEditable,
                                readOnly: clickedEditIndex != index,
                                cursorColor: AppColors.indigo700,
                                style: TextStyle(
                                    fontFamily: 'ProductSans',
                                    color: AppColors.textColorBlack,
                                    fontSize: 30,
                                    fontWeight: FontWeight.normal,
                                ),
                                focusNode: FocusNode(),
                                backgroundCursorColor: AppColors.blackeyGray,
                                controller: TextEditingController(text:"${listOfSubjects[index].subjectName}"),

                                onSubmitted: (value) async{
                                  try{
                                    AcademicSubjectModel newSubject = AcademicSubjectModel(classId: classId,subjectName: value,);
                                    var response = await updateAcademicSubjects(listOfSubjects[index].id,newSubject .toJson());
                                    print("updated subject: $response");
                                    if(response["httpStatusCode"] == 200){
                                      newSubject.id = listOfSubjects[index].id;
                                      setState(() {
                                        academicSubjectModel.removeAt(index);
                                        academicSubjectModel.insert(index, newSubject);
                                        clickedEditIndex = null;
                                      });
                                    }
                                    else if(response["httpStatusCode"] == 500){
                                      String message = response["responseJson"]['message'];
                                      showToast(context, message);
                                    }
                                  }
                                  catch(error){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Something went wrong!'),
                                        ));
                                  }
                                },

                              ),
                            ),
                            Row(children: [
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    clickedEditIndex = index;
                                    isEditable = true;
                                    isReadOnly = false;
                                  });
                                },
                                  child: Icon(Icons.edit,size: 30,)),
                              SizedBox(width: 50,),
                              InkWell(
                                onTap: ()async{

                                  try{
                                   var response =  await deleteAcademicSubject(listOfSubjects[index].id);
                                   if(response["httpStatusCode"] == 204){
                                     setState(() {
                                       listOfSubjects.removeAt(index);
                                     });
                                   }
                                   else{
                                     String message = response["responseJson"]['message'];
                                     showToast(context, message);
                                   }
                                  }
                                  catch(error,stacktrace){
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Something went wrong!'),
                                        ));
                                  }

                                },
                                  child: Icon(Icons.delete,size: 30,))
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
}
