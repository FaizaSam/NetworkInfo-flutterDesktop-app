import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
void main() {
  runApp(WinApp());
}
class WinApp extends StatelessWidget {
  const WinApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Windows Example',
      home:WinAppPage(),
      
    );
  }
}
class WinAppPage extends StatefulWidget {
  @override
  State<WinAppPage> createState() => _WinAppPageState();
}

class _WinAppPageState extends State<WinAppPage> {
   ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
    print('Couldn\'t check connectivity status, error $e');
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  final info = NetworkInfo();

 // const WinAppPage({ Key? key }) : super(key: key);
  String wifiName=""; 
 
var wifiBSSID = ""; // 11:22:33:44:55:66
var wifiIP = ""; // 192.168.1.43
var wifiIPv6 = ""; // 2001:0db8:85a3:0000:0000:8a2e:0370:7334


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/image.jpg',),fit: BoxFit.cover)
      ),
     // color: Color.fromARGB(124, 148, 148, 161),
      child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: Text('Hello!',style: TextStyle(color: Color.fromARGB(74, 8, 8, 8) ,fontWeight: FontWeight.bold,fontSize: 20.0),),
                    ),
                    SizedBox(height: 14,),
                    ElevatedButton(onPressed: () async{

                     wifiName = (await info.getWifiName())!; 
                     wifiBSSID=(await info.getWifiBSSID())!;
                     wifiIPv6= (await info.getWifiIP())!;




                     setState(() {
                       
                     });
                     
                    }, child: Text("Click to get Wifi Details")),
                    SizedBox(height: 12,),
                 ],
        
        
      ),
              ),
              
           Container(
                      color: Color.fromARGB(102, 218, 178, 208),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:[
                          Text('Connection Status: ${_connectionStatus.toString()}'),
                          Text('$wifiName',style: TextStyle(fontSize: 20.00,fontWeight: FontWeight.bold),),
                      Text('$wifiBSSID',style: TextStyle(fontSize: 20.00,fontWeight: FontWeight.bold),),
                      Text('$wifiIPv6',style: TextStyle(fontSize: 20.00,fontWeight: FontWeight.bold),),
                   //   Text('$wifiSubmask',style: TextStyle(fontSize: 20.00,fontWeight: FontWeight.bold),),
                    //  Text('$wifiBroadcast',style: TextStyle(fontSize: 20.00,fontWeight: FontWeight.bold),),
                    //  Text('$wifiGateway',style: TextStyle(fontSize: 20.00,fontWeight: FontWeight.bold),),]
                         ] )) ],
          )
    );
    
  }
}