import 'dart:collection';
import 'package:flutter/cupertino.dart';

class LoginData extends ChangeNotifier {
  Map<int, int> _khasraNumbersList = {};

  String _name,
      _role,
      _adhaarNumber,
      _phoneNumber,
      _city,
      _state,
      _village,
      _district,
      _password,
      _numberOfFields;

  get city => _city;

  set city(value) {
    _city = value;
    notifyListeners();
  }

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

  set adhaarNumber(value) {
    _adhaarNumber = value;
    notifyListeners();
  }

  set phoneNumber(value) {
    _phoneNumber = value;
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

  get phoneNumber => _phoneNumber;

  get adhaarNumber => _adhaarNumber;

  get name => _name;

  get role => _role;

  get state => _state;

  set state(value) {
    _state = value;
    notifyListeners();
  }

  get village => _village;

  set village(value) {
    _village = value;
    notifyListeners();
  }

  get district => _district;

  set district(value) {
    _district = value;
    notifyListeners();
  }
}
