import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:ap/models/qc_fix_model.dart';
import 'package:ap/models/user_model.dart';
import 'package:ap/utilitys/my_constant.dart';
import 'package:ap/utilitys/my_dialog.dart';
import 'package:ap/utilitys/show_signout.dart';
import 'package:ap/widgets/show_image.dart';
import 'package:ap/widgets/show_title.dart';
import 'package:dio/dio.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QcCheck extends StatefulWidget {
  const QcCheck({Key? key}) : super(key: key);

  @override
  _QcCheckState createState() => _QcCheckState();
}

class _QcCheckState extends State<QcCheck> {
  String? fix,
      amount,
      qty,
      readUsername,
      readName,
      readStyle,
      readCode,
      readUserID,
      readGroup,
      readLevel,
      scanresult;
  bool checkBar = false;
  bool checkPic = true;
  List<QCCheckFixModel> fixModels = [];
  final formKey = GlobalKey<FormState>();
  TextEditingController barcodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkFix();
  }

  Future<Null> checkFix({String? readUsername}) async {
    String? apicheckFix =
        '${MyConstant.check_url}/qc_check_fix.php?isCheck=true&txtUser=$readUsername';
    await Dio().get(apicheckFix).then((value) async {
      if (value.toString() == 'null') {
        MyDialog().normalDialog2(
            context, 'Data False', 'User $readUsername Not Data');
      } else {
        for (var item in json.decode(value.data)) {
          QCCheckFixModel model = QCCheckFixModel.fromMap(item);
          String fix = model.fix;
          String amount = model.amount;
          String qty = model.qty;
          print('fix=$fix, amount=$amount, qty=$qty');
          // Navigator.pushNamedAndRemoveUntil(
          //     context, MyConstant.routeQcCheck, (route) => false);
        }
      }
    });
  }

  readDataFix() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // set state  เพื่อให้มีการ refresh เมื่อมีการเก็บค่าลงตัวแปร
      fix = prefs.getString('fix');
      amount = prefs.getString('amount');
      qty = prefs.getString('qty');
    });
  }

  @override
  Widget build(BuildContext context) {
    readData();
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ตรวจสอบค่า',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        backgroundColor: MyConstant.primary,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 44, // Changing Drawer Icon Size
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            ShowSignOut(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName:
                      Text('Quality', style: MyConstant().TitleExit1()),
                  accountEmail: Text('คิวซีตรวจสอบมัดงาน',
                      style: MyConstant().TitleExit2()),
                  currentAccountPicture: CircleAvatar(
                    child: FlutterLogo(
                      size: 42.0,
                    ),
                    backgroundColor: Colors.white,
                  ),
                ),
                menuListLoad1(),
                menuListLoad2(),
                menuListLoad3(),
              ],
            ),
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 16),
                width: size * 0.9,
                child: ListView(
                  children: [
                    InsertScaner(size),
                    InsertButton(),
                    //showDataFromSharedPreferences(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton.large(
      //   onPressed: startScan,
      //   child: Icon(
      //     Icons.qr_code_rounded,
      //     size: 60,
      //   ),
      // ),
    );
  }

  Widget InsertButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      width: 320,
      height: 320,
      child: ElevatedButton(
        onPressed: clickFix,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(150.0)),
            primary: Colors.redAccent),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ตรวจไม่ผ่าน",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'tatol= ${fix}',
                    style: TextStyle(color: Colors.white, fontSize: 50),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget InsertScaner(double size) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: size * 0.8,
      height: 80,
      child: ElevatedButton(
        onPressed: startScan,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            primary: Colors.blue[600]),
        child: Column(
          children: [
            Center(
              child: Row(
                children: [
                  SizedBox(
                    width: 35,
                  ),
                  Icon(
                    Icons.qr_code_outlined,
                    size: 50,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "สแกนมัดงาน",
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  startScan() async {
    String cameraScanResult = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", false, ScanMode.DEFAULT);
    //String? cameraScanResult = await scanner.scan();
    setState(() async {
      scanresult = cameraScanResult;
      if (scanresult.toString() != 'null') {
        checkBar = true;
        checkPic = false;
        print(
            '## name = $readUsername, group = $readGroup, barcode = $scanresult');
        String path =
            '${MyConstant.check_url}/insert_bind_qc.php?isAdd=true&txtUser=$readUsername&txtGroup=$readGroup&txtBarcode=$scanresult';

        await Dio().get(path).then((value) async {
          print('## value ==>> $value');
          if (value.toString() == "true") {
            MyDialog().normalDialog(context, 'Success', 'บันทึกมัดงานสำเร็จ');
            //Navigator.pop(context);
          } else if (value.toString() == "duplicate") {
            MyDialog()
                .normalDialog2(context, 'Warning', 'บันทึกมัดงานมัดซ้ำ!!');
          } else {
            MyDialog().normalDialog2(context, 'Warning', 'ไม่พบมัดงานในระบบ!!');
          }
        });

        print('Process Insert to Database = $scanresult');
        //MyDialog().normalDialog(context, 'Data Success', 'Bind Number = $scanresult');
        readUsername = '';
        readGroup = '';
        scanresult = null;
      }
    });
  }

  clickFix() async {
    readData();
    print(
        'style=$readStyle, code=$readCode, group=$readGroup, qty=1, isAdd=true, txtUser=$readUsername, txtName=$readName');
    if (readStyle.toString().isNotEmpty && readCode.toString().isNotEmpty) {
      var response = await http.post(
          Uri.parse("${MyConstant.check_url}/qc_insert_fix.php"),
          body: ({
            'txtUser': readUsername,
            'txtName': readName,
            'txtStyle': readStyle,
            'txtCode': readCode,
            'txtGroup': readGroup,
            'txtQty': "1",
            'isAdd': "true"
          }));
      if (response.statusCode == 200) {
        print("Insert Success");
        var data = json.decode(response.body); //decoding json to array
        if (data["success"]) {
          setState(() {
            String txtUser = "";
            String txtName = "";
            String txtStyle = "";
            String txtCode = "";
            String txtGroup = "";
            String txtQty = "";
            String isAdd = "";
          });
        } else {
          Navigator.pushNamedAndRemoveUntil(
              context, MyConstant.routeQcCheck, (route) => false);
        }
      } else {
        //there is error
        print("Error during sendign data");
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("ไม่สามารถบันทึกได้")));
      }
    }
  }

  ListTile menuListLoad1() {
    return ListTile(
      onTap: () {
        setState(() {
          Navigator.pushNamedAndRemoveUntil(
              context, MyConstant.routeQcCheck, (route) => false);
        });
      },
      leading: Icon(Icons.filter_1),
      title: ShowTitle(
        title: 'Check the bundle',
        textStyle: MyConstant().h5Style(),
      ),
      subtitle: ShowTitle(
        title: 'ตรวจสอบมัดงาน',
        textStyle: MyConstant().h6Style(),
      ),
    );
  }

  ListTile menuListLoad2() {
    return ListTile(
      onTap: () {
        setState(() {
          Navigator.pushNamedAndRemoveUntil(
              context, MyConstant.routeQcSearch, (route) => false);
        });
      },
      leading: Icon(Icons.filter_2),
      title: ShowTitle(
        title: 'Recive Bind',
        textStyle: MyConstant().h5Style(),
      ),
      subtitle: ShowTitle(
        title: 'มัดงานที่รับวันนี้',
        textStyle: MyConstant().h6Style(),
      ),
    );
  }

  ListTile menuListLoad3() {
    return ListTile(
      onTap: () {
        setState(() {
          Navigator.pushNamedAndRemoveUntil(
              context, MyConstant.routeQcSelectStyle, (route) => false);
        });
      },
      leading: Icon(Icons.filter_3),
      title: ShowTitle(
        title: 'Selcet Style',
        textStyle: MyConstant().h5Style(),
      ),
      subtitle: ShowTitle(
        title: 'เลือกสไตส์ที่ตรวจสอบ',
        textStyle: MyConstant().h6Style(),
      ),
    );
  }

  readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // set state  เพื่อให้มีการ refresh เมื่อมีการเก็บค่าลงตัวแปร
      readUserID = prefs.getString('EmID');
      readUsername = prefs.getString('Emuser');
      readName = prefs.getString('Emname');
      readGroup = prefs.getString('Emgroup');
      readLevel = prefs.getString('Emlevel');
      readStyle = prefs.getString('Style');
      readCode = prefs.getString('Code');
    });
  }

  // Widget showDataFromSharedPreferences() {
  //   readData();
  //   return Container(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: <Widget>[
  //         Text(readUsername ?? ''),
  //         Text(readName ?? ''),
  //         Text(readUserID ?? ''),
  //         Text(readGroup ?? ''),
  //         Text(readLevel ?? ''),
  //         Text(readStyle ?? ''),
  //         Text(readCode ?? ''),
  //       ],
  //     ),
  //   );
  // }
}
