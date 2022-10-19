import 'package:la_vie/models/Question_Model/question_model.dart';

List<QuestionModel> question =
[
  QuestionModel('Name the smallest bone in the human body ?',
      {
        'Spine ' : false,
        'Stapes' : true,
        'Chest ' : false,
      }
  ),
  QuestionModel('Name the deepest ocean in the world ?',
      {
        'Pacific Ocean' : true,
        'Indian Ocean' : false,
        'Southern Ocean' : false,
      }
  ),
  QuestionModel('1024 Kilobytes is equal to ?',
      {
        '1 Megabyte (MB)' : true,
        '1000 Megabyte (MB)' : false,
        '1 Gigabyte (GB)' : false,
      }
  ),
  QuestionModel(' Name the gas which is filled in balloons ?',
      {
        'Hydrogen' : false,
        'Neon' : false,
        'Helium' : true,
      }
  ),
  QuestionModel('Bucharest is the capital of which country ?',
      {
        'Italy' : false,
        'Romania' : true,
        'Egypt' : false,
      }
  ),
];
