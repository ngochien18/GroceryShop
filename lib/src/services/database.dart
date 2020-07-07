import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fryo/src/shared/Cart.dart';
import 'package:fryo/src/shared/Product.dart';

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference foodCollection =
      Firestore.instance.collection('foods');

  final CollectionReference cartCollection =
      Firestore.instance.collection('carts');

  final CollectionReference paymentCollection =
  Firestore.instance.collection('payments');

  Future addFood(Product product) async {
    return await foodCollection.document().setData({
      'name': product.name,
      'image': product.image,
      'price': product.price,
      'discount': product.discount,
      'userLiked': product.userLiked,
      'isFood': product.isFood
    });
  }

  Future addCart(Product product, int amount) async {
    return await cartCollection.document().setData({
      'name': product.name,
      'image': product.image,
      'price': product.price,
      'discount': product.discount,
      'userLiked': product.userLiked,
      'isFood': product.isFood,
      'amount': amount,
    });
  }

  Future addPayment(String name, String phone, String address) async {
    return await paymentCollection.document().setData({
      'name': name,
      'phone': phone,
      'address': address
    });
  }

  Future removeCarts() async {
    cartCollection.getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents){
        ds.reference.delete();
      }
    });
  }

  List<Product> _foodListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Product(
          name: doc.data['name'] ?? '',
          image: doc.data['image'] ?? '',
          price: doc.data['price'] ?? '0',
          discount: doc.data['discount'] ?? '0',
          userLiked: doc.data['userLiked'] ?? false,
          isFood: doc.data['isFood'] ?? false);
    }).toList();
  }

  List<Cart> _cartListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Cart(
          name: doc.data['name'] ?? '',
          image: doc.data['image'] ?? '',
          price: doc.data['price'] ?? '0',
          discount: doc.data['discount'] ?? '0',
          userLiked: doc.data['userLiked'] ?? false,
          isFood: doc.data['isFood'] ?? false,
          amount: doc.data['amount'] ?? 1);
    }).toList();
  }

  // get brews stream
  Stream<List<Product>> get foods {
    return foodCollection.snapshots().map(_foodListFromSnapshot);
  }

  // get carts stream
  Stream<List<Cart>> get carts {
    return cartCollection.snapshots().map(_cartListFromSnapshot);
  }
}
