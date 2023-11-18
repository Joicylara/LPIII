class MateriaItem {
  final String? name;
  final String? price;

  MateriaItem({this.name, this.price});
}

List<MateriaItem> getItems() {
  return [
    MateriaItem(name: 'Teclado ', price: '24'),
    MateriaItem(name: 'Mouse', price: '20'),
    MateriaItem(name: 'Monitor LED', price: '44'),
    MateriaItem(name: 'Macbook Air', price: '240'),
    MateriaItem(name: 'Samsung', price: '204'),
    MateriaItem(name: 'iMac', price: '248'),
    MateriaItem(name: 'Headphones', price: '29'),
    MateriaItem(name: 'Disco USB', price: '19'),
    MateriaItem(name: 'SSD', price: '23'),
  ];
}
