import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_groceries_app/app_color.dart';
import 'package:online_groceries_app/model/product.dart';
import 'package:online_groceries_app/controller/product_controller.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({Key? key, required this.product})
    : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int tam = 1;
  bool _isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Image.network(
                  product.image,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Icon(Icons.favorite_border_outlined, color: AppColor.gray),
                ],
              ),

              Text(
                product.unitPrice,
                style: TextStyle(fontSize: 14.sp, color: AppColor.gray),
              ),
              SizedBox(height: 30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          if (tam > 1) {
                            setState(() {
                              tam--;
                            });
                          }
                        },
                        icon: Icon(Icons.remove),
                      ),
                      Container(
                        width: 50.w,
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.graysearch,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                          shape: BoxShape.rectangle,
                        ),
                        child: Center(
                          child: Text(
                            tam.toString(),
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          setState(() {
                            tam++;
                          });
                        },
                        icon: Icon(Icons.add, color: AppColor.green),
                      ),
                    ],
                  ),
                  Text(
                    "\$${widget.product.price}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Divider(),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Product Detail',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _isExpanded = !_isExpanded;
                      });
                    },
                    icon: Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColor.black,
                      size: 40.sp,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              _isExpanded
                  ? Text(
                    product.description,
                    style: TextStyle(fontSize: 14.sp, color: AppColor.gray),
                  )
                  : Text(
                    product.description,
                    style: TextStyle(fontSize: 12.sp, color: AppColor.gray),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

              SizedBox(height: 30.h),
              Divider(),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nutritions',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: AppColor.black),
                ],
              ),
              SizedBox(height: 30.h),
              Divider(),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Review',
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      Row(
                        children: List.generate(5, (index) {
                          return Icon(
                            index < widget.product.review
                                ? Icons.star
                                : Icons.star_border,
                            color:
                                index < widget.product.review
                                    ? const Color.fromARGB(255, 231, 110, 53)
                                    : const Color.fromARGB(255, 158, 158, 158),
                            size: 30.sp,
                          );
                        }),
                      ),
                      SizedBox(width: 10.w),
                      Icon(Icons.arrow_forward_ios, color: AppColor.black),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Center(
                child: SizedBox(
                  width: 300.w,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15.h),
                      backgroundColor: AppColor.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Add To Basket',
                      style: TextStyle(fontSize: 18.sp, color: AppColor.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
