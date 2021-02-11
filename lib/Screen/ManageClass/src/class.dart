import 'dart:html';

import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Model/academic_class_model.dart';
import 'package:academia_admin_panel/Screen/ManageClass/ApiEndPoint/class_api.dart';
import 'package:academia_admin_panel/Screen/ManageClass/Notifier/class_notifier.dart';
import 'package:academia_admin_panel/Screen/ManageClass/vm/manage_class_vm.dart';

import 'package:academia_admin_panel/vm_service/base_view.dart';
import 'package:flutter/material.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';
import 'package:provider/provider.dart';


class ClassField extends StatefulWidget {
  final String yearId;
  ClassField(this.yearId);
  @override
  _ClassFieldState createState() => _ClassFieldState();
}

class _ClassFieldState extends State<ClassField> {
  int selectedIndex;
  String classId;
  List<AcademicClassModel> academicClassModel =[];
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return classView();
  }



  Widget classView(){
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Manage Class',
            style: TextStyle(
                fontFamily: 'ProductSans',
                color: AppColors.indigo700,
                fontSize: 30,
                fontWeight: FontWeight.bold
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: AppColors.white,
                ),
                child: makeListViewApiBuilder(),
              ),
            ),
          ),
          InkWell(
            splashColor: AppColors.gray400,
            onTap: () async{
              await addClassInput(context);
            },
            child: Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.indigo700
              ),
              child: Icon(Icons.add,size: 23,color: AppColors.white,),
            ),
          )
        ],
      ),
    );

  }

  Widget makeListViewApiBuilder(){
    return BaseView<ManageClassVm>(
        loaderWidget: Center(child: CircularProgressIndicator()),
        onVMReady: (ManageClassVm vm){
          vm.init(widget.yearId);
        },
        builder: (_, vm, child) {
          if(vm.isError == false){
            academicClassModel = vm.academicClassModel;
            return listViewBuilder(academicClassModel);
          }
          return SizedBox();
        }
    );
  }
  Widget listViewBuilder(List<AcademicClassModel> listOfClass){

    var classNotifierProvider = Provider.of<ClassNotifier>(context);
    print(widget.yearId);
    if(listOfClass != null && listOfClass.isNotEmpty){
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount:listOfClass.length,
        itemBuilder: (context,index){
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
            child: InkWell(
              onTap: (){
                setState(() {
                  classId = listOfClass[index].id;
                  classNotifierProvider.setModelId(classId);
                  selectedIndex = index;
                });

              },
              splashColor: Colors.white,
              hoverColor: Colors.white12,
              child: Container(
                width: 108,
                height: 39,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color:  selectedIndex == index ? AppColors.white100:AppColors.white,
                ),
                child: Text('${listOfClass[index].className}',
                  style: TextStyle(
                      fontFamily: 'ProductSans',
                      color:  selectedIndex == index ? AppColors.textColorBlack:AppColors.textColorBlack,
                      fontSize:25,
                      fontWeight: selectedIndex == index ? FontWeight.w700 : FontWeight.normal
                  ),
                ),
              ),
            ),
          );
        },);
    }
    return Center(child: Text("No data"),);

  }
  addClassInput(BuildContext context){

    TextEditingController _textEditingController = TextEditingController();
    String subject;
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
      offsetX: 800,
      offsetY: 575,
      duration: Duration(milliseconds: 200),
      childFun: (pop) {
        return  Container(
          key: GlobalKey(),
          padding: EdgeInsets.all(10),
          height: 180,
          width: 300,
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
                  child: Icon(Icons.close),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    Container(
                      child:SizedBox(
                        width:300,
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _textEditingController,
                            decoration: InputDecoration(
                              hintText: "Enter a class",
                            ),
                            onChanged: (value){
                              setState(() {
                                subject = value;
                              });
                            },
                            validator: (value){
                              if (value.isEmpty || value == "") {
                                return 'Please provide class name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
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
                              AcademicClassModel newClass = AcademicClassModel(className: subject,yearId: widget.yearId);
                              try{
                                var response =  await createAcademicClass(newClass.toJson());
                                if(response["httpStatusCode"] == 201){
                                  String id = response["responseJson"]["data"]["id"];
                                  newClass.id = id;
                                  setState(() {
                                    academicClassModel.add(newClass);
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
}