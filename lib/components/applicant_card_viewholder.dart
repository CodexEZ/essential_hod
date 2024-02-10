import 'package:ess_ward/components/profile_image_holder.dart';
import 'package:ess_ward/res/colors.dart';
import 'package:flutter/material.dart' hide Colors;

class ApplicantCardViewHolder extends StatelessWidget {
  final String? id;
  final String? fullname;
  final String? branch;
  final String? course;
  final String? semester;
  const ApplicantCardViewHolder(
      {super.key,
      this.id,
      this.branch,
      this.course,
      this.fullname,
      this.semester});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16)),
          boxShadow: [BoxShadow(color: Colors.shadowColor, blurRadius: 30)]),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const ProfileImageHolder(),
          const SizedBox(width: 20),
          Expanded(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$id",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 5),
              Text(
                "$fullname",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 5),
              Text(
                "$course $branch $semester",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
