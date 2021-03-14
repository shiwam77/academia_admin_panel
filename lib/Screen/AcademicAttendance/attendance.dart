import 'package:academia_admin_panel/Color.dart';
import 'package:academia_admin_panel/Model/academic_class_model.dart';
import 'package:academia_admin_panel/Screen/AcademicHomeTaskAndTutor/src/class.dart';
import 'package:academia_admin_panel/Screen/ManageClass/vm/manage_class_vm.dart';
import 'package:academia_admin_panel/vm_service/base_view.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
    final String yearId;
 AttendanceScreen(this.yearId);
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
   List<AcademicClassModel> listOfClass =[];
  String classId;
  String preClassId;
  bool isPresent = false ,isAbsent = false ,isLeave = false;
  int selectedIndex;
    List <String> getAttendanceOption = [
    'Present All',
    'Absent All',
    'OnLeave All',
  ] ;
  String attendanceOption ;
  @override
  Widget build(BuildContext context) {
      return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30,right: 50),
          child: Row(children: [
            Text('Attendance',
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
            Container(
                     height: 50,
                     width: 180,
                     decoration: BoxDecoration(
                     color: Color(0xFFE2E8F0),
                       borderRadius: BorderRadius.circular(16),
                        ),
                      child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 4, 0),
                      child: SizedBox(
                      height: 203,
                      child: DropdownButton<String>(
                        hint: Text("Attendance"),
                      value: attendanceOption,
                      icon: Padding(
                       padding: const EdgeInsets.only(left: 20),
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
                                 attendanceOption = data;
                                 });
                                },
                       items: getAttendanceOption.map<DropdownMenuItem<String>>((String value) {
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
                        
          ],),
        ),
        SizedBox(height: 40,),
        Expanded(
         child: GridView.builder(
           itemCount: 100,
           gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
           maxCrossAxisExtent: 500,
           childAspectRatio: 4 / 3,
           crossAxisSpacing: 40,
           mainAxisSpacing: 40), 
           itemBuilder: (context,index) {
             return Container(
               height: 300,
               width: 250,
                decoration: BoxDecoration(
                  color: AppColors.white,
                         borderRadius: BorderRadius.circular(31),
                         ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                   
                     Padding(
                    padding: const EdgeInsets.only(top: 20,right: 20,left: 50),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Spacer(),
                         Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(100),
                       border:Border.all(
                         color: AppColors.indigo700,
                         width: 2,
                       ),
                     ),
                     child: CircleAvatar(
                       radius: 40,
                       backgroundColor: AppColors.transparent,
                       child: ClipRRect(
                         borderRadius: BorderRadius.circular(100),
                         child:Image.asset('Assets/images/visionLogo.png',
                           fit:BoxFit.contain,
                           filterQuality: FilterQuality.high,),
                       ),
                     ),
                 ),
                         Spacer(),
                        Icon(Icons.adaptive.more),
                      ],
                    ),
                  ),
                     SizedBox(height: 10,),
                    Text('Shiwam karn',
                   style: TextStyle(
                   fontFamily: 'ProductSans',
                   color: AppColors.textColorBlack,
                   fontSize: 18,
                   fontWeight: FontWeight.bold
                   ),
                 ),
                    Text('10',
                      style: TextStyle(
                      fontFamily: 'ProductSans',
                     color: AppColors.gray,
                     fontSize: 12,
                   ),
                 ),
                    SizedBox(height: 20,),
                    Text('80% Attendance',
                      style: TextStyle(
                      fontFamily: 'ProductSans',
                      color:AppColors.green600,
                      fontSize: 8,
                      ),
                    ),
                    SizedBox(height: 5,),
                   Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Container(
                      height: 5,
                          decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(8),
                             ),
                  
                      child: Row(children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                             decoration: BoxDecoration(
                                color: AppColors.green600,
                             borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft:  Radius.circular(8)),
                             ),
                           ),
                        ),
                        Expanded(
                           flex: 2,
                           child: Container(
                              decoration: BoxDecoration(
                                 color: AppColors.red600,
                             borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomRight:  Radius.circular(8)),
                             ),
                            ),
                        ),
                   
                      ],),
                  ),
                    ),
                ),
                   SizedBox(height: 20,),
                   Divider(color: AppColors.appBackgroundColor,thickness: 5,height: 5,),
                    SizedBox(height: 10,),
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 75,vertical: 10),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                          atttendanceButton(
                            label: "P",
                            onTapp: (){
                             setState(() {
                               isPresent = ! isPresent;
                               selectedIndex = index;
                               if(isPresent){
                               isLeave = false;
                               isAbsent = false;
                               }
                              
                             });
                          },
                          isTrue: isPresent,
                          isTrueColor: AppColors.green600,
                           index: index
                          ),
                           atttendanceButton(
                            label: "A",
                            onTapp: (){
                             setState(() {
                               isAbsent = ! isAbsent;
                                selectedIndex = index;
                               if(isAbsent){
                                isLeave = false;
                                isPresent = false;
                               }
                              
                             });
                          },
                          isTrue: isAbsent,
                          isTrueColor: AppColors.red600,
                          index: index
                          ),
                       
                       atttendanceButton(
                            label: "L",
                            onTapp: (){
                             setState(() {
                               isLeave = ! isLeave;
                                selectedIndex = index;
                               if(isLeave){
                                isPresent = false;
                                isAbsent = false;
                               }
                              
                             });
                          },
                          isTrue:  isLeave,
                          isTrueColor: AppColors.indigo700,
                          index: index
                          ),
                       ],
                     ),
                   ),
                ],),
             );
           }),
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

  Widget atttendanceButton({Function onTapp,Color isTrueColor,bool isTrue = false,String label,int index}){
 
    return InkWell(
      onTap: onTapp,
          child: Container(
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border:Border.all(
                color:  selectedIndex == index ?  isTrue  ? AppColors.transparent : AppColors.textColorBlack : AppColors.textColorBlack,
                 width: 2,
                 ),
              ),
              child: CircleAvatar(
                       radius: 20,
                       backgroundColor: selectedIndex == index ? isTrue ? isTrueColor : AppColors.transparent : AppColors.transparent ,
                      child:Text(label,style: TextStyle(color: selectedIndex == index ? isTrue ? AppColors.white :  AppColors.textColorBlack : AppColors.textColorBlack),)),
                   ),
    );   
  }
 
}