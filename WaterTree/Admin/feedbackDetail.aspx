<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="feedbackDetail.aspx.cs" Inherits="WaterTree.Admin.feedbackDetail" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
        <form id="form1" runat="server">
<!--主体部分开始-->
  <asp:Repeater ID="suggestDetail" runat="server">
      <ItemTemplate>
<div class="treeCareCommon messageAdd feedbackDetail">
    <div class="common-type">
        <div class="public-head pt10" style="border: none;">
            <span>相关图片</span>
        </div>
        <div class="mui-input-group public-form">
            <img src= "<%#Eval("file1") %>" data-preview-src="" data-preview-group="1" alt="">
            <img src="<%#Eval("file2") %>"  data-preview-src="" data-preview-group="1" alt="">
            <img src="<%#Eval("file3") %>"  data-preview-src="" data-preview-group="1" alt="">
        </div>
    </div>
    <div class="common-info">
        <div class="public-head">
            <span>反馈内容</span>
        </div>
        <div class="feedback-info">
         <%#Eval("suggest") %>
        </div>
    </div>
    <div class="common-ping">
        <div class="public-head pt10">
            <span>领导回复</span>
        </div>
        <div class="feedback-reply">
            <div class="item">
                <div class="item-t">
                    <img src="img/cat.jpg" alt=""/>
                    <div>
                        <span> <%#Eval("replyUserName") %></span>
                        <span> <%#Eval("replyDate") %></span>
                    </div>
                </div>
                <div class="item-b">
                   <%#Eval("reply") %>
                </div>
            </div>
        </div>
    </div>
</div>
          </ItemTemplate>
  </asp:Repeater>
<!--主体部分结束-->

<!--底部部分开始-->
<div style="height: .45rem"></div>
<div class="n-footer">
    <span class="mui-icon mui-icon-arrowleft" onclick="window.history.go(-1)"></span>
    <span class="mui-icon mui-icon-arrowright" onclick="window.history.go(1)"></span>
</div>
<!--底部部分结束-->
</form>
<script>
    mui.previewImage();
</script>
</body>
</html>