
import 'package:ess_hod/components/LeaveHistory.dart';
import 'package:ess_hod/components/application_list.dart';
import 'package:ess_hod/pages/Notice.dart';
import 'package:ess_hod/pages/approve.dart';
import 'package:ess_hod/pages/login.dart';
import 'package:ess_hod/pages/settings.dart';
import 'package:ess_hod/res/colors.dart';
import 'package:ess_hod/res/images.dart';
import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? user;
  @override
  void initState(){
    super.initState();
    loadData();
  }
  void loadData(){
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        user = prefs.getString('user')??'none';
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Settings()));
          },icon: Icon(Icons.info_outline,color: Colors.black,),),
          actions: [
            IconButton(
              color: Colors.black,
                onPressed: ()async{
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.clear();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
            }, icon:Icon(Icons.logout,size: 25,))
          ],
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: SvgPicture.asset(essentialLogo,width: 140,),),
            ],
          ),
          bottom:TabBar(
            tabs: <Widget>[
              Tab(
                icon: Text("Notice",style:  GoogleFonts.poppins(textStyle: TextStyle(color: Colors.primaryColor,fontSize: 12)),),
              ),
              Tab(
                icon: Text("Requests",style:  GoogleFonts.poppins(textStyle: TextStyle(color: Colors.primaryColor,fontSize: 12)),),
              ),
              Tab(
                icon: Text("Approved",style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.primaryColor,fontSize: 12)),),
              ),
              Tab(
                icon: Text("Rejected",style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.primaryColor,fontSize: 12)),),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Notice(),
            Applications(user:user,),
            History(user: user,query: "approved",),
            History(user: user,query: "denied",),
          ],
        ),
      ),
    );
  }
}
