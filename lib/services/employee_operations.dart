import 'package:flutter/material.dart';
import 'package:provider_demo/models/employee.dart';
import 'package:sqflite/sqflite.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'db_helper.dart';

class EmployeeOperations extends ChangeNotifier {
  List<Employee> _employeeList = [];

  List<Employee> get employeeList {
    if (_employeeList.isEmpty) {
      selectAllEmployeeData();
    }
    print(_employeeList);
    return _employeeList;
  }

  void selectAllEmployeeData() async {
    //
    try {
      Database db = await DBHelper.instacne.database;

      List<Map<String, dynamic>> maps = await db.query('employees');
      _employeeList.clear();

      for (int i = 0; i < maps.length; i++) {
        print('inside for loop');
        _employeeList.add(Employee.fromMap(maps[i]));
      }
      notifyListeners();
    } catch (error) {
      Fluttertoast.showToast(msg: 'Error while getting employees');
    }
  }

  // add new employee to database & show toast as per result
  Future<void> addEmployee(Employee employee) async {
    try {
      Database db = await DBHelper.instacne.database;
      int result = await db.insert('employees', employee.toMap());

      if (result != 0) {
        Fluttertoast.showToast(msg: 'Employee "${employee.name}" saved');
        selectAllEmployeeData();
        notifyListeners();
      } else {
        Fluttertoast.showToast(
            msg: 'Unable to save employee "${employee.name}"');
      }
    } catch (error) {
      Fluttertoast.showToast(msg: 'Error to save employee "${employee.name}"');
    }
  }

  // update employee from database & show toast as per result
  Future<void> updateEmployee(Employee employee) async {
    try {
      Database db = await DBHelper.instacne.database;
      int result = await db.update('employees', employee.toMap(),
          where: 'id=?', whereArgs: [employee.id]);

      if (result != 0) {
        Fluttertoast.showToast(msg: 'Employee "${employee.name}" updated');
        print('update working');
        selectAllEmployeeData();
        notifyListeners();
      } else {
         print('update not working $result');
        Fluttertoast.showToast(
            msg: 'Unable to update employee "${employee.name}"');
      }
    } catch (error) {
       print('update working erro');
      Fluttertoast.showToast(
          msg: 'Error to update employee "${employee.name}"');
    }
  }

  // delete employee from database & show toast as per result
  Future<void> deleteEmployee(Employee employee) async {
    try {
      Database db = await DBHelper.instacne.database;
      int result =
          await db.delete('employees', where: 'id=?', whereArgs: [employee.id]);

      if (result != 0) {
        Fluttertoast.showToast(msg: 'Employee "${employee.name}" deleted');
        selectAllEmployeeData();
        notifyListeners();
      } else {
        Fluttertoast.showToast(
            msg: 'Unable to delete employee "${employee.name}"');
      }
    } catch (error) {
      Fluttertoast.showToast(
          msg: 'Error to delete employee "${employee.name}"');
    }
  }
}
