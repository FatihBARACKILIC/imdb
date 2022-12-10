# Flutter IMDb Clone Bitirme projesi

## Kaynak Kodundan Silinen Dosyalar

* Api URLs: ./lib/constant/api-urls.dart
* Google Services: ./android/app/google-services.json
* Translate api: ./lib/services/translate_service.dart

## IMDb

IMDb üzerinden film verileri çeker.

## IMDb Description

* IMDb üzerinden film verilerini çeker ve YouTube'den fragman izlemenizi sağlar.
* Listenize eklediğiniz filmler telefon hafızasında saklanır ve listeyi düzenleyebilirsiniz.
* Seçtiğiniz file göre film özetini çevirebilirsiniz.
* Yakında yayınlanacak filmleri öğrenebilir ve erki filmleri aratabilirsiniz.

## Online Veri Kaynakları

* [Firebase](https://firebase.google.com/)
* [IMDb Api](https://imdb-api.com/)
* [Translate Api](https://rapidapi.com/googlecloud/api/google-translate1)
* [YouTube](https://pub.dev/packages/youtube_player_flutter)

### Firebase

`Kullanım şartı: 18/12/2022 tarihine kadar geçerli.`

Kullanıcı adı, E-Mail ve şifre bilgilerini saklamak ve kullanıcı girişi yapmak için kullanıldı.

### IMDb Api

`Kullanım şartı: Günlük 100 kere istek sınırı var.`

Tüm film verileri bu api'den çekilmektedir.

### Translate Api

`Kullanım şartı: Aylık 500 kere istek sınırı var.`

Film özetlerini kullanıcının seçtiği dile çevirmek için kullanıldı.

### YouTube

`Kullanım şartı: IMDb api'den alınan YouTube linkine bağlı. IMDb api ye istek atma hakkın olduğu sürece çalışır.`

Film fragmanları YouTube'den çekiliyor.

## Offline Veri Kaynakları

* Shared Preferences
* SQLite

### Shared Preferences

* Kullanıcı Login yaptığı zaman bilgilerini tutar ve otomatik login yapmasını sağlar.
* Kullanıcı Gece Modunu açıp kapattığında bu tercihin hatırlanması.
* Kullanıcının seçtiği dili tutar bu sayede çeviri özelliğini kullanabilir.
* Kullanıcı Onboard ekranını bir kez geçtiğinde ekranın bir daha açılmaması için bu bilgiyi saklar.

### SQLite

* SQLite ile kullanıcının seçtiği filmler telefonunda saklanacaktır.

## Kullanılan Flutter Paketleri

* flutter_launcher_icons
* shared_preferences
* smooth_page_indicator
* transparent_image
* provider
* cloud_firestore
* firebase_core
* http
* share_plus
* youtube_player_flutter
* sqflite
* path

## Resimler

[Yüksek kalite resimler](./assets/high-ss/)

[Düşük kalite resimler](./assets/low-ss/)

## Apk

[Apk klasörü](./apk/)

## Author

[`Fatih BARAÇKILIÇ`](https://github.com/FatihBARACKILIC)
