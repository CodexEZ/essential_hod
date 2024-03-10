import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String name = "";
  String hostel = "";
  String college = "";
  @override
  void initState(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await fetchData();
    });
  }
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
  Future<void> fetchData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref.getString('user')??"";
      hostel = pref.getString('branch')??"";
      college = pref.getString('college')??"";
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        elevation: 0,
        title: Text("Information",style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.black)),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            infoRow("Name", name.toUpperCase()),
            infoRow("Branch", hostel.toUpperCase()),
            infoRow("College", college.toUpperCase()),
            SizedBox(height: 10,),
            Divider(height: 1,thickness: 1,color: Colors.black,),
            Text("For help & support contact us at",style: GoogleFonts.poppins(),),
            SizedBox(height: 5,),
            Neumorphic(child: Container(width:200,height: 40,child: callable(Icon(Icons.call), "+91 7008575068"))),
            SizedBox(height: 20,),
            Neumorphic(child: Container(width:200,height:40,child: callable(Icon(Icons.call), "+91 8249859473"))),
            SizedBox(height: 10,),
            Divider(height: 1,thickness: 1,color: Colors.black,),
            SizedBox(height: 10,),
            Text("Mail us at",style: GoogleFonts.poppins(),),
            GestureDetector(
              onTap: (){
                final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: 'support@essentialnetwork.in',
                    query: encodeQueryParameters(<String, String>{
                      'subject': 'Request for support ',
                    }
                    )
                );
                launchUrl(emailLaunchUri);
              },
              child: Neumorphic(
                  child: Container(
                    width:300,
                    height:40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.mail),
                        Text("support@essentialnetwork.in")
                      ],
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget infoRow(String leading, String trailing){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(
                color: Colors.black,
                width: 1
            ),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            Text("$leading :",style: GoogleFonts.poppins(fontSize: 17),),
            Text(" $trailing",style: GoogleFonts.poppins(fontSize: 17),)
          ],
        ),
      ),
    );
  }
  Widget callable(Icon icon, String num) {
    return GestureDetector(
      onTap: (){
        _launchDialer(num);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Text(num,style: GoogleFonts.poppins(),)
        ],
      ),
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
