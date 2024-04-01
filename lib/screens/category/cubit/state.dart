abstract class AddCategoryState {}

class AddCategoryInitalState extends AddCategoryState {}

class AddCategoryLoadingState extends AddCategoryState {}

class AddCategorySuccessState extends AddCategoryState {}

class AddCategoryErrorState extends AddCategoryState {
  final String error;

  AddCategoryErrorState({required this.error});
}

class SelectImageState extends AddCategoryState {}

class ClearFormState extends AddCategoryState {}
