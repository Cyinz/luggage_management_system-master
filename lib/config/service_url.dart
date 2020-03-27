//  服务器地址
const serviceUrl = 'http://luggage.vipgz2.idcfengye.com/';
//  Mock地址
const testUrl =
    'http://mengxuegu.com:7300/mock/5dc61dbb8e0caf01d45a62eb/luggage/';

const servicePath = {
  'login': serviceUrl + 'user/userLogin',   //用户登陆接口
  'getuser': serviceUrl + 'user/getdata',   //使用token获取用户信息
  'checkToken': serviceUrl + 'user/checkToken',   //验证token是否过期
  'getClerkOrder': testUrl + 'record/ByReceiverName',   //获取行李员历史订单
  'hotelWeekOrder': testUrl + 'statistics/weektog',   //酒店一周订单
  'clerkWeekOrder': testUrl + 'statistics/weekcount_tog',    //行李员一周订单
  'neworder': serviceUrl + 'luggage/neworder',    //创建行李寄存订单
};