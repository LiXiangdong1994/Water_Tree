<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HomePage.aspx.cs" Inherits="WaterTree.Admin.HomePage" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>首页</title>
    <link href="../css/bootstrap.min.css?v=3.3.5" rel="stylesheet"/>
    <link href="../css/font-awesome.min.css?v=4.4.0" rel="stylesheet"/>
    <!-- Morris -->
    <link href="../css/plugins/morris/morris-0.4.3.min.css" rel="stylesheet"/>
    <!-- Gritter -->
    <link href="../js/plugins/gritter/jquery.gritter.css" rel="stylesheet"/>
    <link href="../css/animate.min.css" rel="stylesheet"/>
    <link href="../css/style.min.css?v=4.0.0" rel="stylesheet"/>
    <link href="../Content/layui.css" rel="stylesheet" />
    <base target="_blank"/>
    <style>
        /*#form1 > div.wrapper.wrapper-content > div:nth-child(2),#form1 > div.wrapper.wrapper-content > div:nth-child(2) > div > div > div.ibox-content{
            height:349px;
        }*/
    </style>
</head>
<body  class="gray-bg">
    <form id="form1" runat="server">
    <div class="wrapper wrapper-content">
        <div class="row">
            <div class="col-sm-3">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span class="label label-success pull-right">月</span>
                        <h5>植树</h5>
                    </div>
                    <div class="ibox-content">
                        <h1 class="no-margins" runat="server" id="TreeNum">加载中...</h1>
                        <div class="stat-percent font-bold text-success" id="TreePercent" runat="server">加载中... <i class="fa fa-bolt"></i>
                        </div>
                        <small>占比总数</small>
                    </div>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span class="label label-info pull-right">全年</span>
                        <h5>活动数</h5>
                    </div>
                    <div class="ibox-content">
                        <h1 class="no-margins" id="TaskNum" runat="server">加载中...</h1>
                        <div class="stat-percent font-bold text-info" id="TaskPercent" runat="server">加载中... <i class="fa fa-level-up"></i>
                        </div>
                        <small>未完成</small>
                    </div>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span class="label label-primary pull-right">本月</span>
                        <h5>关注人数</h5>
                    </div>
                    <div class="ibox-content">
                        <h1 class="no-margins" id="ConcernsCount" runat="server">加载中...</h1>
                        <div class="stat-percent font-bold text-navy" id="ConcernsPercent"  runat="server">加载中<i class="fa fa-level-up"></i>
                        </div>
                        <small>新关注</small>
                    </div>
                </div>
            </div>
            <div class="col-sm-3">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <span class="label label-danger pull-right">最近一个月</span>
                        <h5>活跃用户</h5>
                    </div>
                    <div class="ibox-content">
                        <h1 class="no-margins"  id="ActiveUserCount" runat="server">加载中...</h1>
                        <div class="stat-percent font-bold text-danger" id="ActivePercent" runat="server">加载中...<i class="fa fa-level-down"></i>
                        </div>
                        <small id="Month" runat="server">12月</small>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>活动情况</h5>
                    </div>
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-9">
                                <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
                                      <ul class="layui-tab-title">
                                        <li class="layui-this">当月植树量和活动量对比</li>
                                        <li>党支部对比</li>
                                        <li>镇街对比</li>
                                        <li>树类对比</li>
                                        <li>年对比</li>
                                        <li>指定年的月份对比</li>
                                      </ul>
                                      <div class="layui-tab-content">
                                        <div class="layui-tab-item layui-show">
                                             
                                            <div class="flot-chart">
                                                <div class="flot-chart-content" id="myChart"></div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item" >党支部对比</div>
                                        <div class="layui-tab-item">镇街对比</div>
                                        <div class="layui-tab-item">树类对比</div>
                                        <div class="layui-tab-item">
                                            <div class="flot-chart">
                                                <div class="flot-chart-content" id="myChart5"></div>
                                            </div>
                                        </div>
                                        <div class="layui-tab-item">
                                            <asp:DropDownList ID="YearList" runat="server"  CssClass="Search">
                                                 <asp:ListItem  Text="2019" Selected="True"></asp:ListItem>
                                                 <asp:ListItem  Text="2018"></asp:ListItem>
                                                 <asp:ListItem  Text="2017"></asp:ListItem>
                                             </asp:DropDownList>
                                            <div class="flot-chart">
                                                 <div class="flot-chart-content" id="myChart6"></div>
                                            </div>
                                        </div>
                                      </div>
                                    </div>
                            </div> 
                                
                            <div class="col-sm-3">
                                <ul class="stat-list">
                                    <li>
                                        <h2 class="no-margins" id="TreeToal" runat="server">加载中...</h2>
                                        <small>当月植树总数</small>
                                        <div class="stat-percent" id="TreeToalPercent" runat="server">48%(未知哪里来) <i class="fa fa-level-up text-navy"></i>
                                        </div>
                                        <div class="progress progress-mini">
                                            <div style="width: 48%;" class="progress-bar"></div>
                                        </div>
                                    </li>
                                    <li>
                                        <h2 class="no-margins " id="LeastMonthTree" runat="server">加载中...</h2>
                                        <small>最近一个月植树</small>
                                        <div class="stat-percent" id="LeastMonthTreePercent" runat="server">加载中... <i class="fa fa-level-down text-navy"></i>
                                        </div>
                                        <div class="progress progress-mini">
                                            <div style="width: 60%;" class="progress-bar"></div>
                                        </div>
                                    </li>
                                    <li>
                                        <h2 class="no-margins " id="LeastMonthTask" runat="server">加载中...</h2>
                                        <small>最近一个月活动数</small>
                                        <div class="stat-percent"  id="LeastMonthTaskPercent"  runat="server">22% <i class="fa fa-bolt text-navy"></i>
                                        </div>
                                        <div class="progress progress-mini">
                                            <div style="width: 22%;" class="progress-bar"></div>
                                        </div>
                                    </li>
                                    </ul>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
     </div>


        <div class="row">
            <div class="col-sm-4">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>最新点赞/评论/留言</h5>
                        <div class="ibox-tools">
                            <a class="collapse-link">
                                <i class="fa fa-chevron-up"></i>
                            </a>
                            <a class="close-link">
                                <i class="fa fa-times"></i>
                            </a>
                        </div>
                    </div>
                   
                    <div class="ibox-content">
                        <div>
                            <div class="feed-activity-list">
                                <table class="table table-hover no-margins">
                                    <asp:Repeater ID="TaskmxCommentList" runat="server">
                                   <ItemTemplate>
                                        <tr>
                                            <td>
                                                  <div class="feed-element">
                                                <a href="profile.html" class="pull-left">
                                                    <img alt="image" class="img-circle" src="../img/profile.jpg">
                                                 </a>
                                                <div class="media-body ">
                                                    <small class="pull-right"> <strong id="TimeDiff"><%#Eval("TimeDiff") %></strong>天前</small>
                                                    <strong><%#Eval("UserName") %></strong> <strong id="bgood"><%#Eval("bgood") %></strong>
                                                    <br>
                                                    <small class="text-muted"><%#Eval("menddate","{0:yyyy-MM-dd  mm:ss:dd}") %></small>
                                                </div>
                                                <div class="well">
                                                    <%#Eval("commenttext") %>
                                                </div>
                                                </div>
                                            </td>
                                        </tr>
                                   </ItemTemplate>
                                      </asp:Repeater>
                                </table>
                            </div>
                            <button class="btn btn-primary btn-block m-t"><i class="fa fa-arrow-down"></i> 加载更多</button>
                        </div>
                    </div>
                </div>
            </div>
         
            <div class="col-sm-8">

                <div class="row">
                    <div class="col-sm-6">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <h5>最新植树列表</h5>
                                <div class="ibox-tools">
                                    <a class="collapse-link">
                                        <i class="fa fa-chevron-up"></i>
                                    </a>
                                    <a class="close-link">
                                        <i class="fa fa-times"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="ibox-content">
                                <table class="table table-hover no-margins">
                                    <thead>
                                        <tr>
                                            <th>树种</th>
                                            <th>日期</th>
                                            <th>党支部</th>
                                            <th>棵树</th>
                                        </tr>
                                    </thead>
                                    <asp:Repeater ID="NewTreeList" runat="server">
                                    
                                   <ItemTemplate>
                                        <tr>
                                            <td><small><%#Eval("treename") %></small>
                                            </td>
                                            <td><i class="fa fa-clock-o"></i><%#Eval("begindate","{0:yyyy-MM-dd}") %></td>
                                            <td><%#Eval("DepartName") %></td>
                                            <td class="text-navy"> <i class="fa fa-level-up"></i><%#Eval("num") %> </td>
                                        </tr>
                                   </ItemTemplate>
                                      </asp:Repeater>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-6">
                        <div class="ibox float-e-margins">
                            <div class="ibox-title">
                                <h5>点赞数排行前十</h5>
                                <div class="ibox-tools">
                                    <a class="collapse-link">
                                        <i class="fa fa-chevron-up"></i>
                                    </a>
                                    <a class="close-link">
                                        <i class="fa fa-times"></i>
                                    </a>
                                </div>
                            </div>
                            <div class="ibox-content">
                                        <table class="table table-hover margin bottom">
                                            <thead>
                                                <tr>
                                                    <th   class="text-center">排行</th>
                                                    <th>党支部</th> 
                                                    <th class="text-center">点赞数</th>
                                                </tr>
                                            </thead>
                                             <asp:Repeater ID="GOODList" runat="server">
                                                <ItemTemplate>
                                                <tr>
                                                    <td style="text-align:center">
                                                          <%#Container.ItemIndex + 1%>
                                                    </td>
                                                    <td>
                                                      <%#Eval("DeptName") %>
                                                    </td> 
                                                    <td class="text-center">
                                                        <span class="label label-primary">  <%#Eval("num") %></span>
                                                    </td>
                                                </tr>
                                            </ItemTemplate>
                                                 </asp:Repeater>
                                        </table>
                                   
                            </div>
                        </div>

                    </div>
                </div>
                
            </div>
        </div>
    </div>
    </form>
