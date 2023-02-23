import 'package:flutter/material.dart';
import '../models/employee_model.dart';

Widget employeeItem(BuildContext context, Datum employee, void Function() delete) {
  return SizedBox(
    height: 80,
    width: MediaQuery.of(context).size.width,
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.employeeName,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w700),
                ),
                Row(
                  children: [
                    Text(
                      'age : ${employee.employeeAge}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      '${employee.employeeSalary}\$',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
                onPressed: delete,
                icon: const Icon(Icons.delete))
          ],
        ),
        const Divider(
          thickness: 3,
        )
      ],
    ),
  );
}
