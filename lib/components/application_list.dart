import 'package:ess_hod/components/ViewLeave.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../res/urls.dart';
import '../utils/leaveModel.dart';

class Applications extends StatefulWidget {
  String? user;
  Applications({super.key,required this.user});

  @override
  State<Applications> createState() => _ApplicationsState();
}

class _ApplicationsState extends State<Applications> {
  TextEditingController _controller = TextEditingController();
  bool isLoading = true;
  List<LeaveViewApiModel> leaves= [];
  List<bool> isExpandedList = [] ;
  GlobalKey key = GlobalKey();
  int length = 0;
  @override
  void initState(){
    super.initState();
  }
  loadData(String? user,{String query = "pending",int start = 0,int end = 100}) async {
    String url = "http://$host/token=<str:token>/hod/leave/view/id=${widget.user}/query=$query";
    print(url);
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
          isExpandedList =  List.generate(leaves.length, (index) => false);
          isLoading = false;
        });
      }
    }
    catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    if(this.isLoading)
      loadData(widget.user);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   shadowColor: Colors.transparent,
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.white,
      //   title: Container(
      //     height: 50,
      //     child: TextFormField(
      //       style: GoogleFonts.poppins(),
      //       decoration: InputDecoration(
      //         prefixIcon: IconButton(
      //           onPressed: () {  },
      //           icon: Icon(Icons.search),
      //         ),
      //         hintText: "Search applicant",
      //         hintStyle: GoogleFonts.poppins(),
      //         border: OutlineInputBorder(
      //           borderSide: BorderSide(
      //             color: Colors.grey,
      //             width: 5
      //           ),
      //           borderRadius: BorderRadius.circular(15)
      //         )
      //       ),
      //     ),
      //   ),
      // ),
      body: RefreshIndicator(
        onRefresh: () async {
            await loadData(widget.user);
        },
        child: ListView.builder(
          itemCount: leaves.length,
          itemBuilder: (context, index){
            print(leaves);
            bool expand = false;

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
                            "http://$host/token=%3Cstr:token%3E/user=${leaves[index].student?.pfp}/getImage",
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
                        Text("${leaves[index].student?.name?.toUpperCase()}",style: GoogleFonts.poppins(textStyle:TextStyle(fontSize: 17,fontWeight: FontWeight.w600) ),),
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
                            Text("Leave ID : ${leaves[index].id}",style: GoogleFonts.poppins(),)
                          ],
                        ),
                        SizedBox(height:10),
                        isExpandedList[index]?expandedView(leaves[index]):SizedBox()
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    IconButton(onPressed: (){
                      setState(() {
                        isExpandedList[index] = !isExpandedList[index];
                      });
                    }, icon: isExpandedList[index]?Icon(Icons.keyboard_arrow_up_rounded,size: 40,):Icon(Icons.keyboard_arrow_down_rounded,size: 40,))
                  ],
                ),
              )
            );
          },
        ),
      )
    );
  }
  Widget expandedView(LeaveViewApiModel model){
    return Container(
      width:MediaQuery.of(context).size.width -155,
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
          SizedBox(height: 10,),
          Container(
            width: 150,
            child: NeumorphicButton(
              style: NeumorphicStyle(
                color: Colors.green,
                shadowDarkColor: Colors.black,
                shadowLightColor: Colors.green,
                shadowDarkColorEmboss: Colors.black,
                shadowLightColorEmboss: Colors.white
              ),
              onPressed: (){if(model.profile?.parentNo != null){
                _launchDialer(model.profile?.parentNo as String);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.add_call,color: Colors.white,),
                  SizedBox(width: 10,),
                  Text(model.profile?.parentNo??"Not available",style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),)
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              NeumorphicButton(
                  style:const NeumorphicStyle(
                      color: Colors.white,
                      shadowDarkColor: Colors.black,
                      shadowLightColor: Colors.green,
                      intensity: 0.6,
                      shadowDarkColorEmboss: Colors.black,
                      shadowLightColorEmboss: Colors.green
                  ),
                  onPressed: ()async{
                  await leaveAction( action: 'false',id: "${model.id}");
                  },
                  child: Text("Approve",style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.green)),)
              ),
              const SizedBox(width: 20,),
              NeumorphicButton(
                  style:const NeumorphicStyle(
                  color: Colors.white,
                  shadowDarkColor: Colors.black,
                  shadowLightColor: Colors.red,
                  intensity: 0.6,
                  shadowDarkColorEmboss: Colors.black,
                  shadowLightColorEmboss: Colors.white
                  ),
                  onPressed: ()async{
                    await showBottomDialog(model);
                    //await leaveAction( action: 'true',id: "${model.id}");

                  },
                  child: Text("Reject",style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.red)))
              )
            ],
          )
        ],
      ),
    );
  }

  Future<void> leaveAction( {required String action,required String id,String reason = "none"})async {
    String url = "http://$host/token=<str:token>/hod/leave/takeAction/hod=${widget.user}/leave_id=$id/deny=$action/reason=$reason";

    try{
      final response = await http.post(
        Uri.parse(url)
      );
      if(response.statusCode == 200){
        setState(() {
          isLoading = true;
        });
      }
    }
    catch (e){
      print(e);
    }
  }
  Future<void> showBottomDialog(LeaveViewApiModel model) async{
    await showModalBottomSheet<void>(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100)
        ),
        isScrollControlled: true,
        builder: (context) => Padding(
          padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 230,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10,),
              Text("Reason for denial",style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: 20)),),
              Container(
                //padding: EdgeInsets.all(6),
                child: TextField(
                    style: GoogleFonts.poppins(),
                    controller: _controller,
                    maxLines: 3, // Allows unlimited number of lines
                    decoration: InputDecoration(

                    border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.black),
                    ),
                    hintText: 'State your reason',
                    ),
                  onChanged: (change){
                      // setState(() {
                      //   length = change.length;
                      // });
                  },
                  ),
              ),
              //TODO:Add text length checker
              //length == 0?Text("Reason cannot be left empty",style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.red),fontSize: 12),):Text(""),
              Center(
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red)
                  ),
                    onPressed: ()async {
                      if(_controller.text.length ==0){
                        return;
                      }
                      await leaveAction( action: 'true',id: "${model.id}",reason: _controller.text);
                      setState(() {
                        length = 0;
                      });
                      Navigator.pop(context);
                    },
                    child: Text("REJECT",style: GoogleFonts.poppins(textStyle: TextStyle(color:Colors.white)),)
                ),
              )
            ],
          )
        )
        )
    );
  }

  Future<void> _launchDialer(String num)async{
    num = 'tel:$num';
    if(await canLaunchUrlString(num)){
      await launchUrlString(num);
    }else{
      print("ERROR");
    }
  }
}
