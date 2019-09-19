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
        .OtherContrastList{
            margin-left:20px;
            width:100px;
            height:30px;
        }
        #OtherContrast{
            margin-left:20px;
        }
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
                        <h5 style="margin-top:10px;font-size:20px;">活动情况</h5> 
                        <asp:Button ID="OtherContrast" runat="server" Text="其他统计图" OnClick="OtherContrast_Click"  class="layui-btn layui-btn-normal"/>

                    </div>
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-sm-9">
                                            <div class="flot-chart">
                                                <div class="flot-chart-content" id="myChart"></div>
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
                                            <td><%#Eval("DeptName") %></td>
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

            $('#OtherContrastList').bind('input propertychange', function () {
                var text = $("#OtherContrastList").find("option:selected").val();
                if (text=='#') {
                    return false;
                }
                else{
                     window.open(text)
                }
                return false;
            })
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
url: "/Admin/GetData.ashx?action=GetTreeAndTaskCountByDayMonth",
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
            alert("获取服务器当月数据出错了！"+ errmsg);
        }
});
}
function InitChart(Time, TreeNum,TaskNum) {
    var myChart = echarts.init(document.getElementById('myChart'));
    var myCharts = document.getElementById('myChart');
    myCharts.style.width = '1096px';
    myCharts.style.height = '400px';
    option = {
      
        tooltip: {
            trigger: 'axis',
            axisPointer: { // 坐标轴指示器，坐标轴触发有效
                type: 'shadow' // 默认为直线，可选为：'line' | 'shadow'
            }
        },
        grid: {
            left: '2%',
            right: '4%',
            bottom: '14%',
            top: '16%',
            containLabel: true
        },
        legend: [
      {
          name: '',
          textStyle: {
              color: "#11000a"
          },
      },
        ],
        //横坐标信息
        xAxis: {
            type: 'category',
            data: Time,
            axisLine: {
                lineStyle: {
                    color: '#11000a'

                }
            },
            axisLabel: {
                // interval: 0,
                // rotate: 40,
                textStyle: {
                    fontFamily: 'Microsoft YaHei'
                }
            },
            },
        //纵坐标信息
        yAxis: {
            type: 'value',
        max: '100',
        axisLine: {
            show: false,
            lineStyle: {
                color: '#11000a'
            }
        },
        splitLine: {
            show: true,
            lineStyle: {
                type:'dash',
                color: '#e7eaec'
            }
        },
        axisLabel: {}
        },
        "dataZoom": [{
            "show": true,
            "height": 12,
            "xAxisIndex": [
              0
            ],
            bottom: '8%',
            "start": 10,
            "end": 90,
            handleIcon: 'path://M306.1,413c0,2.2-1.8,4-4,4h-59.8c-2.2,0-4-1.8-4-4V200.8c0-2.2,1.8-4,4-4h59.8c2.2,0,4,1.8,4,4V413z',
            handleSize: '110%',
            handleStyle: {
                color: "#d3dee5",

            },
            textStyle: {
            },
            borderColor: "#90979c"
        }, {
            "type": "inside",
            "show": true,
            "height": 15,
            "start": 1,
            "end": 35
        }],
        series: [
              {
                  name: '当月植树数',//图例名称
                  data: TreeNum,//数据
                  type: 'bar',
                  barWidth: '40%',
                  itemStyle: {
                      normal: {
                          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                              offset: 0,
                              color: '#fccb05'
                          }, {
                              offset: 1,
                              color: '#f5804d'
                          }]),
                          barBorderRadius: 12,
                      },
                  },
              },
              {
                  symbol: "none",
                  name: '当月活动数',
                  data: TaskNum,
                  type: 'bar',
                  barWidth: '50%',
                  itemStyle: {
                      normal: {
                          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                              offset: 0,
                              color: '#8bd46e'
                          }, {
                              offset: 1,
                              color: '#09bcb7'
                          }]),
                          barBorderRadius: 11,
                      }

                  },
              }]
    };
    var app = {
        currentIndex: -1,
    };
    setInterval(function () {
        var dataLen = option.series[0].data.length;

        // 取消之前高亮的图形
        myChart.dispatchAction({
            type: 'downplay',
            seriesIndex: 0,
            dataIndex: app.currentIndex
        });
        app.currentIndex = (app.currentIndex + 1) % dataLen;
        //console.log(app.currentIndex);
        // 高亮当前图形
        myChart.dispatchAction({
            type: 'highlight',
            seriesIndex: 0,
            dataIndex: app.currentIndex,
        });
        // 显示 tooltip
        myChart.dispatchAction({
            type: 'showTip',
            seriesIndex: 0,
            dataIndex: app.currentIndex
        });


    }, 1000);
    myChart.setOption(option);

}

</script>
