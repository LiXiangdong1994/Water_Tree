<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="OtherContrast.aspx.cs" Inherits="WaterTree.Admin.Other" %>
   <!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>数据统计</title>
    <link rel="shortcut icon" href="favicon.ico">
    <link href="../css/bootstrap.min.css" rel="stylesheet" />
    <link href="../css/font-awesome.min.css" rel="stylesheet" />
    <link href="../css/style.min.css" rel="stylesheet" />
    <link href="../css/animate.min.css" rel="stylesheet" />
    <base target="_blank">
    <style>
        #pie, #main, #mainMap {
            background: #fff !important;
            padding: 25px 0 0 10px;
            box-sizing: content-box;
            border-top: 4px solid #e7eaec;
            margin-top: 30px;
        }

        #pie {
            margin-top: 0;
        }

        .publicIpt {
            background-color: #FFF;
            background-image: none;
            border: 1px solid #e5e6e7;
            border-radius: 3px;
            color: inherit;
            display: block;
            padding: 6px 12px;
            transition: border-color .15s ease-in-out 0s, box-shadow .15s ease-in-out 0s;
            width: 120px;
            font-size: 14px;
            line-height: 1.42857143;
            height: 35px;
        }

        .form {
            display: flex;
            padding-bottom: 15px;
        }
    </style>
