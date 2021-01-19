import 'package:Appening/Core/SharedPrefrences/sharedPrefrence.dart';
import 'package:Appening/UI/Screens/PlacesScreen/placesScreen.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {

  List<String> _checked = [];
  bool allSelectValue = false;
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
checkSet();
  }
  
  void checkSet() async{
    List<String> filters = await getFilterList();
    print(filters);
    setState(() {
      _checked = filters;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body:

      Padding(
        padding: const EdgeInsets.only(left:20.0,right: 20.0,top:12.0, bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(

              children: [
                Checkbox(
                    value: allSelectValue, onChanged: (bool value){
                  setState(() {
                    allSelectValue = value;
                    value == true?
                    _checked = ["GYM", "CAFE" , "RESTAURANT"]:_checked =[];
                  });
                }),
                Text('ALL SELECT'),
                Expanded(child: SizedBox()),
                InkWell(
                  onTap: () {
                    setState(() {
                      _checked =[];
                      allSelectValue =false;
                    });
                  },
                 child: Text('Celar All', style: TextStyle(
                   color: Colors.blueAccent,
                   fontSize: 16,
                 ),),
                )
              ],
            ),

            CheckboxGroup(
            orientation: GroupedButtonsOrientation.VERTICAL,
            onSelected: (List selected) => setState((){

              _checked = selected;
              _checked.length == 3?allSelectValue = true: allSelectValue =false;
              print(_checked);
            }),
            labels: <String>[
              "GYM",
              "CAFE",
              "RESTAURANT"
            ],
            checked: _checked,
            itemBuilder: (Checkbox cb, Text txt, int i){
              return Row(
                children: <Widget>[
                  cb,
                  txt,
                ],
              );
            },
    ),
            Expanded(child: SizedBox()),
            FlatButton(onPressed: () {

              setSharedPrefrences(_checked);

              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> PlacesScreen()));

            }, child: Text('Submit',style: TextStyle(
              color: Colors.white,
              fontSize: 18
            ),),
            color: Colors.blue,
              minWidth: double.infinity,
              height: 45,
            )
          ],
        ),
      )
    );
  }
  setSharedPrefrences(List<String> filters) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList("Filters List", filters);
  }
}
