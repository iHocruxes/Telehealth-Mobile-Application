import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:healthline/res/style.dart';
import 'package:healthline/screen/forum/components/exports.dart';
import 'package:healthline/screen/widgets/text_field_widget.dart';
import 'package:healthline/utils/keyboard.dart';
import 'package:healthline/utils/translate.dart';

class ForumScreen extends StatefulWidget {
  const ForumScreen({super.key});

  @override
  State<ForumScreen> createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  late TextEditingController _textEdittingController;
  late TextEditingController _searchController;

  final FocusNode _focus = FocusNode();

  bool openSearch = false;

  @override
  void initState() {
    _textEdittingController = TextEditingController();
    _searchController = TextEditingController();
    _focus.addListener(_checkFocus);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_checkFocus);
    _focus.dispose();
  }

  void _checkFocus() {
    if (_focus.hasFocus == false) {
      setState(() {
        openSearch = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        KeyboardUtil.hideKeyboard(context);
        _checkFocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        extendBody: true,
        backgroundColor: white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: false,
              pinned: true,
              floating: true,
              titleSpacing: 0,
              leadingWidth: openSearch ? 0 : null,
              leading: openSearch ? const SizedBox() : null,
              title: openSearch
                  ? Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
                      child: TextFieldWidget(
                        focusNode: _focus,
                        validate: (p0) => null,
                        hint: translate(context, 'search'),
                        fillColor: colorF2F5FF,
                        filled: true,
                        focusedBorderColor: colorF2F5FF,
                        enabledBorderColor: colorF2F5FF,
                        controller: _searchController,
                        prefixIcon: IconButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: dimensWidth() * 2),
                          onPressed: () {},
                          icon: InkWell(
                            splashColor: transparent,
                            highlightColor: transparent,
                            onTap: () {},
                            child: FaIcon(
                              FontAwesomeIcons.magnifyingGlass,
                              color: color6A6E83,
                              size: dimensIcon() * .8,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Text(
                      translate(context, 'forum'),
                    ),
              actions: [
                if (openSearch == false)
                  Padding(
                    padding: EdgeInsets.only(right: dimensWidth() * 2),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(180),
                      onTap: () {
                        setState(() {
                          openSearch = true;
                        });
                        Future.delayed(Duration(seconds: 1), () {
                          _checkFocus();
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.all(
                          dimensWidth(),
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.magnifyingGlass,
                          size: dimensIcon() * .7,
                        ),
                      ),
                    ),
                  )
              ],
              expandedHeight: dimensHeight() * 35,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: Container(
                  color: white,
                  padding: EdgeInsets.fromLTRB(dimensWidth() * 3,
                      dimensHeight() * 13, dimensWidth() * 3, 0),
                  child: CreatePost(
                      textEdittingController: _textEdittingController),
                ),
              ),
              // bottom: AppBar(
              //   elevation: 0,
              //   title: Padding(
              //     padding: EdgeInsets.symmetric(horizontal: dimensWidth() * 3),
              //     child: TextFieldWidget(
              //       validate: (p0) => null,
              //       hint: translate(context, 'search'),
              //       fillColor: colorF2F5FF,
              //       filled: true,
              //       focusedBorderColor: colorF2F5FF,
              //       enabledBorderColor: colorF2F5FF,
              //       controller: _searchController,
              //       prefixIcon: IconButton(
              //         padding:
              //             EdgeInsets.symmetric(horizontal: dimensWidth() * 2),
              //         onPressed: () {},
              //         icon: InkWell(
              //           splashColor: transparent,
              //           highlightColor: transparent,
              //           onTap: () {},
              //           child: FaIcon(
              //             FontAwesomeIcons.magnifyingGlass,
              //             color: color6A6E83,
              //             size: dimensIcon() * .8,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              //   leading: const SizedBox(),
              //   leadingWidth: 0,
              //   centerTitle: true,
              //   titleSpacing: 0,
              // ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => const PostCard(),
                childCount: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
