import 'package:ess_hod/pages/pdfview.dart';
import 'package:ess_hod/utils/noticeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../res/urls.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class Notice extends StatefulWidget {
  const Notice({super.key});

  @override
  State<Notice> createState() => _NoticeState();
}

class _NoticeState extends State<Notice> {
  int page =1 ;
  ScrollController _scrollController = ScrollController();
  TextEditingController topic = TextEditingController();
  TextEditingController heading = TextEditingController();
  TextEditingController content = TextEditingController();
  bool _isAtBottom = false;
  late NoticeApiModel obj;
  @override
  void initState() {
    super.initState();

    // Add a listener to the ScrollController
    _scrollController.addListener(_scrollListener);
  }
  Future<NoticeApiModel> getNotice({int page=1}) async{
    final url = "http://$host/api/notices/?page=$page";
    (url);
    try{
      final response =await http.get(Uri.parse(url));
      (url);
      if(response.statusCode == 200){
        return noticeApiModelFromJson(response.body);
      }
    }
    catch(e){
      (e);
    }
    return NoticeApiModel();
  }

  void _scrollListener() {
    // Check if the scroll position is at the bottom
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      setState(() {
        _isAtBottom = true;
      });

      // Call your function when the list reaches the bottom
      _loadMoreData();
    } else {
      setState(() {
        _isAtBottom = false;
      });
    }
  }
  Future<void> _loadMoreData() async {
    // Replace this with your actual function to load more data
    page +=1;
    final extra = await getNotice(page: page);
    setState(() {
      obj.results?.addAll(extra.results!);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.1),
      floatingActionButton: NeumorphicButton(
        style: NeumorphicStyle(

        ),
        onPressed: () {
          _showModalBottomSheet(context);
        },
        child: Icon(Icons.add),
      ),
      body:FutureBuilder<NoticeApiModel>(
        future: getNotice(),
        builder: (BuildContext context, AsyncSnapshot<NoticeApiModel> snapshot) {
          (snapshot.data);
          if(snapshot.hasData){
            obj = snapshot.data!;
            return Container(
              height: MediaQuery.of(context).size.height,
              child: RefreshIndicator(
                onRefresh: () async {
                  final temp = await getNotice();
                  setState(() {
                    obj = temp;
                  });

                },
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: obj.results?.length,
                    itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: NoticeCard(obj.results![index]),
                    );
                    }
                ),
              ),
            );
          }
          else{
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
  Widget NoticeCard(Result model){
    DateTime now = DateTime.now().toUtc();
    Duration difference = now.difference(model!.timestamp!);
    String elapsed = "";
    String filename = "";
    if (model.file != null){
      Uri uri = Uri.parse(model.file!);
      final path = uri.path;
      List<String> pathElements =path.split('/').where((element) => element.isNotEmpty).toList();
      (pathElements);
      filename = pathElements[1];
    }
    if(difference.inDays != 0){
      elapsed = "${difference.inDays}d";
    }
    else if(difference.inHours != 0){
      elapsed = "${difference.inHours}h";
    }
    else{
      elapsed = "${difference.inMinutes}m";
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.zero)
                ),
                child: Text(
                  model.topic??"",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      color: Colors.black,
                    )
                  ),
                ),
              ),
              Expanded(child: SizedBox()),
              Text("$elapsed ago",style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.grey)),),
              SizedBox(width: 20,)
            ],
          ),
          SizedBox(height: 10,),
          model.heading != null?Container(
            width: MediaQuery.of(context).size.width-24,
            child: Row(
              children: [
                Text(model.heading !=null?model.heading.toString(): "",maxLines: 2,style: GoogleFonts.poppins(textStyle: TextStyle(color: Colors.grey,fontSize: 17),))
              ],
            ),
          ):SizedBox(height: 0,),
          const SizedBox(height: 20,),
          Text(model.content??""),
          const SizedBox(height: 10,),
          model.file!=null?GestureDetector(
            onTap: () async {
              //final url = "http://$host/token=asda/view${model.file}";
              Uri uri = Uri.parse(model.file!);
              final url = "http://$host/token=asda/view${uri.path}";
              (uri.path);
              Navigator.push(context, MaterialPageRoute(builder: (contex)=>PDFPage(link:url)));
            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.withOpacity(0.4)
              ),
              child: Row(
                children: [
                  const Icon(Icons.file_copy,color: Colors.red,),
                  const SizedBox(width: 10,),
                  Text("$filename",style: GoogleFonts.poppins(),overflow: TextOverflow.ellipsis,maxLines: 1,)
                ],
              ),
            ),
          ):SizedBox(height: 0,),
          const SizedBox(height: 10,),
          Row(
            children: [
              model.target != null?SingleChildScrollView(
                child:Row(
                  children: [
                    for( String target in model.target!)
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color:Colors.grey.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text(target,style: GoogleFonts.poppins(),),
                        ),
                      )

                  ],
                ),
              ):SizedBox(width: 0,),
              const Expanded(child: SizedBox()),
              model.links != ""?TextButton(onPressed: (){
                if(model.links != ""){
                  //(notice.links);
                  final link = Uri.parse(model.links!);
                  _launchUrl(link);
                }
              }, child: const Text("Apply>",style: TextStyle(color: Colors.blueAccent),)):SizedBox(width: 0,)
            ],
          )
        ],
      ),
    );

  }
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            color: Colors.grey.withOpacity(0.1),
            padding: EdgeInsets.only(
              top: 7,
              left: 5,
              right: 5,
              bottom: MediaQuery.of(context).viewInsets.bottom+10,
            ),
            child: Container(
              child: Column(
                children: [
                  form(topic, "Topic : Announcement, Examination . . . ",1),
                  SizedBox(height: 5,),
                  form(heading, "Heading",1),
                  SizedBox(height: 5,),
                  form(content,"Content",5),
                  SizedBox(height: 5,),
                  NeumorphicButton(
                    style: NeumorphicStyle(
                      color: Colors.white
                    ),
                    onPressed: ()async{
                      await _sendNotice();
                      setState(() {});
                    },
                    child: Text("Send",style: GoogleFonts.poppins(),),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  Widget form(TextEditingController controller,String hintText,int lines){
    return TextFormField(
      maxLines:lines ,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
    );
  }
  Future<void> _sendNotice()async{
    if(topic.text.isNotEmpty && content.text.isNotEmpty && heading.text.isNotEmpty){
      SharedPreferences pref = await SharedPreferences.getInstance();
      final college = pref.getString('college');
      final target = pref.getString('branch');
      final url = Uri.parse('http://$host/college/postNotice');
      final response = await http.post(
          url,
        body: {
            "topic":topic.text,
            "heading":heading.text,
            "content":content.text,
            "target":target,
            "college":college
        }
      );
      if(response.statusCode == 200){
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.greenAccent,content: Text("Notice has been posted")));
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.redAccent,content: Text("Some error occurred")));
      }
    
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor:Colors.redAccent,content: Text("Fields cannot be left empty")));

    }
    setState(() {
      topic.text = "";
      content.text = "";
      heading.text = "";
    });
  }
}




Future<void>_downloadFile(String link)async{

}

Future<void> _launchUrl(link) async {
  if (!await launchUrl(link)) {
    throw Exception('Could not launch $link');
  }
}
