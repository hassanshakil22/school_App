const baseURL = "http://13.36.39.94:5000/api";
// const baseURL = "http://10.0.2.2:5000/api";
// const baseURL = "http://10.0.2.2:8080/api";


class ApiUrls {
//post
static const studentLogin = "/SwaggerControllerApi/student-login";


//get
static getContent(String token) => "/SwaggerControllerApi/content-visualization?encodedToken=$token";

static  downloadFile(String fileId , String fileType) => "/SwaggerControllerApi/download?fileId=$fileId&fileType=$fileType";


}