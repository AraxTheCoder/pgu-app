import 'dart:io';

class ImageChecker{
  static Future<bool> checkMutipleToday() async {
    String srcSingle = "https://www.pgu.de/fileadmin/Vertretungsplan/Neu/Plaene/plan_heute_schueler.png";

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(srcSingle));
    HttpClientResponse response = await request.close();
    httpClient.close();

    /*
     * Image Mime-Type : image/png
     */
    return !response.headers.contentType.mimeType.contains("image");
  }

  static Future<bool> checkMutipleTomorrow() async {
    String srcSingle = "https://www.pgu.de/fileadmin/Vertretungsplan/Neu/Plaene/plan_morgen_schueler.png";

    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(srcSingle));
    HttpClientResponse response = await request.close();
    httpClient.close();

    /*
     * Image Mime-Type : image/png
     */
    return !response.headers.contentType.mimeType.contains("image");
  }
}