// ignore_for_file: deprecated_member_use
import 'package:dummy_api/core/constant/b7c_constant.dart';
import 'package:dummy_api/data/models/remote_model.dart';
import 'package:dummy_api/data/servies/remote_service.dart';
import 'package:dummy_api/size_config.dart';
import 'package:dummy_api/data/models/item.dart';
import 'package:dummy_api/views/widgets/circle_image.dart';
import 'package:dummy_api/views/widgets/shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserDetail extends StatefulWidget {
  static const routeName = '/UserDetail';
  final Map<String, Object>? param;

  const UserDetail({Key? key, this.param}) : super(key: key);

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  RemoteService userApi = RemoteService();
  TextEditingController controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  List<PostList> _userPost = [];
  late Animation<double> animation;
  bool _isLoading = false;
  bool _isLoadingPost = false;
  bool isPressed = false;
  bool isEditable = false;
  int totalLike = 22;
  late int page = 0;
  late int pages;
  int? totalPage;
  String? _errorApi;

  String? title;
  String? firstName;
  String? lastName;
  String? picture;
  String? gender;
  DateTime? dateOfBirth;
  DateTime? joinFrom;
  String? email;
  String? street;
  String? city;
  String? state;
  String? country;

  bool? selected;

  @override
  void initState() {
    _scrollController = ScrollController();
    _getDataDetail(context);
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

  _getDataDetail(context) async {
    setState(() {
      _isLoading = true;
      _errorApi = null;
    });
    String id = widget.param!['id'].toString();
    // String id = '60d0fe4f5311236168a109ca';
    try {
      UserDetailResponse response = await userApi.getUserDetail(id: id);

      if (response.firstName != null) {
        setState(() {
          title = response.title;
          firstName = response.firstName;
          lastName = response.lastName;
          gender = response.gender;
          picture = response.picture;
          dateOfBirth = response.dateOfBirth;
          joinFrom = response.registerDate;
          email = response.email;
          street = response.location!.street.toString();
          city = response.location!.city.toString();
          state = response.location!.state.toString();
          country = response.location!.country.toString();
          _isLoading = false;
          _errorApi = null;
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorApi = "Server tidak dapar dijangkau";
        });
      }
    } catch (err) {
      setState(() {
        _isLoading = false;
        _errorApi = err.toString();
      });
    }
  }

  _getListPost(context, page) async {
    setState(() {
      _isLoadingPost = true;
      _errorApi = null;
    });
    String id = widget.param!['id'].toString();
    // String id = '60d0fe4f5311236168a10a2b';
    try {
      UserPostResponse response = await userApi.getUserPost(id: id, page: page);

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

  void _onDoubleTapLikePhoto() {
    setState(() {
      totalLike = totalLike + 1;
      isPressed = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: ((context, innerBoxIsScrolled) => [
              SliverAppBar(
                backgroundColor: Colors.white.withOpacity(0.1),
                automaticallyImplyLeading: false,
                toolbarHeight: customWidth(60),
                elevation: 3.0,
                title: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new_outlined,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side:
                              const BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: TextFormField(
                          controller: controller,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.all(10),
                              // isDense: true,
                              hintText: 'Search',
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  //   width: 1.2,
                                  color: Colors.transparent,
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(26)),
                              ),
                              prefixIcon: Container(
                                padding: const EdgeInsets.only(
                                    left: 2, top: 3.0, right: 0),
                                child: const Icon(Icons.search),
                              ),
                              suffixIcon: Padding(
                                padding:
                                    const EdgeInsets.only(left: 3, right: 0),
                                child: IconButton(
                                  icon: const Icon(Icons.cancel),
                                  onPressed: () {
                                    controller.clear();
                                    onSearchTextChanged('');
                                  },
                                ),
                              )),
                          onChanged: onSearchTextChanged,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                centerTitle: false,
              )
            ]),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            _mainBody(),
            _listPost(),
          ],
        )),
      ),
    );
  }

  Widget _mainBody() {
    Size size = MediaQuery.of(context).size;
    if (_isLoading) {
      return const SkeletonDetailCard();
    }

    if (_errorApi != null) {
      return _showAlert(context, _errorApi);
    }
    var thisURL = picture;

    bool isNetwork = true;
    if (picture == null) {
      isNetwork = false;

      thisURL = 'assets/images/women.png';
      if (title == 'mr') {
        thisURL = 'assets/images/men.png';
      }
    }

    street ??= "-";
    city ??= "-";
    state ??= "-";
    country ??= "-";
    title ??= "-";
    firstName ??= "-";
    lastName ??= "-";

    String fullname = '$title $firstName $lastName';

    List<DataUser> dataUsers = [
      DataUser(name: "Gender ", value: gender ??= ""),
      DataUser(name: "Date Of Birth ", value: '$dateOfBirth'),
      DataUser(name: "Join From ", value: '$joinFrom'),
      DataUser(name: "Email ", value: email ??= ""),
      DataUser(name: "Address ", value: '$street, $city, $state, $country')
    ];

    return Container(
      margin: const EdgeInsets.only(right: 0, left: 0),
      width: size.height * 0.80,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: size.height * 0.01),
          Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.userPlus,
                    size: size.height * 0.06,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: CircleImage(
                  '$thisURL',
                  imageSize: 200.0,
                  whiteMargin: 1.0,
                  imageMargin: 1.0,
                  isNetwork: isNetwork,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
          ),
          SizedBox(height: size.height * 0.01),
          Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                  left: size.width * 0.12,
                ),
                child: Text(fullname,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700)),
              )),
          SizedBox(height: size.height * 0.01),
          Container(
            padding: const EdgeInsets.only(left: 30.0, right: 2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: dataUsers.map((dt) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          dt.name.toString(),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Expanded(
                          flex: 0,
                          child: Text(
                            ':',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                              fontSize: 16,
                            ),
                          )),
                      Expanded(
                        flex: 3,
                        child: Text(
                          dt.value.toString(),
                          style: const TextStyle(
                            fontSize: 16.0,
                            letterSpacing: 1,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.symmetric(horizontal: 30),
          //   child: ButtonTheme(
          //     minWidth: 20.0,
          //     height: 26.0,
          //     child: RaisedButton(
          //       color: Colors.purple,
          //       onPressed: () {
          //         _getListPost(context, 0);
          //       },
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(80.0)),
          //       textColor: Colors.white,
          //       child: const Text(
          //         "List Data User",
          //         textAlign: TextAlign.center,
          //         style: TextStyle(
          //           color: Colors.white,
          //           fontWeight: FontWeight.w800,
          //           fontSize: 12,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
      // ),
    );
  }

  Widget _listPost() {
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
            totalLike = pl.likes;

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
                                        ? Icons.favorite
                                        : FontAwesomeIcons.heart,
                                    size: 34,
                                    color: pl.inWishList.value == false
                                        ? Colors.black
                                        : Colors.red,
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

  void showInSnackBar(String value) {
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(value)));
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    for (var userDetail in _userDetails) {
      if (userDetail.firstName!.contains(text) ||
          userDetail.lastName!.contains(text)) _searchResult.add(userDetail);
    }

    setState(() {});
  }
}

List<UserDetails> _searchResult = [];

List<UserDetails> _userDetails = [];

class UserDetails {
  final int? id;
  final String? firstName, lastName, profileUrl;

  UserDetails({this.id, this.firstName, this.lastName, this.profileUrl = ''});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['id'],
      firstName: json['name'],
      lastName: json['username'],
    );
  }
}
