import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uas_flutter_biodata/database/dbhelper.dart';
import 'package:uas_flutter_biodata/model/user.dart';

class UpdatePage extends StatefulWidget {
  final User user;
  const UpdatePage({Key? key, required this.user}) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  dbHelper dbhelper = dbHelper();
  TextEditingController namaController = TextEditingController();
  TextEditingController nimController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  int _value = 1;

  @override
  void initState() {
    // TODO: implement initState
    dbhelper.database();
    namaController.text = widget.user.nama!;
    nimController.text = widget.user.nim!.toString();
    alamatController.text = widget.user.alamat!.toString();
    dateController.text = widget.user.updatedAt.toString();
    _value = widget.user.jk!;

    super.initState();
  }

  // Variable/State untuk mengambil tanggal
  DateTime selectedDate = DateTime.now();

  //  Initial SelectDate FLutter
  Future<void> _selectDate(BuildContext context) async {
    // Initial DateTime FIinal Picked
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
      print(formattedDate);
      setState(() {
        selectedDate = picked;
        dateController.text = formattedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update"),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("nim"),
              TextField(
                controller: nimController,
              ),
              SizedBox(
                height: 20,
              ),
              Text("nama"),
              TextField(
                controller: namaController,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Alamat"),
              TextField(
                controller: alamatController,
              ),
              SizedBox(
                height: 20,
              ),
              Text("Jenis Kelamin"),
              ListTile(
                title: Text("Laki-laki"),
                leading: Radio(
                    groupValue: _value,
                    value: 1,
                    onChanged: (value) {
                      setState(() {
                        _value = int.parse(value.toString());
                      });
                    }),
              ),
              ListTile(
                title: Text("Perempuan"),
                leading: Radio(
                    groupValue: _value,
                    value: 2,
                    onChanged: (value) {
                      setState(() {
                        _value = int.parse(value.toString());
                      });
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Tanggal Lahir"),
              TextField(
                controller: dateController,
                decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: "Masukkan Tanggal",
                ),
                onTap: () {
                  _selectDate(context);
                },
              ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () async {
                    await dbhelper.update(widget.user.id!, {
                      'nim': nimController.text,
                      'nama': namaController.text,
                      'jk': _value,
                      'alamat': alamatController.text,
                      'updated_at': dateController.text,
                    });
                    Navigator.pop(context);
                  },
                  child: Text("Update")),
            ],
          ),
        )),
      ),
    );
  }
}