</head>
<body class="gray-bg">
    <input id="TownNameHide" style="display:none"/><%--用于记录图2的镇名--%>
     <input id="YearCompareObjectHide" style="display:none"/><%--用于记录图2的年对比对象--%>
     <input id="PartyCompareObjectHide" style="display:none"/><%--用于记录图2的党支部对比对象--%>
     <input id="TreeTypeCompareObjectHide" style="display:none"/><%--用于记录图3的树类对比对象--%>
      <input id="PartyCompareObjectInMonthHide" style="display:none"/><%--用于记录图3的月对比对象--%>
    <script src="source/jquery17.js"></script>
    <div style="padding: 20px 0px 60px;width: 1200px;margin: 0 auto;">
        <div class="form">
            <div style="display: flex">
                <span style="width: 65px;line-height: 35px;">筛选对象：</span>
                <select id="item" class="publicIpt">
                    <option value="vwTownTreeSum" selected>树木数</option>
                    <option value="vwTownTaskSum">活动数</option>
                    <option value=1>人均种植</option>
                    <option value="vwTownGoodSum">点赞数</option>
                    <option value="vwTownScoreSum">评分</option>
                </select>
            </div>
            <div style="display: flex">
                <form id="form1" runat="server" style="border:0 0;">
                <span style="width: 65px;line-height: 35px;text-align: right;float:left;">年份：</span>
                    <span style="width: 85px;line-height: 35px;text-align: right;float:left;">
                 <asp:DropDownList id="year" class="publicIpt" style="width: 90px;" runat="server"  CssClass="publicIpt">
                  </asp:DropDownList></span>
                    </form>
            </div>
            <input type="button" class="btn btn-primary" style="margin-left: 25px;" onclick="query();" value="确定" />
        </div>
        <!--Step:1 Prepare a dom for ECharts which (must) has size (width & hight)-->
        <!--Step:1 为ECharts准备一个具备大小（宽高）的Dom-->
        <div id="pie" style="width:100%;height:300px;"></div>
        <div id="main" style="width:100%;height:350px;"></div>
        <div id="mainMap" style="width:100%;height:350px;    padding-bottom: 25px;"></div>
    </div>
    <!--Step:2 Import echarts.js-->
    <!--Step:2 引入echarts.js-->
    <script src="source/echarts.js"></script>
    <script src="source/data.js"></script>
    <script type="text/javascript">
    var myChart1, myChart2, myChart3;

    // Step:3 conifg ECharts's path, link to echarts.js from current page.
        // Step:3 为模块加载器配置echarts的路径，从当前页面链接到echarts.js，定义所需图表路径
      //图1样式
    var option1 = {
        title: {
            text: '',
            // subtext: '纯属虚构',
            x: 'center',
            textStyle: {color: '#333'}
        },
        tooltip: {
            trigger: 'item',
            //formatter: "{a}ww <br/>{b} : {c} ({d}%)"
            formatter: "{b} : {c} ({d}%)"
        },
        legend: {
            show: false,
            orient: 'vertical',
            x: 'left',
            //y:'left',
            data: []
        },
        toolbox: {
            show: false,
            feature: {
                mark: {show: true},
                dataView: {show: true, readOnly: false},
                magicType: {
                    show: true,
                    type: ['pie', 'funnel'],
                    option: {
                        funnel: {
                            x: '25%',
                            width: '50%',
                            funnelAlign: 'left',
                            max: 1548
                        }
                    }
                },
                restore: {show: true},
                saveAsImage: {show: true}
            }
        },
        calculable: true,
        series: [
            {
                name: '男女比例',
                type: 'pie',
                radius: '60%',
                selectedMode: 'single',
                center: ['50%', '50%'],
                itemStyle: {
                    normal: {
                        label: {
                            show: true
                        },
                        labelLine: {
                            show: true
                        }
                    },
                    emphasis: {
                        label: {
                            show: false
                        },
                        labelLine: {
                            show: false
                        }
                    }
                },
                data: []
            }
        ]
    };
       //图2样式
    var option2 = {
        title: {
            text: '',
            // subtext: '纯属虚构',
            x: 'center',
            textStyle: {color: '#333'}
        },
        tooltip: {
            trigger: 'items',
            formatter: "{b} : {c}"
        },
        legend: {
            show: false,
            data: []
        },
        toolbox: {
            show: false,
            feature: {
                mark: {show: true},
                dataView: {show: true, readOnly: false},
                magicType: {show: true, type: ['line', 'bar']},
                restore: {show: true},
                saveAsImage: {show: true}
            }
        },
        calculable: true,
        xAxis: [
            {
                splitLine: false,
                type: 'category',
                data: []
            }
        ],
        yAxis: [
            {
                splitLine: false,
                type: 'value',
                //splitArea : {show : true}
                show: true
            }
        ],
        series: [
            {
                //name:'小学',
                type: 'bar',
                barWidth : 60,
                itemStyle: {
                    normal: {
                        color: function (params) {
                            // build a color map as your need.
                            var colorList = [
                                '#C1232B', '#B5C334', '#FCCE10', '#E87C25', '#27727B',
                                '#FE8463', '#9BCA63', '#FAD860', '#F3A43B', '#60C0DD',
                                '#D7504B', '#C6E579', '#F4E001', '#F0805A', '#26C0C0',
                                '#D7504B', '#C6E579', '#F4E001', '#F0805A', '#26C0C0'
                            ];
                            return colorList[params.dataIndex]
                        },
                        label: {
                            show: false,
                            position: 'top',
                            formatter: '{b}\n{c}'
                        }
                    }
                },
                data: []
            }
        ]
    };