</body>
</html>

    <script src="../js/jquery.min.js?v=2.1.4"></script>
    <script src="../js/bootstrap.min.js?v=3.3.5"></script>
    <script src="../js/plugins/flot/jquery.flot.js"></script>
    <script src="../js/plugins/flot/jquery.flot.tooltip.min.js"></script>
    <script src="../js/plugins/flot/jquery.flot.spline.js"></script>
    <script src="../js/plugins/flot/jquery.flot.resize.js"></script>
    <script src="../js/plugins/flot/jquery.flot.pie.js"></script>
    <script src="../js/plugins/flot/jquery.flot.symbol.js"></script>
    <script src="../js/plugins/peity/jquery.peity.min.js"></script>
    <script src="../js/demo/peity-demo.min.js"></script> 
    <script src="../js/content.min.js?v=1.0.0"></script>
    <script src="../js/plugins/jquery-ui/jquery-ui.min.js"></script> 
    <script src="../js/plugins/easypiechart/jquery.easypiechart.js"></script>
   <script src="../js/plugins/sparkline/jquery.sparkline.min.js"></script>
    <script src="../js/demo/sparkline-demo.min.js"></script> 
    <script src="../Scripts/echarts.min.js"></script>
    <script src="../Scripts/macarons.js"></script>
    <script src="../Scripts/layui/layui.js"></script>
