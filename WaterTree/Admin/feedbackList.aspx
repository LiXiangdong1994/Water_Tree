<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="feedbackList.aspx.cs" Inherits="WaterTree.Admin.feedbackList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
        <style>
        .feedbackList .feed-bottom {
    height: 0.14rem;
}
    </style>
</head>
<body style="background: #f5f5f5">
    <form id="form1" runat="server">
   <div class="treeCareDetail messageList feedbackList">
    <div id="segmentedControl" class="mui-segmented-control">
        <a class="mui-control-item mui-active" href="#item1">
            全部
        </a>
        <a class="mui-control-item" href="#item2">
            已回复 
        </a>
        <a class="mui-control-item" href="#item3">
           未回复
        </a>
        <a class="mui-control-item" href="#item4">
            其他
        </a>
        <a href="./feedbackAdd.aspx">
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
           done: function (page, next) { //执行下一页的回调
               //模拟数据插入
               var lis = [];
               var pages = 0;
               setTimeout(function () {
                   $.ajax({
                       type: "get",
                       async: false,
                       url: "/Admin/GetData.ashx?action=GetAllSuggestList",
                       data: {
                           'Page': page
                       },
                       dataType: "json",
                       success: function (params) {
                           var list = params.data;
                           pages = params.code;
                           for (var i = 0; i < list.length; i++) {
                               var suggest = list[i];
                               var commitDate = GetTimeFormat(suggest.commitDate);
                               lis.push(`<li class="mui-table-view-cell">
                                        <div class="mui-slider-right mui-disabled">
                                            <a class="mui-btn mui-btn-red mui-icon" style="transform: translate(0px, 0px);"><span class="font14">删除</span></a>
                                        </div>
                                        <div class ="mui-slider-handle" onclick= "window.top.location.href = './feedbackDetail.aspx?ID=`+ suggest.id+`'" >
                                            <div class="mui-table-cell">
                                                <div class="feed-top">
                                                    <img src="img/feed.png" alt="">
                                                    <span class ="title"> `+suggest.title+` </span>
                                                    <span class ="type" style = "background: `+ suggest.statusColor+`;" > `+suggest.reply+` </span>
                                                    <span class ="time"> `+commitDate+` </span>
                                                </div>
                                                <div class="feed-bottom">
                                                   ` +suggest.suggest+`
                                                </div>
                                            </div>
                                        </div>
                                    </li>`)
                           }
                           var list = $(".type");
                           //for (var i = 0; i < list.length; i++) {
                           //    alert(list[i].innerHTML)

                           //    if (list[i].innerHTML=="未回复") {
                           //        list[i].style.background = "#C7C7CC";
                           //    }
                           //}
                       },
                       error: function (errmsg) {
                           alert("Ajax获取服务器数据出错了！" + errmsg);
                       }
                   });

                   // 执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
                   // pages为Ajax返回的总页数，只有当前页小于总页数的情况下，才会继续出现加载更多
                   next(lis.join(''), page < pages); //假设总页数为 10
               }, 100);
               //
              
           }

       });

       flow.load({
           elem: '#OA_task_2', //流加载容器
           done: function (page, next) { //执行下一页的回调
               var lis = [];
               var pages = 0;
               setTimeout(function () {
                   $.ajax({
                       type: "get",
                       async: false,
                       url: "/Admin/GetData.ashx?action=GetNotReplySuggestList",
                       data: {
                           'Page': page
                       },
                       dataType: "json",
                       success: function (params) {
                           var list = params.data;
                           pages = params.code;
                           for (var i = 0; i < list.length; i++) {
                               var suggest = list[i];
                               var commitDate = GetTimeFormat(suggest.commitDate);
                               lis.push(`<li class="mui-table-view-cell">
                                        <div class="mui-slider-right mui-disabled">
                                            <a class="mui-btn mui-btn-red mui-icon" style="transform: translate(0px, 0px);"><span class="font14">删除</span></a>
                                        </div>
                                        <div class ="mui-slider-handle" onclick= "window.top.location.href = './feedbackDetail.aspx?ID=`+ suggest.id+`'" >
                                            <div class="mui-table-cell">
                                                <div class="feed-top">
                                                    <img src="img/feed.png" alt="">
                                                    <span class ="title"> `+ suggest.title + ` </span>
                                                    <span class ="type" style = "background: `+ suggest.statusColor+`;" > `+ suggest.reply + ` </span>
                                                    <span class ="time"> `+commitDate + ` </span>
                                                </div>
                                                <div class="feed-bottom">
                                                   ` + suggest.suggest + `
                                                </div>
                                            </div>
                                        </div>
                                    </li>`)
                               //if (suggest.reply == "未回复") {
                               //    $(this).(".type")
                               //}
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
               var lis = [];
               var pages = 0;
               setTimeout(function () {
                   $.ajax({
                       type: "get",
                       async: false,
                       url: "/Admin/GetData.ashx?action=GetReplySuggestList",
                       data: {
                           'Page': page
                       },
                       dataType: "json",
                       success: function (params) {
                           var list = params.data;
                           pages = params.code;
                           for (var i = 0; i < list.length; i++) {
                               var suggest = list[i];
                               var commitDate = GetTimeFormat(suggest.commitDate);
                               lis.push(`<li class="mui-table-view-cell">
                                        <div class="mui-slider-right mui-disabled">
                                            <a class="mui-btn mui-btn-red mui-icon" style="transform: translate(0px, 0px);"><span class="font14">删除</span></a>
                                        </div>
                                        <div class ="mui-slider-handle" onclick= "window.top.location.href = './feedbackDetail.aspx?ID=`+ suggest.id+`'" >
                                            <div class="mui-table-cell">
                                                <div class="feed-top">
                                                    <img src="img/feed.png" alt="">
                                                    <span class ="title"> `+ suggest.title + ` </span>
                                                    <span class ="type" style = "background: `+ suggest.statusColor+`;" > `+ suggest.reply + ` </span>
                                                    <span class ="time"> `+ commitDate + ` </span>
                                                </div>
                                                <div class="feed-bottom">
                                                   ` + suggest.suggest + `
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
<script>

</script>