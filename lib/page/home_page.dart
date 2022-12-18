import 'package:flutter/material.dart';
import 'package:uas_flutter_biodata/database/dbhelper.dart';
import 'package:uas_flutter_biodata/model/user.dart';
import 'package:uas_flutter_biodata/page/create_page.dart';
import 'package:uas_flutter_biodata/page/update_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dbHelper? dbhelper;

  Future _refresh() async {
    setState(() {});
  }

  @override
  void initState() {
    dbhelper = dbHelper();
    initDatabase();
    super.initState();
  }

  Future initDatabase() async {
    await dbhelper!.database();
    setState(() {});
  }

  showAlertDialog(BuildContext contex, int id) {
    Widget okButton = TextButton(
      child: Text("Yakin"),
      onPressed: () {
        //delete disini
        dbhelper!.hapus(id);
        Navigator.of(contex, rootNavigator: true).pop();
        setState(() {});
      },
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text("Peringatan !"),
      content: Text("Anda yakin akan menghapus ?"),
      actions: [okButton],
    );

    showDialog(
        context: contex,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Biodata"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreatePage()));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            // FutureBuilder(
            //   future: dbhelper!.totalPemasukan(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Text("-");
            //     } else {
            //       if (snapshot.hasData) {
            //         return Text(
            //             "Total pemasukan : Rp. ${snapshot.data.toString()}");
            //       } else {
            //         return Text("Total pemasukan: Rp. 0");
            //       }
            //     }
            //   },
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // FutureBuilder(
            //   future: dbhelper!.totalPengeluaran(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Text("-");
            //     } else {
            //       if (snapshot.hasData) {
            //         return Text(
            //             "Total pengeluaran : Rp. ${snapshot.data.toString()}");
            //       } else {
            //         return Text("Total pengeluaran: Rp. 0");
            //       }
            //     }
            //   },
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // FutureBuilder(
            //   future: dbhelper!.saldo(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return Text("-");
            //     } else {
            //       if (snapshot.hasData) {
            //         return Text(
            //             "Saldo Saat ini : Rp. ${snapshot.data.toString()}");
            //       } else {
            //         // return Text("Saldo Saat ini: Rp. 0");
            //         var masuk = FutureBuilder(
            //           future: dbhelper!.totalPemasukan(),
            //           builder: (context, snapshot) {
            //             if (snapshot.connectionState ==
            //                 ConnectionState.waiting) {
            //               return Text("-");
            //             } else {
            //               if (snapshot.hasData) {
            //                 return Text(
            //                     "Saldo Saat ini : Rp. ${snapshot.data.toString()}");
            //               } else {
            //                 return Text("Saldo Saat ini: Rp. 0");
            //               }
            //             }
            //           },
            //         );
            //         return masuk;
            //       }
            //     }
            //   },
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            FutureBuilder<List<User>>(
                future: dbhelper!.getAll(),
                builder: (context, snapshot) {
                  print('HASIL : ' + snapshot.data.toString());
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  } else {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(snapshot.data![index].nama!),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Rp. ' +
                                          snapshot.data![index].nim!.toString(),
                                      style: TextStyle(
                                        color: Color(0xFF0084FF),
                                      ),
                                    ),
                                    Text(snapshot.data![index].updatedAt!
                                        .toString()),
                                  ],
                                ),
                                leading: snapshot.data![index].jk == 1
                                    ? Icon(
                                        Icons.download,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.upload,
                                        color: Colors.red,
                                      ),
                                trailing: Wrap(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      UpdatePage(
                                                        user: snapshot
                                                            .data![index],
                                                      )))
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.grey,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          showAlertDialog(context,
                                              snapshot.data![index].id!);
                                        },
                                        icon: Icon(Icons.delete,
                                            color: Colors.red))
                                  ],
                                ),
                              );
                            }),
                      );
                    } else {
                      return Text("Tidak ada data");
                    }
                  }
                })
          ],
        )),
      ),
    );
  }
}
