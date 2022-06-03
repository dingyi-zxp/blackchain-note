# 食品溯源总结
## 智能合约


## vue

### 获取数据
从Java后端获取数据，通过`axios`,get 和 post 获取数据或发送数据
#### axios
```js
axios({
  methods: 'get',
  url:'xxx',
  data:{
    element: 'value'
  }
})
.then(res => {
	...
})
```

- methods: 请求方法
- url: 请求的链接
- data：携带参数

[axios文档](https://axios-http.com/)


## java
### 跨域问题
```java
@CrossOrigin(value = "http://localhost:8081")
```
### 初始化 
```java
  //填写WeBASE-Front地址，用于后续交互
    private static final String URL = "http://47.93.57.119:5002/WeBASE-Front/trans/handle1";

    private static final String CONTRACT_NAME = "Trace";
    private static final String CONTRACT_ADDRESS = "0xebb45a4f36c9be79f3d170d1153e4e4e1cf7e0ce";
    private static final String CONTRACT_ABI = "[{\"constant\":true,\"inputs\":
    ...";

    //填写用户地址信息
    private static final String PRODUCER_ADDRESS = "0x4ea15b9038bd2936d321e80ab234b0d08e1606fc";
    private static final String DISTRIBUTOR_ADDRESS = "0x172bccef37a3fdb76f3a961bad2054430e6c653b";
    private static final String RETAILER_ADDRESS = "0x89ea7d04ab7b06fc1d0eee46bd8ba94448cee611";
```

1. 设置webase 的url地址
2. 合约名称
3. 合约地址
4. ABI
5. 用户地址

### 调用合约
#### 接收前端的数据
```java
@ResponseBody
@PostMapping(path = "/addretail", produces = MediaType.APPLICATION_JSON_VALUE)
public String add_trace_by_retailer(@RequestBody JSONObject jsonParam) {
	...
	String trace_number = (String) jsonParam.get("traceNumber");
  String trace_name = (String) jsonParam.get("traceName");
  int quality = (int) jsonParam.get("quality");
  
  JSONArray params = JSONUtil.parseArray("["+trace_number+",\""+trace_name+"\","+quality+"]");
	String responseStr = httpPost(DISTRIBUTOR_ADDRESS,"addTraceInfoByDistributor",params);
  JSONObject responseJsonObj = JSONUtil.parseObj(responseStr);
  
  String msg = responseJsonObj.getStr("message");
  if (msg.equals("Success")){
    _outPutObj.set("ret",1);
    _outPutObj.set("msg",msg);
  }else{
    _outPutObj.set("ret",0);
    _outPutObj.set("msg",msg);
  }
}
```



- @RequestBody JSONObject jsonParam 接收前端传过来的JSON数据
- (类型) jsonParam.get("传过来的参数")
- params 格式化参数为JSON数组

#### 发送数据
```java
private String httpPost(String address, String funcName, List funcParam) {
  JSONObject _jsonObj = new JSONObject();
  _jsonObj.set("contractName",CONTRACT_NAME);
  _jsonObj.set("contractAddress",CONTRACT_ADDRESS);
  _jsonObj.set("contractAbi",JSONUtil.parseArray(CONTRACT_ABI));
  _jsonObj.set("user",address);
  _jsonObj.set("funcName",funcName);
  _jsonObj.set("funcParam",funcParam);
  _jsonObj.set("groupId",1);
  _jsonObj.set("useCns",false);

  String dataString = JSONUtil.toJsonStr(_jsonObj);
  String responseBody = HttpRequest.post(URL)
  .header(Header.CONTENT_TYPE, "application/json").body(dataString).execute().body();
  System.out.println(responseBody);
  return responseBody;
}
```
##### 格式化参数
- 合约名称
- 合约地址
- ABI
- 用户地址
- 方法名称
- 方法参数（JSON 格式）
- 组别
- useCns 未知
- JSON转换成string

##### 发送请求
`HttpRequest.post(URL).header(Header.CONTENT_TYPE, "application/json").body(dataString).execute().body();`

#### 发送参数获取数据
转换为JSON Array类型使用自定义的httpPost 函数进行发送请求
