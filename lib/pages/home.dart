import 'package:ess_ward/components/applicant_card_viewholder.dart';
import 'package:ess_ward/pages/approve.dart';
import 'package:ess_ward/res/colors.dart';
import 'package:flutter/material.dart' hide Colors;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 50),
            const Padding(
              padding: EdgeInsets.only(top: 50, bottom: 40),
              child: Center(
                child: Text(
                  "Applicants",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                children: [
                  const Text(
                    "25 feb 2024",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.gray,
                        fontWeight: FontWeight.w600),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ApprovelPage(
                                      id: "leave id from server"))),
                          child: const ApplicantCardViewHolder(
                            id: "01UG21020037",
                            fullname: "Pratyush Behera",
                            branch: "BTech",
                            course: "CSE",
                            semester: "21",
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 14),
                      itemCount: 5)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
