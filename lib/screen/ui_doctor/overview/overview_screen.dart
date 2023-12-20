import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// import 'package:healthline/app/jitsi_service.dart';
import 'package:healthline/res/style.dart';
import 'package:healthline/screen/ui_doctor/overview/components/export.dart';
import 'package:healthline/screen/widgets/file_widget.dart';
import 'package:healthline/utils/translate.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      backgroundColor: white,
      body: ListView(
        shrinkWrap: false,
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.only(bottom: dimensHeight() * 10),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: dimensWidth() * 3, vertical: dimensHeight() * 2),
            child: Text(
              translate(context, 'statistics'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: dimensHeight() * 2,
            ),
            child: CarouselSlider(
              items: const [
                RevenueCard(),
                AppointmentCard(),
                ReportCard(),
              ],
              options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 2.2,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                  reverse: false,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: dimensWidth() * 3, vertical: dimensHeight() * 2),
            child: Text(
              translate(context, 'upcoming_appointments'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: dimensWidth() * 3, right: dimensWidth() * 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: 
              
              [
                ListTile(
                  onTap: () {
                    // JitsiService.instance.join(
                    //     token:
                    //         "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6InZwYWFzLW1hZ2ljLWNvb2tpZS1mZDA3NDQ4OTRmMTk0ZjNlYTc0ODg4NGY4M2NlYzE5NS8xMjM0NSJ9.eyJhdWQiOiJqaXRzaSIsImlzcyI6ImNoYXQiLCJpYXQiOjE3MDMwMDYzNDIsImV4cCI6MTcwMzAyNjM0MiwibmJmIjoxNzAzMDA2MzM3LCJzdWIiOiJ2cGFhcy1tYWdpYy1jb29raWUtZmQwNzQ0ODk0ZjE5NGYzZWE3NDg4ODRmODNjZWMxOTUiLCJjb250ZXh0Ijp7ImZlYXR1cmVzIjp7ImxpdmVzdHJlYW1pbmciOnRydWUsIm91dGJvdW5kLWNhbGwiOnRydWUsInNpcC1vdXRib3VuZC1jYWxsIjp0cnVlLCJ0cmFuc2NyaXB0aW9uIjp0cnVlLCJyZWNvcmRpbmciOnRydWV9LCJ1c2VyIjp7ImlkIjoiZDNjYzMyMTItM2ZjOS00YWEzLWE2N2QtNDNjMTVmODFmNTU1IiwibmFtZSI6ImhlYWx0aGxpbmVtYW5hZ2VyMjAyMyIsImF2YXRhciI6IiIsImVtYWlsIjoiaGVhbHRobGluZW1hbmFnZXIyMDIzQGdtYWlsLmNvbSIsIm1vZGVyYXRvciI6ZmFsc2UsImhpZGRlbi1mcm9tLXJlY29yZGVyIjpmYWxzZX19LCJyb29tIjoiKiJ9.ATVvOJDkZs4PHbYCI0CDqsJZoCEX1SyCt05uJZjvG7lc89QwmRxAU1Ly69PSh_xDv5VHuoiZFA9ZPsMCdRQAzSzD0Hs4fXyEYedIHoL73qZX8QUJ9V6DXhUKlnZpb2iUqGzICHBJFB9da8PhbCylZuHx7S90-YkhflSw2j-dNFtQCFDQxD6tUZmxKUN_zdGGeqjVRLIzxpt8H-lRnFKdPYWWCNs_7If4KhDTrhR21oAeTND_Iwvgsq5pVhc6HSj4dSnpF42zxkPThZTvDZ-BY9sz0PPc4wsVFQTPXgq0Id56PK4KgpbVzqjFc2OdKbchbPFzGtQ_myBjv4TpdSTpxw",
                    //     roomName:
                    //         "vpaas-magic-cookie-fd0744894f194f3ea748884f83cec195/12345",
                    //     displayName: "healthlinemanager2023",
                    //     urlAvatar: '',
                    //     email: "healthlinemanager2023@gmail.com");
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      dimensWidth(),
                    ),
                  ),
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(DImages.placeholder),
                    radius: dimensWidth() * 3,
                  ),
                  title: Text(
                    'Cảm',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trần Huỳnh Tấn Phát',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  trailing: Text(
                    TimeOfDay.now().format(context).toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Divider(
                  color: color1F1F1F.withOpacity(.3),
                ),
                ListTile(
                  onTap: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      dimensWidth(),
                    ),
                  ),
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(DImages.placeholder),
                    radius: dimensWidth() * 3,
                  ),
                  title: Text(
                    'Đau bụng',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trần Huỳnh Tấn Phát',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  trailing: Text(
                    TimeOfDay.now().format(context).toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Divider(
                  color: color1F1F1F.withOpacity(.3),
                ),
                ListTile(
                  onTap: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      dimensWidth(),
                    ),
                  ),
                  dense: true,
                  visualDensity: const VisualDensity(vertical: 0),
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(DImages.placeholder),
                    radius: dimensWidth() * 3,
                  ),
                  title: Text(
                    'Đau đầu',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Trần Huỳnh Tấn Phát',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ],
                  ),
                  trailing: Text(
                    TimeOfDay.now().format(context).toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: dimensWidth() * 3, vertical: dimensHeight() * 2),
            child: Text(
              translate(context, 'next_patient_profile'),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
            child: Text(
              translate(context, 'images'),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: dimensHeight() * 2,
            ),
            child: CarouselSlider(
              items: [
                Container(
                  margin: EdgeInsets.only(top: dimensHeight()),
                  height: dimensHeight() * 35,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: color1F1F1F,
                    borderRadius: BorderRadius.circular(dimensWidth() * 2),
                    image: DecorationImage(
                        alignment: Alignment.topCenter,
                        image: AssetImage(DImages.placeholder),
                        fit: BoxFit.fitWidth),
                  ),
                )
              ],
              options: CarouselOptions(
                  autoPlay: false,
                  aspectRatio: 2,
                  enlargeCenterPage: true,
                  viewportFraction: 0.8,
                  reverse: false,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
            child: Text(
              translate(context, 'file'),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                left: dimensWidth() * 3, right: dimensWidth() * 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FileWidget(
                  title: 'cam',
                  extension: 'doc',
                ),
                const Divider(),
                FileWidget(
                  title: translate(context, 'cam'),
                  extension: 'xls',
                ),
                const Divider(),
                const FileWidget(
                  title: 'cam',
                  extension: 'jpg',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
