import 'package:flutter/material.dart';
import 'package:pharma_connect/core/widgets/simple_app_bar.dart';
import 'package:pharma_connect/features/cart/ui/cart_screen.dart';
import 'package:pharma_connect/features/home_page/presentation/widgets/promotions_widget.dart';
import 'package:pharma_connect/features/home_page/presentation/widgets/sample_drugs_list.dart';
import 'package:pharma_connect/features/my_orders/presentation/ui/my_orders_page.dart';
import 'package:pharma_connect/features/profile/presentation/profile_page.dart';

final PageController globalPageController = PageController();

class AppMainPage extends StatefulWidget {
  const AppMainPage({super.key});

  @override
  State<AppMainPage> createState() => _HomePageState();
}

class _HomePageState extends State<AppMainPage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    globalPageController.addListener(() {
      setState(() {
        _selectedIndex = globalPageController.page!.toInt();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: globalPageController,
        physics: NeverScrollableScrollPhysics(),
        children: [_HomeWidget(), MyOrdersPage(), CartScreen(), ProfilePage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFFAFAFA),
        selectedItemColor: Color(0xFF2B9794),
        unselectedItemColor: Color(0xFFA1A5B7),
        showUnselectedLabels: true,
        unselectedFontSize: 12,
        currentIndex: _selectedIndex,
        elevation: 5,
        onTap: globalPageController.jumpToPage,
        selectedLabelStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'My Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.face), label: 'Profile'),
        ],
      ),
    );
  }
}

class _HomeWidget extends StatelessWidget {
  const _HomeWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(
        title: 'PharmaConnect',
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12.0),
        child: Column(
          spacing: 24,
          children: [PromotionsWidget(), SampleDrugsList()],
        ),
      ),
    );
  }
}