<%--layUI选项卡--%>
<script>
   


layui.use('element', function(){
  var $ = layui.jquery
  ,element = layui.element; //Tab的切换功能，切换事件监听等，需要依赖element模块
  
  //触发事件
  var active = {
    tabAdd: function(){
      //新增一个Tab项
      element.tabAdd('demo', {
        title: '新选项'+ (Math.random()*1000|0) //用于演示
        ,content: '内容'+ (Math.random()*1000|0)
        ,id: new Date().getTime() //实际使用一般是规定好的id，这里以时间戳模拟下
      })
    }
  };
  
  $('.site-demo-active').on('click', function(){
    var othis = $(this), type = othis.data('type');
    active[type] ? active[type].call(this, othis) : '';
  });
  
});
</script>
<%--点赞列表格式--%>
 <script>
            for(var i=1;i<6;i++){
            var Label = $("#form1 > div.wrapper.wrapper-content > div:nth-child(3) > div.col-sm-4 > div > div.ibox-content > div > div > table > tbody > tr:nth-child("+i+") > td > div > div.media-body").find("#bgood").html();
            if (Label == "1") {
                $("#form1 > div.wrapper.wrapper-content > div:nth-child(3) > div.col-sm-4 > div > div.ibox-content > div > div > table > tbody > tr:nth-child(" + i + ") > td > div > div.media-body").find("#bgood").html("点赞了");
            } else {
                $("#form1 > div.wrapper.wrapper-content > div:nth-child(3) > div.col-sm-4 > div > div.ibox-content > div > div > table > tbody > tr:nth-child(" + i + ") > td > div > div.media-body").find("#bgood").html("");
            }
            }
        </script>
