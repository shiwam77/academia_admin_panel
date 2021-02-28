import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Model/academic_class_model.dart';
import 'package:academia_admin_panel/Screen/AcademicHomeTaskAndTutor/src/class.dart';
import 'package:academia_admin_panel/Screen/AcademicHomeTaskAndTutor/widget.dart';
import 'package:academia_admin_panel/Screen/ManageClass/vm/manage_class_vm.dart';
import 'package:academia_admin_panel/vm_service/base_view.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

class AcademicTutor extends StatefulWidget {
  final String yearId;
  AcademicTutor(this.yearId);
  @override
  _AcademicTutorState createState() => _AcademicTutorState();
}

class _AcademicTutorState extends State<AcademicTutor> {
  List<AcademicClassModel> listOfClass =[];
  String classId;
  String preClassId;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30,right: 50),
          child: Row(children: [
            Text('Tutor',
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
                padding: const EdgeInsets.symmetric(horizontal: 75,vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Get some more knowledge",
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        color:AppColors.textColorBlack,
                        fontSize:40,
                      ),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 36,
                          width: 330,
                          child: TextField(
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: AppColors.white,
                                focusColor: AppColors.white,
                                hoverColor: AppColors.white,
                                contentPadding: EdgeInsets.only(top: 5,left: 10),
                                suffixIcon: GestureDetector(
                                    onTap: (){
                                      print("searching...");
                                    },
                                    child: Icon(Icons.search_rounded,color: AppColors.indigo700,)),
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
                                hintText: "search"
                            ),
                          ),
                        ),

                        SizedBox(width: 40,),
                        InkWell(
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
                            ),
                            child: Icon(Icons.add,size: 18,color: AppColors.textColorBlack,),),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 1000,
                      childAspectRatio: 7 / 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                      itemCount: 40,
                      itemBuilder: (BuildContext ctx, index){
                      return Row(
                        children: [
                          Container(
                            width:365,
                            height: 220,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black12,
                            ),
                            child: Stack(children: [
                              Align(
                                alignment: Alignment.center,
                                child: Icon(Icons.play_circle_outline,size: 66,color: AppColors.white,),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15,right: 30),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.thumb_up_alt_outlined,size: 13,color: AppColors.white,),
                                      SizedBox(width: 5,),
                                      Text("2122",
                                        style: TextStyle(
                                            fontFamily: 'ProductSans',
                                            color:AppColors.white,
                                            fontSize:16,
                                        ),),
                                      SizedBox(width: 15,),
                                      Icon(Icons.vertical_align_bottom,size: 13,color: AppColors.white,),
                                      SizedBox(width: 5,),
                                      Text("150",
                                        style: TextStyle(
                                            fontFamily: 'ProductSans',
                                            color:AppColors.white,
                                            fontSize:16,
                                        ),),

                                    ],
                                  ),
                                ),
                              ),
                            ],),
                          ),
                          Spacer(flex: 1,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text("Theory Of Relativity",
                                style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  color:AppColors.textColorBlack,
                                  fontSize:35,
                                  fontWeight: FontWeight.bold
                                ),),
                              Spacer(flex: 1,),
                              Row(
                                children: [
                                  Icon(Icons.watch_later_outlined,size: 12,color: AppColors.textColorBlack,),
                                  SizedBox(width: 5,),
                                  Text("1 month ago",
                                    style: TextStyle(
                                      fontFamily: 'ProductSans',
                                      color:AppColors.gray,
                                      fontSize:14,
                                    ),),

                                ],
                              ),
                              Spacer(flex: 2,),
                              Row(
                                children: [
                                  Icon(Icons.backup_table_sharp,size: 14,color: AppColors.textColorBlack,),
                                  SizedBox(width: 8,),
                                  Text("Physics",
                                    style: TextStyle(
                                      fontFamily: 'ProductSans',
                                      color:AppColors.gray,
                                      fontSize:20,
                                    ),),

                                ],
                              ),
                              Spacer(flex: 2,),
                              Row(
                                children: [
                                  Icon(Icons.person,size: 14,color: AppColors.textColorBlack,),
                                  SizedBox(width: 8,),
                                  Text("Shiwam Karn",
                                    style: TextStyle(
                                      fontFamily: 'ProductSans',
                                      color:AppColors.gray,
                                      fontSize:20,
                                    ),),

                                ],
                              ),
                              Spacer(flex: 5,),
                              Row(
                                children: [
                                  InkWell(
                                    onTap:(){
                                      addHomeTaskAndTutor(context);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 88,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: AppColors.blue,
                                      ),
                                      child: Text("Edit",style: TextStyle(
                                          fontFamily: 'ProductSans',
                                          color: AppColors.white,
                                          fontSize: 16,
                                      )),
                                    ),
                                  ),
                                  SizedBox(width: 20,),
                                  Container(
                                    height: 30,
                                    width: 88,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: AppColors.blue)
                                    ),
                                    child: Text("Delete",style: TextStyle(
                                        fontFamily: 'ProductSans',
                                        color:AppColors.blue,
                                        fontSize: 16,
                                    )),
                                  ),
                                ],
                              ),
                              Spacer(flex: 1,),
                            ],
                          ),
                          Spacer(flex: 2,),
                        ],
                      );
                      }),
                ),
              )
            ],
          ),
        ),
      ],
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
}