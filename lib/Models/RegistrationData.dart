import 'dart:collection';

import 'package:flutter/cupertino.dart';

class RegistrationData extends ChangeNotifier {
  List<int> _khasraNumbersList = [];
  String _name,
      _address,
      _phoneNumber,
      _adhaarNumber,
      _password,
      _numberOfFields;

  UnmodifiableListView<int> get getKhasraNumberList {
    return UnmodifiableListView(_khasraNumbersList);
  }

  void addKhasraNumber(int khasraNumber) {
    _khasraNumbersList.add(khasraNumber);
    notifyListeners();
  }

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  set address(value) {
    _address = value;
    notifyListeners();
  }

  set phoneNumber(value) {
    _phoneNumber = value;
    notifyListeners();
  }

  set adhaarNumber(value) {
    _adhaarNumber = value;
    notifyListeners();
  }

  set password(value) {
    _password = value;
    notifyListeners();
  }

  set numberOfFields(value) {
    _numberOfFields = value;
    notifyListeners();
  }

  get numberOfFields => _numberOfFields;

  get password => _password;

  get adhaarNumber => _adhaarNumber;

  get phoneNumber => _phoneNumber;

  get address => _address;

  get name => _name;
}
