abstract class ProductDetailEvent {}

class buyNowButtonPressed extends ProductDetailEvent {
  String id;
  String quant;
  String token;

  buyNowButtonPressed({
    this.id,
    this.quant,
    this.token,
  });
}
