import 'package:flutter/material.dart';
import 'package:sidan_app/MyDart.dart';
import 'package:sidan_app/OrderStatus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


void main() => runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CartOne(),
    )
);

class CartOne extends StatefulWidget {
  final id,serviceName;

  const CartOne({Key key, this.id,this.serviceName}) : super(key: key);

  @override
  _CartOneState createState() => _CartOneState();
}

class _CartOneState extends State<CartOne> {

  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff006DFF),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage('assets/Group.png'),
                        ),
                        SizedBox(width: 10,),
                        Text(
                            widget.serviceName,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            )
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                        child: Text(
                            'Select items to add to cart',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            )
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 300.0,
                        //the best song ever
                        child:     StreamBuilder(
                          stream: getItems(widget.id),
                          builder: (BuildContext context,
                              AsyncSnapshot<List> snapshot) {
                            if (snapshot.hasError)
                              return Text('${snapshot.error}');
                            if (!snapshot.hasData)
                              return CircularProgressIndicator();

                            return ListView(
                              shrinkWrap: true,
                              children: snapshot.data
                                  .map((item) =>
                                  ListTile(
                                  title: Text(item['price']),
                                  subtitle: FlatButton(

                                      child: Column(
                                        children: [
                                          Text(item['name']),
                                          Image.network(item['icon'])
                                        ],
                                      )
                                  )))
                                  .toList(),
                            );
                          },
                        ),

                      )
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150.0,
                        height: 50.0,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1.0),
                            ),
                            color: Colors.white,
                            onPressed: () async {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(builder: (context) => DashBoard()),
                              // );
                            },
                            child:
                            Row(
                              children: [
                                Icon(
                                  Icons.shopping_basket,
                                  color: Color(0xffFFA451),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(15, 10, 0, 0),
                                  child: Column(
                                    children: [
                                      Text(
                                          'Total Amount',
                                          style: TextStyle(color: Colors.grey.shade500, fontSize: 12.0,)
                                      ),
                                      Text(
                                          'KSHS 1700',
                                          style: TextStyle(color: Colors.black, fontSize: 14.0,)
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )

                        ),
                      ),
                      SizedBox(
                        width: 150.0,
                        height: 50.0,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1.0),
                          ),
                          color: Color(0xffFFA451),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => OrderStatus()),
                            );
                          },
                          child:
                          Text(
                              'PROCEED',
                              style: TextStyle(color: Colors.white, fontSize: 17.0,)
                          ),

                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Stream<List> getItems(String id) {
    final Stream<QuerySnapshot> documents = firestoreInstance
        .collection("items")
        .where("service_id", isEqualTo: id)
        .snapshots();
    {
      return documents.map((querySnapshot) {
        List history;
        final documents = querySnapshot.docs;

        history = documents.map((documentSnapshot) => documentSnapshot).toList();

        return history;
      });


    }
  }
}

