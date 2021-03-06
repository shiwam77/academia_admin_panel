import 'dart:html';

import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Model/academic_class_model.dart';
import 'package:academia_admin_panel/Screen/ManageClass/ApiEndPoint/class_api.dart';
import 'package:academia_admin_panel/Screen/ManageClass/Notifier/class_notifier.dart';
import 'package:academia_admin_panel/Screen/ManageClass/vm/manage_class_vm.dart';

import 'package:academia_admin_panel/vm_service/base_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';
import 'package:provider/provider.dart';

Widget _simplePopup() => PopupMenuButton<int>(
  itemBuilder: (context) => [
    PopupMenuItem(
      value: 1,
      child: Text("Edit"),
    ),
    PopupMenuItem(
      value: 2,
      child: Text("Delete"),
    ),
  ],
);
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
  String selectedButton;

  /// A list of lucky numbers.
  List<String> menuButton = ["Edit","Delete"];
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
    /// The list containing the [PopUpMenuItem]s
    List<PopupMenuItem> buttons = [];

    // Add each luckyNumber name into the list of PopupMenuItems, [buttons]
    for (String button in menuButton) {
      buttons.add(
          new PopupMenuItem(
            child: new Text("$button"),
            value: button,
          )
      );
    }

    /// When a [PopUpMenuItem] is selected, we assign its value to
    /// selectedLuckyNumber and rebuild the widget.
    void handlePopUpChanged(String value,String id,int index) async{
        try {
          if (value == "Delete") {
            var response = await deleteAcademicClass(id);
            if (response["httpStatusCode"] == 204) {
              setState(() {
                academicClassModel.removeAt(index);
                selectedButton = value;
              });
            }
            print("The button you selected was $selectedButton");
          }
          else if(value == "Edit"){
            // ToDo implement edit function here
            setState(() {
              selectedButton = value;
            });
            print("The button you selected was $selectedButton");
          }
        }
        catch(error){
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Something went wrong!'),
              ));
        }

    }

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
                  String className = listOfClass[index].className;
                  print(className);
                  classNotifierProvider.setModelId(classId);
                  classNotifierProvider.setClassName(className);
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
                    borderRadius: BorderRadius.circular(7),
                    color:  selectedIndex == index ? AppColors.white100:AppColors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('${listOfClass[index].className}',
                        style: TextStyle(
                            fontFamily: 'ProductSans',
                            color:  selectedIndex == index ? AppColors.textColorBlack:AppColors.textColorBlack,
                            fontSize:25,
                            fontWeight: selectedIndex == index ? FontWeight.w700 : FontWeight.normal
                        ),
                      ),
                      SizedBox(
                        height: 39,
                        child:
                        PopupMenuButton(
                          padding: EdgeInsets.zero,
                          elevation: 0.0,
                          icon: Icon(Icons.adaptive.more),
                          // key: _menuKey,
                          color: AppColors.white,
                          onSelected: (selectedDropDownItem) async => handlePopUpChanged(selectedDropDownItem,listOfClass[index].id,index),
                          itemBuilder: (BuildContext context) => buttons,
                          //tooltip: "Tap me to select a number.",
                        ),
                      )
                    ],
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
    bool isLoading = false;
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
      offsetX: 800,
      offsetY: 575,
      duration: Duration(milliseconds: 200),
      childFun: (pop) {
        return  Container(
          key: GlobalKey(),
          padding: EdgeInsets.all(10),
          height: 160,
          width: 500,
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
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter classState) {
              return Stack(
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
                        Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: _textEditingController,
                            decoration: InputDecoration(
                              hintText: "Add class",
                            ),
                            onChanged: (value){
                                subject = value;
                            },
                            validator: (value){
                              if (value.isEmpty || value == "") {
                                return 'Please provide class name';
                              }
                              return null;
                            },
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
                              child: !isLoading ? Text(
                                'Save',
                                style: TextStyle(fontSize: 25,color: AppColors.white),
                              ) : CircularProgressIndicator(backgroundColor: AppColors.green600,),
                              onPressed: () async {
                                if(_formKey.currentState.validate()){
                                  AcademicClassModel newClass = AcademicClassModel(className: subject,yearId: widget.yearId);
                                  try{
                                    classState(() {
                                      isLoading = true;
                                    });
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
                                  }finally{
                                    classState(() {
                                      isLoading = false;
                                    });
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
              );
            }
          ),
        );
      },
    );

  }
}