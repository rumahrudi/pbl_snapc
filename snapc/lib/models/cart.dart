import 'package:flutter/material.dart';
import 'package:snapc/models/photo.dart';

class Cart extends ChangeNotifier {
  // * list photo package
  List<Photo> photoShop = [
    Photo(
      name: 'Basic',
      price: '100k',
      numberOfPhotos: '',
      revisions: '',
      rating: '4.3',
      imagePath: 'lib/images/donut_basic.png',
      description:
          'Lorem ipsum Basic Package, consectetur adipiscing elit. Nam mollis laoreet arcu, sit amet imperdiet dolor cursus nec. Mauris volutpat ante nec massa consectetur, in accumsan orci ornare. Nulla ante magna, dictum ac odio semper, vehicula fringilla nulla. Phasellus malesuada lectus commodo lectus euismod, eget ullamcorper ligula vestibulum.Lorem ipsum Premium Package, consectetur adipiscing elit. Nam mollis laoreet arcu, sit amet imperdiet dolor cursus nec. Mauris volutpat ante nec massa consectetur, in accumsan orci ornare. Nulla ante magna, dictum ac odio semper, vehicula fringilla nulla. Phasellus malesuada lectus commodo lectus euismod, eget ullamcorper ligula vestibulum',
    ),
    Photo(
      name: 'Standart',
      price: '300k',
      numberOfPhotos: '',
      revisions: '',
      rating: '4.5',
      imagePath: 'lib/images/donout.png',
      description:
          'Lorem ipsum Standart Package, consectetur adipiscing elit. Nam mollis laoreet arcu, sit amet imperdiet dolor cursus nec. Mauris volutpat ante nec massa consectetur, in accumsan orci ornare. Nulla ante magna, dictum ac odio semper, vehicula fringilla nulla. Phasellus malesuada lectus commodo lectus euismod, eget ullamcorper ligula vestibulum.Lorem ipsum Premium Package, consectetur adipiscing elit. Nam mollis laoreet arcu, sit amet imperdiet dolor cursus nec. Mauris volutpat ante nec massa consectetur, in accumsan orci ornare. Nulla ante magna, dictum ac odio semper, vehicula fringilla nulla. Phasellus malesuada lectus commodo lectus euismod, eget ullamcorper ligula vestibulum',
    ),
    Photo(
        name: 'Premium',
        price: '400k',
        numberOfPhotos: '',
        revisions: '',
        rating: '4.9',
        imagePath: 'lib/images/donout_premium.png',
        description:
            'Lorem ipsum Premium Package, consectetur adipiscing elit. Nam mollis laoreet arcu, sit amet imperdiet dolor cursus nec. Mauris volutpat ante nec massa consectetur, in accumsan orci ornare. Nulla ante magna, dictum ac odio semper, vehicula fringilla nulla. Phasellus malesuada lectus commodo lectus euismod, eget ullamcorper ligula vestibulum.Lorem ipsum Premium Package, consectetur adipiscing elit. Nam mollis laoreet arcu, sit amet imperdiet dolor cursus nec. Mauris volutpat ante nec massa consectetur, in accumsan orci ornare. Nulla ante magna, dictum ac odio semper, vehicula fringilla nulla. Phasellus malesuada lectus commodo lectus euismod, eget ullamcorper ligula vestibulum')
  ];
  // * list item in user cart
  List<Photo> userCart = [];
  // * get list oh photo package for sale
  List<Photo> getPhotoList() {
    return photoShop;
  }

  // * get cart
  List<Photo> getUserCart() {
    return userCart;
  }

  // * add items to cart
  void addItemToCart(Photo photo) {
    userCart.add(photo);
    notifyListeners();
  }

  // * remove item from cart
  void removeItemFromCart(Photo photo) {
    userCart.remove(photo);
    notifyListeners();
  }
}