<%--当月植树量和活动量对比--%>
<script>
        $(function () {
    Bar();
});

        
        function Bar() {
            var Time = new Array();
            var TreeNum = new Array();
            var TaskNum = new Array();
    var myCharts = document.getElementById('myChart');
    myCharts.style.width = '1096px';
    myCharts.style.height = '200px';
    var myChart = echarts.init(myCharts);
    $.ajax({
        type: "post",
        async: false,
url: "/Admin/ChartData.ashx?action=GetTreeAndTaskCountByDayMonth",
        dataType: "json",       
        success:function(data){
        for (var i=0;i<data.length;i++){
                Time.push(data[i].Time);
                TreeNum.push(data[i].TreeNum);
                TaskNum.push(data[i].TaskNum);
            }
InitChart(Time, TreeNum, TaskNum);
        },
        error: function(errmsg) {
            alert("Ajax获取服务器数据出错了！"+ errmsg);
        }
});
}
function InitChart(Time, TreeNum,TaskNum) {
    var myChart = echarts.init(document.getElementById('myChart'));
    option = {
        legend:[
            {
             name: '',
            },
        ],
        //横坐标信息
        xAxis: {
            type: 'category',
            data: Time,
            },
        //纵坐标信息
        yAxis: {
            type: 'value',
            min: 0,
            max: 30,//最大多少
            splitNumber: 5,//隔几个分开
        },
        series: [
              {
                  name: '当月植树数',//图例名称
                  data: TreeNum,//数据
                  type: 'bar',//柱状
                  /*颜色*/
                  itemStyle: {
                      normal: {
                          color: '#a3e1d4',
                           }
                  },
              },
              {
                  symbol: "none",
                  name: '当月活动数',
                  data: TaskNum,
                  type: 'line',
                  smooth: true,
                  areaStyle: {
                      normal: {
                          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
                            { offset: 0, color: "#dadce7" },
                            { offset: 0.5, color: "#dadce7" },
                            { offset: 1, color: "#dadce7" }
                          ])
                      }
                  },
                  itemStyle: {  /*设置折线颜色*/
                      normal: {
                          color: '#698aa0'
                      }
                  },
              }]
    };
    myChart.setOption(option);
    setTimeout(function (){
        window.onresize = function () {
            myChart.resize();
           
        }
    })

}

