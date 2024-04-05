import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:pro_mobile/model/alarm_description_model.dart';
import 'package:pro_mobile/repository/firebase/fire_alarm_repo.dart';
import 'package:pro_mobile/repository/notification_repo.dart';
import 'package:pro_mobile/widgets/toast/toast_alert.dart';

class FireBackground {
  FireBackground._privateContructor();
  static final FireBackground instance = FireBackground._privateContructor();
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  bool isPlaying = false;

  void initialized() {
    alarmStelling();
  }

  void alarmStelling() async {
    FireAlarmRepo.instance.onChange(callback: ((value) {
      if (value["status"] != null && value["status"]) {
        if (!isPlaying) {
          initializedAudio(assetsAudioPlayer);
          isPlaying = true;
          //Set Notif
          NotificationRepo.instance.setNotif(
              title: AlarmDescriptionModel
                  .instance.alarmDescription[value["code"]]["title"],
              subTitle: AlarmDescriptionModel
                  .instance.alarmDescription[value["code"]]["sub_title"],
              content: AlarmDescriptionModel
                  .instance.alarmDescription[value["code"]]["description"],
              code: "0-alarm");
        }
      } else {
        if (isPlaying) {
          stopAudio(assetsAudioPlayer);
          isPlaying = false;
        }
      }
    }));
  }

  void initializedAudio(AssetsAudioPlayer assetsAudioPlayer) async {
    assetsAudioPlayer.open(
      Audio("assets/audio/alarm.mp3"),
      showNotification: true,
      loopMode: LoopMode.playlist,
    );
    ToastAlert.instance.showMessage(
        customMessage: true, customMessageText: "Alarm dibunyikan");
  }

  void stopAudio(AssetsAudioPlayer assetsAudioPlayer) async {
    await assetsAudioPlayer.stop();
    ToastAlert.instance.showMessage(
        customMessage: true, customMessageText: "Alarm diberhentikan");
  }
}
