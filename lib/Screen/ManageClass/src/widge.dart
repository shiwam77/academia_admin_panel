import 'package:academia_admin_panel/Color.dart';
import 'package:flutter/material.dart';

Widget boxContainer({Widget child,BuildContext context}){
  return Container(
    height: 604,
    width: MediaQuery.of(context).size.width * .39,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(39),
      color: AppColors.white,
    ),
    child: child,
  );
}