// 服务器地址
const serviceUrl = 'http://luggage.vipgz2.idcfengye.com/';

const servicePath = {
  'login': serviceUrl + 'user/userLogin',   //用户登陆接口
  'getuser': serviceUrl + 'user/getdata',  //使用token获取用户信息
  'checkToken': serviceUrl + 'user/checkToken',   //验证token是否过期
};