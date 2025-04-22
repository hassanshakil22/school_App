const baseURL = "http://10.0.2.2:8080/api";


class ApiUrls {
//post
static const studentLogin = "/SwaggerControllerApi/student-login";


//get
static const getContent = "/SwaggerControllerApi/content-visualization";

static  downloadFile(String fileId , String fileType) => "/SwaggerControllerApi/download?fileId=$fileId&fileType=$fileType";


}