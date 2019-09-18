<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="my.aspx.cs" Inherits="WaterTree.Admin.my" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
    <title>Document</title>
</head>
<body style="background: #f5f5f5;">
 <form id="form1" runat="server">
<!--主体部分开始-->
<div class="my">
    <a href="myInfo.html" style="display: block;">
        <div class="my-head">
            <div class="my-head-tou">
                <img src="../img/cat.jpg" alt="">
                <div class="nickname">
                    <span>刘映红</span>
                    <span>3</span>
                    <span>(党员)</span>
                </div>
            </div>
        </div>
    </a>
    <div class="my-nav1">
        <ul>
            <li>
                <a href="./passwordEdit.html">
                    <img src="../img/my1.png" alt="">
                    <span>修改密码</span>
                </a>
            </li>
            <li>
                <a href="messageList.aspx">
                    <img src="../img/my3.png" alt="">
                    <span>我的消息</span>
                </a>
            </li>
        </ul>
    </div>
    <ul class="mui-table-view">
        <li class="mui-table-view-cell">
            <a class="mui-navigate-right" href="helpList.aspx">
                <img src="../img/my4.png" alt=""><span>使用帮助</span>
            </a>
        </li>
        <li class="mui-table-view-cell">
            <a class="mui-navigate-right" href="feedbackList.aspx">
                <img src="../img/my5.png" alt=""><span>建议反馈</span>
            </a>
        </li>
        <li class="mui-table-view-cell">
            <a class="mui-navigate-right" href="about.aspx">
                <img src="../img/my6.png" alt=""><span>关于我们</span>
            </a>
        </li>
    </ul>
</div>
<!--主体部分结束-->

<!--底部部分开始-->
<div style="height: .50rem;"></div>
<nav class="mui-bar mui-bar-tab">
    <a class="mui-tab-item" href="./index.html">
        <span class="mui-icon iconfont icon-shouye"></span>
        <span class="mui-tab-label">首页</span>
    </a>
    <a class="mui-tab-item" href="taskList.aspx">
        <span class="mui-icon iconfont icon-kaoherenwujihua"></span>
        <span class="mui-tab-label">活动管理</span>
    </a>
    <a class="mui-tab-item" href="./treeCareList.html">
        <span class="mui-icon iconfont icon-shu"></span>
        <span class="mui-tab-label">树木信息</span>
    </a>
    <a class="mui-tab-item mui-active" href="my.aspx">
        <span class="mui-icon iconfont icon-geren"></span>
        <span class="mui-tab-label">我的</span>
    </a>
</nav>
       </form>
<!--底部部分结束-->
</body>
</html>

