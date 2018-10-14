<%@ page language="java" import="java.util.*,java.io.*"
contentType="text/html;charset=utf-8"%>
<!DOCTYPE html>
<html><head><title>Rich Text Editing</title></head>
<body>
  <div class="editable" id="richedit" contenteditable="true" style="padding:10px; width:400px; height:200px; border:solid 1px black;">
  </div><br>
  <input type="button" value="斜体" onclick="italic()">
  <input type="button" value="颜色" onclick="forecolor()">
  <input type="button" value="字号" onclick="fontsize()">
  <input type="button" value="图像" onclick="insertimage()">
  <input type="button" value="链接" onclick="createlink()">
  <input type="button" value="撤销" onclick="undo()">
  <input type="button" value="代码" onclick="show()">
  <script>
    function italic() {
      document.execCommand("italic", false, null);
    }
    function forecolor() {
      document.execCommand("forecolor", false, "red");
    }
    function fontsize() {
      document.execCommand("fontsize", false, 7);
    }
    function insertimage() {
      document.execCommand("insertimage", false, "images/home.gif");
    }
    function createlink() {
      document.execCommand("createlink", false, "http://www.sysu.edu.cn");
    }
    function undo() {
      document.execCommand("undo", false, null);
    }
    function show() {
      var o = document.getElementById("richedit");
      alert(o.innerHTML);
    }
  </script>
</body>
</html>