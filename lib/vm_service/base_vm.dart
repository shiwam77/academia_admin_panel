import 'package:flutter/material.dart';

enum ViewState {
  Idle,
  Busy
}


class BaseVM extends ChangeNotifier {

  // when the state is idle, basevm shows a circular progress indicator. This is handled automatically by base view
  ViewState _state = ViewState.Idle;
  Alignment _primaryLoaderAlignment = Alignment.center;

  // when state is idle and secondary state is busy, dotted loader is shown at the bottom of the screen
//  ViewState _secondaryState = ViewState.Idle;
//  Alignment _secondaryLoaderAlignment = Alignment.center;


  ViewState get state => _state;
  Alignment get primaryLoaderAlignment => _primaryLoaderAlignment;

//  ViewState get secondaryState => _secondaryState;
//  Alignment get secondaryLoaderAlignment => _secondaryLoaderAlignment;

  String _errorMessage;

  String _message;

  void setState({ViewState state,
    Alignment primaryAlignment = Alignment.center}) {

    if(state != null) {
      // reset loader on idle state to default value
      _state = state;
      _primaryLoaderAlignment = primaryAlignment;
    }

//    if(secondaryState != null) {
//      _secondaryState = secondaryState;
//      _secondaryLoaderAlignment = secondaryAlignment;
//    }

    /// bring out of current build call stack to avoid widget marked _needsrebuild while building
    Future.delayed(Duration(seconds: 0),(){
      notifyListeners();
    });

  }

  void setErrorMessage([String msg]) {
    if(msg != null && msg.length > 0) {
      _errorMessage = msg;
    }else{
      _errorMessage = "Something went wrong";
    }
    return;
  }

  void setMessage([String msg]) {
    if(msg != null && msg.length > 0) {
      _message = msg;
    } else {
      _message = "Operaion completed successfully";
    }
    return;
  }

  // getters

  String get errorMessage {
    String error = _errorMessage;
    _errorMessage = null;
    return error;
  }

  String get message {
    String msg = _message;
    _message = null;
    return msg;
  }
}