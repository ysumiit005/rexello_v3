import 'package:url_launcher/url_launcher.dart';

//
//
// func to open whatsapp url which transfer to app on user permisiion
//
//
void launchWhatsApp() async {
  final whatsappUrl = Uri.parse(
      "https://api.whatsapp.com/send/?phone=919029058680&text&type=phone_number&app_absent=0");

  if (await canLaunchUrl(whatsappUrl)) {
    await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch YouTube';
  }
}