//图3样式
    var option3 = {
        title: {
            text: '',
            // subtext: '纯属虚构',
            x: 'center',
            textStyle: { color: '#333' }
        },
        tooltip: {
            trigger: 'items',
            formatter: "{b} : {c}"
        },
        legend: {
            show: false,
            data: []
        },
        toolbox: {
            show: false,
            feature: {
                mark: { show: true },
                dataView: { show: true, readOnly: false },
                magicType: { show: true, type: ['line', 'bar'] },
                restore: { show: true },
                saveAsImage: { show: true }
            }
        },
        calculable: true,
        xAxis: [
            {
                splitLine: false,
                type: 'category',
                data: []
            }
        ],
        yAxis: [
            {
                splitLine: false,
                type: 'value',
                //splitArea : {show : true}
                show: true
            }
        ],
        series: [
            {
                //name:'小学',
                type: 'line',
                itemStyle: {
                    normal: {
                        //color: function (params) {
                        //    // build a color map as your need.
                        //    var colorList = [
                        //        '#C1232B', '#B5C334', '#FCCE10', '#E87C25', '#27727B',
                        //        '#FE8463', '#9BCA63', '#FAD860', '#F3A43B', '#60C0DD',
                        //        '#D7504B', '#C6E579', '#F4E001', '#F0805A', '#26C0C0',
                        //        '#D7504B', '#C6E579', '#F4E001', '#F0805A', '#26C0C0'
                        //    ];
                        //    return colorList[params.dataIndex]
                        //},
                        label: {
                            show: false,
                            position: 'top',
                            formatter: '{b}\n{c}'
                        }
                    }
                },
                data: []
            }
        ]
    }

    //图3样式（2）
    var option4 = {
        title: {
            text: '',
            // subtext: '纯属虚构',
            x: 'center',
            textStyle: { color: '#333' }
        },
        tooltip: {
            trigger: 'items',
            formatter: "{b} : {c}"
        },
        legend: {
            show: false,
            data: []
        },
        toolbox: {
            show: false,
            feature: {
                mark: { show: true },
                dataView: { show: true, readOnly: false },
                magicType: { show: true, type: ['line', 'bar'] },
                restore: { show: true },
                saveAsImage: { show: true }
            }
        },
        calculable: true,
        xAxis: [
            {
                splitLine: false,
                type: 'category',
                data: []
            }
        ],
        yAxis: [
            {
                splitLine: false,
                type: 'value',
                //splitArea : {show : true}
                show: true
            }
        ],
        series: [
            {
                //name:'小学',
                type: 'bar',
                barWidth: 60,
                itemStyle: {
                    normal: {
                        color: function (params) {
                            // build a color map as your need.
                            var colorList = [
                                '#C1232B', '#B5C334', '#FCCE10', '#E87C25', '#27727B',
                                '#FE8463', '#9BCA63', '#FAD860', '#F3A43B', '#60C0DD',
                                '#D7504B', '#C6E579', '#F4E001', '#F0805A', '#26C0C0',
                                '#D7504B', '#C6E579', '#F4E001', '#F0805A', '#26C0C0'
                            ];
                            return colorList[params.dataIndex]
                        },
                        label: {
                            show: false,
                            position: 'top',
                            formatter: '{b}\n{c}'
                        }
                    }
                },
                data: []
            }
        ]
    };
    require.config({
        paths: {
            echarts: './source'
        }
    });

    // Step:4 require echarts and use it in the callback.
    // Step:4 动态加载echarts然后在回调函数中开始使用，注意保持按需加载结构定义图表路径
    var ecConfig;
    require(
        [
            'echarts',
            'echarts/chart/bar',
            'echarts/chart/line',
            'echarts/chart/pie'

        ],
        function (ec) {
            ecConfig = require('echarts/config');


            //initData();

            myChart1 = ec.init(document.getElementById('pie'));
            myChart2 = ec.init(document.getElementById('main'));
            myChart3 = ec.init(document.getElementById('mainMap'));
            loadAll(itemIndex, 2014);
           
        }
    );
    var h1 = new Array();
    var itemIndex = 0;

