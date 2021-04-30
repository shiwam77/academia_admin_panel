import 'package:academia_admin_panel/Color.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

Widget boxContainer({Widget child,BuildContext context}){
  return Container(
    height: 604,
    width: MediaQuery.of(context).size.width * .38,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(39),
      color: AppColors.white,
    ),
    child: child,
  );
}

String toHumanReadableDate(DateTime timestamp) {
  var moonLanding = timestamp;
  var jiffy = Jiffy([
    moonLanding.year,
    moonLanding.month,
    moonLanding.day,
    moonLanding.hour,
    moonLanding.minute,
    00,
  ]).format("dd MMM,yyy");
  return jiffy;
}

String toStoreDate(DateTime timestamp) {
  var moonLanding = timestamp;
  var jiffy = Jiffy([
    moonLanding.year,
    moonLanding.month,
    moonLanding.day,
    moonLanding.hour,
    moonLanding.minute,
    00,
  ]).format("dd,MMM yyy");
  return jiffy;
}