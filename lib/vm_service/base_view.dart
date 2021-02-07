import 'package:academia_admin_panel/utils/utils.dart';
import 'package:academia_admin_panel/vm_service/base_vm.dart';
import 'package:academia_admin_panel/vm_service/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class BaseView<T extends BaseVM> extends StatefulWidget {

  final Widget Function(BuildContext context, T value, Widget child) builder;
  final Function(T) onVMReady;
  final Widget loaderWidget;
  final bool create;
  BaseView({@required this.builder, this.onVMReady, this.loaderWidget, this.create : true});

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends BaseVM> extends State<BaseView<T>> {

  T vm = locator<T>();

  @override
  void initState() {
    if(widget.onVMReady != null){
      widget.onVMReady(vm);
    }
    super.initState();
  }

  Widget _getBody(BuildContext context, BaseVM baseVm, Widget child) {

    if(baseVm.state == ViewState.Idle){
      return widget.builder(context, baseVm, child);
    }

    return widget.loaderWidget != null?
    widget.loaderWidget:
    Align(
      alignment: baseVm.primaryLoaderAlignment,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: CircularProgressIndicator(),
      ),
    );
  }

  // Widget getJumpingDotsLoader(BuildContext context){
  //   return  SizedBox(
  //     height: 48, width: 72,
  //     child: SpinKitThreeBounce(
  //       size: 16,
  //       color: AppColors.primaryColor.withOpacity(0.6),
  //     ),
  //   );
  // }


  @override
  Widget build(BuildContext context) {

    if(widget.create){
      return ChangeNotifierProvider<T>(
        create: (context) => vm,

        child: Consumer<T>(builder: (BuildContext context, BaseVM vm, child) {
          showMessages(context, message: vm.message, errorMessage: vm.errorMessage);

          return _getBody(context, vm, child);

        }),
      );

    }


  }


  void showMessages(BuildContext context, {String message, String errorMessage}) {

    if(message == null && errorMessage == null) {
      return;
    } else {
      SchedulerBinding.instance.addPostFrameCallback((_){
        if(message != null) {
          showToast(context, message);
        }

        if(errorMessage != null) {
          showToast(context, errorMessage);
        }
      });
    }
  }

}
