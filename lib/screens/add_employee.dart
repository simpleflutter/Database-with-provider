import 'package:flutter/material.dart';
import 'package:provider_demo/models/employee.dart';
import 'package:provider_demo/services/employee_operations.dart';
import 'package:provider/provider.dart';

class AddEmployee extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController postController = TextEditingController();
  final TextEditingController salaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Employee'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              saveData(context);
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            // name
            TextFormField(
              controller: nameController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(hintText: 'Name'),
              validator: (String nameValue) {
                if (nameValue.isEmpty) {
                  return 'Name is required';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            // post
            TextFormField(
              controller: postController,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(hintText: 'Post'),
              validator: (String postValue) {
                if (postValue.isEmpty) {
                  return 'Post is required';
                }
                return null;
              },
            ),
            SizedBox(height: 16),

            //salary
            TextFormField(
              controller: salaryController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Salary'),
              validator: (String salaryValue) {
                if (salaryValue.isEmpty) {
                  return 'Salary is required';
                }
                return null;
              },
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void saveData(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      String name = nameController.text;
      String post = postController.text;
      int salary = int.parse(salaryController.text);

      Employee employee = Employee(name: name, post: post, salary: salary);

      await context.read<EmployeeOperations>().addEmployee(employee);
      Navigator.pop(context);
    }
  }
}
