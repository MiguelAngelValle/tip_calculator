import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  tipCalculation() {
    var costOfService = double.parse(tipController.text ?? "0");
    if(selectedRadio == 0) {
      tip = costOfService * 0.20;
    } else if(selectedRadio == 1) {
      tip = costOfService * 0.18;
    } else if(selectedRadio == 2) {
      tip = costOfService * 0.15;
    }
    if(switchEnabled) {
      tip = tip.ceilToDouble();
    }
    return 0.0;
  }

  bool switchEnabled = false;
  var tipController = TextEditingController();
  double tip = 0.0;
  var radioGroupValues = {
    0: 'Amazing 20%',
    1: 'Good 18%', 
    2: 'Okay 15%'
  };
  int selectedRadio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip time'),
      ),
      body: ListView(
        children: [
          SizedBox(height: 14),
          ListTile(
            leading: Icon(Icons.room_service),
            title: Padding(
              padding: EdgeInsets.only(right: 24),
              child: TextField(
                controller: tipController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Ingresar propina",
                  border: OutlineInputBorder()
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dinner_dining),
            title: Text("How was the service?"),
          ),
          
          Column(
            mainAxisSize: MainAxisSize.min,
            children: radioGroupValues.entries.map(
              (e) => ListTile(
                leading: Radio(value: e.key, 
                groupValue: selectedRadio, 
                onChanged: (int currentSelectedRadio) {
                  selectedRadio = currentSelectedRadio;
                  setState(() {});
                }),
                title: Text(e.value),
              )
              ).toList()
          ),

          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text("Round up tip"),
            trailing: Switch(
              value: switchEnabled, 
              onChanged: (switchstate){
                switchEnabled = switchstate;
                setState(() {});
              }),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: MaterialButton(
                    child: Text("CALCULATE", style: TextStyle(color: Colors.grey[200])),
                    onPressed: (){
                      tipCalculation();
                      setState(() {});
                    },
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(12),
            child: Text("Tip amount: \$$tip", textAlign: TextAlign.end),
          )
        ],
      ),
    );
  }
}