//进入页面：加载图1饼状图镇区数对比
    function GetTownTreeCount() {
         var Time = new Array();
         var TownName=new Array();
         var TreeNum = new Array();
         var option1Arr = new Array();
         var options = $("#item option:selected");//获取当前选择项.
         var compareObjectVal = options.val();
         var compareObjectItem = options.text();
         year = $("#year").val();
         if (compareObjectVal == "vwTownTreeSum") {
             $("#PartyCompareObjectHide").val("vwPartyTreeSum");
             $("#PartyCompareObjectInMonthHide").val("vwTreeCountDayInMonth");
             $("#YearCompareObjectHide").val("vwTreeSumByYear");
             $("#TreeTypeCompareObjectHide").val("vwTreeSumByTreeName");
             
         }
         if (compareObjectVal == "vwTownTaskSum") {
             $("#PartyCompareObjectHide").val("vwPartyTaskSum");
             $("#PartyCompareObjectInMonthHide").val("vwTaskCountDayInMonth");
             $("#YearCompareObjectHide").val("vwTaskSumByYear");
             $("#TreeTypeCompareObjectHide").val("vwTaskSumByTreeName");
         }
         if (compareObjectVal == "vwTownGoodSum") {
             $("#PartyCompareObjectHide").val("vwPartyGoodSum");
             $("#PartyCompareObjectInMonthHide").val("vwGoodCountDayInMonth");
             $("#YearCompareObjectHide").val("vwGoodSumByYear");
             $("#TreeTypeCompareObjectHide").val("vwGoodSumByTreeName");
         }
         if (compareObjectVal == "vwTownScoreSum") {
             $("#PartyCompareObjectHide").val("vwPartyScoreSum");
             $("#PartyCompareObjectInMonthHide").val("vwScoreCountDayInMonth");
             $("#YearCompareObjectHide").val("vwScoreSumByYear");
             $("#TreeTypeCompareObjectHide").val("vwScoreSumByTreeName");
         } 
        $.ajax({
            type: "get",
            async: false,
            url: "/Admin/GetData.ashx?action=TownContrast",
            data: { 'compareObject': compareObjectVal, 'year': year },
            dataType: "json",
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    TownName.push(data[i].TownName);
                    var obj = new Object();
                    obj.name = data[i].TownName;
                    obj.value = data[i].TreeNum;
                    option1Arr.push(obj);
                }
                option1.title.text = year + "年镇区" + compareObjectItem + "对比"
                option1.legend.data = TownName;
                option1.series[0].data = option1Arr;
                myChart1.setOption(option1);
            },
            error: function (errmsg) {
                alert("Ajax获取服务器数据出错了！" + errmsg);
            }
        });
 }

//进入页面：加载图2各年对比的数据
    function GetYearCotrastCount() {
        var Time = new Array();
        var option1Arr = new Array();
        var options = $("#item option:selected");//获取当前选择项.
        var compareObjectVal = $("#YearCompareObjectHide").val();;//对比项
        var compareObjectItem = options.text();
        console.log(compareObjectVal);
        $.ajax({
            type: "get",
            async: false,
            url: "/Admin/GetData.ashx?action=YearContrast",
            data: { 'compareObject': compareObjectVal},
            dataType: "json",
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    Time.push(data[i].Time);
                    var obj = new Object();
                    obj.name = data[i].Time;
                    obj.value = data[i].TreeNum;
                    option1Arr.push(obj);
                }
                option2.title.text = "各年" + compareObjectItem + "对比";
                option2.xAxis[0].data = Time;
                option2.series[0].data = option1Arr;
                myChart2.setOption(option2);
            },
            error: function (errmsg) {
                alert("Ajax获取服务器数据出错了！" + errmsg);
            }
        });
    }

//进入页面：加载图3各树种对比的数据
    function GetTreeTypeCotrastCount() {
        var Time = new Array();
        var option1Arr = new Array();
        var options = $("#item option:selected");//获取当前选择项.
        var compareObjectVal = $("#TreeTypeCompareObjectHide").val();;//对比项
        var compareObjectItem = options.text();
        console.log(compareObjectVal);
        $.ajax({
            type: "get",
            async: false,
            url: "/Admin/GetData.ashx?action=TreeTypeContrast",
            data: { 'compareObject': compareObjectVal },
            dataType: "json",
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    Time.push(data[i].Time);
                    var obj = new Object();
                    obj.name = data[i].Time;
                    obj.value = data[i].TreeNum;
                    option1Arr.push(obj);
                }
                option4.title.text = "各树类" + compareObjectItem + "对比";
                option4.xAxis[0].data = Time;
                option4.series[0].data = option1Arr;
                myChart3.setOption(option4);
            },
            error: function (errmsg) {
                alert("Ajax获取服务器数据出错了！" + errmsg);
            }
        });
    }


