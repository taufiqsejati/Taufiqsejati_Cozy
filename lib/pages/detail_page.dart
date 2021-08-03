import 'package:flutter/material.dart';
import 'package:taufiqsejati_cozy/models/space.dart';
import 'package:taufiqsejati_cozy/pages/error_page.dart';
import 'package:taufiqsejati_cozy/theme.dart';
import 'package:taufiqsejati_cozy/widgets/facility_item.dart';
import 'package:taufiqsejati_cozy/widgets/rating_item.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailPage extends StatefulWidget {
  final Space space;

  DetailPage(this.space);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool isFavorite = false;
  // int index = 0;
  @override
  Widget build(BuildContext context) {
    launchUrl(String url) async {
      if (await canLaunch(url)) {
        launch(url);
      } else {
        // throw (url);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ErrorPage()));
      }
    }

    Future<void> showConfirmation() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Konfirmasi'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Apakah kamu ingin menghubungi pemilik kos?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Nanti',
                  style: greyTextStyle,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Hubungi'),
                onPressed: () {
                  Navigator.of(context).pop();
                  launchUrl('tel:${widget.space.phone}');
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Image.network(
                widget.space.imageUrl,
                width: MediaQuery.of(context).size.width,
                height: 350,
                fit: BoxFit.cover,
              ),
              ListView(
                children: [
                  SizedBox(
                    height: 328,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                        color: whiteColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 30),
                        // NOTE: TITLE
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: edge),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.space.name,
                                    style:
                                        blackTextStyle.copyWith(fontSize: 22),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text.rich(TextSpan(
                                      text: '\$${widget.space.price}',
                                      style: purpleTextStyle.copyWith(
                                          fontSize: 16),
                                      children: [
                                        TextSpan(
                                            text: ' / mounth',
                                            style: greyTextStyle.copyWith(
                                                fontSize: 16))
                                      ])),
                                ],
                              ),
                              Row(
                                children: [1, 2, 3, 4, 5].map((index) {
                                  return Container(
                                    margin: EdgeInsets.only(left: 2),
                                    child: RatingItem(
                                      index: index,
                                      rating: widget.space.rating,
                                    ),
                                  );
                                }).toList(),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        // NOTE: MAIN FACILITES
                        Padding(
                          padding: EdgeInsets.only(left: edge),
                          child: Text(
                            'Main Facilities',
                            style: regularTextStyle.copyWith(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: edge),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FacilityItem(
                                name: 'kitchen',
                                total: widget.space.numberOfKitchens,
                                imageUrl: 'assets/icon_kitchen.png',
                              ),
                              FacilityItem(
                                name: 'bedroom',
                                total: widget.space.numberOfBedrooms,
                                imageUrl: 'assets/icon_bedroom.png',
                              ),
                              FacilityItem(
                                name: 'Big Lemari',
                                total: widget.space.numberOfCupboards,
                                imageUrl: 'assets/icon_cupboard.png',
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        // NOTE: PHOTO
                        Padding(
                          padding: EdgeInsets.only(left: edge),
                          child: Text(
                            'Photos',
                            style: regularTextStyle.copyWith(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                            height: 88,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: widget.space.photos.length,
                                itemBuilder: (_, index) => Container(
                                      margin: EdgeInsets.only(
                                          left: 24,
                                          right: (index ==
                                                  widget.space.photos.length -
                                                      1)
                                              ? 24
                                              : 0),
                                      child: Column(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: Image.network(
                                              widget.space.photos[index],
                                              width: 110,
                                              height: 88,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ))

                            // ListView(
                            //     scrollDirection: Axis.horizontal,
                            //     children: widget.space.photos.map((item) {
                            //       index++;
                            //       return Container(
                            //         margin: EdgeInsets.only(
                            //           right: 24,
                            //           left: index == 1 ? 24 : 0,
                            //         ),
                            //         child: Column(
                            //           children: [
                            //             ClipRRect(
                            //               borderRadius: BorderRadius.circular(16),
                            //               child: Image.network(
                            //                 item,
                            //                 width: 110,
                            //                 height: 88,
                            //                 fit: BoxFit.cover,
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       );
                            //     }).toList()),
                            ),
                        SizedBox(
                          height: 30,
                        ),
                        // NOTE: LOCATION
                        Padding(
                          padding: EdgeInsets.only(left: edge),
                          child: Text(
                            'Location',
                            style: regularTextStyle.copyWith(fontSize: 16),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: edge),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${widget.space.address}\n${widget.space.country}',
                                  style: greyTextStyle,
                                ),
                                InkWell(
                                  onTap: () {
                                    launchUrl(widget.space.mapUrl);
                                    // launchUrl(
                                    //     'https://www.google.com/maps/@-6.2327073,107.0638355,16z?hl=id');
                                  },
                                  child: Image.asset(
                                    'assets/btn_map.png',
                                    width: 40,
                                  ),
                                )
                              ]),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(horizontal: edge),
                            height: 50,
                            width:
                                MediaQuery.of(context).size.width - (2 * edge),
                            child: RaisedButton(
                              onPressed: () {
                                showConfirmation();
                              },
                              color: purpleColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17)),
                              child: Text('Book Now',
                                  style: whiteTextStyle.copyWith(fontSize: 18)),
                            )),
                        SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: edge, vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'assets/btn_back.png',
                        width: 40,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isFavorite = !isFavorite;
                          // index = 0;
                        });
                      },
                      child: Image.asset(
                        isFavorite
                            ? 'assets/btn_wishlist_active.png'
                            : 'assets/btn_wishlist.png',
                        width: 40,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
