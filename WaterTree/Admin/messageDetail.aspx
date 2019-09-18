<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="messageDetail.aspx.cs" Inherits="WaterTree.Admin.messageDetail" %>
<!DOCTYPE html>

<html>
<head runat="server">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <title>Document</title>
</head>
<body style="background: #f5f5f5;border-top: 1px solid #00AD48;">
       <form id="form1" runat="server">
<!--主体部分开始-->
<div class="messageDetail">
    <div class="info">
        <div class="line"></div>
         <asp:Repeater ID="MessageDetail" runat="server">
             <ItemTemplate>
                <div class="content">
                    <div class="title"><%#Eval("MessageType") %></div>
                    <div class="time"><%#Eval("SendDateTime") %></div>
                    <div class="info"><%#Eval("MsgText") %></div>
                    <div class="send">
                        <span>已发送：</span>
                        <span><%#Eval("AcceptUserName") %></span>
                    </div>
                </div>
             </ItemTemplate>
         </asp:Repeater>
    </div>
</div>
       </form>
<!--主体部分结束-->

<!--底部部分开始-->
<div style="height: .45rem"></div>
<div class="n-footer">
    <span class="mui-icon mui-icon-arrowleft" onclick="window.history.go(-1)"></span>
    <span class="mui-icon mui-icon-arrowright" onclick="window.history.go(1)"></span>
</div>
<!--底部部分结束-->
</body>
</html>
