<%@ page language="java" import="java.util.*,java.sql.*"
  contentType="text/html; charset=utf-8"%>
<% request.setCharacterEncoding("utf-8");%>
<%
  String current_user_name = (String)session.getAttribute("current_user_name");
  if(current_user_name == null) current_user_name = "匿名";
%>
<!DOCTYPE html>
<html>
  <head>
    <title>WebChat</title>
    <style type="text/css">
		#ChatWindow{
		  position:fixed;
		  z-index:9999;
		  bottom:0px;
		  right:0px;
		  height: 420px;
		  width: 390px;
		  font-size: 16px;
		  line-height:normal;
		}
		
		#ChatWindow #ChatButton{
		  box-sizing: border-box;
		  font-size: 20px;
		  text-align: center;
		  padding-top: 8px;
		  width: 400px;
		  height: 40px;
		  background-color: #CCCCFF; 
		  border-radius:5px;
		  border: none;
		  color:white;
		  font-weight: bolder;
		  
		}
		#ChatWindow #ChatShow{
		  visibility:hidden;
		  background-color: rgba(250,250,255,1);
		  border: 1px solid rgba(250,250,255,1);
		  color:grey;
		  box-sizing: border-box;
		  border-radius:10px;
		  padding-left: 10px;
		  width: 400px;
		  height: 380px;
		}
		#ChatWindow #ChatShow #chat{
		  box-sizing: border-box;
		  width: 370px;
		  height:30px;
		  color:#333;
		  padding:4px 4px;
		  border-radius:3px;
		  border: 1px solid rgba(30,146,253,1.00);
		  margin-top:15px;
		}
		#ChatWindow #ChatShow #chat:focus {
		   border: 1px solid #007eff;
		   box-shadow: 0px 0px 5px #007eff;
		}
		#ChatWindow #ChatShow #console-container{
		  width: 360px;
		  margin-top:25px;
		}
		#ChatWindow #ChatShow #console-container #console{
		  box-shadow: 0px 0px 5px rgba(30,146,253,1.00);
		  border-radius:3px;
		  height: 280px;
		  overflow-y: scroll;
		  padding: 5px;
		  width: 100%;
		}
		#ChatWindow #ChatShow #console-container #console p{
		  padding: 0;
		  margin: 0;
		  font-size: 18px;
		}
    </style>
    <script type="application/javascript">
      var new_message_state = false;
      var Chat = {};
      Chat.socket = null;
      Chat.connect= (function(host) {
        if('WebSocket' in window) {
          Chat.socket = new WebSocket(host);
        } else if('MozWebSocket' in window) {
          Chat.socket = new MozWebSocket(host);
        } else{
          Console.log('Error: WebSocket is not supported by this browser.');
          return;
        }
        Chat.socket.onopen= function() {
          Console.log('Higo聊天室欢迎你的到来 o(*￣▽￣*)ブ');
          var username = "<%=current_user_name%>";
          Chat.socket.send(username);
          document.getElementById('ChatShow').style.visibility='hidden';
          document.getElementById('chat').onkeydown = function(event) {
            if(event.keyCode == 13) {
              Chat.sendMessage();
            }
          };
        };
        Chat.socket.onclose= function() {
        	document.getElementById('chat').onkeydown = null;
        	Console.log('Higo聊天室被关闭了（＞人＜；）');
        };
        Chat.socket.onmessage= function(message) {
          Console.log(message.data);
          if(new_message_state==false && document.getElementById('ChatShow').style.visibility=='hidden'){
        	  document.getElementById('ChatButton').innerHTML = '你有新的消息';
        	  new_message_state = true;
        	  twinkle();
          }
        };
      });

      Chat.initialize= function() {
        if(window.location.protocol == 'http:') {
          Chat.connect('ws://'+ window.location.host + '/15352237/chat');
        } else{
          Chat.connect('wss://'+ window.location.host + '/15352237/chat');
        }
      };
      Chat.sendMessage= (function() {
        var message = document.getElementById('chat').value;
        if(message != '') {
          Chat.socket.send(message);
          document.getElementById('chat').value = '';
        }
      });
      var Console = {};
      Console.log = (function(message) {
        var console = document.getElementById('console');
        var p = document.createElement('p');
        p.style.wordWrap = 'break-word';
        p.innerHTML = message;
        console.appendChild(p);
        while(console.childNodes.length > 25) {
          console.removeChild(console.firstChild);
        }
        console.scrollTop = console.scrollHeight;
      });
      Chat.initialize();
      document.addEventListener("DOMContentLoaded", function() {}, false);
      
      function showwindow()
      {
        if(document.getElementById('ChatShow').style.visibility!='hidden'){
          document.getElementById('ChatShow').style.visibility='hidden';
        }else{
          document.getElementById('ChatButton').style.opacity='1';
          document.getElementById('ChatShow').style.visibility='visible';
          document.getElementById('ChatButton').innerHTML = 'Higo聊天室';
          new_message_state = false;
        }
      }
      
      
      function twinkle()
      {  
        if(new_message_state)
        {  
          if(document.getElementById('ChatButton').style.opacity!='0'){
            document.getElementById('ChatButton').style.opacity='0';
          }else{
            document.getElementById('ChatButton').style.opacity='1';
          }
          window.setTimeout(twinkle, 500);
	    }else{  
	      document.getElementById('ChatButton').style.opacity='1';
	    }  
	     
	  }
    </script>
  </head>
  <body>
	<div id="ChatWindow">
		<div id="ChatShow">
		  <p>
		    <input id="chat" type="text" placeholder="Here to say hi" />
		  </p>
		  <div id="console-container">
		    <div style="font-size: 16px;" id="console"></div>
		  </div>
		</div>
		<div style="font-size: 16px;" id="ChatButton" onclick="showwindow()">
		    Higo聊天室
		</div>
	</div>
  </body>
</html>