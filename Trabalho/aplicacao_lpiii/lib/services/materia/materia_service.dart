import 'package:aplicacao_lpiii/models/materia/materia_item.dart';
import 'package:flutter/material.dart';

class MateriaService with ChangeNotifier {
  List<MateriaItem> _items = getItems();
  List<MateriaItem> _cart = [];

  List<MateriaItem> get items => _items;

  List<MateriaItem> get cart => _cart;

  void addToCart(MateriaItem item) {
    _cart.add(item);
    notifyListeners();
  }

  void removeFromCart(MateriaItem item) {
    _cart.remove(item);
    notifyListeners();
  }
}