</script>
<%--指定年的月份对比--%>
<script>
        var myCharts6 = document.getElementById('myChart6');
        myCharts6.style.width = '1096px';
        myCharts6.style.height = '200px';
        var myChart6 = echarts.init(myCharts6);

        // 指定图表的配置项和数据切换
       
        myChart6.on('legendselectchanged', function (params) {
            var selected = params.selected;
            var setiesName = params.name;
            switch (setiesName) {
                case '总树木数':
                    if (selected['总树木数']) {
                        option.legend.data[0].icon = 'image://images/1.jpg';
                        option.legend.selected['总树木数'] = true;
                    } else {
                        option.legend.data[0].icon = 'image://images/3.jpg';
                        option.legend.selected['总树木数'] = false;
                    }
                    break;
                case '总活动数':
                    if (selected['总活动数']) {
                        option.legend.data[1].icon = 'image://images/2.jpg';
                        option.legend.selected['总活动数'] = true;
                    } else {
                        option.legend.data[1].icon = 'image://images/4.jpg';
                        option.legend.selected['总活动数'] = false;
                    }
                    break;
                case '点赞数':
                    if (selected['点赞数']) {
                        option.legend.data[1].icon = 'image://images/2.jpg';
                        option.legend.selected['点赞数'] = true;
                    } else {
                        option.legend.data[1].icon = 'image://images/4.jpg';
                        option.legend.selected['点赞数'] = false;
                    }
                    break;
                case '评分人数':
                    if (selected['评分人数']) {
                        option.legend.data[1].icon = 'image://images/2.jpg';
                        option.legend.selected['评分人数'] = true;
                    } else {
                        option.legend.data[1].icon = 'image://images/4.jpg';
                        option.legend.selected['评分人数'] = false;
                    }
                    break;
            }
        })
    //加载数据和图表
        var date = new Date;
        var year = date.getFullYear();
        SetAllOpintion(year);

    //下拉框改变事件
        $('#YearList').bind('input propertychange', function () {
            myChart6.clear();
            var year = $("#YearList").find("option:selected").text();
            SetAllOpintion(year);
            return false;
        })
    //交互数据
        function SetAllOpintion(year) {
            var Time = new Array();
            var TreeNum = new Array();
            var TaskNum = new Array();
            var GoodNum = new Array();
            var ScoreNum = new Array();
            $.ajax({
                type: "post",
                async: false,
                url: "/Admin/ChartData.ashx?action=GetCountByMonthInYear",
                data: { 'year': year },
                dataType: "json",
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {
                        Time.push(data[i].Time);
                        TreeNum.push(data[i].TreeNum);
                        TaskNum.push(data[i].TaskNum);
                        GoodNum.push(data[i].GoodNum);
                        ScoreNum.push(data[i].ScoreNum);
                    }
                    var option = {
                        title: {
                            text: '年对比'
                        },
                        //提示框  
                        tooltip: {
                            //触发类型：坐标轴触发  
                            trigger: 'axis',
                        },
                        //图例  
                        legend: {
                            selected: {
                                '总树木数': true,
                                '总活动数': true,
                                '点赞数': true,
                                '评分人数': true
                            },
                            data: [{
                                name: '总树木数',
                                icon: 'image://images/1.jpg',//显示你需要展示的图片  
                                textStyle: {
                                    fontSize: 12,
                                    fontWeight: 'bolder',
                                    color: 'red'
                                }
                            },
                            {
                                name: '总活动数',
                                icon: 'image://images/2.jpg',
                                textStyle: {
                                    fontSize: 12,
                                    fontWeight: 'bolder',
                                    color: 'blue'
                                },
                            },
                            {
                                name: '点赞数',
                                icon: 'image://images/2.jpg',
                                textStyle: {
                                    fontSize: 12,
                                    fontWeight: 'bolder',
                                    color: 'red'
                                },
                            } ,
                            {
                                name: '评分人数',
                                icon: 'image://images/2.jpg',
                                textStyle: {
                                    fontSize: 12,
                                    fontWeight: 'bolder',
                                    color: 'blue'
                                },
                            }],
                            bottom: 5,

                        },
                        xAxis: {
                            data: Time
                        },
                        //控制y轴线是否显示  
                        yAxis: {
                            axisLine: { show: false }
                        },
                        series: [{
                            name: '总树木数',
                            type: 'line',
                            data: TreeNum
                        },
                        {
                            name: '总活动数',
                            type: 'line',
                            data: TaskNum
                        },
                        {
                            name: '点赞数',
                            type: 'line',
                            data: GoodNum
                        },
                        {
                            name: '评分人数',
                            type: 'line',
                            data: ScoreNum
                        }
                        ]

                    };

                    // 使用刚指定的配置项和数据显示图表  
                    myChart6.setOption(option, true);
                    setTimeout(function () {
                        window.onresize = function () {
                            myChart6.resize();
                        }
                    })
                },
                error: function (errmsg) {
                    alert("Ajax获取服务器数据出错了！" + errmsg);
                }
            });
        }
        </script>

