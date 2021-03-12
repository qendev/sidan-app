import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sidan_app/MyOrders.dart';
import 'package:sidan_app/OrderStatus.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';


void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScheduleOrder(),
    )
);

class ScheduleOrder extends StatefulWidget {
  const ScheduleOrder({Key key}) : super(key: key);

  static final kInitialPosition = LatLng(-33.8567844, 151.213108);


  @override
  _ScheduleOrderState createState() => _ScheduleOrderState();
}

class _ScheduleOrderState extends State<ScheduleOrder> {
  PickResult selectedPlace;


  //to dispaly date
  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  //to display time
  TimeOfDay selectedTime = TimeOfDay.now();
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay picked_s = await showTimePicker(
        context: context,
        initialTime: selectedTime, builder: (BuildContext context, Widget child) {
      return MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
        child: child,
      );});

    if (picked_s != null && picked_s != selectedTime )
      setState(() {
        selectedTime = picked_s;
      });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff006DFF),
        ),
        child: ListView(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 0, 0),
                  child: Text(
                      'Schedule your order',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      )
                  ),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Container(
              height: MediaQuery.of(context).size.height - 100.0,
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 200,
                        width: 320,
                        child: Card(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                      child: Text(
                                          'Add address and Contact Details',
                                          style: TextStyle(
                                            color: Colors.blue.shade900,
                                            fontSize: 17.0,
                                          )
                                      )),
                                ],
                              ),

                              Row(
                                children: [

                                  Padding(
                                    padding: EdgeInsets.fromLTRB(22, 0, 70, 0),
                                    child: Text('Location:',
                                    style: TextStyle(color: Colors.grey[700]),),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: FlatButton(
                                      onPressed: () {
                                        print('MAP CLICKED');
                                        openLocation();

                                      },
                                      child: Icon(
                                        Icons.location_on_rounded
                                      ),
                                    ),
                                  ),



                                ],
                              ),

                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 70, 0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'HOUSE NO.'
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        width: 320,
                        child: Card(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(32.0, 0, 0, 0),

                                        child: Text(
                                            'Schedule Date and Time',
                                            style: TextStyle(
                                              color: Colors.blue.shade900,
                                              fontSize: 17.0,
                                            )
                                        ),
                                      )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: FlatButton(
                                      onPressed: () => _selectDate(context),
                                      child: Container(
                                        margin: EdgeInsets.fromLTRB(2.0,  0, 0, 0),
                                        child: Icon(
                                          Icons.date_range,
                                          size: 32.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(0, 0, 70.0, 0),
                                      child: TextButton(
                                        onPressed: (){
                                          print('TIME CLICKED');
                                          _selectTime(context);

                                        },
                                        child: Icon(
                                          Icons.timer,
                                          size: 32.0,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 70, 0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'EXTRA DEATAILS / LANDMARK (OPTIONAL)'
                                  ),
                                ),
                              ),
                            ],
                          )
                        ),
                      ),
                      SizedBox(
                        height: 130,
                        width: 320,
                        child: Card(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                      child: Text(
                                          'Contact details',
                                          style: TextStyle(
                                            color: Colors.blue.shade900,
                                            fontSize: 17.0,
                                          )
                                      )),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 70, 0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'PHONE NUMBER'
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: SizedBox(
                          width: 320.0,
                          height: 50.0,
                          child: RaisedButton(
                            color: Color(0xffFFA451),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1.0),
                            ),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => OrderStatus()),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    'Confirm Order',
                                    style: TextStyle(color: Colors.white, fontSize: 17.0,)
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.white,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );

  }


  void openLocation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PlacePicker(
            apiKey: "AIzaSyACm1zfEZtKj78i47eKVaru5Pc3HI2refA",
            initialPosition: ScheduleOrder.kInitialPosition,
            useCurrentLocation: true,
            selectInitialPosition: true,

            //usePlaceDetailSearch: true,
            onPlacePicked: (result) {
              selectedPlace = result;
              Navigator.of(context).pop();
              setState(() {});
            },
            //forceSearchOnZoomChanged: true,
            //automaticallyImplyAppBarLeading: false,
            //autocompleteLanguage: "ko",
            //region: 'au',
            //selectInitialPosition: true,
            // selectedPlaceWidgetBuilder: (_, selectedPlace, state, isSearchBarFocused) {
            //   print("state: $state, isSearchBarFocused: $isSearchBarFocused");
            //   return isSearchBarFocused
            //       ? Container()
            //       : FloatingCard(
            //           bottomPosition: 0.0, // MediaQuery.of(context) will cause rebuild. See MediaQuery document for the information.
            //           leftPosition: 0.0,
            //           rightPosition: 0.0,
            //           width: 500,
            //           borderRadius: BorderRadius.circular(12.0),
            //           child: state == SearchingState.Searching
            //               ? Center(child: CircularProgressIndicator())
            //               : RaisedButton(
            //                   child: Text("Pick Here"),
            //                   onPressed: () {
            //                     // IMPORTANT: You MUST manage selectedPlace data yourself as using this build will not invoke onPlacePicker as
            //                     //            this will override default 'Select here' Button.
            //                     print("do something with [selectedPlace] data");
            //                     Navigator.of(context).pop();
            //                   },
            //                 ),
            //         );
            // },
            // pinBuilder: (context, state) {
            //   if (state == PinState.Idle) {
            //     return Icon(Icons.favorite_border);
            //   } else {
            //     return Icon(Icons.favorite);
            //   }
            // },
          );
        },
      ),

    );
    selectedPlace == null ? Container() : Text(selectedPlace.formattedAddress ?? "");



  }


}
