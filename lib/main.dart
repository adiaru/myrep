import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() {
  runApp(
    MaterialApp(
        theme: new ThemeData(scaffoldBackgroundColor: Colors.blueGrey[200]),
        title:'Simple Interest Calculator',
      home: SIForm() //stateful widget

    )
  );
}

class SIForm extends StatefulWidget{

  @override
  State<StatefulWidget> createState(){
    return _SIFormState();
  }
}
class _SIFormState extends State<SIForm>{
  var _currencies = ['Rupees', 'Dollars','Pounds'];
  final _minimumPadding=5.0;
var _currentItemSelected= 'Rupees';
TextEditingController principalController = TextEditingController(); //controllers help us extract the values out of the labels.
  TextEditingController interestController = TextEditingController();
  TextEditingController termController = TextEditingController();

  var displayResult ='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: Container(



        margin: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(
          children: <Widget> [
            getImageAsset(),

            Padding(   //to give some space between two text fields
              padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
                child: TextField(
              keyboardType: TextInputType.number, //to enable numbers only in the keyboard
                  controller: principalController,
      decoration: InputDecoration(
        labelText: 'Principal',
        labelStyle: TextStyle(fontSize:16,color: Colors.black),
        hintText: 'Enter Principal e.g 12000', //to specify the kind of input to be entered when clicked on principal.
        border:OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
    ),
    )),
        Padding(
          padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),

          child:
            TextField(
              keyboardType: TextInputType.number, //to enable numbers only in the keyboard
              controller: interestController,
              decoration: InputDecoration(
                labelText: 'interest',
                labelStyle: TextStyle(fontSize:16,color: Colors.black),
                hintText: 'In percent', //to specify the kind of input to be entered when clicked interest.
                border:OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)
                ),
              ),
            )),
             Padding(
                 padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
                 child:Row(
                children:<Widget>[

                  Expanded(child:
                  TextField(
                    keyboardType: TextInputType.number, //to enable numbers only in the keyboard
                    controller: termController,
                    decoration: InputDecoration(
                      labelText: 'Term',
                      labelStyle: TextStyle(fontSize:16,color: Colors.black),
                      hintText: 'time in years', //to specify the kind of input to be entered when clicked interest.
                      border:OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      ),
                    ),
                  )),
                  Container(width: _minimumPadding*5,),
                 Expanded(child: DropdownButton<String>(
                    items: _currencies.map((String value){
                     return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                      );
                    }).toList(),
                     value: _currentItemSelected,
                onChanged: (newValueSelected){
                      _onDropDownItemSelected(newValueSelected);

                      },
                 ))
                ],
)),
            Padding(
                padding: EdgeInsets.only(top: _minimumPadding,bottom: _minimumPadding),
                child:Row(children: <Widget>[
              Expanded(
                child: RaisedButton(
                  
                  textColor: Theme.of(context).primaryColor,
                  child: Text('Calculate'),
                  onPressed: (){
                    setState(() {
                     this.displayResult = _calculateTotalReturns();
                    });
                    },

                ),
              ),

                Expanded(
                  child: RaisedButton(
                    child: Text('Reset'),
                    onPressed: (){
                      setState(() {
                        _reset();
                      });

                    },
                  ),
                ),
              ],)),
            Padding(
              padding: EdgeInsets.all(_minimumPadding*2),
              child: Text( this.displayResult),
        ),
        ],
      ),
    ),
    );
  }
  Widget getImageAsset()
  {
    AssetImage assetImage = AssetImage('images/money.png');
        Image image =Image(image: assetImage, width: 190.0, height:190.0,);
     return Container(child: image, margin: EdgeInsets.all(_minimumPadding * 10),);

  }
  void _onDropDownItemSelected(newValueSelected){
    setState(() {
      this._currentItemSelected=newValueSelected;
    });
  }
  String _calculateTotalReturns() {
    double principal = double.parse(principalController.text);
    double interest = double.parse(interestController.text);
    double term = double.parse(termController.text);
    double totalAmountPayable = principal+(principal * interest * term) /100;
    String result ='After $term years, your investment will be worth $totalAmountPayable $_currentItemSelected';
    return result;
  }
  void _reset()
  {
    principalController.text = '';
    interestController.text = '';
    termController.text = '';
    displayResult ='';
    _currentItemSelected= _currencies[0]; //sets back to rupees which is at index 0
  }
}