// Reply message with Telegram Bot API
// Store received message into Google Sheet using Google App Script
// Michael Tam, 2022

var token       = "<<TOKEN>>"; 
var telegramUrl = "https://api.telegram.org/bot" + token;
var webAppUrl   = "https://script.google.com/macros/s/<<URL>>/exec";
var sheetId     = "<<SHEETID>>";
var sheetName   = "Received Message";

function setWebhook() {
var url = telegramUrl + "/setWebhook?url=" + webAppUrl;
var response = UrlFetchApp.fetch(url);
}

function getWebhookinfo() {
var url = telegramUrl + "/getWebhookInfo";
var response = UrlFetchApp.fetch(url);
  Logger.log(response.getContentText());
}

function sendMessage(chat_id, text) {
var url = telegramUrl + "/sendMessage?chat_id=" + chat_id + "&text="+ text;
var response = UrlFetchApp.fetch(url);
Logger.log(response.getContentText()); 
}

function doPost(e){
  var estringa = JSON.parse(e.postData.contents);
  var d = new Date();
  var e = estringa.message.from.id;
  var f = estringa.message.text;
  var g = f.split(",");
  var SpreadSheet = SpreadsheetApp.openById(sheetId);
  var Sheet = SpreadSheet.getSheetByName(sheetName);
  var LastRow = Sheet.getLastRow();
  Sheet.getRange(LastRow+1, 1).setValue(d);
  Sheet.getRange(LastRow+1, 2).setValue(e);
  Sheet.getRange(LastRow+1, 3).setValue(g[0]);
  Sheet.getRange(LastRow+1, 4).setValue(g[1]);
  Sheet.getRange(LastRow+1, 5).setValue(g[2]);
  Sheet.getRange(LastRow+1, 6).setValue(g[3]);  
  //Sheet.getRange(LastRow+1, 4).setValue(estringa);
  //Sheet.getRange(LastRow+1, 3).setValue(f);
  var text = "Beep boop bop, message received2.";
  sendMessage(e,text)
}