<%--年对比--%>
<script>
        var myCharts5 = document.getElementById('myChart5');
        myCharts5.style.width = '1096px';
        myCharts5.style.height = '200px';
        var myChart5 = echarts.init(myCharts5);

        // 指定图表的配置项和数据切换
       
        myChart5.on('legendselectchanged', function (params) {
            var selected = params.selected;
            var setiesName = params.name;
            switch (setiesName) {
                case '总树木数':
                    if (selected['总树木数']) {
                        option.legend.data[0].icon = 'image://images/1.jpg';
                        option.legend.selected['总树木数'] = true;
                    } else {
                        option.legend.data[0].icon = 'image://images/3.jpg';
                        option.legend.selected['总树木数'] = false;
                    }
                    break;
                case '总活动数':
                    if (selected['总活动数']) {
                        option.legend.data[1].icon = 'image://images/2.jpg';
                        option.legend.selected['总活动数'] = true;
                    } else {
                        option.legend.data[1].icon = 'image://images/4.jpg';
                        option.legend.selected['总活动数'] = false;
                    }
                    break;
                case '点赞数':
                    if (selected['点赞数']) {
                        option.legend.data[1].icon = 'image://images/2.jpg';
                        option.legend.selected['点赞数'] = true;
                    } else {
                        option.legend.data[1].icon = 'image://images/4.jpg';
                        option.legend.selected['点赞数'] = false;
                    }
                    break;
                case '评分人数':
                    if (selected['评分人数']) {
                        option.legend.data[1].icon = 'image://images/2.jpg';
                        option.legend.selected['评分人数'] = true;
                    } else {
                        option.legend.data[1].icon = 'image://images/4.jpg';
                        option.legend.selected['评分人数'] = false;
                    }
                    break;
            }
        })
    //加载数据和图表
        var date = new Date;
        var year = date.getFullYear();
        SetAllOpintion();

    //下拉框改变事件
        $('#YearList').bind('input propertychange', function () {
            myChart5.clear();
            var year = $("#YearList").find("option:selected").text();
            SetAllOpintion(year);
            return false;
        })
    //交互数据
        function SetAllOpintion() {
            var Time = new Array();
            var TreeNum = new Array();
            var TaskNum = new Array();
            var GoodNum = new Array();
            var ScoreNum = new Array();
            $.ajax({
                type: "post",
                async: false,
                url: "/Admin/ChartData.ashx?action=GetCountByYear",
                dataType: "json",
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {
                        Time.push(data[i].Time);
                        TreeNum.push(data[i].TreeNum);
                        TaskNum.push(data[i].TaskNum);
                        GoodNum.push(data[i].GoodNum);
                        ScoreNum.push(data[i].ScoreNum);
                    }
                    var option = {
                        title: {
                            text: '年对比'
                        },
                        //提示框  
                        tooltip: {
                            //触发类型：坐标轴触发  
                            trigger: 'axis',
                        },
                        //图例  
                        legend: {
                            selected: {
                                '总树木数': true,
                                '总活动数': true,
                                '点赞数': true,
                                '评分人数': true
                            },
                            data: [{
                                name: '总树木数',
                                icon: 'image://images/1.jpg',//显示你需要展示的图片  
                                textStyle: {
                                    fontSize: 12,
                                    fontWeight: 'bolder',
                                    color: 'red'
                                }
                            },
                            {
                                name: '总活动数',
                                icon: 'image://images/2.jpg',
                                textStyle: {
                                    fontSize: 12,
                                    fontWeight: 'bolder',
                                    color: 'blue'
                                },
                            },
                            {
                                name: '点赞数',
                                icon: 'image://images/2.jpg',
                                textStyle: {
                                    fontSize: 12,
                                    fontWeight: 'bolder',
                                    color: 'red'
                                },
                            } ,
                            {
                                name: '评分人数',
                                icon: 'image://images/2.jpg',
                                textStyle: {
                                    fontSize: 12,
                                    fontWeight: 'bolder',
                                    color: 'blue'
                                },
                            }],
                            bottom: 5,

                        },
                        xAxis: {
                            data: Time
                        },
                        //控制y轴线是否显示  
                        yAxis: {
                            axisLine: { show: false }
                        },
                        series: [{
                            name: '总树木数',
                            type: 'line',
                            data: TreeNum
                        },
                        {
                            name: '总活动数',
                            type: 'line',
                            data: TaskNum
                        },
                        {
                            name: '点赞数',
                            type: 'line',
                            data: GoodNum
                        },
                        {
                            name: '评分人数',
                            type: 'line',
                            data: ScoreNum
                        }
                        ]

                    };

                    // 使用刚指定的配置项和数据显示图表  
                    myChart5.setOption(option, true);
                    setTimeout(function () {
                        window.onresize = function () {
                            myChart5.resize();
                        }
                    })
                },
                error: function (errmsg) {
                    alert("Ajax获取服务器数据出错了！" + errmsg);
                }
            });
        }
        </script>























