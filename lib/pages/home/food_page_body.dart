import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:food_deli/Utils/app_constants.dart';
import 'package:food_deli/Utils/colors.dart';
import 'package:food_deli/Utils/dimentions.dart';
import 'package:food_deli/controllers/popular_product_controller.dart';
import 'package:food_deli/controllers/recommended_product_controller.dart';
import 'package:food_deli/models/products_model.dart';
import 'package:food_deli/pages/food/popular_food_detail.dart';
import 'package:food_deli/routes/route_helper.dart';
import 'package:food_deli/widgets/app_column.dart';
import 'package:food_deli/widgets/icon_text.dart';
import 'package:food_deli/widgets/large_text.dart';
import 'package:food_deli/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _height = Dimentions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        // Slider Section
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? SizedBox(
                  height: Dimentions.pageView,
                  // color: Colors.green.shade100,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: popularProducts.popularProductList.length,
                    itemBuilder: (context, index) {
                      return _buildPageItem(index, popularProducts.popularProductList[index]);
                    },
                  ),
                )
              : SizedBox(
                  height: Dimentions.pageView,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.mainColor,
                    ),
                  ),
                );
        }),
        // Dots(Indicatore)
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty ? 1 : popularProducts.popularProductList.length,
            position: _currentPageValue,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeColor: AppColors.mainColor,
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        // Recommended Title
        SizedBox(height: Dimentions.height30),
        Container(
          margin: EdgeInsets.only(left: Dimentions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const LargeText(text: 'Recommended'),
              SizedBox(width: Dimentions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: const LargeText(
                  text: '.',
                  color: Colors.black26,
                ),
              ),
              SizedBox(width: Dimentions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: const SmallText(text: 'food catering'),
              ),
            ],
          ),
        ),
        // List of recommended food and Images
        GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
          return recommendedProduct.isLoaded
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: recommendedProduct.recommendedProductList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRecommendedFood(index, 'home'));
                      },
                      child: _buildListItem(index, recommendedProduct.recommendedProductList[index]),
                    );
                  },
                )
              : SizedBox(
                  height: Dimentions.pageView,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.mainColor,
                    ),
                  ),
                );
        }),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel popularProduct) {
    Matrix4 matrix = Matrix4.identity();

    if (index == _currentPageValue.floor()) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currentScale = _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currentScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
    } else {
      var currentScale = 0.8;
      var currentTrans = _height * (1 - currentScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTrans, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getPopularFood(index, 'home'));
            },
            child: Container(
              height: Dimentions.pageViewContainer,
              margin: EdgeInsets.only(left: Dimentions.width10, right: Dimentions.width10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentions.radius30),
                image: DecorationImage(
                  // image: AssetImage('assets/image/food0.png'),
                  image: NetworkImage(AppConstants.uploadURL + popularProduct.img!),
                  fit: BoxFit.cover,
                ),
                color: index.isEven ? Colors.blue.shade100 : Colors.grey.shade100,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimentions.pageViewTextContainer,
              margin: EdgeInsets.only(
                left: Dimentions.width30,
                right: Dimentions.width30,
                bottom: Dimentions.height30,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimentions.radius20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 203, 203, 203),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, 0),
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(5, 0),
                  ),
                ],
              ),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: Dimentions.height20, vertical: Dimentions.height10),
                // height: double.maxFinite,
                child: AppColumn(title: popularProduct.name!),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(int index, ProductModel recommendedProduct) {
    return Container(
      margin: EdgeInsets.only(left: Dimentions.width20, right: Dimentions.width20, bottom: Dimentions.height10),
      child: Row(
        children: [
          // Image Section
          Container(
            width: Dimentions.listViewImgSize,
            height: Dimentions.listViewImgSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimentions.radius20),
              color: Colors.white,
              image: DecorationImage(
                  image: NetworkImage(AppConstants.uploadURL + recommendedProduct.img!), fit: BoxFit.cover),
            ),
          ),
          // Text Container
          Expanded(
            child: Container(
              height: Dimentions.listViewTextContSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(Dimentions.radius20),
                  bottomRight: Radius.circular(Dimentions.radius20),
                ),
                color: Colors.green.shade100,
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimentions.width10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LargeText(
                      text: recommendedProduct.name!,
                      size: Dimentions.font18,
                    ),
                    SizedBox(height: Dimentions.height10),
                    SmallText(
                      text: recommendedProduct.description!,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Info Section
                    SizedBox(height: Dimentions.height10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        IconTextWidget(
                          icon: Icons.circle_sharp,
                          text: 'Normal',
                          iconColor: AppColors.iconColor1,
                        ),
                        IconTextWidget(
                          icon: Icons.location_on,
                          text: '1.7km',
                          iconColor: AppColors.mainColor,
                        ),
                        IconTextWidget(
                          icon: Icons.access_time_rounded,
                          text: '32mins',
                          iconColor: AppColors.iconColor2,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
