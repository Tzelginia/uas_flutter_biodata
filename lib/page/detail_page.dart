import 'package:flutter/material.dart';
import 'package:uas_flutter_biodata/model/user.dart';
import 'home_page.dart';

class DetailPage extends StatefulWidget {
  final User user;
  const DetailPage({Key? key, required this.user}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Biodata"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.user.type! == 1
                  ? Center(
                      child: Image(
                      image: NetworkImage(
                          "https://media.istockphoto.com/id/1162207969/vector/male-face-icon-in-flat-design-man-avatar-profile-vector-illustration.jpg?b=1&s=170667a&w=0&k=20&c=Z_ASYiL1raziY7gwGRYIGgsBAtegJMVeMV4xjJ5SsmM="),
                      height: 140,
                      width: 140,
                      alignment: Alignment.center,
                    ))
                  : Center(
                      child: Image(
                      image: NetworkImage(
                          "https://media.istockphoto.com/id/1162207423/vector/female-face-icon-in-flat-design-woman-avatar-profile-vector-illustration.jpg?b=1&s=170667a&w=0&k=20&c=233txMu9iYVKYUX4HoTpf23S-VIAn4r5faazvT-rElY="),
                      height: 140,
                      width: 140,
                      alignment: Alignment.center,
                    )),
              Center(
                  child: Text(
                "\n\nNIM",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 10,
              ),
              Center(child: Text(widget.user.nim!.toString())),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                "Nama",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 10,
              ),
              Center(child: Text(widget.user.name!)),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                "Alamat",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 10,
              ),
              Center(child: Text(widget.user.alamat!)),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                "Jenis Kelamin",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 10,
              ),
              widget.user.type! == 1
                  ? Center(child: Text('Laki-laki'))
                  : Center(child: Text('Perempuan')),
              SizedBox(
                height: 20,
              ),
              Center(
                  child: Text(
                "Tanggal Lahir",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 10,
              ),
              Center(child: Text(widget.user.updatedAt.toString())),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context){
                return HomePage();
              }
            ),
            );
        },
        child: Icon(Icons.keyboard_arrow_left)
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
