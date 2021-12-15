import 'package:flutter/material.dart';
import 'pay'


PaytmPGService Service = PaytmPGService.getStagingService();


Map<String, String> paramMap = new HashMap<String,String>();
paramMap.put( "MID" , "mtBctO03532455133594");
// Key in your staging and production MID available in your dashboard
paramMap.put( "ORDER_ID" , "order1");
paramMap.put( "CUST_ID" , "cust123");
paramMap.put( "MOBILE_NO" , "7777777777");
paramMap.put( "EMAIL" , "username@emailprovider.com");
paramMap.put( "CHANNEL_ID" , "WAP");
paramMap.put( "TXN_AMOUNT" , "100.12");
paramMap.put( "WEBSITE" , "WEBSTAGING");
// This is the staging value. Production value is available in your dashboard
paramMap.put( "INDUSTRY_TYPE_ID" , "Retail");
// This is the staging value. Production value is available in your dashboard
paramMap.put( "CALLBACK_URL", "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=order1");
paramMap.put( "CHECKSUMHASH" , "w2QDRMgp1234567JEAPCIOmNgQvsi+BhpqijfM9KvFfRiPmGSt3Ddzw+oTaGCLneJwxFFq5mqTMwJXdQE2EzK4px2xruDqKZjHupz9yXev4=")
PaytmOrder Order = new PaytmOrder(paramMap);


Service.initialize(Order, null);


Service.startPaymentTransaction(this, true, true, new PaytmPaymentTransactionCallback() {
  /*Call Backs*/
  public void someUIErrorOccurred(String inErrorMessage) {}
  public void onTransactionResponse(Bundle inResponse) {}
  public void networkNotAvailable() {}
  public void clientAuthenticationFailed(String inErrorMessage) {}
  public void onErrorLoadingWebPage(int iniErrorCode, String inErrorMessage, String inFailingUrl) {}
  public void onBackPressedCancelTransaction() {}
  public void onTransactionCancel(String inErrorMessage, Bundle inResponse) {}
});

public void onTransactionResponse(Bundle inResponse) {
  /*Display the message as below */
  Toast.makeText(getApplicationContext(), "Payment Transaction response " + inResponse.toString(), Toast.LENGTH_LONG).show();
}

public void networkNotAvailable() {
  /*Display the message as below */
  Toast.makeText(getApplicationContext(), "Network connection error: Check your internet connectivity", Toast.LENGTH_LONG).show();
}

public void someUIErrorOccurred(String inErrorMessage) {
  /*Display the error message as below */
  Toast.makeText(getApplicationContext(), "UI Error " + inErrorMessage , Toast.LENGTH_LONG).show();
}

public void clientAuthenticationFailed(String inErrorMessage)  {
  /*Display the message as below */
  Toast.makeText(getApplicationContext(), "Authentication failed: Server error" + inResponse.toString(), Toast.LENGTH_LONG).show();
}

public void onErrorLoadingWebPage(int iniErrorCode, String inErrorMessage, String inFailingUrl)  {
  /*Display the message as below */
  Toast.makeText(getApplicationContext(), "Unable to load webpage " + inResponse.toString(), Toast.LENGTH_LONG).show();
}

public void onBackPressedCancelTransaction(){
  /*Display the message as below */
  Toast.makeText(getApplicationContext(), "Transaction cancelled" , Toast.LENGTH_LONG).show();
}

public void onTransactionCancel(String inErrorMessage, Bundle inResponse)
/*Display the message as below */
Toast.makeText(getApplicationContext(), "Transaction Cancelled" + inResponse.toString(), Toast.LENGTH_LONG).show();
}



String merchantMid = "rxazcv89315285244163";
// Key in your staging and production MID available in your dashboard
String merchantKey = "gKpu7IKaLSbkchFS";
// Key in your staging and production MID available in your dashboard
String orderId = "order1";
String channelId = "WAP";
String custId = "cust123";
String mobileNo = "7777777777";
String email = "username@emailprovider.com";
String txnAmount = "100.12";
String website = "WEBSTAGING";
// This is the staging value. Production value is available in your dashboard
String industryTypeId = "Retail";
// This is the staging value. Production value is available in your dashboard
String callbackUrl = "https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=order1";
TreeMap<String, String> paytmParams = new TreeMap<String, String>();
paytmParams.put("MID",merchantMid);
paytmParams.put("ORDER_ID",orderId);
paytmParams.put("CHANNEL_ID",channelId);
paytmParams.put("CUST_ID",custId);
paytmParams.put("MOBILE_NO",mobileNo);
paytmParams.put("EMAIL",email);
paytmParams.put("TXN_AMOUNT",txnAmount);
paytmParams.put("WEBSITE",website);
paytmParams.put("INDUSTRY_TYPE_ID",industryTypeId);
paytmParams.put("CALLBACK_URL", callbackUrl);
String paytmChecksum = CheckSumServiceHelper.getCheckSumServiceHelper().genrateCheckSum(merchantKey, paytmParams);

Endpoints:-

private final String merchantKey = "gKpu7IKaLSbkchFS";
private String paytmChecksum = null;
// Create a tree map from the form post param
TreeMap<String, String> paytmParams = new TreeMap<String, String>();
// Request is HttpServletRequest
for (Entry<String, String[]> requestParamsEntry : request.getParameterMap().entrySet()) {
if ("CHECKSUMHASH".equalsIgnoreCase(requestParamsEntry.getKey())){
paytmChecksum = requestParamsEntry.getValue()[0];
} else {
paytmParams.put(requestParamsEntry.getKey(), requestParamsEntry.getValue()[0]);
}
}
// Call the method for verification
boolean isValidChecksum = CheckSumServiceHelper.getCheckSumServiceHelper().verifycheckSum(merchantKey, paytmParams, paytmChecksum);
// If isValidChecksum is false, then checksum is not valid
if(isValidChecksum){
System.out.append("Checksum Matched");
}else{
System.out.append("Checksum MisMatch");
}