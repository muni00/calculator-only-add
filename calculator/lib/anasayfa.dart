import 'package:calculator/renkler.dart';
import 'package:flutter/material.dart';

class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  //hesaplama değişkenleri
  dynamic text = "0";
  dynamic toplam = "0";
  double birinci = 0;
  double ikinci = 0;

  dynamic sonuc = "";
  dynamic gosterilecekDeger = "";
  dynamic islem = "";
  dynamic islemKaydi = "";

  @override
  Widget build(BuildContext context) {
    //ekran bilgisi değişkenleri
    var ekranBilgisi = MediaQuery.of(context);
    //final double ekranYuksekligi = ekranBilgisi.size.height;
    final double ekranGenisligi = ekranBilgisi.size.width;

    return Scaffold(
      backgroundColor: yaziRenk,
      appBar: AppBar(
        backgroundColor: yaziRenk,
        title: Text(
          "Hesap Makinesi",
          style: TextStyle(color: buttonRenkAcik),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "$text",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: buttonRenkAcik,
                          fontSize: 75,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Text(
                      " = $toplam",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 20, color: buttonRenkKoyu),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              children: [
                buttonOlustur(
                    ekranGenisligi / 4, 70.0, "AC", buttonRenkKoyu, yaziRenk),
                buttonOlustur((ekranGenisligi / 4) * 2.4, 70.0, "+",
                    buttonRenkKoyu, yaziRenk),
              ],
            ),
            Row(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        buttonOlustur(ekranGenisligi / 5, 70.0, "1",
                            buttonRenkAcik, yaziRenk),
                        buttonOlustur(ekranGenisligi / 5, 70.0, "2",
                            buttonRenkAcik, yaziRenk),
                        buttonOlustur(ekranGenisligi / 5, 70.0, "3",
                            buttonRenkAcik, yaziRenk),
                      ],
                    ),
                    Row(
                      children: [
                        buttonOlustur(ekranGenisligi / 5, 70.0, "4",
                            buttonRenkAcik, yaziRenk),
                        buttonOlustur(ekranGenisligi / 5, 70.0, "5",
                            buttonRenkAcik, yaziRenk),
                        buttonOlustur(ekranGenisligi / 5, 70.0, "6",
                            buttonRenkAcik, yaziRenk),
                      ],
                    ),
                    Row(
                      children: [
                        buttonOlustur(ekranGenisligi / 5, 70.0, "7",
                            buttonRenkAcik, yaziRenk),
                        buttonOlustur(ekranGenisligi / 5, 70.0, "8",
                            buttonRenkAcik, yaziRenk),
                        buttonOlustur(ekranGenisligi / 5, 70.0, "9",
                            buttonRenkAcik, yaziRenk),
                      ],
                    ),
                  ],
                ),
                GestureDetector(
                  child: Container(
                    child: buttonOlustur(ekranGenisligi / 5, 230.0, "=",
                        buttonRenkKoyu, yaziRenk),
                  ),
                  onTap: () {},
                ),
              ],
            ),
            Row(
              children: [
                buttonOlustur(
                    ekranGenisligi / 5, 70.0, "0", buttonRenkAcik, yaziRenk),
                buttonOlustur(ekranGenisligi / 5 * 2.1, 70.0, "00",
                    buttonRenkAcik, yaziRenk),
                buttonOlustur(
                    ekranGenisligi / 5, 70.0, ".", buttonRenkAcik, yaziRenk),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonOlustur(double btnwidth, double btnheight, String btntext,
      Color btncolor, Color txtcolor) {
    return InkWell(
      focusColor: buttonRenkFocus,
      onTap: () {
        hesaplama(btntext);
      },
      child: Container(
          margin: const EdgeInsets.only(left: 10, top: 8.0),
          width: btnwidth,
          height: btnheight,
          decoration: BoxDecoration(
              color: btncolor, borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                btntext,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: txtcolor,
                ),
              ),
            ],
          )),
    );
  }

  void hesaplama(btnText) {
    if (btnText == "AC") {
      degiskenTemizle(); //değişkenleri temizleme

    } else if (islem == '=' && btnText == '=') {
      if (islemKaydi == '+') {
        gosterilecekDeger = toplama();
      }
    } else if (btnText == '+' || btnText == '=') {
      if (birinci == 0) {
        birinci = double.parse(sonuc);
      } else {
        ikinci = double.parse(sonuc);
      }

      if (islem == '+') {
        gosterilecekDeger = toplama();
        //toplam = toplama();
      }
      islemKaydi = islem;
      islem = btnText;
      sonuc = '';
    } else {
      sonuc = sonuc + btnText;
      gosterilecekDeger = sonuc;
    }

    setState(() {
      text = gosterilecekDeger;
      toplam = gosterilecekDeger;
    });
  }

  String toplama() {
    sonuc = (birinci + ikinci).toString();
    birinci = double.parse(sonuc);
    return noktaIceriyorMu(sonuc);
  }

  void degiskenTemizle() {
    text = "0";
    toplam = "0";
    birinci = 0;
    ikinci = 0;
    sonuc = '';
    gosterilecekDeger = '0';
    islem = '';
    islemKaydi = '';
  }

  String noktaIceriyorMu(dynamic sayi) {
    // string'den sayıya cevirme'
    if (sayi.toString().contains('.')) {
      List<String> splitDecimal = sayi.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return sayi = splitDecimal[0].toString();
      }
    }
    return sayi;
  }
}
