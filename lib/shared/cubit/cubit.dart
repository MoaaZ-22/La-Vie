// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:la_vie/models/Categories/plants_model.dart';
import 'package:la_vie/models/Categories/seeds_model.dart';
import 'package:la_vie/models/Categories/tools_model.dart';
import 'package:la_vie/models/Forums_Model/forum_model.dart';
import 'package:la_vie/models/Forums_Model/comment_model.dart';
import 'package:la_vie/models/Forums_Model/create_post_model.dart';
import 'package:la_vie/models/Forums_Model/like_model.dart';
import 'package:la_vie/models/Profile_Model/update_model.dart';
import 'package:la_vie/models/Profile_Model/user_model.dart';
import 'package:la_vie/modules/Forums_Screen/Forums_Screen.dart';
import 'package:la_vie/modules/Notification_Screen/notification_screen.dart';
import 'package:la_vie/modules/Profile_Screen/profile_screen.dart';
import 'package:la_vie/modules/QR_Code_Screen/qr_code_screen.dart';
import 'package:la_vie/shared/components/const.dart';
import 'package:la_vie/shared/cubit/states.dart';
import 'package:la_vie/shared/network/end_points.dart';
import 'package:la_vie/shared/network/local/cache_helper.dart';
import 'package:la_vie/shared/network/remote/dio_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import '../../models/Blogs_Model/all_blogs_model.dart';
import '../../models/Blogs_Model/blog_by_id.dart';
import '../../models/Categories/all_products_model.dart';
import '../../modules/Home_Screen/home.dart';

class LaVieAppCubit extends Cubit<LaVieAppStates>
{
  LaVieAppCubit() : super(LaVieAppInitialState()) ;

  static LaVieAppCubit get(context) => BlocProvider.of(context);

  //************************************************************************************************
  TabController? homeBarIndexController;
  TextEditingController commentTextController= TextEditingController();
  TextEditingController searchTextController= TextEditingController();
  TextEditingController myCommentTextController= TextEditingController();
  int initialStart = 15;
  ScrollController scrollAllForumsController = ScrollController();
  int initialMyStart = 0;
  ScrollController scrollMyForumsController = ScrollController();
 //***********************************************************************************************
  int bottomNavBarCurrentIndex = 2;

