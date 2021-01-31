import 'package:academia_admin_panel/Color.dart';
import 'package:flutter/material.dart';

class OrganizationName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40,top: 10,right: 100),
      child: Column(
        children: [
       Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Row(
             children: [
               Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(100),
                   border:Border.all(
                     color: AppColors.indigo700,
                     width: 2,
                   ),
                 ),
                 child: CircleAvatar(
                   radius: 25,
                   backgroundColor: AppColors.transparent,
                   child: ClipRRect(
                     borderRadius: BorderRadius.circular(100),
                     child:Image.asset('Assets/images/visionLogo.png',
                       fit:BoxFit.fill,width: 70,height: 70,
                       filterQuality: FilterQuality.high,),
                   ),
                 ),
               ),
               SizedBox(width: 50,),
               Text(
                 'Deenbandhu Chhotu Ram University of Science and Technology',
                 style: TextStyle(
                   fontFamily: 'ProductSans',
                   fontWeight: FontWeight.bold,
                   color: AppColors.textColorBlack,
                   fontSize: MediaQuery.of(context).size.width * .015,
                 ),
               ),
             ],
           ),
           Padding(
             padding: const EdgeInsets.only(right: 30),
             child: SizedBox(
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
           ),
         ],
       ),
          Padding(
            padding: const EdgeInsets.only(left: 100),
            child: Container(
              margin: EdgeInsets.only(top: 10,),
              height: .5,
              width: MediaQuery.of(context).size.width,
              color: AppColors.lineSeparatorColor,
            ),
          ),

        ],
      ),
    );
  }
}
