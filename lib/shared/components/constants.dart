void printFullText(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

// const String token ='563492ad6f917000010000011d5da0e886d84f0d85cf9da468a2f39c';
const String token ='563492ad6f91700001000001357a9c11f2914b6b9e34749dfd5cef54';
const String baseURL ='https://api.pexels.com/v1/';
const String curatedUrl ='https://api.pexels.com/v1/curated';
const String curated ='https://api.pexels.com/v1/curated?page=';
const String method ='?page=';
const String searchUrl ='https://api.pexels.com/v1/search';
