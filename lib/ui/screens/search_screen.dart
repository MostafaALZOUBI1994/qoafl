
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/screen_util.dart';


import 'dart:async';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qawafel/constants.dart';
import 'package:path/path.dart';

import 'package:qawafel/models/product.dart';
import 'package:qawafel/repository/productRepo.dart';
import 'package:qawafel/ui/screens/product_detail.dart';
import 'package:record_mp3/record_mp3.dart';
import 'package:speech_bubble/speech_bubble.dart';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  File _image;
  final picker = ImagePicker();
  List<Product> searchedProducts;
  String statusText = "";
  bool isComplete = false;
  bool isRecording=false;
  bool isLoading=false;
TextEditingController searchController;
  final String _mPath = '/data/user/0/com.example.qawafel/cache/flutter_sound_example.aac';
  @override
  void initState() {
    searchController=TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(leading: IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back, color: Colors.black,)),
              backgroundColor: Colors.white, title: Container(
                decoration: BoxDecoration(
                    color: backColor, borderRadius: BorderRadius.circular(300)
                ),
                child: TextField(controller: searchController,onChanged: (searchText){
                  setState(() {
                    isLoading=true;
                  });
                  ProductRepo().searchProductsByText(searchText).then((value) {
                    setState(() {
                      searchedProducts=value;
                        isLoading=false;
                    });
                  });
                },
                  decoration: InputDecoration(enabledBorder: InputBorder.none,focusedBorder: InputBorder.none,
                      hintText: 'Search in qwafel',
                      prefixIcon: Icon(Icons.search)
                  ),),
              ), actions: [
                GestureDetector(onTapDown: (value){startRecord();
                setState(() {
                  isRecording=true;
                  isLoading=true;
                });
                } ,onTapCancel: (){stopRecord();
                ProductRepo().searchProductsByVoice(recordFilePath).then((value) {
                  setState(() {
                    isRecording=false;
                    isLoading=false;
                   value==null?searchedProducts=[]: searchedProducts=value;
                  });
                });

                },
                  child: IconButton(onPressed: (){
                  },
                    icon: Icon(Icons.mic, color: Theme
                        .of(context)
                        .primaryColor,),
                  ),
                ),
                SizedBox(width: 27,),
                IconButton(onPressed: () async {
                  setState(() {
                    isLoading=true;
                    searchedProducts=[];
                  });
                  final imageFile = await picker.getImage(source: ImageSource.camera);
                  setState(() {
                    if (imageFile != null) {
                      _image = File(imageFile.path);
                    } else {
                      print('No image selected.');
                    }
                  });
                  uploadFileFromDio(_image);
                  setState(() {
                    isLoading=false;
                  });
                  },

                  icon: Icon(Icons.camera_alt, color: Theme
                      .of(context)
                      .primaryColor,),

                ),
                SizedBox(width: 13,)
              ],),
          body: Stack(
            children: [
              searchedProducts==null? Center(child: Image.asset("assets/search.png")) :searchedProducts.isEmpty? Center(
                child: Text("no results"),
              ) :Container(
        child:  Padding(
              padding: const EdgeInsets.only(top:8.0),
              child: AnimationLimiter(
              child: GridView.count(shrinkWrap: true,scrollDirection: Axis.vertical,physics:NeverScrollableScrollPhysics(),
                crossAxisCount: 2,crossAxisSpacing:5,mainAxisSpacing: 10,
                children: List.generate(
                  searchedProducts.length,
                      (int index) {
                    print(searchedProducts[index]);
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 500),
                      columnCount: 2,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                            child:Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(18),),
                              child: InkWell(
                                onTap: () async {
                                  Product  product= kUser==null?await ProductRepo().getProductDetails(searchedProducts[index].id): await ProductRepo().getProductDetails(searchedProducts[index].id,kUser.userId);
                                  Navigator.push (
                                    context,
                                    MaterialPageRoute(builder: (context) => ProductDetail(product: product,)),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6.0),
                                    color: const Color(0xffffffff),
                                    border: Border.all(
                                        width: 0.1, color: const Color(0xff000000)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0x1a000000),
                                        offset: Offset(0, 0),
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: ScreenUtil().setHeight(5),
                                      ),
                                      Container(
                                        height: ScreenUtil().setHeight(87),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                          mediaUrl +searchedProducts[index].thumbnailImage,
                                          placeholder: (context, url) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Center(child: CircularProgressIndicator()),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ),

                                      SizedBox(
                                        height: ScreenUtil().setHeight(5),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Text(
                                          searchedProducts[index].name,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: ScreenUtil().setSp(14)),
                                        ),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(5),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(5),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: ScreenUtil().setWidth(8),
                                          ),
                                          RatingBarIndicator(
                                            rating:searchedProducts[index].rating.toDouble(),
                                            itemBuilder: (context, index) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            itemCount: 5,
                                            itemSize: ScreenUtil().setWidth(10),
                                            direction: Axis.horizontal,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(5),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: ScreenUtil().setWidth(8),
                                          ),
                                          Text(
                                            searchedProducts[index].basePrice.toString(),
                                            style: TextStyle(
                                                fontSize: ScreenUtil().setSp(14),
                                                color: Theme.of(context).primaryColor),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            )
                        ),
                      ),
                    );
                  },
                ),
              ),

              ),
        )) ,
isLoading?Center(child: CircularProgressIndicator()) :Container()
            ],
          ),
        ),
   isRecording?     Container():Positioned(top: ScreenUtil().setHeight(75),
          right: ScreenUtil().setWidth(10),
          child: SpeechBubble(
            nipLocation: NipLocation.TOP,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Hold button while\n    you speaking',

              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<bool> checkPermission() async {
    if (!await Permission.microphone.isGranted) {
      PermissionStatus status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        return false;
      }
    }
    return true;
  }

  void startRecord() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      statusText = "Recording...";
      recordFilePath = await getFilePath();
      isComplete = false;
      RecordMp3.instance.start(recordFilePath, (type) {
        statusText = "Record error--->$type";
        setState(() {});
      });
    } else {
      statusText = "No microphone permission";
    }
    setState(() {});
  }



  void stopRecord() {
    bool s = RecordMp3.instance.stop();
    if (s) {
      statusText = "Record complete";
      isComplete = true;
      setState(() {});
    }
  }

  void resumeRecord() {
    bool s = RecordMp3.instance.resume();
    if (s) {
      statusText = "Recording...";
      setState(() {});
    }
  }

  String recordFilePath;

  int i = 0;

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return sdPath + "/test_${i++}.mp3";
  }
   uploadFileFromDio(File photoFile) async {
    var dio = new Dio();
    dio.options.baseUrl = baseUrl;
    String fileName = basename(photoFile.path);
    FormData formData = new FormData.fromMap({
      "file":await MultipartFile.fromFile(photoFile.path,filename: fileName)
    });
    if (photoFile != null &&
        photoFile.path != null &&
        photoFile.path.isNotEmpty) {
      // Create a FormData
      String fileName = basename(photoFile.path);
      print("File Name : $fileName");
      print("File Size : ${photoFile.lengthSync()}");

    }
    var response = await dio.post(baseUrl+'/products/searchImage',
        data: formData,
        options: Options(
            method: 'POST',
            responseType: ResponseType.json // or ResponseType.JSON
        ));

    print("Response status: ${response.statusCode}");
    print("Response data: ${response.data}");
    searchedProducts.clear();
    if (response.statusCode == 200) {
      response.data["data"]
          .map((product) => searchedProducts.add(Product.fromJson(product)))
          .toList();
    }
    setState(() {

    });
  }
}