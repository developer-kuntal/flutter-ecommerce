import 'package:paytm/paytm.dart';
import 'package:http/http.dart' as http;

class PaytmPayment {

  final amount;
  final orderId;
  // final payment_response;

  PaytmPayment(this.amount, this.orderId);

  void payment() async {

    final callBackUrl =  "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=";

    final url = "https://irretentive-acids.000webhostapp.com/paytmChecksum/generateChecksum.php";
    

    final response = await http.post(url, headers: {
      "Content-Type": "application/x-www-form-urlencoded"
    }, body: {
      "mid": "UXRqLg59985688559960",
      "CHANNEL_ID": "WAP",
      'INDUSTRY_TYPE_ID': 'Retail',
      'WEBSITE': 'APPSTAGING',
      'PAYTM_MERCHANT_KEY': 'Z2brCyX6!lwCZ7ER',
      'TXN_AMOUNT': amount,
      'ORDER_ID': orderId,
      'CUST_ID': '122',
    });

    print("Response: ${response}");

    var paytmResponse = Paytm.startPaytmPayment(
    true,
    "UXRqLg59985688559960",
    orderId,
    "122",
    "WAP",
    "10",
    'APPSTAGING',
    callBackUrl,
    'Retail',
    response.body);

    paytmResponse.then((value) {
      // setState(() {
      //   payment_response = value.toString();
      // });
      print("Value: ${value}");
    }).catchError((onError) {
      print("Error: ${onError}");
    });
  }
}