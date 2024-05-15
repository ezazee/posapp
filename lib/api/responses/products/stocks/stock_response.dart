class StockResponse {
  final int id;
  final int? stock;
  final int? initStock;
  final String type;
  final double? initialPrice;
  final double? sellingPrice;
  final String date;
  

  StockResponse({
    required this.id,
    required this.stock,
    required this.initStock,
    required this.type,
    this.initialPrice,
    this.sellingPrice,
    required this.date,
  });

  factory StockResponse.fromJson(Map<String, dynamic> json) {
    return StockResponse(
      id: json['id'],
      stock: json['stock'],
      initStock: json['init_stock'],
      type: json['type'], 
      initialPrice: double.parse(json['initial_price'].toString()),
      sellingPrice: double.parse(json['selling_price'].toString()),
      date: json['date'],
    );
  }
}
