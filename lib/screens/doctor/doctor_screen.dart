import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screens/widgets/text_field_widget.dart';
import 'package:healthline/utils/translate.dart';

import 'components/export.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  late TextEditingController _searchController;

  final List<Map<String, dynamic>> doctors = [
    {
      "avatar": "123",
      "name": "Drr. Phat Phut Phit",
      "specialty": "gynaecologist",
      "available_next": "8:00",
      "biography":
          "BSCKII Nguyễn Quốc Thái có hơn 15 năm kinh nghiệm học tập, nghiên cứu và làm việc trong lĩnh vực Ngoại tổng quát, chuyên ngành nội soi – phẫu thuật nội soi. Sau khi tốt nghiệp Bác sĩ Đa khoa Đại học Y Dược TP.HCM, Bác sĩ Nguyễn Quốc Thái tiếp tục tham gia các khóa đào tạo Bác sĩ Nội trú, chuyên khoa I Ngoại tổng quát và Chuyên khoa II Ngoại tổng quát của đại học này. Năm 2011, Bác sĩ Nguyễn Quốc Thái được cấp chứng chỉ Cắt tuyến giáp mổ mở và nội soi của BV Nội tiết Trung Ương. BSCKII Nguyễn Quốc Thái có 7 năm công tác tại BV Pháp Việt TP.HCM, 3 năm công tác tại BV Vinmec Central Park TP.HCM trước khi về làm việc tại BVĐK Tâm Anh TP.HCM với vai trò Bác sĩ Ngoại tổng quát.",
      "averageRating": 3.6153846153846154,
      "reviewed": 13
    },
    {
      "avatar": "123",
      "name": "Drr. Phat Phut Phit",
      "specialty": "gynaecologist",
      "available_next": "8:00",
      "biography":
          "BSCKII Nguyễn Quốc Thái có hơn 15 năm kinh nghiệm học tập, nghiên cứu và làm việc trong lĩnh vực Ngoại tổng quát, chuyên ngành nội soi – phẫu thuật nội soi. Sau khi tốt nghiệp Bác sĩ Đa khoa Đại học Y Dược TP.HCM, Bác sĩ Nguyễn Quốc Thái tiếp tục tham gia các khóa đào tạo Bác sĩ Nội trú, chuyên khoa I Ngoại tổng quát và Chuyên khoa II Ngoại tổng quát của đại học này. Năm 2011, Bác sĩ Nguyễn Quốc Thái được cấp chứng chỉ Cắt tuyến giáp mổ mở và nội soi của BV Nội tiết Trung Ương. BSCKII Nguyễn Quốc Thái có 7 năm công tác tại BV Pháp Việt TP.HCM, 3 năm công tác tại BV Vinmec Central Park TP.HCM trước khi về làm việc tại BVĐK Tâm Anh TP.HCM với vai trò Bác sĩ Ngoại tổng quát.",
      "averageRating": 3.6153846153846154,
      "reviewed": 13
    },
    {
      "avatar": "123",
      "name": "Drr. Phat Phut Phitfasdfsdfsadfsfsdfasdfasd",
      "specialty": "gynaecologist",
      "available_next": "8:00",
      "biography":
          "BSCKII Nguyễn Quốc Thái có hơn 15 năm kinh nghiệm học tập, nghiên cứu và làm việc trong lĩnh vực Ngoại tổng quát, chuyên ngành nội soi – phẫu thuật nội soi. Sau khi tốt nghiệp Bác sĩ Đa khoa Đại học Y Dược TP.HCM, Bác sĩ Nguyễn Quốc Thái tiếp tục tham gia các khóa đào tạo Bác sĩ Nội trú, chuyên khoa I Ngoại tổng quát và Chuyên khoa II Ngoại tổng quát của đại học này. Năm 2011, Bác sĩ Nguyễn Quốc Thái được cấp chứng chỉ Cắt tuyến giáp mổ mở và nội soi của BV Nội tiết Trung Ương. BSCKII Nguyễn Quốc Thái có 7 năm công tác tại BV Pháp Việt TP.HCM, 3 năm công tác tại BV Vinmec Central Park TP.HCM trước khi về làm việc tại BVĐK Tâm Anh TP.HCM với vai trò Bác sĩ Ngoại tổng quát.",
      "averageRating": 3.6153846153846154,
      "reviewed": 13
    },
    {
      "avatar": "123",
      "name": "Drr. Phat Phut Phit",
      "specialty": "gynaecologist",
      "available_next": "8:00",
      "biography":
          "BSCKII Nguyễn Quốc Thái có hơn 15 năm kinh nghiệm học tập, nghiên cứu và làm việc trong lĩnh vực Ngoại tổng quát, chuyên ngành nội soi – phẫu thuật nội soi. Sau khi tốt nghiệp Bác sĩ Đa khoa Đại học Y Dược TP.HCM, Bác sĩ Nguyễn Quốc Thái tiếp tục tham gia các khóa đào tạo Bác sĩ Nội trú, chuyên khoa I Ngoại tổng quát và Chuyên khoa II Ngoại tổng quát của đại học này. Năm 2011, Bác sĩ Nguyễn Quốc Thái được cấp chứng chỉ Cắt tuyến giáp mổ mở và nội soi của BV Nội tiết Trung Ương. BSCKII Nguyễn Quốc Thái có 7 năm công tác tại BV Pháp Việt TP.HCM, 3 năm công tác tại BV Vinmec Central Park TP.HCM trước khi về làm việc tại BVĐK Tâm Anh TP.HCM với vai trò Bác sĩ Ngoại tổng quát.",
      "averageRating": 3.6153846153846154,
      "reviewed": 13
    },
  ];
  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: white,
        appBar: AppBar(
          title: Text(
            translate(context, 'list_of_doctors'),
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w900),
          ),
        ),
        body: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: dimensHeight() * 0,
                  right: dimensWidth() * 3,
                  left: dimensWidth() * 3),
              child: TextFieldWidget(
                validate: (p0) => null,
                hint: translate(context, 'search_drugs_categories'),
                fillColor: colorF2F5FF,
                filled: true,
                focusedBorderColor: colorF2F5FF,
                enabledBorderColor: colorF2F5FF,
                controller: _searchController,
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: color6A6E83,
                    size: dimensIcon(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: dimensHeight() * 2),
              child: const ListCategories(),
            ),
            ...doctors.map(
              (e) => Padding(
                padding: EdgeInsets.only(left: dimensWidth() * 3),
                child: DoctorCard(
                  doctor: e,
                ),
              ),
            ),
          ],
        )
        // ],

        );
  }
}