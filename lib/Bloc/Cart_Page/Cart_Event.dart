abstract class CartListEvent {
  const CartListEvent();
}

class OnShowCartList extends CartListEvent {
  final String accessToken;
  OnShowCartList({
    this.accessToken,
  });
}

class OnDeleteSwiped extends CartListEvent {
  final String productId;
  final String accessToken;
  OnDeleteSwiped({
    this.productId,
    this.accessToken,
  });
}

class OnDropDownPressed extends CartListEvent {
  final String productId;
  final String quantity;
  final String accessToken;
  OnDropDownPressed({
    this.productId,
    this.quantity,
    this.accessToken,
  });
}
