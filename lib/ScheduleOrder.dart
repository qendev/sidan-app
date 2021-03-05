import 'package:flutter/material.dart';
import 'package:sidan_app/MyOrders.dart';
import 'package:sidan_app/OrderStatus.dart';

void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScheduleOrder(),
    )
);

class ScheduleOrder extends StatefulWidget {
  @override
  _ScheduleOrderState createState() => _ScheduleOrderState();
}

class _ScheduleOrderState extends State<ScheduleOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff006DFF),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 50, 0, 0),
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
              height: MediaQuery.of(context).size.height - 200.0,
              child: ListView(
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
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 0, 70, 0),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'LOCATION'
                                  ),
                                ),
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
                                      child: Text(
                                          'Schedule Date and Time',
                                          style: TextStyle(
                                            color: Colors.blue.shade900,
                                            fontSize: 17.0,
                                          )
                                      )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: 'DAY.'
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: 'TIME'
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
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
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
}
