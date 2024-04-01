abstract class AddProductsState {}

class AddProductsInitalState extends AddProductsState {}

class AddProductsLoadingState extends AddProductsState {}

class AddProductsSuccessState extends AddProductsState {}

class AddProductsErrorState extends AddProductsState {
  final String error;

  AddProductsErrorState({required this.error});
}

class SelectImageState extends AddProductsState {}

class SelectImageState2 extends AddProductsState {}

class ClearFormState extends AddProductsState {}
