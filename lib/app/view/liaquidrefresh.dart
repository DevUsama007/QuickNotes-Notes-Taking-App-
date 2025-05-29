import 'package:flutter/material.dart';
import 'package:liquid_pull_refresh/liquid_pull_refresh.dart';
import 'package:get/get.dart';

class LiquidRefresh extends StatefulWidget {
  const LiquidRefresh({super.key});

  @override
  State<LiquidRefresh> createState() => _LiquidRefreshState();
}

class _LiquidRefreshState extends State<LiquidRefresh> {
  Future<void> handleRefresh() async {
    // Simulate network request
    await Future.delayed(Duration(seconds: 10));
    // You would typically call your data refresh here
    // await _controller.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liquid Refresh'),
      ),
      body: LiquidPullRefresh(
        onRefresh: handleRefresh, // Just pass the function directly
        color: Colors.blue, // Customize the refresh indicator color
        backgroundColor: Colors.white, // Background color
        height: 150, // Height of the refresh indicator
        animSpeedFactor: 2, // Animation speed
        showChildOpacityTransition: false,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(), // Important!
          child: Column(
            children: List.generate(
              2,
              (index) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: Get.width * 0.9,
                        height: 200,
                        color:
                            Colors.primaries[index % Colors.primaries.length],
                        child: Center(
                          child: Text(
                            'Item ${index + 1}',
                            style: TextStyle(color: Colors.white, fontSize: 24),
                          ),
                        ),
                      ).paddingSymmetric(horizontal: 10, vertical: 10),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
