/*
 * Copyright (c) 2015, Majenko Technologies
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * * Redistributions of source code must retain the above copyright notice, this
 *   list of conditions and the following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above copyright notice, this
 *   list of conditions and the following disclaimer in the documentation and/or
 *   other materials provided with the distribution.
 *
 * * Neither the name of Majenko Technologies nor the names of its
 *   contributors may be used to endorse or promote products derived from
 *   this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/* Create a WiFi access point and provide a web server on it. */

#include <ESP8266WiFi.h>
#include <WiFiClient.h>
#include <ESP8266WebServer.h>

#include "BH1750.h"

extern "C" {
#include "user_interface.h"
}

int lux;
/* Set these to your desired credentials. */
const char *ssid = "ESPap";
const char *password = "thereisnospoon";

ESP8266WebServer server(80);
BH1750 lightMeter;
String webSite,javaScript,XML;
ADC_MODE(ADC_VCC);
/* Just a little test message.  Go to http://192.168.4.1 in a web browser
 * connected to this access point to see it.
 */


void buildJavascript(){
  javaScript="<SCRIPT>\n";
  javaScript+="var xmlHttp=createXmlHttpObject();\n";

  javaScript+="function createXmlHttpObject(){\n";
  javaScript+=" if(window.XMLHttpRequest){\n";
  javaScript+="    xmlHttp=new XMLHttpRequest();\n";
  javaScript+=" }else{\n";
  javaScript+="    xmlHttp=new ActiveXObject('Microsoft.XMLHTTP');\n";
  javaScript+=" }\n";
  javaScript+=" return xmlHttp;\n";
  javaScript+="}\n";

  javaScript+="function process(){\n";
  javaScript+=" if(xmlHttp.readyState==0 || xmlHttp.readyState==4){\n";
  javaScript+="   xmlHttp.open('PUT','xml',true);\n";
  javaScript+="   xmlHttp.onreadystatechange=handleServerResponse;\n"; // no brackets?????
  javaScript+="   xmlHttp.send(null);\n";
  javaScript+=" }\n";
  javaScript+=" setTimeout('process()',1000);\n";
  javaScript+="}\n";

  javaScript+="function handleServerResponse(){\n";
  javaScript+=" if(xmlHttp.readyState==4 && xmlHttp.status==200){\n";
  javaScript+="   xmlResponse=xmlHttp.responseXML;\n";

  javaScript+="   xmldoc = xmlResponse.getElementsByTagName('response');\n";
  javaScript+="   message = xmldoc[0].firstChild.nodeValue;\n";
  javaScript+="   document.getElementById('runtime').innerHTML=message;\n";

  javaScript+="   xmldoc = xmlResponse.getElementsByTagName('fHeap_xml');\n";
  javaScript+="   message = xmldoc[0].firstChild.nodeValue;\n";
  javaScript+="   document.getElementById('fHeap').innerHTML=message;\n";

  javaScript+="   xmldoc = xmlResponse.getElementsByTagName('chID_xml');\n";
  javaScript+="   message = xmldoc[0].firstChild.nodeValue;\n";
  javaScript+="   document.getElementById('chid').innerHTML=message;\n";

  javaScript+="   xmldoc = xmlResponse.getElementsByTagName('chSize_xml');\n";
  javaScript+="   message = xmldoc[0].firstChild.nodeValue;\n";
  javaScript+="   document.getElementById('chSize').innerHTML=message;\n";

  javaScript+="   xmldoc = xmlResponse.getElementsByTagName('chSpeed_xml');\n";
  javaScript+="   message = xmldoc[0].firstChild.nodeValue;\n";
  javaScript+="   document.getElementById('chSpeed').innerHTML=message;\n";

  javaScript+="   xmldoc = xmlResponse.getElementsByTagName('Vcc_xml');\n";
  javaScript+="   message = xmldoc[0].firstChild.nodeValue;\n";
  javaScript+="   document.getElementById('Vcc').innerHTML=message;\n";

  javaScript+="   xmldoc = xmlResponse.getElementsByTagName('Lux_xml');\n";
  javaScript+="   message = xmldoc[0].firstChild.nodeValue;\n";
  javaScript+="   document.getElementById('Lux').innerHTML=message;\n";

  javaScript+=" }\n";
  javaScript+="}\n";
  javaScript+="</SCRIPT>\n";
}

void buildWebsite(){
  buildJavascript();
  webSite="<!DOCTYPE HTML>\n";
  webSite+=javaScript;
  webSite+="<BODY onload='process()'>\n";
  webSite+="<BR>This is the ESP website ...<BR>\n";
  webSite+="Runtime = <A id='runtime'></A><BR>\n";
  webSite+="Free Heap = <A id='fHeap'></A><BR>\n";
  webSite+="Chip ID = <A id='chid'></A><BR>\n";
  webSite+="Chip Size = <A id='chSize'></A><BR>\n";
  webSite+="Chip Speed = <A id='chSpeed'></A><BR>\n";
  webSite+="Vcc = <A id='Vcc'></A><BR>\n";
  webSite+="Lux = <A id='Lux'></A><BR>\n";
  webSite+="</BODY>\n";
  webSite+="</HTML>\n";
}

String millis2time(){
  String Time="";
  unsigned long ss;
  byte mm,hh;
  delay(10);
  ss=millis()/1000;
  hh=ss/3600;
  delay(10);
  mm=(ss-hh*3600)/60;
  ss=(ss-hh*3600)-mm*60;
  if(hh<10)Time+="0";
  delay(10);
  Time+=(String)hh+":";
  if(mm<10)Time+="0";
  delay(10);
  Time+=(String)mm+":";
  if(ss<10)Time+="0";
  delay(10);
  Time+=(String)ss;
  return Time;
}

void handleWebsite(){
  buildWebsite();
  delay(10);
  server.send(200,"text/html",webSite);
}

void buildXML(){
  XML="<?xml version='1.0'?>";
  XML+="<Donnees>";
    XML+="<response>";
    XML+=millis2time();
    XML+="</response>";
    XML+="<fHeap_xml>";
    XML+=ESP.getFreeHeap();
    XML+="</fHeap_xml>";
    XML+="<chID_xml>";
    XML+=ESP.getChipId();
    XML+="</chID_xml>";
    XML+="<chSize_xml>";
    XML+=ESP.getFlashChipSize();
    XML+="</chSize_xml>";
    XML+="<chSpeed_xml>";
    XML+=ESP.getFlashChipSpeed();
    XML+="</chSpeed_xml>";
    XML+="<Vcc_xml>";
    XML+= ESP.getVcc();
    XML+="</Vcc_xml>";
    XML+="<Lux_xml>";
    XML+= lux;
    XML+="</Lux_xml>";
  XML+="</Donnees>";
}

void handleXML(){
  buildXML();
  delay(10);
  server.send(200,"text/xml",XML);
}

void setup() {
	delay(1000);
	Serial.begin(115200);
	lightMeter.begin();
	delay(1000);
	Serial.println();
	Serial.print("Configuring access point...");
	/* You can remove the password parameter if you want the AP to be open. */
	WiFi.softAP(ssid, password);

	IPAddress myIP = WiFi.softAPIP();
	Serial.print("AP IP address: ");
	Serial.println(myIP);

	server.on("/",handleWebsite);
	server.on("/xml",handleXML);

	server.begin();
	Serial.println("HTTP server started");

}

void loop() {
	lux = lightMeter.readLightLevel();
	server.handleClient();
	delay(50);
}