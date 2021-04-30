
import 'package:academia_admin_panel/Screen/AcademicHomeTaskAndTutor/vm/home_task_vm.dart';
import 'package:academia_admin_panel/Screen/AcademicHomeTaskAndTutor/vm/home_tutor_vm.dart';
import 'package:academia_admin_panel/Screen/ManageClass/vm/manage_class_vm.dart';
import 'package:academia_admin_panel/Screen/ManageClass/vm/manage_student_vm.dart';
import 'package:academia_admin_panel/Screen/ManageClass/vm/manage_subject_vm.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => ManageClassVm());
  locator.registerFactory(() => ManageSubjectVm());
  locator.registerFactory(() => ManageStudentVm());
  locator.registerFactory(() => HomeTaskVm());
  locator.registerFactory(() => TutorVm());

}