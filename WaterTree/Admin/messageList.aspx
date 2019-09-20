<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="messageList.aspx.cs" Inherits="WaterTree.Admin.messageList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Document</title>

</head>
<body style="background: #f5f5f5">
     <form id="form1" runat="server">
<!--主体部分开始-->
<div class="treeCareDetail messageList">
    <div id="segmentedControl" class="mui-segmented-control">
        <a class="mui-control-item mui-active" href="#item1">
            全部
        </a>
        <a class="mui-control-item" href="#item2">
            未读
        </a>
        <a class="mui-control-item" href="#item3">
            已读
        </a>
        <a class="mui-control-item" href="#item4">
            已发送
        </a>
        <a href="messageAdd.aspx">
            <span>发布</span>
        </a>
    </div>
    <div style="margin-top: .44rem;">
        <div id="item1" class="mui-active mui-control-content">
            <ul id="OA_task_1" class="mui-table-view">
            </ul>
        </div>
        <div id="item2" class="mui-control-content">
            <ul id="OA_task_2" class="mui-table-view">

            </ul>
        </div>
        <div id="item3" class="mui-control-content">
            <ul id="OA_task_3" class="mui-table-view">
                
            </ul>
        </div>
        <div id="item4" class="mui-control-content">
            <ul id="OA_task_4" class="mui-table-view">
                 
            </ul>
        </div>
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
<script>


    layui.use('flow', function () {
        var flow = layui.flow;
        flow.lazyimg();
        flow.load({
            elem: '#OA_task_1', //流加载容器
            isAuto: false,
            done: function (page, next) { //执行下一页的回调
                //模拟数据插入
                var lis = [];
                var  pages=0;
                setTimeout(function () {
                    $.ajax({
                        type: "get",
                        async: false,
                        url: "/Admin/GetData.ashx?action=GetAllMessageList",
                        data: {
                            'UserName':'刘映红',
                            'Page': page
                        },
                        dataType: "json",
                        success: function (params) {
                            var list = params.data;
                            pages = params.code;
                            for (var i = 0; i < list.length; i++) {
                                var message = list[i];
                                SendDateTime = GetTimeFormat(message.SendDateTime);
                                lis.push(`<li class="mui-table-view-cell message-item">
                                        <div class="mui-slider-right mui-disabled">
                                            <a class="mui-btn mui-btn-yellow mui-icon" style="transform: translate(0px, 0px);"><span class="font14">标记已读</span></a>
                                            <a class="mui-btn mui-btn-red mui-icon" style="transform: translate(-75px, 0px);"><span class="font14">删除</span></a>
                                        </div>
                                        <div class ="mui-slider-handle" onclick= "window.top.location.href = './messageDetail.aspx?ID=`+ message.id+`'" >
                                            <div class="mui-table-cell">
                                                <div class="logo">
                                                    <img src="../img/mes1.png" alt="">
                                                    <span style = "background: `+ message.statusColor+`;" ></span>
                                                </div>
                                                <div class="info">
                                                    <h6>
                                                        <span> `+message.MessageType+` </span>
                                                        <span>`+SendDateTime+`</span>
                                                    </h6>
                                                    <p> `+message.MsgText+` </p>
                                                </div>
                                            </div>
                                        </div>
                                    </li>`)
                            }
                        },
                        error: function (errmsg) {
                            alert("Ajax获取服务器数据出错了！" + errmsg);
                        }
                    });
                   
                    // 执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
                    // pages为Ajax返回的总页数，只有当前页小于总页数的情况下，才会继续出现加载更多
                    next(lis.join(''), page < pages); //假设总页数为 10
                }, 100);
            }
        });
        flow.load({
            elem: '#OA_task_2', //流加载容器
            done: function (page, next) { //执行下一页的回调
                //模拟数据插入
                var lis = [];
                var pages = 0;
                setTimeout(function () {
                    $.ajax({
                        type: "get",
                        async: false,
                        url: "/Admin/GetData.ashx?action=GetNotReadMessageList",
                        data: {
                            'UserName': '刘映红',
                            'Page': page
                        },
                        dataType: "json",
                        success: function (params) {
                            var list = params.data;
                            pages = params.code;
                            for (var i = 0; i < list.length; i++) {
                                var message = list[i];
                                SendDateTime = GetTimeFormat(message.SendDateTime);
                                lis.push(`<li class="mui-table-view-cell message-item">
                                        <div class="mui-slider-right mui-disabled">
                                            <a class="mui-btn mui-btn-yellow mui-icon" style="transform: translate(0px, 0px);"><span class="font14">标记已读</span></a>
                                            <a class="mui-btn mui-btn-red mui-icon" style="transform: translate(-75px, 0px);"><span class="font14">删除</span></a>
                                        </div>
                                        <div class ="mui-slider-handle" onclick= "window.top.location.href = './messageDetail.aspx?ID=`+ message.id+`'" >
                                            <div class="mui-table-cell">
                                                <div class="logo">
                                                    <img src="../img/mes1.png" alt="">
                                                    <span style = "background: `+ message.statusColor+`;" ></span>
                                                </div>
                                                <div class="info">
                                                    <h6>
                                                        <span> `+ message.MessageType + ` </span>
                                                        <span>`+ SendDateTime + `</span>
                                                    </h6>
                                                    <p> `+ message.MsgText + ` </p>
                                                </div>
                                            </div>
                                        </div>
                                    </li>`)
                            }
                        },
                        error: function (errmsg) {
                            alert("Ajax获取服务器数据出错了！" + errmsg);
                        }
                    });

                    // 执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
                    // pages为Ajax返回的总页数，只有当前页小于总页数的情况下，才会继续出现加载更多
                    next(lis.join(''), page < pages); //假设总页数为 10
                }, 100);
            }
        });
        flow.load({
            elem: '#OA_task_3', //流加载容器
            done: function (page, next) { //执行下一页的回调
                //模拟数据插入
                var lis = [];
                var pages = 0;
                setTimeout(function () {
                    $.ajax({
                        type: "get",
                        async: false,
                        url: "/Admin/GetData.ashx?action=GetReadMessageList",
                        data: {
                            'UserName': '刘映红',
                            'Page': page
                        },
                        dataType: "json",
                        success: function (params) {
                            var list = params.data;
                            pages = params.code;
                            for (var i = 0; i < list.length; i++) {
                                var message = list[i];
                                SendDateTime = GetTimeFormat(message.SendDateTime);
                                lis.push(`<li class="mui-table-view-cell message-item">
                                        <div class="mui-slider-right mui-disabled">
                                            <a class="mui-btn mui-btn-yellow mui-icon" style="transform: translate(0px, 0px);"><span class="font14">标记已读</span></a>
                                            <a class="mui-btn mui-btn-red mui-icon" style="transform: translate(-75px, 0px);"><span class="font14">删除</span></a>
                                        </div>
                                        <div class ="mui-slider-handle" onclick= "window.top.location.href = './messageDetail.aspx?ID=`+ message.id+`'" >
                                            <div class="mui-table-cell">
                                                <div class="logo">
                                                    <img src="../img/mes1.png" alt="">
                                                    <span style = "background: `+ message.statusColor+`;" ></span>
                                                </div>
                                                <div class="info">
                                                    <h6>
                                                        <span> `+ message.MessageType + ` </span>
                                                        <span>`+ SendDateTime + `</span>
                                                    </h6>
                                                    <p> `+ message.MsgText + ` </p>
                                                </div>
                                            </div>
                                        </div>
                                    </li>`)
                            }
                        },
                        error: function (errmsg) {
                            alert("Ajax获取服务器数据出错了！" + errmsg);
                        }
                    });

                    // 执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
                    // pages为Ajax返回的总页数，只有当前页小于总页数的情况下，才会继续出现加载更多
                    next(lis.join(''), page < pages); //假设总页数为 10
                }, 100);
            }
        });
        flow.load({
            elem: '#OA_task_4', //流加载容器
            done: function (page, next) { //执行下一页的回调
                //模拟数据插入
                var lis = [];
                var pages = 0;
                setTimeout(function () {
                    $.ajax({
                        type: "get",
                        async: false,
                        url: "/Admin/GetData.ashx?action=GetMySendMessageList",
                        data: {
                            'UserName': '刘映红',
                            'Page': page
                        },
                        dataType: "json",
                        success: function (params) {
                            var list = params.data;
                            pages = params.code;
                            for (var i = 0; i < list.length; i++) {
                                var message = list[i];
                                SendDateTime = GetTimeFormat(message.SendDateTime);
                                lis.push(`<li class="mui-table-view-cell message-item">
                                        <div class="mui-slider-right mui-disabled">
                                            <a class="mui-btn mui-btn-yellow mui-icon" style="transform: translate(0px, 0px);"><span class="font14">标记已读</span></a>
                                            <a class="mui-btn mui-btn-red mui-icon" style="transform: translate(-75px, 0px);"><span class="font14">删除</span></a>
                                        </div>
                                        <div class ="mui-slider-handle" onclick= "window.top.location.href = './messageDetail.aspx?ID=`+ message.id + `'" >
                                            <div class="mui-table-cell">
                                                <div class="logo">
                                                    <img src="../img/mes1.png" alt="">
                                                    <span style = "background: `+ message.statusColor+`;" ></span>
                                                </div>
                                                <div class="info">
                                                    <h6>
                                                        <span> `+ message.MessageType + ` </span>
                                                        <span>`+ SendDateTime + `</span>
                                                    </h6>
                                                    <p> `+ message.MsgText + ` </p>
                                                </div>
                                            </div>
                                        </div>
                                    </li>`)
                            }
                        },
                        error: function (errmsg) {
                            alert("Ajax获取服务器数据出错了！" + errmsg);
                        }
                    });

                    // 执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
                    // pages为Ajax返回的总页数，只有当前页小于总页数的情况下，才会继续出现加载更多
                    next(lis.join(''), page < pages); //假设总页数为 10
                }, 100);
            }
        });
    });

    (function ($) {
        var btnArray = ['确认', '取消'];
        $('#OA_task_1').on('tap', '.mui-btn-red', function(event) {
            var elem = this;
            var li = elem.parentNode.parentNode;
            mui.confirm('确认删除该条记录？', '提示', btnArray, function(e) {
                if (e.index == 0) {
                    li.parentNode.removeChild(li);
                } else {
                    setTimeout(function() {
                        $.swipeoutClose(li);
                    }, 0);
                }
            });
        });
        $('#OA_task_2').on('tap', '.mui-btn-red', function(event) {
            var elem = this;
            var li = elem.parentNode.parentNode;
            mui.confirm('确认删除该条记录？', '提示', btnArray, function(e) {
                if (e.index == 0) {
                    li.parentNode.removeChild(li);
                } else {
                    setTimeout(function() {
                        $.swipeoutClose(li);
                    }, 0);
                }
            });
        });
        $('#OA_task_3').on('tap', '.mui-btn-red', function(event) {
            var elem = this;
            var li = elem.parentNode.parentNode;
            mui.confirm('确认删除该条记录？', '提示', btnArray, function(e) {
                if (e.index == 0) {
                    li.parentNode.removeChild(li);
                } else {
                    setTimeout(function() {
                        $.swipeoutClose(li);
                    }, 0);
                }
            });
        });
        $('#OA_task_4').on('tap', '.mui-btn-red', function(event) {
            var elem = this;
            var li = elem.parentNode.parentNode;
            mui.confirm('确认删除该条记录？', '提示', btnArray, function(e) {
                if (e.index == 0) {
                    li.parentNode.removeChild(li);
                } else {
                    setTimeout(function() {
                        $.swipeoutClose(li);
                    }, 0);
                }
            });
        });
    })(mui);
    function GetTimeFormat(Time) {
        var date = new Date(Time);
        var year = date.getFullYear();//获取当前年
        var month = date.getMonth() + 1;//获取当前月
        var day = date.getDate();//获取当前日
        var time = year + "-" + month + "-" + day;
        return time;
    }
   
</script>
</body>
</html>
