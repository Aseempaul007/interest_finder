import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Si calci",
    home: MyFun(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        primaryColor: Colors.indigo,
        accentColor: Colors.deepPurple,
        brightness: Brightness.dark),
  ));
}

class MyFun extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyFun();
  }
}

class _MyFun extends State<MyFun> {
  var _formKey = GlobalKey<FormState>();
  var dropDownValue = 'Rupees';
  var displayResult = '';
  TextEditingController principalText = new TextEditingController();
  TextEditingController roiText = new TextEditingController();
  TextEditingController timeText = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    final _minPadding = 5.0;
    var _currentSelectedItem = 'Rupees';
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          "Interest Calculator",
          style: TextStyle(fontSize: 30.0, fontFamily: 'Ubuntu'),
        ),
      ),
      body: Form(
        key: _formKey,
          child: Padding(
                   padding: EdgeInsets.all(_minPadding*2),
              child: ListView(
        children: <Widget>[
          ImageIcon(),
          Padding(
              padding: EdgeInsets.only(
                  top: _minPadding * 10, bottom: _minPadding * 2),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: principalText,
                validator: (String value){
                if(value.isEmpty){
                  return 'Please entre principal';
                }
                },
                decoration: InputDecoration(
                    labelText: 'Principal',
                    hintText: 'Entre your total amount',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(_minPadding))),
              )),
          Padding(
              padding: EdgeInsets.only(
                  top: _minPadding * 2, bottom: _minPadding * 2),
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: roiText,
                validator: (String value){
                  if(value.isEmpty){
                    return 'Please enter rate';
                  }
                },
                decoration: InputDecoration(
                    labelText: 'Rate of interest',
                    hintText: 'Enter interest eg. 20',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(_minPadding))),
              )),
          Padding(
              padding: EdgeInsets.only(
                  top: _minPadding * 2, bottom: _minPadding * 2),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: timeText,
                      validator: (String value){
                        if(value.isEmpty){
                          return 'Please enter time period';
                        }
                      },
                      decoration: InputDecoration(
                          labelText: 'Duration',
                          hintText: 'Time in years',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(_minPadding))),
                    ),
                  ),
                  Container(
                    width: _minPadding * 3,
                  ),
                  Expanded(
                      child: DropdownButton<String>(
                    value: dropDownValue,
                    onChanged: (String newValue) {
                      setState(() {
                        dropDownValue = newValue;
                      });
                    },
                    items: <String>['Rupees', 'Dollars', 'Euros']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value, child: Text(value));
                    }).toList(),
                  ))
                ],
              )),
          Padding(
            padding:
                EdgeInsets.only(top: _minPadding * 2, bottom: _minPadding * 2),
            child: Row(children: <Widget>[
              Expanded(
                child: RaisedButton(
                  elevation: 5.0,
                  color: Colors.teal,
                  child: Text(
                    "Calculate",
                    style: textStyle,
                  ),
                  onPressed: () {
                    setState(() {
                      if(_formKey.currentState.validate()) {
                        displayResult = Interest();
                        return displayResult;
                      }
                    });
                  },
                ),
              ),
              Container(
                width: _minPadding * 3,
              ),
              Expanded(
                  child: RaisedButton(
                elevation: 5.0,
                color: Colors.red,
                child: Text("Reset", style: textStyle),
                onPressed: () {
                  setState(() {
                    _reset();
                  });
                },
              ))
            ]),
          ),
          Padding(
              padding:
                  EdgeInsets.only(top: _minPadding * 2, bottom: _minPadding),
              child: Container(
                child: Text(this.displayResult, style: textStyle),
              ))
        ],
      ))),
    );
  }

  String Interest() {
    double p = double.parse(principalText.text);
    double r = double.parse(roiText.text);
    double t = double.parse(timeText.text);
    double si = p + ((p * r * t) / 100);
    String result =
        "After $t years your total amount at the interest of $r% is $si $dropDownValue";
    return result;
  }

  String _reset() {
    principalText.text = '';
    roiText.text = '';
    timeText.text = '';
    displayResult = '';
  }
}

class ImageIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = new AssetImage("images/imageone.png");
    Image image = new Image(image: assetImage);
    return Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Container(
          child: image,
          height: 100.0,
          width: 100.0,
        ));
  }
}
