import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BirthDate extends StatefulWidget {
  @override
  _BirthDateState createState() => _BirthDateState();
}

class _BirthDateState extends State<BirthDate> {
  String selectedMonth;
  int selectedDay;
  int selectYear;
  List<int> days = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30,
    31
  ];
  List<Map> months = [
    {"name": "January", "short": "Jan", "number": 1, "days": 31},
    {"name": "February", "short": "Feb", "number": 2, "days": 28},
    {"name": "March", "short": "Mar", "number": 3, "days": 31},
    {"name": "April", "short": "Apr", "number": 4, "days": 30},
    {"name": "May", "short": "May", "number": 5, "days": 31},
    {"name": "June", "short": "Jun", "number": 6, "days": 30},
    {"name": "July", "short": "Jul", "number": 7, "days": 31},
    {"name": "August", "short": "Aug", "number": 8, "days": 31},
    {"name": "September", "short": "Sep", "number": 9, "days": 30},
    {"name": "October", "short": "Oct", "number": 10, "days": 31},
    {"name": "November", "short": "Nov", "number": 11, "days": 30},
    {"name": "December", "short": "Dec", "number": 12, "days": 31}
  ];
  List<int> years = [
    2021,
    2020,
    2019,
    2018,
    2017,
    2016,
    2015,
    2014,
    2013,
    2012,
    2011,
    2010,
    2009,
    2008,
    2007,
    2006,
    2005,
    2004,
    2003,
    2002,
    2001,
    2000,
    1999,
    1998,
    1997,
    1996,
    1995,
    1994,
    1993,
    1992,
    1991,
    1990,
    1989,
    1988,
    1987,
    1986,
    1985,
    1984,
    1983,
    1982,
    1981,
    1980,
    1979,
    1978,
    1977,
    1976,
    1975,
    1974,
    1973,
    1972,
    1971,
    1970,
    1969,
    1968,
    1967,
    1966,
    1965,
    1964,
    1963,
    1962,
    1961,
    1960,
    1959,
    1958,
    1957,
    1956,
    1955,
    1954,
    1953,
    1952,
    1951,
    1950,
    1949,
    1948,
    1947,
    1946,
    1945,
    1944,
    1943,
    1942,
    1941,
    1940,
    1939,
    1938,
    1937,
    1936,
    1935,
    1934,
    1933,
    1932,
    1931,
    1930,
    1929,
    1928,
    1927,
    1926,
    1925,
    1924,
    1923,
    1922,
    1921,
    1920,
    1919,
    1918,
    1917,
    1916,
    1915,
    1914,
    1913,
    1912,
    1911,
    1910,
    1909,
    1908,
    1907,
    1906,
    1905,
    1904,
    1903,
    1902,
    1901
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(44),
      child: Row(
        children: [
          SizedBox(
            width: ScreenUtil().setWidth(10),
          ),
          Container(
            width: ScreenUtil().setWidth(106),
            height: ScreenUtil().setHeight(44),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xffffffff),
              border: Border.all(width: 0.2, color: const Color(0xff000000)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  icon: Icon(
                    // Add this
                    Icons.arrow_drop_down, // Add this
                    color: Theme.of(context).primaryColor, // Add this
                  ),
                  hint: SizedBox(
                      width: ScreenUtil().setWidth(60),
                      child: Text("Day", textAlign: TextAlign.center)),
                  value: selectedDay,
                  items: days.map((value) {
                    return new DropdownMenuItem(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: new Text(value.toString()),
                      ),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      selectedDay = newVal;
                    });
                  }),
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(17),
          ),

          Container(
            width: ScreenUtil().setWidth(106),
            height: ScreenUtil().setHeight(44),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xffffffff),
              border: Border.all(width: 0.2, color: const Color(0xff000000)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  icon: Icon(
                    // Add this
                    Icons.arrow_drop_down, // Add this
                    color: Theme.of(context).primaryColor, // Add this
                  ),
                  hint: SizedBox(
                      width: ScreenUtil().setWidth(60),
                      child: Text("Month", textAlign: TextAlign.center)),
                  value: selectedMonth,
                  items: months.map((value) {
                    return new DropdownMenuItem(
                      value: value["name"],
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: new Text(value["name"]),
                      ),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      selectedMonth = newVal;
                    });
                  }),
            ),
          ),


          SizedBox(
            width: ScreenUtil().setWidth(17),
          ),

          Container(
            width: ScreenUtil().setWidth(106),
            height: ScreenUtil().setHeight(44),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color(0xffffffff),
              border: Border.all(width: 0.2, color: const Color(0xff000000)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                  icon: Icon(
                    Icons.arrow_drop_down, // Add this
                    color: Theme.of(context).primaryColor, // Add this
                  ),
                  hint: SizedBox(
                      width: ScreenUtil().setWidth(60),
                      child: Text("Year", textAlign: TextAlign.center)),
                  value: selectYear,
                  items: years.map(( value) {
                    return new DropdownMenuItem(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: new Text(value.toString()),
                      ),
                    );
                  }).toList(),
                  onChanged: (newVal) {
                    setState(() {
                      selectYear = newVal;
                    });
                  }),
            ),
          ),


          SizedBox(
            width: ScreenUtil().setWidth(13),
          ),
        ],
      ),
    );
  }
}
