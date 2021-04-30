import 'package:academia_admin_panel/Model/academic_class_model.dart';
import 'package:flutter/material.dart';

class ClassNotifier extends ChangeNotifier {
  String _modelId;
  String _name;
  getModelId() => _modelId;
  getName() => _name;
  void setModelId(String modelId) async {
    _modelId = modelId;
    notifyListeners();
  }
  void setClassName(String name) async {
    _name = name;
    notifyListeners();
  }
}