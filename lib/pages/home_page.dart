import 'package:flutter/material.dart';
import 'package:network_example/service/utils_service.dart';
import '../items/employee_item.dart';
import '../service/network_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


 /* @override
  void initState() {
    super.initState();
    // EmployeeServices.getEmployees();
    // EmployeeServices.apiOneEmployee(12);
    //EmployeeServices.createEmployee('Ilmhub', 12000, 3);
    // EmployeeServices.updateEmployee('Ilmhub', 12000, 3, 12);
    //EmployeeServices.deleteEmployee(12);
  }*/

TextEditingController nameCtr = TextEditingController();
TextEditingController ageCtr = TextEditingController();
TextEditingController salaryCtr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HTTP Networking"),
        actions: [
          IconButton(
              onPressed: (){
                _showBottomSheet(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: EmployeeServices.getEmployees(context),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context,i){
                return employeeItem(context,snapshot.data![i],
                    () async {

                    String? result = await EmployeeServices.deleteEmployee(snapshot.data![i].id);
                    if(result == 'success'){
                     // setState(() {});
                      Utils.snackBarSuccess('Deleted successfully',context);
                    }else{
                      Utils.snackBarError('Someting is wrong',context);
                    }
                  }
                );
              });
            }else {
              return const Center(
                child: Text('No data'),);
            }
          },
        ),
      ),

    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,

        builder: (BuildContext context) {
          return SingleChildScrollView(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              //mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Add new employee',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0),
                ),
                TextFormField(
                  controller: nameCtr,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextFormField(
                  controller: ageCtr,
                  decoration: InputDecoration(
                      labelText: 'Age'),
                ),
                TextFormField(
                  controller: salaryCtr,
                  decoration: InputDecoration(labelText: 'Salary'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if(nameCtr.text.isNotEmpty && ageCtr.text.isNotEmpty && salaryCtr.text.isNotEmpty ) {
                      String? result =  await EmployeeServices.createEmployee(
                      nameCtr.text, salaryCtr.text, ageCtr.text);
                      if(result == 'success'){
                        Utils.snackBarSuccess('Added successfully',context);
                        Navigator.pop(context);
                      }else{
                        Utils.snackBarError('Someting is wrong',context);
                      }
                    }else{
                      Utils.snackBarError('Please fill all fields', context);
                    }
                  },
                  child: Text('Add'),
                ),
                SizedBox(height: 400,)
              ],
            ),
          );
        });
  }

}