//点击图1的饼状图 加载图2
    function GetPartyTreeCount(townName) {
     var Time = new Array();
     var PartyName = new Array();
     var TreeNum = new Array();
     var option1Arr = new Array();
     var options=$("#item option:selected");//获取当前选择项.
     var compareObjectVal = $("#PartyCompareObjectHide").val();//对比项
     var compareObjectItem = options.text();
     var year = $("#year").val();//对比年份
     console.log(compareObjectVal);
     $.ajax({
         type: "get",
         async: false,
         url: "/Admin/GetData.ashx?action=PartyContrast",
         data: { 'compareObject': compareObjectVal, 'year': year, 'TownName': townName },
         dataType: "json",
         success: function (data) {
             for (var i = 0; i < data.length; i++) {
                 PartyName.push(data[i].PartyName);
                 var obj = new Object();
                 obj.name = data[i].PartyName;
                 obj.value = data[i].TreeNum;
                 option1Arr.push(obj);
             }
             if (townName == "") {
                 townName = "石龙镇";
             }
             option2.title.text = townName + year + "年党支部" + compareObjectItem + "对比"
             option2.xAxis[0].data = PartyName;
             option2.series[0].data = option1Arr;
             myChart2.setOption(option2);
         },
         error: function (errmsg) {
             alert("Ajax获取服务器数据出错了！" + errmsg);
         }
     });
 }

 //点击图2的柱状图 加载图3
 function GetMonthTreeCount(townName,partyName) {
     var Time = new Array();
     var TreeNum = new Array();
     var options = $("#item option:selected");//获取当前选择项.
     var PartyCompareObjectInMonthHide = $("#PartyCompareObjectInMonthHide").val();
     var compareObjectItem = options.text();
     year = $("#year").val();
     $.ajax({
         type: "get",
         async: false,
         url: "/Admin/GetData.ashx?action=PartyContrastByMonth",
         data: { 'compareObject': PartyCompareObjectInMonthHide, 'year': year, 'TownName': townName, 'PartyName': partyName },
         dataType: "json",
         success: function (data) {
             for (var i = 0; i < data.length; i++) {
                 Time.push(data[i].Time);
                 TreeNum.push(data[i].TreeNum);
             }
             if (townName == "") {
                 townName = "石龙镇";
             }
             if (partyName == "") {
                 partyName = "石龙镇党支部1";
             }
             option3.title.text = townName + partyName + "--" + year + "年各月" + compareObjectItem + "对比"
             option3.xAxis[0].data = Time;
             option3.series[0].data = TreeNum;
             myChart3.setOption(option3);
         },
         error: function (errmsg) {
             alert("Ajax获取服务器数据出错了！" + errmsg);
         }
     });
 }


  //按对比对象和年份加载所有数据
    function loadAll(index, year) {
        //加载之前先清空
        itemIndex = index;
        myChart1.clear();
        myChart2.clear();
        myChart3.clear();
        //option1.legend.data = itemdata[index][0];//获取对比对象的选项设置在图1图例上
        //option1.title.text = year + title[index];//获取对比对象的选项设置在图1的标题上
        GetTownTreeCount();//加载图1 
        var townName = "";
        var partyName = "";
        GetYearCotrastCount();
        GetTreeTypeCotrastCount()//加载图3
        myChart1.on(ecConfig.EVENT.CLICK, function (e) {//重写图1鼠标点击事件
            click1(year, itemIndex, e);
        });
        myChart2.on(ecConfig.EVENT.CLICK, function (e) {//重写图2鼠标点击事件
            click2(year, itemIndex, e);
        });

    }
        //图1鼠标点击
    function click1(year, index, e) {
      
        var TownName = e.name;
        myChart2.clear();
        $("#TownNameHide").val(TownName);
        GetPartyTreeCount(TownName);
       

    }
        //图2鼠标点击
    function click2(year, index, e) {
        var  partyName= e.name;
        myChart3.clear();
        var townName = $("#TownNameHide").val();
        GetMonthTreeCount(townName, partyName);
       

    }
        //鼠标点击确认事件
    function query() {
        var item = parseInt($("#item").val());
        var year = parseInt($("#year").val());
        if (item == 1) {
            alert("暂无数据");
            return;
        }
        loadAll(item, year);
    }
       //图表页面大小
    window.onresize = function () {
        myChart1.resize();
        myChart2.resize();
        myChart3.resize();
    }


        





    </script>

    <script src="../js/jquery.min.js"></script>
    <script src="../js/bootstrap.min.js"></script>
    <script src="../js/content.min.js"></script>
    <script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>
</body>
</html>

<%--加载植树数对应年份的镇区数据供图1使用--%>
     