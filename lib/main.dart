import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: FirstScreen());
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Selamat Datang di BMI Calulator.\n',
                  style: new TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  ' Aplikasi ini mampu menghitung Body Mass Index (BMI)\n Anda dan mengetahui apakah berat badan Anda\n sudah ideal atau belum.\n')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Silahkan pilih jenis kelamin')],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(
              child: Text('Laki-laki'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SecondScreen();
                }));
              },
            ),
            ElevatedButton(
              child: Text('Perempuan'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SecondScreen();
                }));
              },
            ),
          ])
        ],
      )),
    );
  }
}

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  double bb = 0;
  double tb = 0;
  late double bmi;
  late String status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Berat dan Tinggi Badan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Berat Badan',
                labelText: 'Berat Badan (dalam kg)',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (input) => bb = double.parse(input),
            ),
            TextField(
              decoration: InputDecoration(
                hintText: 'Tinggi Badan',
                labelText: 'Tinggi Badan (dalam cm)',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (input) => tb = double.parse(input),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (bb == 0 || tb == 0) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(
                              'Harap masukan data berat badan dan tinggi badan yang sesuai'),
                        );
                      });
                } else {
                  setState(() {
                    bmi = bb / ((tb / 100) * (tb / 100));
                  });
                  if (18.5 <= bmi && bmi <= 24.9) {
                    setState(() {
                      status = 'ideal';
                    });
                  }
                  if (24.9 < bmi) {
                    setState(() {
                      status = 'kegemukan';
                    });
                  }
                  if (bmi < 18.5) {
                    setState(() {
                      status = 'kurang';
                    });
                  }
                  //navigator disiniiiii
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ThirdScreen(bb, tb, bmi, status)));
                }
              },
              child: Text('Submit'),
            )
          ],
        ),
      ),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  final double bb;
  final double tb;
  final String status;
  double bmi;

  ThirdScreen(this.bb, this.tb, this.bmi, this.status);

  get content => null;
  void hasil() {
    bmi = bb / ((tb / 100) * (tb / 100));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasil BMI'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Nilai BMI Anda adalah $bmi')]),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Berat Badan Anda $status')]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FirstScreen();
                  }));
                },
                child: Text('Kembali'),
              )
            ])
          ],
        ),
      ),
    );
  }
}
