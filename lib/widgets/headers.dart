import 'package:flutter/material.dart';
import 'package:udhaarkaroapp/constants/constants.dart';
import 'package:udhaarkaroapp/custom_classes/navigations.dart';
import 'package:udhaarkaroapp/widgets/texts.dart';

class NormalHeader extends StatelessWidget {
  final String text;
  final bool backIcon;
  final bool frontIcon;

  const NormalHeader({
    @required this.text,
    this.backIcon = true,
    this.frontIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: displayHeight(context) * 0.16,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: const BoxDecoration(
        color: darkBlueColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (backIcon)
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: backIconLight,
                )
              else
                height30,
              if (frontIcon)
                InkWell(
                  onTap: () {
                    Navigate().toReports(context);
                  },
                  child: reportIconLight,
                )
              else
                height10,
            ],
          ),
          height10,
          Center(
            child: H3Light(
              txt: text,
            ),
          ),
        ],
      ),
    );
  }
}

class SliverHeader extends StatelessWidget {
  final String text;
  final bool backIcon;

  const SliverHeader({@required this.text, this.backIcon = true});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      expandedHeight: displayHeight(context) * 0.2,
      leading: backIcon
          ? InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: backIconLight,
            )
          : const Text(""),
      backgroundColor: darkBlueColor,
      flexibleSpace: FlexibleSpaceBar(
        title: H4Light(
          txt: text,
        ),
        centerTitle: true,
      ),
    );
  }
}

class HomePageTabBarButton extends StatelessWidget {
  final Color color;
  final Icon icon;
  final String price;
  final String subtitle;
  final String buttonText;
  final int count;

  const HomePageTabBarButton({
    this.color,
    this.icon,
    this.price,
    this.subtitle,
    this.buttonText,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: displayWidth(context),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.rotate(angle: 3.142 / 4, child: icon),
              height5,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  H3Light(txt: price.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')),
                ],
              ),
              height5,
              T14Light(txt: subtitle),
            ],
          ),
        ),
        height5,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonText,
              style: TextStyle(color: color, fontSize: 20),
            ),
            width5,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(50),
              ),
              child: T12Light(txt: count.toString()),
            )
          ],
        ),
      ],
    );
  }
}

class UserTransactionHeader extends StatelessWidget {
  final String text;

  const UserTransactionHeader({
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: displayHeight(context) * 0.18,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      decoration: const BoxDecoration(
        color: darkBlueColor,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: backIconLight,
                )
            ],
          ),
          height5,
          Center(
            child: Column(
              children: [
                const T16Light(txt: "All your Transactions with"),
                height5,
                H3Light(
                  txt: text,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
