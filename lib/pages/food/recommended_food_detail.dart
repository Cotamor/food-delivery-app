import 'package:flutter/material.dart';
import 'package:food_deli/Utils/app_constants.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimentions.dart';
import 'package:food_deli/controllers/recommended_product_controller.dart';
import 'package:food_deli/models/products_model.dart';
import 'package:food_deli/routes/route_helper.dart';
import 'package:food_deli/widgets/app_icon.dart';
import 'package:food_deli/widgets/expandable_text_widget.dart';
import 'package:food_deli/widgets/large_text.dart';
import 'package:get/get.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
  const RecommendedFoodDetail({
    Key? key,
    required this.pageId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductModel product =
        Get.find<RecommendedProductController>().recommendedProductList[pageId];
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(20),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimentions.radius20),
                    topRight: Radius.circular(Dimentions.radius20),
                  ),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                width: double.maxFinite,
                child: Center(
                  child: LargeText(
                    text: product.name!,
                    size: Dimentions.font26,
                  ),
                ),
              ),
            ),
            pinned: true,
            backgroundColor: Colors.yellow,
            expandedHeight: 300,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: const AppIcon(icon: Icons.close),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const AppIcon(icon: Icons.shopping_cart_outlined),
                ),
              ],
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.uploadURL + product.img!,
                // width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: Dimentions.width20),
                  child: ExpandableTextWidget(text: product.description!),
                ),
              ],
            ),
          ),
        ],
      ),
      // Buttom Navigation
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimentions.width20 * 2.5,
                vertical: Dimentions.height10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.remove,
                  bgColor: AppColors.mainColor,
                  iconColor: Colors.white,
                  iconSize: Dimentions.iconSize24,
                ),
                LargeText(
                  text: '\$${product.price} x 0',
                ),
                AppIcon(
                  icon: Icons.add,
                  bgColor: AppColors.mainColor,
                  iconColor: Colors.white,
                  iconSize: Dimentions.iconSize24,
                ),
              ],
            ),
          ),
          Container(
            height: Dimentions.bottomHeightBar120,
            padding: EdgeInsets.only(
              top: Dimentions.height30,
              bottom: Dimentions.height30,
              left: Dimentions.width20,
              right: Dimentions.width20,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimentions.radius20),
                topRight: Radius.circular(Dimentions.radius20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimentions.width20,
                      vertical: Dimentions.height20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimentions.radius20),
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.favorite,
                    color: AppColors.mainColor,
                  ),
                ),
                // Bottom Nav(Add to Cart Button)
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimentions.width20,
                      vertical: Dimentions.height20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimentions.radius20),
                    color: AppColors.mainColor,
                  ),
                  child: LargeText(
                    text: '\$${product.price} | Add to cart',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
