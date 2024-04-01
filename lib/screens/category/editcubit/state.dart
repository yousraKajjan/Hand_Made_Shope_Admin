abstract class EditCategoryState {}

class EditCategoryInitalState extends EditCategoryState {}

class EditCategoryLoadingState extends EditCategoryState {}

class EditCategorySuccessState extends EditCategoryState {}

class EditCategoryErrorState extends EditCategoryState {
  final String error;

  EditCategoryErrorState({required this.error});
}

class SelectImageState extends EditCategoryState {}

class ClearFormState extends EditCategoryState {}
