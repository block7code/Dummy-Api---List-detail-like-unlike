import 'package:dummy_api/core/constant/b7c_constant.dart';
import 'package:dummy_api/data/models/remote_model.dart';
import 'package:dummy_api/data/servies/remote_service.dart';
import 'package:dummy_api/size_config.dart';
import 'package:dummy_api/views/widgets/shimmer/shimmer.dart';
import 'package:dummy_api/views/screens/users/user_detail.dart';
import 'package:dummy_api/views/styles/colors.dart';
import 'package:dummy_api/views/styles/styles.dart';
import 'package:flutter/material.dart';

class UsersWidget extends StatefulWidget {
  static const routeName = '/UsersWidget';
  final Map<String, Object>? param;
  final Function()? callback;

  const UsersWidget({
    Key? key,
    this.param,
    this.callback,
  }) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _UsersWidgetState createState() => _UsersWidgetState();
}

_goDeatail(context, param) {
  Navigator.pushNamed(context, UserDetail.routeName, arguments: param);
}

class _UsersWidgetState extends State<UsersWidget> {
  RemoteService userApi = RemoteService();
  List<ListUser> _userList = [];

  ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  late int page = 0;
  late int pages;
  int? totalPage;
  String? _errorApi;

  @override
  void initState() {
    _scrollController = ScrollController();
    _getDataUsers(context, page);

    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if ((page) < (totalPage! - 1)) {
          page = page + 1;

          _getDataUsers(context, page);
        } else {
          showInSnackBar("Ini data terakhir");
        }
      }
    });
  }

  Future<void> _getDataUsers(context, page) async {
    setState(() {
      _isLoading = true;
      _errorApi = null;
    });

    try {
      UserListResponse response = await userApi.getUserList(page: 4);

      if (response.total != 0) {
        setState(() {
          totalPage = _getPages(response.total);

          _userList = response.userList;
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

  _getPages(totals) {
    var cekPage = totals / B7CConstants.limit;
    var total = cekPage.toString().split('');
    pages = int.parse(total[0]);
    if (int.parse(total[2]) != 0) {
      pages = int.parse(total[0]) + 1;
    }
    return pages;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () {
          setState(() {
            page = 0;
          });
          return _getDataUsers(context, page);
        },
        child: Column(
          children: [
            SizedBox(
              height: customWidth(10),
            ),
            _titleText(),
            Expanded(
              child: _buildUsersList(context),
            ),
          ],
        ),
      ),
    );
  }

  Padding _titleText() {
    return Padding(
      padding: EdgeInsets.only(
          left: customWidth(18), right: customWidth(18), top: 30),
      child: SizedBox(
        height: customWidth(40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "Users",
                  style: B7CTheme.headingBoldText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsersList(context) {
    Size size = MediaQuery.of(context).size;

    if (_isLoading) {
      return const SkeletonCard();
    }

    if (_errorApi != null) {
      return _showAlert(context, _errorApi);
    }

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: GridView.count(
            crossAxisCount: 2,
            controller: _scrollController,
            shrinkWrap: true,
            children: List.generate(_userList.length, (i) {
              var newcount = _userList[i].title.length +
                  _userList[i].firstName.length +
                  _userList[i].lastName.length;

              return Container(
                  margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color:
                            const MaterialColor(0xffA975FF, B7CColor.mapColor),
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  child: GestureDetector(
                      onTap: () {
                        Map<String, Object> param = {};
                        param['id'] = _userList[i].id;

                        _goDeatail(context, param);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: SizedBox(
                                height: 140,
                                width: 160,
                                child: _userList[i].picture != 'null'
                                    ? Image.network(
                                        _userList[i].picture,
                                        fit: BoxFit.cover,
                                      )
                                    : _userList[i].title == 'mr.'
                                        ? Image.asset(
                                            'assets/images/men.png',
                                            fit: BoxFit.cover,
                                          )
                                        : Image.asset(
                                            'assets/images/women.png',
                                            fit: BoxFit.cover,
                                          )),
                          ),
                          SizedBox(
                            height: newcount > 17
                                ? size.height * 0.001
                                : size.height * 0.01,
                          ),
                          Flexible(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style: const TextStyle(
                                      color: Colors.black, letterSpacing: 0.4),
                                  children: [
                                    TextSpan(
                                        text: _userList[i].title != 'null'
                                            ? "${_userList[i].title}. "
                                            : "-",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600)),
                                    TextSpan(
                                        text: _userList[i].firstName != 'null'
                                            ? "${_userList[i].firstName} "
                                            : "-",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600)),
                                    TextSpan(
                                        text: _userList[i].lastName != 'null'
                                            ? _userList[i].lastName
                                            : "-",
                                        style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600)),
                                  ]),
                            ),
                          ),
                        ],
                      )));
            })));
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
    // ignore: deprecated_member_use
    Scaffold.of(context).showSnackBar(SnackBar(content: Text(value)));
  }
}