  List<Widget> laVieHomeLayoutScreens =
  [
    const ForumsScreen(),
    const QRCodeScreen(),
    const Home(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  int selectedIndex = 0 ;

  List<String> categoryName = ['All', 'Plants', 'Seeds', 'Tool'];


  void catListToggle(int index)
  {
    selectedIndex = index;
    if(index == 0)
      {
        getAllProducts();
      }
    else if (index == 1)
      {
        getPlants();
      }
    else if (index == 2)
    {
      getSeeds();
    }
    else if (index == 3)
    {
      getTools();
    }

    print(index);
    emit(LaVieToggleCatListState());
  }

  bool forumsIndex = true;
  
  // Forums Screen
  void forumsToggle(bool trueOrFalse)
  {
    if(trueOrFalse == true)
    {
      forumsIndex =true;
      getAllForums();
    }
    else if(trueOrFalse == false)
    {
      forumsIndex =false;
      getMyForums();
    }
    else
    {
      forumsIndex = !forumsIndex;
    }
    emit(LaVieToggleForumsState());
  }

  AllProductModel? allProductModel;

  List<AllProductData> itemsToSearch = [];

  List<AllProductData> searchedList = [];
  bool isError= false;
  void getAllProducts()
  {

    emit(LaVieGetAllProductsLoadingState());

    DioHelper.getData(url: GET_ALL_PRODUCTS,accessToken: accessToken,lang:'en')
        .then((value)
    {
      allProductModel = AllProductModel.fromJson(value.data);
      for (var element in allProductModel!.data!) {
        itemsToSearch.add(element);
      }
      emit(LaVieGetAllProductsSuccessState(allProductModel!));
      isError = false;
    }
    )
        .catchError((error){
      emit(LaVieGetAllProductsErrorState(error.toString()));
      isError = true;
      print(error.toString());
    });
  }
  
  void putSearchedItemInMyList(String title)
  {
    searchedList = itemsToSearch.where((element) => element.name!.toLowerCase().startsWith(title)).toList();
    getAllProducts();
    emit(LaVieGetSearchedListSuccessState());
  }

  saveSearchToRecent(String value) async {
    final List<String>? items = CacheHelper.getStringList('searchItem');
    if (items == null) {
      await CacheHelper.setStringList('', <String>[value]);
    } else if (items.length >= 5) {
      items.add(value);
      items.removeAt(0);
      await CacheHelper.setStringList('searchItem', items);
    } else {
      items.add(value);
      await CacheHelper.setStringList('searchItem', items);
    }
    getRecentSearchItems();
  }
  
  List<String> recentItems = [];
  Future getRecentSearchItems() async {
    recentItems = CacheHelper.getStringList('searchItem') ?? [];
    getAllProducts();
  }

  removeRecentItem(String value) async {
    getRecentSearchItems();
    recentItems.removeWhere((item) => item == value);
    await CacheHelper.setStringList('searchItem', recentItems).then((value)
    {
      getRecentSearchItems();
      emit(LaVieRemoveFromRecentSuccessState());
    }).catchError((error)
    {
      emit(LaVieRemoveFromRecentErrorState(error.toString()));
    });


  }

  // ******************************************* Plants Model ***********************************************

  PlantsModel? plantsModel;

  void getPlants()
  {

    emit(LaVieGetPlantsLoadingState());

    DioHelper.getData(url: GET_PLANTS,accessToken: accessToken,lang:'en')
        .then((value)
    {
      plantsModel = PlantsModel.fromJson(value.data);

      // print(plantsModel!.message);
      // print(plantsModel!.data![1].name);
      // print(plantsModel!.data![1].plantId);

      emit(LaVieGetPlantsSuccessState(plantsModel!));

    }
    )

        .catchError((error){

      emit(LaVieGetPlantsErrorState(error.toString()));
      print(error.toString());
    });
  }
 // ******************************************* Seeds Model ***********************************************

  SeedsModel? seedsModel;

  void getSeeds()
  {

    emit(LaVieGetSeedsLoadingState());

    DioHelper.getData(url: GET_SEEDS,accessToken: accessToken,lang:'en')
        .then((value)
    {
      seedsModel = SeedsModel.fromJson(value.data);

      // print(seedsModel!.message);
      // print(seedsModel!.data![1].name);
      // print(seedsModel!.data![1].seedId);

      emit(LaVieGetSeedsSuccessState(seedsModel!));

    }
    )

        .catchError((error){

      emit(LaVieGetSeedsErrorState(error.toString()));
      print(error.toString());
    });
  }

  // ******************************************* Tools Model ***********************************************
  ToolsModel? toolsModel;
  void getTools()
  {
    emit(LaVieGetToolsLoadingState());
    DioHelper.getData(url: GET_TOOLS,accessToken: accessToken,lang:'en')
        .then((value)
    {
      toolsModel = ToolsModel.fromJson(value.data);
      // print(toolsModel!.message);
      // print(toolsModel!.data![1].name);
      // print(toolsModel!.data![1].toolId);
      emit(LaVieGetToolsSuccessState(toolsModel!));
    }
    )
        .catchError((error){
      emit(LaVieGetToolsErrorState(error.toString()));
      print(error.toString());
    });
  }
  
  // ****************************************** Profile Model ***********************************************
  UserModel? userModel;

  void getUserData()
  {
    emit(LaVieLoadingUserDataState());

    DioHelper.getData(url: GET_USER_ME,lang: 'en',accessToken: accessToken)
    .then((value)
    {
      userModel = UserModel.fromJson(value.data);
      emit(LaVieSuccessUserDataState(userModel!));
      print(userModel!.data!.firstName);
      print(userModel!.data!.email);
    })
    .catchError((error){
      print(error.toString());
      emit(LaVieErrorUserDataState());
    });
  }

  UpdateModel? updateModel;
  void updateUserData({required String? firstName, required String? lastName, required String? email, required String? address,})
{
  emit(LaVieUpdateUserDataLoadingState());
  DioHelper.patchData(url: UPDATE_USER_DATA,
      lang: 'en',
      accessToken: accessToken,
      data:{
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "address": address,
      }
  )
  .then((value)
  {
    updateModel = UpdateModel.fromJson(value.data);
    print(updateModel!.message);
    emit(LaVieUpdateUserDataSuccessState(updateModel!));
  })
  .catchError((error)
  {
    LaVieUpdateUserDataErrorState(error.toString());
  });
}

  // Image Picker Function
  io.File? profileImage;
  io.File? coverImage;
  var picker = ImagePicker();

// For Profile Image
  Future<void> pickProfileImage() async {
    final XFile? pickedProfileFile =
    await picker.pickImage(source: ImageSource.gallery);

    if (pickedProfileFile != null) {
      profileImage = io.File(pickedProfileFile.path);

      emit(LaVieProfileImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(LaVieProfileImagePickedSuccessState());
    }
  }
  // Image Picker Function
  io.File? postImage;
  // Images64 Saved Here
  String? base64string;
// For Profile Image & Convert It to imageBase64
  Future<void> pickPostImage() async {
    final XFile? pickedPostFile =
    await picker.pickImage(source: ImageSource.gallery);

    if (pickedPostFile != null) {
      postImage = io.File(pickedPostFile.path);
      // print(postImage.toString());
      // Uint8List imageBytes = await profileImage!.readAsBytes(); //convert to bytes
      Uint8List imageBytes = io.File(postImage!.path).readAsBytesSync();
      base64string = base64.encode(imageBytes);
      emit(LaViePostImagePickedSuccessState());
    } else {
      print('No Image Selected');
      emit(LaViePostImagePickedSuccessState());
    }
  }
  CreatePostModel? createPostModel;
  void createPost({String? title,String? description,String? imageBase64})
  {
  emit(LaVieCreatePostLoadingState());
  
  DioHelper.postData(url: CREATE_POST,accessToken: accessToken,lang: 'en', data:
  {
    'title' : title,
    'description' : description,
    'imageBase64' : 'data:image/png;base64,$imageBase64'
  }
  )
  .then((value)
  {
    createPostModel = CreatePostModel.fromJson(value.data);
    print(createPostModel!.message);
    print(createPostModel!.data!.title);
    emit(LaVieCreatePostSuccessState(createPostModel!));
  })
  .catchError((error)
  {
    emit(LaVieCreatePostErrorState(error.toString()));
    print(error.toString());
  });
    
  }

  // ******************************************* MY Forums Model ***********************************************

  ForumsModel? forumsModel;
  void getMyForums()
  {
    emit(LaVieGetUserPostLoadingState());
    DioHelper.getData(url:GET_MY_POSTS, accessToken: accessToken,lang: 'en')
        .then((value)
    {
      forumsModel = ForumsModel.fromJson(value.data);
      print('Length of Second Post ${forumsModel!.data[1].forumComments.length}');

      emit(LaVieGetUserPostSuccessState(forumsModel!));
    }
    )
        .catchError((error){

      emit(LaVieGetUserPostErrorState(error.toString()));
      print(error.toString());
    });
  }

  // ******************************************* All Forums Model ***********************************************

  ForumsModel? allForumsModel;
  void getAllForums()
  {
    emit(LaVieGetAllPostLoadingState());
    DioHelper.getData(url:GET_ALL_FORUMS, accessToken: accessToken)
        .then((value)
    async {
      allForumsModel = ForumsModel.fromJson(value.data);
      // print('data2 ${value.data}');
      print(allForumsModel!.message);
      emit(LaVieGetAllPostSuccessState());
    }
    )
        .catchError((error){
      emit(LaVieGetAllPostErrorState(error.toString()));
      print(error.toString());
    });
  }

 // ******************************************* Post Like *******************************************************

  LikeModel? likeModel;
  void addAndRemoveLike(String? forumsId)
  {
    DioHelper.postWithoutData(url: '/api/v1/forums/$forumsId/like',accessToken: accessToken,)
    .then((value)
    {
      likeModel = LikeModel.fromJson(value.data);
      print(likeModel!.message);
      emit(LaVieLikeSuccessState());
    })
    .catchError((error){emit(LaVieLikeErrorState());print(error.toString());});
  }

  void addAndRemoveLikeFromALl(String? forumsId)
  {
    DioHelper.postWithoutData(url: '/api/v1/forums/$forumsId/like',accessToken: accessToken,)
        .then((value)
    {
      likeModel = LikeModel.fromJson(value.data);
      print(likeModel!.message);
      emit(LaVieLikeAllSuccessState());
    })
        .catchError((error){emit(LaVieLikeAllErrorState());print(error.toString());});
  }

  // ******************************************* Comments Post **************************************************

  CommentModel? commentModel;
  void createComments({String? comment, String? forumId})
  {
    emit(LaVieCreateCommentsLoadingState());

    DioHelper.postData(url: '/api/v1/forums/$forumId/comment',accessToken: accessToken, data:
    {
      'comment' : comment
    })
    .then((value)
    {
      commentModel = CommentModel.fromJson(value.data);
      emit(LaVieCreateCommentsSuccessState(commentModel!));
    })
    .catchError((error){
      print(error);
      emit(LaVieCreateCommentsErrorState(error.toString()));
    });
  }
 // ******************************************* DataBase SQFLITE *******************************************************
  late Database database;

  //  Create DataBase
  void createDataBase() {
    openDatabase(
      'laVieCart.db', //Name Of DataBase You Want
      version: 1,
      //Version Of DataBase Don't change it
      // until you Change Table Structure
      // Such As add New Column or Delete Column
      onCreate: (database, version)
      // It's Executed once When DataBase Created
      // (one Time Execute)
      //Then We Create table Here
      {
        print('DataBase Created');
        database
            .execute(
            'CREATE TABLE cart (id INTEGER PRIMARY KEY, name TEXT, price INTEGER, number INTEGER, image TEXT)')
            .then((value) {
            print('Table Created');

        }).catchError((error) {

            print('Error When Creating Table ${error.toString()}');

        });
      },
      onOpen: (database)
      // It Gets Called Every Time The App Opens

      {
          print('DataBase Opened');
          getDataFromDatabase(database);

      },
    ).then((value) => {
      database = value,
      emit(LaVieCreateDataBaseSuccessState())
    });

  }


  // Insert Into DataBase
  insertDataBase({required String name,required int price,required int number,required String image}) async{
    await database.transaction((txn) => txn
        .rawInsert(
        'INSERT INTO cart(name, price, number, image) VALUES("$name", "$price" , "$number","$image")')
        .then((value) {

        print('$value Has Been Inserted');
        emit(LaVieInsertDateBaseState());
        getDataFromDatabase(database);
    }
    ).catchError((error) {
        print('There Is an Error when data Inserted ${error.toString()}');
    }));
  }

  String? totalPrice = '';
  List<Map> cartList = [];
  // Get Data From DataBase
  getDataFromDatabase(database)
  {
    cartList = [];
    emit(LaVieGetDataBaseLoadingState());
    database.rawQuery('SELECT * FROM cart').then((value){
      value.forEach((element) {
        cartList.add(element);
        // print(cartList);
      });

      // Cart Total Price **********
      if(cartList.isNotEmpty && cartList != null)
        {
          totalPrice = cartList.map((e) => e['price'] * e['number']).reduce((value, element) => value+element).toString();
          print(totalPrice);
        }
      emit(LaVieGetDataBaseSuccessState());
    });
  }
  
  void updateData({required int number, required int id }) async
  {
    database.rawUpdate(
        'UPDATE cart SET number = ? WHERE id = ?',
        [number, id]).then((value)
    {
      getDataFromDatabase(database);
      emit(LaVieUpdateDataBaseState());
    });
      print('updated: ');


  }

  void deleteData({required int id }) async
  {
    database.rawDelete(
        'DELETE FROM cart WHERE id = ?',
        [id]).then((value)
    {
      getDataFromDatabase(database);
      emit(LaVieDeleteDataBaseState());
    });
      print('Deleted: ');
  }

  GetAllBlogs? getAllBlogsModel;

  void getAllBlogs()
  {
    emit(LaVieGetAllBlogsLoadingState());
    
    DioHelper.getData(url: GET_ALL_BLOG, accessToken: accessToken, lang: 'en').then((value)
    {
      getAllBlogsModel = GetAllBlogs.fromJson(value.data);
      print(getAllBlogsModel!.message!);
      emit(LaVieGetAllBlogsSuccessState(getAllBlogsModel!));
    }).catchError((error)
    {
      emit(LaVieGetAllBlogsErrorState(error.toString()));
    });
  }


  BLogModelById? bLogModelById;

  void getIdBlogs({String? blogId})
  {
    emit(LaVieGetIDBlogsLoadingState());

    DioHelper.getData(url: '/api/v1/products/blogs/:$blogId', accessToken: accessToken, lang: 'en').then((value)
    {
      bLogModelById = BLogModelById.fromJson(value.data);
      print(bLogModelById!.message!);
      emit(LaVieGetIDBlogsSuccessState(bLogModelById!));
    }).catchError((error)
    {
      emit(LaVieGetIDBlogsErrorState(error.toString()));
    });
  }


  void cartDecreaseNumber(Map model)
  {
    if(model['number'] == 1)
    {
      model['number'] = 1;
    }
    else
    {
      int newNumber = model['number'];
      newNumber--;
      updateData(number: newNumber, id: model['id']);
      emit(LaVieDecreaseNumberState());
    }
  }
}


