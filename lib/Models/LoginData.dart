import 'dart:collection';
import 'package:flutter/cupertino.dart';

class LoginData extends ChangeNotifier {
  Map<int, int> _khasraNumbersList = {};

  String _name,
      _role,
      _address,
      _phoneNumber,
      _adhaarNumber,
      _password,
      _numberOfFields;

  UnmodifiableMapView<int, int> get getKhasraNumberList {
    return UnmodifiableMapView(_khasraNumbersList);
  }

  void addKhasraNumber(int khasraNumber, int index) {
    _khasraNumbersList[index] = khasraNumber;
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

  set role(value) {
    _role = value;
    notifyListeners();
  }

  get numberOfFields => _numberOfFields;

  get password => _password;

  get adhaarNumber => _adhaarNumber;

  get phoneNumber => _phoneNumber;

  get address => _address;

  get name => _name;

  get role => _role;
}
