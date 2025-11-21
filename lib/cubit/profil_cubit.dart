import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/profile.dart';

class ProfileState {
  final Profile profile;
  ProfileState(this.profile);
}

class ProfileCubit extends Cubit<ProfileState> {
  final Profile _initialProfile = Profile(
    nama: 'Farhandhika Nurrohman',
    nim: '23552011203',
    jurusan: 'Teknik Informatika',
    email: 'farhandhikanurrohman@gmail.com',
    telepon: '+62 838 - 765 - 01241',
    status: StatusMahasiswa.aktif,
    hobi: ['Menonton Film/YT', 'Pelihara Ikan', 'Mendengarkan Musik', 'Main Game'],
    skill: ['Quality Control', 'Breeding Ikan', 'Rajin Menabung', 'Packing Barang', 'Baik Hati', 'Canva', 'Tidak Sombong', 'Suka Membantu Teman'],
    githubUrl: 'https://github.com/Farhandhika-N', 
    instagramUrl: 'https://www.instagram.com/farhandhika.n?igsh=MWJqenF2c2I4dmc1ZA==', 
  );

   ProfileCubit() : super(ProfileState(Profile(
    nama: '', nim: '', jurusan: '', email: '', telepon: '', status: StatusMahasiswa.aktif, hobi: [], skill: [],
    githubUrl: '', instagramUrl: ''
  ))) {
    loadProfile();
  }

  void loadProfile() {
    emit(ProfileState(_initialProfile));
  }
}
