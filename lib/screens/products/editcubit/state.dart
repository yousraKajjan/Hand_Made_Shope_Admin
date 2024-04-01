abstract class EditProductsState {}

class EditProductsInitalState extends EditProductsState {}

class EditProductsLoadingState extends EditProductsState {}

class EditProductsSuccessState extends EditProductsState {}

class EditProductsErrorState extends EditProductsState {
  final String error;

  EditProductsErrorState({required this.error});
}

class SelectImageState extends EditProductsState {}

class SelectImageState2 extends EditProductsState {}

class ClearFormState extends EditProductsState {}
