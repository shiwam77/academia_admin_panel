import 'package:academia_admin_panel/Model/academic_class_model.dart';
import 'package:flutter/material.dart';

class ClassNotifier extends ChangeNotifier {
  String _modelId;

  getModelId() => _modelId;

  void setModelId(String modelId) async {
    _modelId = modelId;
    notifyListeners();
  }
}