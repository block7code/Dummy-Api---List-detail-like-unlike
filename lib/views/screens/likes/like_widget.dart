// ignore_for_file: deprecated_member_use

import 'package:dummy_api/core/constant/b7c_constant.dart';
import 'package:dummy_api/data/models/remote_model.dart';
import 'package:dummy_api/data/servies/remote_service.dart';
import 'package:dummy_api/size_config.dart';
import 'package:dummy_api/views/styles/b7c_theme.dart';
import 'package:dummy_api/data/models/item.dart';
import 'package:dummy_api/views/widgets/circle_image.dart';
import 'package:dummy_api/views/widgets/shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';

class YourLikeWidget extends StatefulWidget {
  static const routeName = '/YourLikeWidget';

  const YourLikeWidget({Key? key}) : super(key: key);

  @override
  _YourLikeWidgetState createState() => _YourLikeWidgetState();
}

class _YourLikeWidgetState extends State<YourLikeWidget> {
  TextEditingController controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  RemoteService userApi = RemoteService();
  List<PostList> _userPost = [];

  bool _isLoadingPost = false;
  late int page = 0;
  late int pages;
  int? totalPage;
  String? _errorApi;

  @override
  void initState() {
    _scrollController = ScrollController();

    _getListPost(context, page);
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if ((page) < (totalPage! - 1)) {
          page = page + 1;

          _getListPost(context, page);
        } else {
          showInSnackBar("Ini data terakhir");
        }
      }
    });
  }

  _getListPost(context, page) async {
    setState(() {
      _isLoadingPost = true;
      _errorApi = null;
    });

    try {
      UserPostResponse response =
          await userApi.getLike(id: '60d0fe4f5311236168a10a22', page: 0);

      if (response.total != 0) {
        setState(() {
          totalPage = _getPages(response.total);
          _userPost = response.listPost;
          _errorApi = null;
          _isLoadingPost = false;
        });
      } else {
        setState(() {
          _isLoadingPost = false;
          _errorApi = "Server tidak dapar dijangkau";
        });
      }
    } catch (err) {
      setState(() {
        _isLoadingPost = false;

        _errorApi = err.toString();
      });
    }
  }

  _getPages(totals) {
    var cekPage = totals / B7CConstants.limit;
    var total = cekPage.toString().split('');
    pages = int.parse(total[0]);
    if (int.parse(total[2]) != 0) {
      pages = int.parse(total[0]) + 1;
    }
    return pages;
  }

  void _onDoubleTapLikePhoto() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: _titleText(),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _mainBody(),
          ],
        ),
      ),
      // )
    );
  }

  Widget _mainBody() {
    Size size = MediaQuery.of(context).size;

    if (_isLoadingPost) {
      return const SkeletonUserPost();
    }

    if (_errorApi != null) {
      return _showAlert(context, _errorApi);
    }

    final RxList<Item> _itemsNew = List.generate(
        _userPost.length,
        (i) => Item(
            id: i,
            postID: _userPost[i].id,
            fullName:
                ' ${_userPost[i].owner.title}  ${_userPost[i].owner.firstName}  ${_userPost[i].owner.lastName}',
            publishDate: DateFormat("MMM d, yy \u00B7 h:mm a")
                .format(_userPost[i].publishDate),
            image: _userPost[i].owner.picture,
            imagePost: _userPost[i].image,
            text: _userPost[i].text,
            website: 'https://logique.co.id',
            likes: _userPost[i].likes,
            inWishList: false.obs)).obs;

    void addItem(int id) {
      final int index = _itemsNew.indexWhere((item) => item.id == id);
      _itemsNew[index].inWishList.value = true;
      _itemsNew[index].likes + 1;
    }

    void removeItem(int id) {
      final int index = _itemsNew.indexWhere((item) => item.id == id);
      _itemsNew[index].inWishList.value = false;
      _itemsNew[index].likes - 1;
    }

    return Column(children: [
      GridView.count(
        crossAxisCount: 1,
        controller: _scrollController,
        shrinkWrap: true,
        childAspectRatio: (size.width / size.height) * 2.092,
        children: List.generate(
          _itemsNew.length,
          (i) {
            final pl = _itemsNew[i];
            // children: _itemsNew.map((pl) {
            //

            String thisImage = pl.imagePost;
            bool isNetwork = true;
            // ignore: unnecessary_null_comparison
            if (pl.image == null) {
              isNetwork = false;
              thisImage = 'assets/images/image_post.png';
            }

            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
              child: Card(
                  // semanticContainer: true,
                  // clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 2,
                  child: Column(
                    children: [
                      userInfoRow(context, pl),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 40,
                          right: 40,
                        ),
                        child: GestureDetector(
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                                color: Colors.white,
                                image: isNetwork
                                    ? DecorationImage(
                                        image: NetworkImage(
                                          thisImage,
                                        ),
                                        fit: BoxFit.fill,
                                      )
                                    : DecorationImage(
                                        image: AssetImage(thisImage),
                                        fit: BoxFit.fill,
                                      )),
                          ),
                          onDoubleTap: _onDoubleTapLikePhoto,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 23, vertical: 0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                ButtonTheme(
                                  minWidth: 20.0,
                                  height: 26.0,
                                  child: RaisedButton(
                                    color: Colors.purple,
                                    onPressed: () {},
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(80.0)),
                                    textColor: Colors.white,
                                    child: const Text(
                                      "Views",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: customWidth(10),
                                  width: customWidth(10),
                                ),
                                ButtonTheme(
                                  minWidth: 20.0,
                                  height: 26.0,
                                  child: RaisedButton(
                                    color: Colors.purple,
                                    onPressed: () {},
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(80.0)),
                                    textColor: Colors.white,
                                    child: const Text(
                                      "Dark",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: customWidth(10),
                                  width: customWidth(10),
                                ),
                                ButtonTheme(
                                  minWidth: 20.0,
                                  height: 26.0,
                                  child: RaisedButton(
                                    color: Colors.purple,
                                    onPressed: () {},
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(80.0)),
                                    textColor: Colors.white,
                                    child: const Text(
                                      "Sky",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                pl.text,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: customWidth(5),
                              // width: customWidth(5),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: GestureDetector(
                                onTap: () => {},
                                child: Text(
                                  pl.website,
                                  style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF2661FA)
                                      // color: Colors.black54,
                                      ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: customWidth(4),
                              // width: customWidth(5),
                            ),
                            // _likeHandle(pl),
                            Obx(
                              () => Container(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                  onPressed: () {
                                    if (pl.inWishList.value == false) {
                                      addItem(pl.id);
                                    } else {
                                      removeItem(pl.id);
                                    }
                                  },
                                  icon: Icon(
                                    pl.inWishList.value == true
                                        ? FontAwesomeIcons.heart
                                        : Icons.favorite,
                                    size: 34,
                                    color: pl.inWishList.value == false
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: customWidth(3),
                              // width: customWidth(10),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            );
          },
        ),
      ),
    ]);
  }

  Widget userInfoRow(context, pl) {
    String thisURL = pl.image;
    bool isNetwork = true;
    if (pl.fullName == null) {
      thisURL = 'assets/images/men.png';
    }

    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          child: GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                CircleImage(
                  thisURL,
                  imageSize: 56.0,
                  whiteMargin: 2.0,
                  imageMargin: 2.0,
                  isNetwork: isNetwork,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      pl.fullName,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      pl.publishDate,
                      style: const TextStyle(color: Colors.black45),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Padding _titleText() {
    return Padding(
      padding: EdgeInsets.only(
          left: customWidth(18), right: customWidth(18), top: 0),
      child: SizedBox(
        height: customWidth(40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "Likes",
                  style: B7CTheme.headingBoldText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(value)));
  }

  _showAlert(context, message) {
    return AlertDialog(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      title: const Center(
          child: Text(
        'Ops Terjadi Kesalahan',
        style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
      )),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            message!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
