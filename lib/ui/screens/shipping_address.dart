import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:qawafel/models/address.dart';
import 'package:qawafel/models/user.dart';
import 'package:qawafel/repository/userRepo.dart';
import 'package:qawafel/ui/widgets/textfield.dart';

import '../../constants.dart';

class Address extends StatefulWidget {
  final TabController controller;

  const Address({Key key, this.controller}) : super(key: key);
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> with SingleTickerProviderStateMixin {
  int selected = 0;
  Address newAdress;
  @override
  void initState() {


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: ScreenUtil().setHeight(27)),
        buttonWidget("Add New Address", Theme.of(context).accentColor,
            () async {
          showAnimatedDialog(
            context: context,
            barrierDismissible: true,
            builder: (BuildContext context) {
              TextEditingController addressController=TextEditingController();
              TextEditingController postalCodeController=TextEditingController();
              TextEditingController cityController=TextEditingController();
              TextEditingController countryController=TextEditingController();
              TextEditingController phoneController=TextEditingController();

                return Material(
                  color: Colors.transparent,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(13),
                          vertical: ScreenUtil().setHeight(200)),
                      child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(
                              ScreenUtil().setWidth(10.0),
                            ),
                            color: const Color(0xffffffff),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: ScreenUtil().setHeight(13),
                                horizontal: ScreenUtil().setWidth(13)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: ScreenUtil().setHeight(13),
                                ),
                                Center(
                                  child: Text("Add new Address"),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                TextFieldWidget(controller: addressController,
                                  passfieled: false,
                                  hint: "Address",
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(13),
                                ),
                                TextFieldWidget(controller: postalCodeController,
                                  passfieled: false,
                                  hint: "Postal code",
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(13),
                                ),
                                TextFieldWidget(controller: cityController,
                                  passfieled: false,
                                  hint: "City",
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(13),
                                ),
                                TextFieldWidget(controller: countryController,
                                  passfieled: false,
                                  hint: "Country",
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(13),
                                ),
                                TextFieldWidget(controller: phoneController,
                                  passfieled: false,
                                  hint: "Phone",
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(20),
                                ),
                                buttonWidget(
                                    "Add Address", Theme.of(context).primaryColor,
                                        () async {
                                            await UserRepo(context).addAddress(
                                                kUser.userId,
                                                kUser.accessToken,
                                                addressController.text,
                                                postalCodeController.text,
                                                cityController.text,
                                                countryController.text,
                                                phoneController.text);
                                            Navigator.pop(context);
                                            setState(() {
                                            });

                                        })

                              ],
                            ),
                          )),
                    ),
                  ),
                );

            },
            animationType: DialogTransitionType.slideFromTop,
            curve: Curves.fastOutSlowIn,
            duration: Duration(seconds: 1),
          );
        }),

        Flexible(
          child: FutureBuilder(
            future:
                UserRepo(context).getAddress(kUser.userId, kUser.accessToken),
            builder: (context, addressSnap) {
              if (addressSnap.connectionState == ConnectionState.done) {
                if (addressSnap.data == null) {
                  return Text('no data');
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: addressSnap.data.length,
                    itemBuilder: (context, index) {
                      AddressModel address = addressSnap.data[index];
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selected = index;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setHeight(22),
                              horizontal: ScreenUtil().setWidth(13)),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: selected == index
                                      ? Theme.of(context).primaryColor
                                      : grey),
                              borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(10.0),
                              ),
                              color: const Color(0xffffffff),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(26),
                                  vertical: ScreenUtil().setHeight(20)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                          width: ScreenUtil().setWidth(95),
                                          child: Text("Address")),


                                      Flexible(child: Text(address.address)),
                                      SizedBox(width: ScreenUtil().setWidth(40),),
                                      IconButton(icon: Icon(Icons.close,color: Theme.of(context).primaryColor,), onPressed: () async {
                                        await UserRepo(context).removeAddresss(address.id,kUser.accessToken);
                                        setState(() {

                                        });
                                      }),
                                    ],
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(15),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          width: ScreenUtil().setWidth(95),
                                          child: Text("Postal code")),
                                      Text(address.postalCode)
                                    ],
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(15),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          width: ScreenUtil().setWidth(95),
                                          child: Text("City")),
                                      Text(address.city)
                                    ],
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(15),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          width: ScreenUtil().setWidth(95),
                                          child: Text("Country")),
                                      Text(address.country)
                                    ],
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(15),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          width: ScreenUtil().setWidth(95),
                                          child: Text("Phone")),
                                      Text(address.phone)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              } else {
                return Center(child: CircularProgressIndicator()); // loading
              }
            },
          ),
        ),
        SizedBox(height: ScreenUtil().setHeight(10),),
        buttonWidget(
            "Continue to Delivery Info", Theme.of(context).primaryColor, () {
          setState(() {
            widget.controller.animateTo(2);
          });
        }),
        SizedBox(
          height: ScreenUtil().setHeight(25),
        )
      ],
    );
  }

  Widget buttonWidget(String text, Color color, Function f) {
    return InkWell(
      onTap: f,
      child: Container(
        height: ScreenUtil().setHeight(31),
        width: ScreenUtil().setWidth(209),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(4)),
          color: color,
        ),
        child: Center(
            child: Text(
          text,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(14),
              color: Colors.white,
              fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}
