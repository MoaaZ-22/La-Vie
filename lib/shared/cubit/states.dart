
import 'package:la_vie/models/Blogs_Model/blog_by_id.dart';
import 'package:la_vie/models/Categories/plants_model.dart';
import 'package:la_vie/models/Forums_Model/comment_model.dart';
import 'package:la_vie/models/Forums_Model/create_post_model.dart';
import 'package:la_vie/models/Forums_Model/forum_model.dart';
import 'package:la_vie/models/Profile_Model/update_model.dart';
import 'package:la_vie/models/Profile_Model/user_model.dart';
import '../../models/Blogs_Model/all_blogs_model.dart';
import '../../models/Categories/all_products_model.dart';
import '../../models/Categories/seeds_model.dart';
import '../../models/Categories/tools_model.dart';

abstract class LaVieAppStates {}

class LaVieAppInitialState extends LaVieAppStates{}

class LaVieBottomNavState extends LaVieAppStates{}

class LaVieFloatingActionButtonState extends LaVieAppStates{}

class LaVieToggleCatListState extends LaVieAppStates{}

class LaVieToggleForumsState extends LaVieAppStates{}

// ************************************ Cart Increase And Decrease Quantity of Item  ******************************

class LaVieIncreaseNumberState extends LaVieAppStates{}

class LaVieDecreaseNumberState extends LaVieAppStates{}


// *************************************** Get All Products Model **************************************************

class LaVieGetAllProductsLoadingState extends LaVieAppStates{}

class LaVieGetAllProductsSuccessState extends LaVieAppStates{

  final AllProductModel allProductModel;

  LaVieGetAllProductsSuccessState(this.allProductModel);


}

class LaVieGetAllProductsErrorState extends LaVieAppStates{

  final String error;

  LaVieGetAllProductsErrorState(this.error);
}

// *************************************** Get Plants Model **************************************************

class LaVieGetPlantsLoadingState extends LaVieAppStates{}

class LaVieGetPlantsSuccessState extends LaVieAppStates{

  final PlantsModel plantsModel;

  LaVieGetPlantsSuccessState(this.plantsModel);


}

class LaVieGetPlantsErrorState extends LaVieAppStates{

  final String error;

  LaVieGetPlantsErrorState(this.error);
}

// *************************************** Get Seeds Model **************************************************

class LaVieGetSeedsLoadingState extends LaVieAppStates{}

class LaVieGetSeedsSuccessState extends LaVieAppStates{

  final SeedsModel seedsModel;

  LaVieGetSeedsSuccessState(this.seedsModel);


}

class LaVieGetSeedsErrorState extends LaVieAppStates{

  final String error;

  LaVieGetSeedsErrorState(this.error);
}


// *************************************** Get Tools Model **************************************************

class LaVieGetToolsLoadingState extends LaVieAppStates{}

class LaVieGetToolsSuccessState extends LaVieAppStates{

  final ToolsModel toolsModel;

  LaVieGetToolsSuccessState(this.toolsModel);


}

class LaVieGetToolsErrorState extends LaVieAppStates{

  final String error;

  LaVieGetToolsErrorState(this.error);
}


// *************************************** Get User Data Model **************************************************

class LaVieLoadingUserDataState extends LaVieAppStates{}

class LaVieSuccessUserDataState extends LaVieAppStates{

  final UserModel userModel;

  LaVieSuccessUserDataState(this.userModel);

}

class LaVieErrorUserDataState extends LaVieAppStates{}


// *************************************** Update User Data Model **************************************************

class LaVieUpdateUserDataLoadingState extends LaVieAppStates{}

class LaVieUpdateUserDataSuccessState extends LaVieAppStates{

  final UpdateModel updateModel;

  LaVieUpdateUserDataSuccessState(this.updateModel);

}

class LaVieUpdateUserDataErrorState extends LaVieAppStates{
  final String? error;

  LaVieUpdateUserDataErrorState(this.error);
}


// *************************************** Image Picker ************************************************************

class LaVieProfileImagePickedSuccessState extends LaVieAppStates{}
class LaVieProfileImagePickedErrorState extends LaVieAppStates{}

// *************************************** Post Picker ************************************************************

class LaViePostImagePickedSuccessState extends LaVieAppStates{}
class LaViePostImagePickedErrorState extends LaVieAppStates{}
class LaVieRemoveImagePickedSuccessState extends LaVieAppStates{}



