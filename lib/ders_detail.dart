import 'package:flutter/material.dart';

import 'data/dbHelper.dart';
import 'main.dart';

class DersDetail extends StatefulWidget {
  Ders ders;
  DersDetail(this.ders);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DersDetailState(ders);
  }
}

enum Options { delete, update }

class _DersDetailState extends State {
  Ders ders;
  _DersDetailState(this.ders);
  var dbHelper = DbHelper();
  var txtName = TextEditingController();
  var txtKredi = TextEditingController();
  var txtHarf = TextEditingController();

  @override
  void initState() {
    txtName.text = ders.ad;
    txtHarf.text = ders.harfDegeri.toString();
    txtKredi.text = ders.kredi.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Ders Detayı"),
        actions: <Widget>[

        ],
      ),
      body: buildDersDetail(),
    );
  }

  buildDersDetail() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            buildNameField(),
            buildHarfField(),
            buildKrediField(),
            OutlineButton(onPressed: () async {        await dbHelper.update(Ders.withId(ders.id, txtName.text,
                double.tryParse(txtHarf.text), int.tryParse(txtKredi.text)));
            Navigator.pop(context, true);}, child: Text("Güncelle")),
            OutlineButton(onPressed: ()async { await dbHelper.delete(ders.id);
            Navigator.pop(context, true);}, child: Text("Sil")),

          ],
        ),
      ),
    );
  }

  buildNameField() {
    return TextField(
      decoration: InputDecoration(labelText: "Ders adı"),
      controller: txtName,
    );
  }

  buildKrediField() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: "Ders kredisi"),
      controller: txtKredi,
    );
  }

  buildHarfField() {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: "Ders harf değeri"),
      controller: txtHarf,
    );
  }

}
