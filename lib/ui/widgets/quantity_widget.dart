import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:qawafel/bloc/quantity_bloc/quantity_bloc.dart';
import 'package:qawafel/bloc/quantity_bloc/quantity_event.dart';
import 'package:qawafel/bloc/quantity_bloc/quantity_state.dart';


class QuantityWidget extends StatelessWidget {
  final int priceLower;

  const QuantityWidget({Key key, this.priceLower}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final QuantityBloc quantityBloc = BlocProvider.of<QuantityBloc>(context);
    return BlocBuilder<QuantityBloc,QuantityState>(
      builder: (context,state){
        return Row(
          children: [
            InkWell(
                onTap: () {
                  state.quantity == 1
                      ? () {}
                      :quantityBloc.add(DecrementEvent());
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.elliptical(9999.0, 9999.0)),
                    color: const Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x19000000),
                        offset: Offset(0, 0),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  child: Icon(Icons.remove),
                )),
            SizedBox(
              width: ScreenUtil().setWidth(15),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: const Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x19000000),
                    offset: Offset(0, 0),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 22.0, vertical: 4),
                child: Text(state.quantity.toString()),
              ),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(15),
            ),
            InkWell(
              onTap: () {

                  quantityBloc.add(IncrementEvent());

              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.elliptical(9999.0, 9999.0)),
                  color: const Color(0xffffffff),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x19000000),
                      offset: Offset(0, 0),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Icon(Icons.add),
              ),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(80),
            ),
            Text(
              (state.quantity * priceLower).toString(),
              style: TextStyle(
                  color: Theme.of(context).primaryColor),
            )
          ],
        );
      },
    );
  }
}
