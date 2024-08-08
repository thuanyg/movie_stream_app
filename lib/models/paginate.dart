class Paginate {
  int? currentPage;
  int? totalPage;
  int? totalItems;
  int? itemsPerPage;

  Paginate(
      {this.currentPage, this.totalPage, this.totalItems, this.itemsPerPage});

  Paginate.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    totalPage = json['total_page'];
    totalItems = json['total_items'];
    itemsPerPage = json['items_per_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['total_page'] = this.totalPage;
    data['total_items'] = this.totalItems;
    data['items_per_page'] = this.itemsPerPage;
    return data;
  }
}