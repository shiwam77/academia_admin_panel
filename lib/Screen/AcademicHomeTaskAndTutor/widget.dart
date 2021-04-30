import 'dart:typed_data';

import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Model/academic_hometask_model.dart';
import 'package:academia_admin_panel/Screen/AcademicHomeTaskAndTutor/endpoint.dart';
import 'package:academia_admin_panel/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

addHomeTaskAndTutor(BuildContext context,DateTime date,String subjectId){
  String subjectName , teacherName,topic,chapter,description,comment,fileName;
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
          builder: (context,StateSetter setState){
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
                                    setState(() {
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
                                      }
                                      else {
                                        String message = response["responseJson"]['message'];
                                        showToast(context, message);
                                      }
                                    }
                                    catch(error){
                                      showToast(context, "Something went wrong!");
                                    }
                                    Navigator.pop(context);
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
