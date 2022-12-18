class User {
  /*
  tipe
  1 -> pemasukan
  2 -> pengeluaran
  */
  int? id, jk, nim;
  String? nama, alamat, createdAt, updatedAt;

  User(
      {this.id,
      this.jk,
      this.nim,
      this.nama,
      this.alamat,
      this.createdAt,
      this.updatedAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        jk: json['jk'],
        nim: json['nim'],
        nama: json['nama'],
        alamat: json['alamat'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at']);
  }
}