// ***************************************  Create Post States **************************************************

class LaVieCreatePostLoadingState extends LaVieAppStates{}

class LaVieCreatePostSuccessState extends LaVieAppStates{

  final CreatePostModel createPostModel;

  LaVieCreatePostSuccessState(this.createPostModel);

}

class LaVieCreatePostErrorState extends LaVieAppStates{
  final String? error;

  LaVieCreatePostErrorState(this.error);
}


// *************************************** Get My Forums Model **************************************************

class LaVieGetUserPostLoadingState extends LaVieAppStates{}

class LaVieGetUserPostSuccessState extends LaVieAppStates{
  final ForumsModel forumsModel;

  LaVieGetUserPostSuccessState(this.forumsModel);
}

class LaVieGetUserPostErrorState extends LaVieAppStates{

  final String error;

  LaVieGetUserPostErrorState(this.error);
}

// *************************************** Get All Forums Model **************************************************

class LaVieGetAllPostLoadingState extends LaVieAppStates{}

class LaVieGetAllPostSuccessState extends LaVieAppStates{}

class LaVieGetAllPostErrorState extends LaVieAppStates{

  final String error;

  LaVieGetAllPostErrorState(this.error);
}


// *************************************** Likes Only Current User **************************************************

class LaVieLikeSuccessState extends LaVieAppStates{}

class LaVieLikeErrorState extends LaVieAppStates{}

// *************************************** Likes All Forums **************************************************

class LaVieLikeAllSuccessState extends LaVieAppStates{}

class LaVieLikeAllErrorState extends LaVieAppStates{}

// *************************************** Likes All Forums **************************************************

class LaVieCreateCommentsLoadingState extends LaVieAppStates{}

class LaVieCreateCommentsSuccessState extends LaVieAppStates{

  final CommentModel commentModel;

  LaVieCreateCommentsSuccessState(this.commentModel);
}

class LaVieCreateCommentsErrorState extends LaVieAppStates{

  final String error;

  LaVieCreateCommentsErrorState(this.error);
}

// ***************************************** Search Suffix Icon State ***********************************************

class LaVieIsSuffixIconShowState extends LaVieAppStates{}

// ***************************************** Search State To Refresh List ***********************************************

class LaVieGetSearchedListSuccessState extends LaVieAppStates{}


// ****************************************************** Remove From Recent Search List **************************

class LaVieRemoveFromRecentSuccessState extends LaVieAppStates{}

class LaVieRemoveFromRecentErrorState extends LaVieAppStates{

  final String error;

  LaVieRemoveFromRecentErrorState(this.error);
}


// ************************************************************************************************************

class LaVieSearchSuffixIconChangeStateState extends LaVieAppStates{}

// **************************************** Create DataBase State ******************************************

class LaVieCreateDataBaseSuccessState extends LaVieAppStates{}

// get DataBase

class LaVieGetDataBaseLoadingState extends LaVieAppStates{}

class LaVieGetDataBaseSuccessState extends LaVieAppStates{}

// Update DataBase

class LaVieUpdateDataBaseState extends LaVieAppStates{}

// Delete DataBase

class LaVieDeleteDataBaseState extends LaVieAppStates{}

// ***************************************** GetAllBlogs ************************************************************

class LaVieGetAllBlogsLoadingState extends LaVieAppStates{}

class LaVieGetAllBlogsSuccessState extends LaVieAppStates{

  final GetAllBlogs getAllBlogs;

  LaVieGetAllBlogsSuccessState(this.getAllBlogs);
}

class LaVieGetAllBlogsErrorState extends LaVieAppStates{

  final String error;

  LaVieGetAllBlogsErrorState(this.error);
}

// ***************************************** Blog By ID *************************************************************

class LaVieGetIDBlogsLoadingState extends LaVieAppStates{}

class LaVieGetIDBlogsSuccessState extends LaVieAppStates{

  final BLogModelById bLogModelById;

  LaVieGetIDBlogsSuccessState(this.bLogModelById);
}

class LaVieGetIDBlogsErrorState extends LaVieAppStates{

  final String error;

  LaVieGetIDBlogsErrorState(this.error);
}

// ********************************************* insert Database ****************************************************

class LaVieInsertDateBaseState extends LaVieAppStates{}






