//  服务器地址
const serviceUrl = 'http://luggage.vipgz2.idcfengye.com/';
//  树莓派地址
const raspiUrl = 'http://raspi.vipgz4.idcfengye.com/luggage/';
//  Mock地址
const testUrl =
    'http://mengxuegu.com:7300/mock/5dc61dbb8e0caf01d45a62eb/luggage/';

const servicePath = {
  'login': serviceUrl + 'user/userLogin', //用户登陆接口
  'getuser': serviceUrl + 'user/getdata', //使用token获取用户信息
  'checkToken': serviceUrl + 'user/checkToken', //验证token是否过期
  'getClerkOrder': serviceUrl + 'record/ByReceiverName', //通过行李员姓名获取所有订单
  'getOrderByPhone': serviceUrl + 'record/ByPhonenumber', //通过客户手机号获取所有订单
  'addHotelDeposit': serviceUrl + 'statistics/Addhotelweeksave', //添加酒店寄存数据
  'addHotelReceive': serviceUrl + 'statistics/Addhotelweekgiver', //添加酒店领取数据
  'addClerkDeposit': serviceUrl + 'statistics/AddrecData', //添加行李员寄存数据
  'addClerkReceive': serviceUrl + 'statistics/AddGiverdata', //添加行李员领取数据
  'hotelWeekOrder': serviceUrl + 'statistics/weektog', //酒店一周订单
  'getHotelDeposit': serviceUrl + 'statistics/gethotelrecdata', //获取酒店每日寄存数
  'getHotelReceive': serviceUrl + 'statistics/gethotelgivdata', //获取酒店每日领取数
  'clerkWeekOrder': serviceUrl + 'statistics/weekcount_tog', //行李员一周订单
  'getClerkDeposit': serviceUrl + 'statistics/getrecdata', //获取行李员每日寄存数
  'getClerkReceive': serviceUrl + 'statistics/getgivdata', //获取行李员每日领取数
  'neworder': serviceUrl + 'luggage/neworder', //创建行李寄存订单
  'getluggage': serviceUrl + 'luggage/getluggage', //领取行李订单
  'sendCode': serviceUrl + 'user/sendLoginMsg', //发送验证码(通过手机号登陆)
  'codeLogin': serviceUrl + 'user/loginByMsg', //通过验证码登陆
  'getSaver': serviceUrl + 'record/BySaverid',  //通过ID获取寄存者信息
  'getLuggage': serviceUrl + 'record/ByLuggageid',  //通过ID获取行李信息
  'resetPassword': serviceUrl + 'user/updatepassword',  //修改密码接口
  'updateMsg': serviceUrl + 'user/update',  //用户修改信息接口
  'getApk': serviceUrl + 'ota/getOta',  //获取apk接口
};
