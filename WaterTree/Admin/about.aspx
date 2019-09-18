<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="about.aspx.cs" Inherits="WaterTree.Admin.about" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
<!--主体部分开始-->
<div class="about">
    <div class="about-logo">
        <img src="img/logo.png" alt=""/>
    </div>
    <div class="about-title">
        植树活动管理系统
    </div>
    <div class="about-version">
        Version 1.0.1
    </div>
    <div class="about-copy">
        水乡特色发展经济区管理委员会 版权所有<br/>
        Copyright @ 2011 - 2019 Tencent.All Rights Reserved
    </div>
</div>
<!--主体部分结束-->

<!--底部部分开始-->
<div style="height: .45rem"></div>
<div class="n-footer">
    <span class="mui-icon mui-icon-arrowleft" onclick="window.history.go(-1)"></span>
    <span class="mui-icon mui-icon-arrowright" onclick="window.history.go(1)"></span>
</div>
<!--底部部分结束-->
    </form>
</body>
</html>
