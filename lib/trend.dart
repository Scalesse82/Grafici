
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:graphic/graphic.dart' as graphic;


class TrendScreen extends StatefulWidget {
  static String routeName = "/trendPage";






  TrendScreen( {Key key}) : super(key: key);

  @override
  _TrendScreenState createState() => _TrendScreenState();
}

class _TrendScreenState extends State<TrendScreen> {

  bool six = true;

  var surveysLastSixMonths=[
    {"questionNumber":"1","media":23,"periodT":"T1"},
    {"questionNumber":"1","media":34,"periodT":"T2"},
    {"questionNumber":"1","media":67,"periodT":"T3"},
    {"questionNumber":"2","media":1,"periodT":"T1"},
    {"questionNumber":"2","media":89,"periodT":"T2"},
    {"questionNumber":"2","media":44,"periodT":"T3"}
    ];
  var surveysLastYear=[
    {"questionNumber":"1","media":56,"periodT":"T1"},
    {"questionNumber":"1","media":90,"periodT":"T2"},
    {"questionNumber":"1","media":12,"periodT":"T3"},
    {"questionNumber":"2","media":17,"periodT":"T1"},
    {"questionNumber":"2","media":34,"periodT":"T2"},
    {"questionNumber":"2","media":78,"periodT":"T3"}
  ];




  var data;

  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:body(context),
    );
  }



  Widget body(context) {
    return Container(
      padding: EdgeInsets.only(left: 28, right: 28),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Expanded(
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
                child: AutoSizeText(
                  "Trend"

                  //AppLocalizations.of(context)
                  //  .translate('trendVuotoText')
                  ,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Mulish",
                      fontSize: ScreenUtil().setSp(16)),
                  maxLines: 4,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(14)),
                child: AutoSizeText(
                  "descrizione"


                  //AppLocalizations.of(context).translate('trendVuotoText1')
                  ,
                  style: TextStyle(
                      fontFamily: "Mulish",
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(14)),
                  maxLines: 4,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: ScreenUtil().setHeight(28)),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(right: 2, left: 8),
                        //height: ScreenUtil().setHeight(24),
                        // decoration: BoxDecoration(),
                        child: RaisedButton(
                          padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          child: Text(
                            "6 mesi"

                            ,
                            style: TextStyle(
                                fontFamily: 'Mulish',
                                color: six
                                    ? Colors.white
                                    : Colors.grey,
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.w400),
                          ),
                          color: six
                              ? Colors.orange
                              : Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: BorderSide(
                                color: six
                                    ? Colors.orange
                                    : Colors.grey,
                                width: 2),
                          ),
                          elevation: 0,
                          onPressed: () {
                            setState(() {
                              six = true;
                              //data=getData();

                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 2, right: 8),
                        // height: ScreenUtil().setHeight(24),
                        //decoration: BoxDecoration(),
                        child: RaisedButton(
                          padding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                          child: Text(
                           "un anno",
                            style: TextStyle(
                                fontFamily: 'Mulish',
                                color: six
                                    ? Colors.orange
                                    : Colors.white,
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.w400),
                          ),
                          color: six
                              ? Colors.white
                              : Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            side: BorderSide(
                                color: six
                                    ? Colors.grey
                                    : Colors.orange,
                                width: 2),
                          ),
                          elevation: 0,
                          onPressed: () {
                            setState(() {
                              six = false;
                              data=getData();
                            });
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.only(top: ScreenUtil().setHeight(16),bottom:ScreenUtil().setHeight(8) ),
                  width: 350,
                  height: 300,

                  child:  graphic.Chart(

                    data:
                    //getData(),

                    six ? surveysLastSixMonths : surveysLastYear,

                    scales: {
                      'index': graphic.CatScale(
                        accessor: (map) => map["periodT"].toString(),

                        //  (map) => map['variableName'].toString(),

                        // range: [0, 1],
                      ),
                      'type': graphic.CatScale(
                        accessor: (map) => map["questionNumber"] as String,
                        //  (map) => map['variableDescription'] as String,
                      ),
                      'value': graphic.LinearScale(
                        accessor: (map) => map["media"] as num,
                        nice: true,

                        // (map) => map['variableValue'] as num,

                        // nice: true,
                      ),
                    },
                    geoms: [
                      graphic.LineGeom(
                        position: graphic.PositionAttr(field: 'index*value'),
                        // valore segli assi
                        color: graphic.ColorAttr(field: 'type', values: [ Colors.grey,Colors.blue,Colors.red,Colors.blueGrey,Colors.amberAccent,Colors.lightGreen,Colors.indigo,Colors.teal,Colors.lime,Colors.green]),//field: 'type'
                        //imposta il colore in base al type
                        shape: graphic.ShapeAttr(
                            values: [graphic.BasicLineShape(smooth: false)]),
                        //tipo di curva della linea
                        //adjust: graphic.StackAdjust(),
                        size: graphic.SizeAttr(values: [2]), //dimensione linee
                      )
                    ],
                    axes: {
                      'index': graphic.Defaults.horizontalAxis,
                      'value': graphic.Defaults.verticalAxis,
                      // ..label=null
                    },
                  )
              ),




            ],
          ),
        ),
      ),
    );
  }




  getData(){

    if(six)
      return surveysLastSixMonths;
    else
      return surveysLastYear;
  }



}
