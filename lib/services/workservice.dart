import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class WorkService{
  final dio = Dio();
  final storage = const FlutterSecureStorage();
  final String url="http://10.0.2.2:3000/api/";
  addWork(String workdetails) async {
    final response = await dio.post("${url}addworks", data: workdetails);
    return response;
  }
  viewWorkByVendor(String workerid)async{
    final response = await dio.post("${url}viewworkbyworkerid", data: {"workerid":workerid});
    return response;
  }
  viewWorkById(String workid)async{
    final response = await dio.post("${url}viewworkbyid", data: {"workid":workid});
    return response;
  }
  removeWork(String workid)async{
    final response = await dio.post("${url}deletework", data: {"workid":workid});
    return response;
  }
  getAllInterior() async {
    final response = await dio.post("${url}listallinterior");
    return response;
  }
  getAllArchitect()async{
    final response = await dio.post("${url}listallarchitect");
    return response;
  }
  getAllElectrician() async {
    final response = await dio.post("${url}listallelectrician");
    return response;
  }
  getInteriorById(String workerid) async {
    final response = await dio.post("${url}viewinterior",data: {"workerid":workerid});
    return response;
  }
  getArchitectById(String workerid) async {
    final response = await dio.post("${url}viewarchitect",data: {"workerid":workerid});
    return response;
  }
  getElectricianById(String workerid) async {
    final response = await dio.post("${url}viewelectrician",data: {"workerid":workerid});
    return response;
  }
  sendConnectionRequest(String conn)async{
    final response = await dio.post("${url}sendrequest",data: conn);
    return response;
  }
  viewConnectionByUser(String userid)async{
    final response = await dio.post("${url}viewconnection-by-user",data: {"userid":userid});
    return response;
  }
  viewConnectionByVendor(String userid)async{
    final response = await dio.post("${url}viewconnection-by-vendor",data: {"userid":userid});
    return response;
  }
  updateConnection(String connectionid)async{
    final response = await dio.post("${url}updateconnection",data: {"connectionid":connectionid,"status":"accepted"});
    return response;
  }
  viewConnectionById(String connectionid)async{
    final response = await dio.post("${url}viewconnectionbyid",data: {"connectonid":connectionid});
    return response;
  }

}