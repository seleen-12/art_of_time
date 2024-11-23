class Category{
  Category({
    this.categoryID = 0,
    this.categoryName = "",
})
  
  int categoryID;
  String categoryName;

  factory Category.fromJson(Map<String,dynamic>json)=>Category(
    categoryID: json ["categoryID"],
    categoryName: json ["categoryName"],
  );
  Map<String,dynamic> toJson() => {
    "categoryID":categoryID,
    "categoryName": categoryName,
  };
}