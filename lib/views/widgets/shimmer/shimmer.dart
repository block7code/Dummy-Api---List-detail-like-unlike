import 'package:dummy_api/views/widgets/shimmer/lloading_page.dart';
import 'package:flutter/material.dart';

class SkeletonUserPost extends StatefulWidget {
  final double height;
  final double width;

  const SkeletonUserPost({Key? key, this.height = 20, this.width = 200})
      : super(key: key);

  @override
  createState() => SkeletonUserPostState();
}

class SkeletonUserPostState extends State<SkeletonUserPost>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _childrenLoad = <Widget>[];
    // for (var i = 0; i < 7; i++) {
    _childrenLoad.add(
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
          child: GridView.count(
              crossAxisCount: 1,
              shrinkWrap: true,
              children: List.generate(2, (i) {
                return Container(
                    margin:
                        const EdgeInsets.only(left: 5, right: 5, bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.06),
                        border: Border.all(
                            color: const Color.fromARGB(0, 148, 141, 141)
                                .withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(12)),
                    child: GestureDetector(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                          height: 32,
                          width: MediaQuery.of(context).size.width - 16,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                spreadRadius: 0.2,
                                blurRadius: 5,
                              )
                            ],
                            // color: Colors.white,
                            color: Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(28)),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.016,
                        ),
                        Container(
                          height: size.height * 0.26,
                          width: MediaQuery.of(context).size.width - 16,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                spreadRadius: 0.2,
                                blurRadius: 5,
                              )
                            ],
                            // color: Colors.white,
                            color: Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(28)),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.016,
                        ),
                        Container(
                          height: size.height * 0.06,
                          width: MediaQuery.of(context).size.width - 16,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                spreadRadius: 0.2,
                                blurRadius: 5,
                              )
                            ],
                            // color: Colors.white,
                            color: Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(28)),
                          ),
                        ),
                      ],
                    )));
              }))),
    );

    return LoadAnimation(
        child: SingleChildScrollView(
      child: Column(
        children: _childrenLoad,
      ),
    ));
  }
}

class SkeletonCard extends StatefulWidget {
  final double height;
  final double width;

  const SkeletonCard({Key? key, this.height = 20, this.width = 200})
      : super(key: key);

  @override
  createState() => SkeletonCardState();
}

class SkeletonCardState extends State<SkeletonCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _childrenLoad = <Widget>[];
    // for (var i = 0; i < 7; i++) {
    _childrenLoad.add(
      Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
          child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              children: List.generate(8, (i) {
                return Container(
                    margin:
                        const EdgeInsets.only(left: 5, right: 5, bottom: 10),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.06),
                        border: Border.all(
                            color: const Color.fromARGB(0, 148, 141, 141)
                                .withOpacity(0.2)),
                        borderRadius: BorderRadius.circular(12)),
                    child: GestureDetector(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Container(
                          height: size.height * 0.11,
                          width: MediaQuery.of(context).size.width - 16,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                spreadRadius: 0.2,
                                blurRadius: 5,
                              )
                            ],
                            // color: Colors.white,
                            color: Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(28)),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.016,
                        ),
                        Container(
                          height: 32,
                          width: MediaQuery.of(context).size.width - 16,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.12),
                                spreadRadius: 0.2,
                                blurRadius: 5,
                              )
                            ],
                            // color: Colors.white,
                            color: Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(28)),
                          ),
                        ),
                      ],
                    )));
              }))),
    );

    return LoadAnimation(
        child: SingleChildScrollView(
      child: Column(
        children: _childrenLoad,
      ),
    ));
  }
}

class SkeletonDetailCard extends StatefulWidget {
  final double height;
  final double width;

  const SkeletonDetailCard({Key? key, this.height = 20, this.width = 200})
      : super(key: key);

  @override
  createState() => SkeletonDetailCardState();
}

class SkeletonDetailCardState extends State<SkeletonDetailCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var _childrenLoad = <Widget>[];
    // for (var i = 0; i < 7; i++) {
    _childrenLoad.add(
      Container(
          // margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.06),
              border: Border.all(
                  color:
                      const Color.fromARGB(0, 148, 141, 141).withOpacity(0.2)),
              borderRadius: BorderRadius.circular(12)),
          child: GestureDetector(
              child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.12,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          spreadRadius: 0.2,
                          blurRadius: 5,
                        )
                      ],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
                  Container(
                    height: size.height * 0.22,
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.12),
                          spreadRadius: 0.2,
                          blurRadius: 5,
                        )
                      ],
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                height: size.height * 0.03,
                width: MediaQuery.of(context).size.width - 16,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      spreadRadius: 0.2,
                      blurRadius: 5,
                    )
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(28)),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                height: size.height * 0.03,
                width: MediaQuery.of(context).size.width - 16,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      spreadRadius: 0.2,
                      blurRadius: 5,
                    )
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(28)),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                height: size.height * 0.03,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      spreadRadius: 0.2,
                      blurRadius: 5,
                    )
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Container(
                height: size.height * 0.03,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      spreadRadius: 0.2,
                      blurRadius: 5,
                    )
                  ],
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ],
          ))),
    );

    return LoadAnimation(
        child: SingleChildScrollView(
      child: Column(
        children: _childrenLoad,
      ),
    ));
  }
}
