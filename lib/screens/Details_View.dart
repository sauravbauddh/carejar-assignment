import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class DetailsView extends StatefulWidget {
  const DetailsView({Key? key}) : super(key: key);

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  CollectionReference doctors =
      FirebaseFirestore.instance.collection('doctors');
  late List<Map<String, dynamic>> doctorList;
  late List<Map<String, dynamic>> displayedDoctors;
  TextEditingController searchController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      QuerySnapshot querySnapshot = await doctors.get();
      doctorList = querySnapshot.docs
          .map((DocumentSnapshot doc) => {
                'name': doc['name'],
                'image': doc['image'],
                'price': doc['price'],
                'booked': false, // Add a 'booked' flag initially set to false
              })
          .toList();
      displayedDoctors = List.from(doctorList);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterDoctors(String query) {
    setState(() {
      displayedDoctors = doctorList
          .where((doctor) =>
              doctor['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, left: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 267.w,
                  height: 50.h,
                  child: TextField(
                    controller: searchController,
                    onChanged: filterDoctors,
                    cursorColor: const Color.fromRGBO(249, 168, 77, 0.1),
                    style: GoogleFonts.roboto(
                      color: const Color.fromRGBO(218, 99, 23, 0.4),
                      fontSize: 12.sp,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.5,
                    ),
                    decoration: InputDecoration(
                      fillColor: const Color.fromRGBO(249, 168, 77, 0.1),
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: BorderSide.none,
                      ),
                      hintText: 'What do you want to search?',
                      hintStyle: GoogleFonts.roboto(
                        color: const Color.fromRGBO(218, 99, 23, 0.4),
                        fontSize: 12.sp,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                      ),
                      prefixIcon: Container(
                        padding: EdgeInsets.all(15),
                        child: const Icon(Icons.search,
                            color: const Color.fromRGBO(249, 168, 77, 1)),
                        width: 24.w,
                        height: 24.h,
                      ),
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  searchController.clear();
                                  displayedDoctors = List.from(doctorList);
                                });
                              },
                            )
                          : null,
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {},
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r)),
                  backgroundColor: const Color.fromRGBO(249, 168, 77, 0.1),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Image.asset('assets/filter.png'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
                    child: ListView.builder(
                      itemCount: displayedDoctors.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: SizedBox(
                            width: double.infinity,
                            height: 103.h,
                            child: Card(
                              elevation: 0.3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(22.r)),
                              color: Colors.white,
                              child: InkWell(
                                onTap: () {
                                  // Handle doctor selection
                                },
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 20.h, bottom: 20.h, left: 14.w),
                                      child: Container(
                                        width: 62.w,
                                        height: 62.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.r)),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                displayedDoctors[index]
                                                    ['image']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            displayedDoctors[index]['name'],
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              fontStyle: FontStyle.normal,
                                              fontFamily: 'BentonSans Medium',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          GradientText(
                                            '\$' +
                                                displayedDoctors[index]
                                                    ['price'],
                                            style: TextStyle(
                                              fontSize: 19.sp,
                                              fontStyle: FontStyle.normal,
                                              fontFamily: 'BentonSans Medium',
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.5.sp,
                                            ),
                                            colors: [
                                              Color.fromRGBO(83, 232, 139, 1),
                                              Color.fromRGBO(21, 190, 119, 1),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 12.w),
                                    Container(
                                      width: 99.w,
                                      height: 29.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(17.5.r),
                                        gradient: displayedDoctors[index]
                                                    ['booked'] ??
                                                false
                                            ? null
                                            : const LinearGradient(
                                                begin: Alignment.topLeft,
                                                colors: [
                                                  Color.fromRGBO(
                                                      83, 232, 139, 1),
                                                  Color.fromRGBO(
                                                      21, 190, 119, 1),
                                                ],
                                              ),
                                      ),
                                      child: displayedDoctors[index]
                                                  ['booked'] ??
                                              false
                                          ? ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.grey,
                                                shadowColor: Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.r)),
                                              ),
                                              child: Text(
                                                'Booked',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'BentonSans Bold',
                                                  fontSize: 12.sp,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.5.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          "Doctor Appointed"),
                                                      actions: <Widget>[
                                                        ElevatedButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            setState(() {
                                                              displayedDoctors[
                                                                          index]
                                                                      [
                                                                      'booked'] =
                                                                  true;
                                                            });
                                                          },
                                                          child: Text("OK"),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.transparent,
                                                shadowColor: Colors.transparent,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.r)),
                                              ),
                                              child: Text(
                                                'Appoint',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'BentonSans Bold',
                                                  fontSize: 12.sp,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 0.5.sp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
