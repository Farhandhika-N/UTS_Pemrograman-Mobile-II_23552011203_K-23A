enum StatusMahasiswa {
  aktif,
  cuti,
  lulus,
  nonAktif,
}

class Profile {
  final String nama;
  final String nim;
  final String jurusan;
  final String email;
  final String telepon;
  final StatusMahasiswa status;
  final List<String> hobi;
  final List<String> skill;
  
  final String githubUrl;
  final String instagramUrl;

  Profile({
    required this.nama,
    required this.nim,
    required this.jurusan,
    required this.email,
    required this.telepon,
    required this.status,
    required this.hobi,
    required this.skill,
    required this.githubUrl,
    required this.instagramUrl,
  });

  String get statusDisplay {
    switch (status) {
      case StatusMahasiswa.aktif: return 'Aktif';
      case StatusMahasiswa.cuti: return 'Cuti';
      case StatusMahasiswa.lulus: return 'Lulus';
      case StatusMahasiswa.nonAktif: return 'Non-Aktif';
    }
  }
}
