import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../res/urls.dart';
import 'package:http/http.dart' as http;

import '../utils/leaveModel.dart';
class History extends StatefulWidget {
  String? user;
  String? query;
  History({super.key,required this.user,required this.query});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool isLoading = true;
  List<LeaveViewApiModel> leaves= [];
  List<bool> isExpandedList = [] ;
  @override
  loadData(String? user,{String query = "approved",int start = 0,int end = 100}) async {
    String url = "http://$host/token=<str:token>/hod/leave/view/id=${widget.user}/query=${widget.query}";
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      if (response.statusCode == 200){
        setState(() {
          leaves = leaveViewApiModelFromJson(response.body);
          print(leaves);
          isExpandedList =  List.generate(leaves.length, (index) => false);
          isLoading = false;
        });
      }
    }
    catch(e){
      print(e);
    }
  }
  Widget build(BuildContext context) {
    if(this.isLoading)
      loadData(widget.user);
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await loadData(widget.user);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: leaves.length,
              itemBuilder: (context,index){
                return Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Container(

                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child:ClipOval(
                              child: Image.network(
                                "http://$host/token=%3Cstr:token%3E/user=${leaves[index].student}/getImage",
                                fit: BoxFit.cover,
                                errorBuilder: (context,e,s){
                                  return Icon(Icons.person,color: Colors.grey.withOpacity(0.4),size: 40,);
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: 20,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${leaves[index]!.student?.name}",style: GoogleFonts.poppins(textStyle:TextStyle(fontSize: 17,fontWeight: FontWeight.w600) ),),
                              SizedBox(height: 2,),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(3)
                                    ),
                                    child: Row(
                                      children: [
                                        Text(leaves[index].profile?.branch as String,style: GoogleFonts.poppins(),),
                                        Text(","),
                                        Text(leaves[index].profile?.batch as String,style: GoogleFonts.poppins(),),

                                      ],
                                    ),

                                  ),
                                  SizedBox(width: 9,),
                                  Text("ID : ${leaves[index].id}",style: GoogleFonts.poppins(),)
                                ],
                              ),
                              SizedBox(height:10),
                              isExpandedList[index]?expandedView(leaves[index]):SizedBox()
                            ],
                          ),

                          IconButton(onPressed: (){
                            setState(() {
                              isExpandedList[index] = !isExpandedList[index];
                            });
                          }, icon: isExpandedList[index]?Icon(Icons.keyboard_arrow_up_rounded,size: 40,):Icon(Icons.keyboard_arrow_down_rounded,size: 40,))
                        ],
                      ),
                    )
                );
              }
          ),
        ),
      ),
    );
  }
  Widget expandedView(LeaveViewApiModel model){
    return Container(
      width:MediaQuery.of(context).size.width -175,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("From : ",style: TextStyle(fontWeight: FontWeight.bold),),
              Text("${model.departure!.day}.${model.departure!.month}.${model.departure!.year}",style:GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16))),
            ],
          ),
          SizedBox(height: 5,),
          Row(
            children: [
              Text("To : ",style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),),
              Text("${model.arrival!.day}.${model.arrival!.month}.${model.arrival!.year}",),
            ],
          ),
          SizedBox(height: 5,),
          Text("Reason : ",style:GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16,fontWeight: FontWeight.bold))),
          Text("${model.reason}",softWrap: true,style:GoogleFonts.poppins(textStyle: TextStyle(fontSize: 16))),
          SizedBox(height: 5,),
          Row(
            children: [
              model.warden_decision == true || model.warden_decision == null ? Text("Warden :",style: GoogleFonts.poppins(),):SizedBox(),
              model.warden_decision == null ? Icon(Icons.access_time,size: 17,color: Colors.orange,): model.warden_decision == true?Icon(Icons.verified,size: 15,color: Colors.green,):SizedBox()
            ],
          ),
        ],
      ),
    );
  }
}
