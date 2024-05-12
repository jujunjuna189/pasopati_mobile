class Api {
  // static const server = 'http://10.0.2.2:8000/';
  // static const server = 'http://192.168.1.109:8000/';
  static const server = 'https://pasopati.hplbz18.com/';
  //Auth
  static const login = '${server}api/login';
  static const register = '${server}api/register';
  //Profile
  static const updateProfile = '${server}api/profile/update';
  //Pengguna
  static const penggunaShow = '${server}api/pengguna/show';
  //Kemampuan
  static const kemampuanShow = '${server}api/pengguna/kemampuan/show';
  //Artikel
  static const artikelShow = '${server}api/artikel/show';
  static const artikelView = '${server}artikel/view';
  //E-Learning
  static const eLearningShow = '${server}api/e-learning/show';
  //Bujuk
  static const bujukShow = '${server}api/bujuk/show';
  // Pangkalan
  static const pangkalanShow = '${server}api/pangkalan/show';
  //Absensi
  static const absensiShow = '${server}api/absensi/show';
  static const absensiStore = '${server}api/absensi/store';
  static const absensiUpdate = '${server}api/absensi/update';
  static const absensiDelete = '${server}api/absensi/delete';
  //Perizinan
  static const perizinanStore = '${server}api/perizinan/store';
  //Perizinan Ranpur
  static const perizinanRanpurStore = '${server}api/perizinan/ranpur/store';
  //Perizinan Kendaraan
  static const perizinanKendaraanStore = '${server}api/perizinan/kendaraan/store';
  //Gudang Senjata
  static const gudangSenjataStore = '${server}api/gudang_senjata/store';
  //Logistik
  static const logistikStore = '${server}api/logistik/store';
  //Staff
  static const staffShow = '${server}api/staff/show';
  // Pejabat
  static const pejabatShow = '${server}api/pejabat/show';
  // Pejabat Armed
  static const armedShow = '${server}api/armed/show';
  // Pejabat Kostrad
  static const kostradShow = '${server}api/kostrad/show';
  // Calendar
  static const calendarShow = '${server}api/event/show';
  // Suggestion
  static const suggestion = '${server}api/saran/store';
  static const reportSuggestion = '${server}api/report/saran';
  //Report
  static const reportAbsensi = '${server}api/report/absensi';
  static const reportPerizinan = '${server}api/report/perizinan';
  static const reportPerizinanRanpur = '${server}api/report/ranpur';
  static const reportPerizinanKendaraan = '${server}api/report/kendaraan';
  static const reportGudangSenjata = '${server}api/report/gudang_senjata';
  static const reportLogistik = '${server}api/report/logistik';
  // Feature
  static const ftDashboardSlider = '${server}api/feature/slider/show';
  static const ftDashboardTextMarquee = '${server}api/feature/marquee/show';
}