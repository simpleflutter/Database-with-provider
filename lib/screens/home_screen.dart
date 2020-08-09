import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/models/employee.dart';
import 'package:provider_demo/screens/add_employee.dart';
import 'package:provider_demo/screens/edit_employee.dart';
import 'package:provider_demo/services/employee_operations.dart';
import 'package:provider_demo/uitils/jump_to_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Demo'),
      ),
      body: context.watch<EmployeeOperations>().employeeList.isEmpty
          ? Center(
              child: Text('No Employee'),
            )
          : ListView.builder(
              itemCount:
                  context.watch<EmployeeOperations>().employeeList.length,
              itemBuilder: (BuildContext context, int index) {
                Employee employee =
                    context.watch<EmployeeOperations>().employeeList[index];

                return ListTile(
                  leading: CircleAvatar(
                    child: Text(employee.name[0]),
                  ),
                  title: Text(employee.name),
                  subtitle: Text('${employee.post}  \u20b9${employee.salary}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      context
                          .read<EmployeeOperations>()
                          .deleteEmployee(employee);
                    },
                  ),
                  onTap: () {
                    JumpToPage.push(context, EditEmployee(index: index));
                  },
                );
              },
            ),

      //
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          JumpToPage.push(context, AddEmployee());
        },
      ),
    );
  }
}
