import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class QuotationService{
  final dio = Dio();
  final storage = const FlutterSecureStorage();
  final String url="http://10.0.2.2:3000/api/";
  addQuotation(String quo) async {

    final response = await dio.post("${url}addquotation", data: quo);
    return response;
  }
  viewQuotationByVendor(String userid) async {
    final response = await dio.post("${url}view-quotationby-vendor", data: {"userid":userid});
    return response;

  }
  viewQuotationsByCustomer(String userid)async{
    final response = await dio.post("${url}view-quotationby-customer", data: {"userid":userid});
    return response;
  }
  viewQuotationById(String quotationid)async{
    final response = await dio.post("${url}viewquotationbyid", data: {"quotationid":quotationid});
    return response;
  }
  sendReply(String quo)async{
    final response = await dio.post("${url}sendreply", data: quo);
    return response;
  }

}