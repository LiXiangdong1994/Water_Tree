<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="WaterTree.Admin.Register" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
    <meta charset="UTF-8"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
    <script src="../js/rem.js"></script>
    <title>Document</title>
    <link rel="stylesheet" href="../css/mui.min.css"/>
    <link href="../Scripts/layui/css/layui.css" rel="stylesheet" />
    <link rel="stylesheet" href="../css/style.css"/>
    <script src="../js/jquery-3.3.1.min.js"></script>
    <script src="../js/mui.min.js"></script>
        <script src="../Scripts/layui/layui.js"></script>
        <script src="../js/common.js"></script>
        <script src="../Scripts/LuTree.js"></script>
        <link href="http://netdna.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
    <style>
        html,body{height:100%;}
        body{background:url("../img/logbg.png") no-repeat left bottom;background-size:cover;position:relative;}
        ::-webkit-input-placeholder{color:#777;}
        ::-moz-placeholder{color:#777;}
        :-ms-input-placeholder{color:#777;}
        :-moz-placeholder{color:#777;}
        .layui-tree-txt{
           display: inline-block;
    vertical-align: middle;
    color:white;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <!--主体部分开始-->
<div class="login">
    <div class="login-logo">
        <img src="../img/logo.png" alt=""/>
    </div>
    <div class="login-title">
        注册账号
    </div>
    <form class="mui-input-group">
        <div class="mui-input-row">
            <label><img src="../img/log1.png" alt=""/></label>
            <input type="text" class="mui-input-clear" id="name" placeholder="请输入真实姓名"/>
        </div>
        <div class="mui-input-row mt10">
            <label><img src="../img/log2.png" style="width:.1rem;margin:0 .03rem;" alt=""/></label>
            <input type="number" class="mui-input-clear" id="phone" placeholder="请输入手机号码"/>
        </div>
        <div class="mui-input-row mt10" id="select">
            <label><img src="../img/log3.png" alt=""/></label>
            <input type="text" id="belong" class="mui-input-clear" placeholder="请选择所属党支部" readonly/>
        </div>
        <div class="tree-box layui-hide">
            <div id="tree" class="demo-tree-more"></div>
            <div class="btn">
                <span class="hide-tree">确定</span>
                <span class="hide-tree">关闭</span>
            </div>
        </div>
        <div class="mui-button-row">
            <button type="button" id="submit" class="mui-btn mui-btn-primary">提交审核</button>
        </div>
        <div class="a" id="toUl">

		</div>
    </form>
    <!--<div class="login-bottom">-->
    <!--温馨提示:审核通过 我们会以短信形式通知您-->
    <!--</div>-->
</div>
<!--主体部分结束-->
    </form>
</body>
</html>
<%--<script type="text/javascript">
		//预加载数据格式
	

		//无限级菜单生成
		$("#toUl").LuTree({
		    arr: arr2,
		    sign: true,
		    simIcon: "fa fa-file-o",//叶子图标
		    mouIconOpen: " fa fa-folder-open",//展开图标
		    mouIconClose: "fa fa-folder",//关闭图标
		    callback: function (id) {
		        console.log("你选择的id是" + id);
		    }
		});
    </script>--%>
<script>
 

    mui.init();
    //layer组件初始化
    layui.use(['tree', 'form', 'util', 'laydate', 'upload', 'layer', 'jquery', 'element'], function () {
        $('#select').on('click', function () {
            $('.tree-box').removeClass("layui-hide");
        });
        $(".hide-tree").on("click", function () {
            $('.tree-box').addClass("layui-hide");
        });
        //获取数据库json格式的list数据
        var data2 = new Array();
        function GetLayerTreeData() {
            $.ajax({
                type: "get",
                async: false,
                url: "/Admin/GetData.ashx?action=GetLayerTreeData",
                dataType: "json",
                success: function (data) {
                    data2.push(data);
                },
                error: function (errmsg) {
                    alert("获取服务器数据出错了！" + errmsg);
                }
            });
            return data2;
        }
    
    //通过下面函数循环将Json换成树形图需要的格式（已抛弃）
     var arr = GetLayerTreeData();
     //var newArr = [];
     //arr.forEach(function(item){
     //    var childrenArr=[];
     //    for (var i = 0; i < arr.length; i++) {
     //        //判断是否为最高级（入口）
     //        if (arr[i].ParentID == 0) {
     //            newArr.push({
     //                checked: false,
     //                id: arr[i]['ID'],
     //                spread: false,
     //                title: arr[i]['Name'],
     //                title2: arr[i]['Name']//路径 供输入框显示
     //            });
     //            //最高级添加进去之后删除此条数据
     //            arr.splice(i, 1);
     //            //继续循环数据库拿出来的数据
     //            for(var j=0;j<arr.length;j++){
     //                if (arr[j].ParentID == item.ID) {
     //                    childrenArr.push({
     //                        checked: false,
     //                        id: arr[j]['ID'],
     //                        spread: false,
     //                        title: arr[j]['Name'],
     //                        title2: arr[j]['PathName']
     //                    })
     //                    arr.splice(j,1);
     //                    j--;
     //                }
     //            }
     //            // 加载第3级
     //            childrenArr.forEach(function (item,index) {
     //                var childrenArr2=[];
     //                for (var k = 0; k < arr.length; k++) {
     //                    if (arr[k].ParentID == childrenArr[index]['id']) {
     //                        childrenArr2.push({
     //                            checked: false,
     //                            id: arr[k]['ID'],
     //                            spread: false,
     //                            title: arr[k]['Name'],
     //                            title2: arr[k]['PathName']
     //                        })
     //                        arr.splice(k,1);
     //                        k--;
     //                        childrenArr[index].children = childrenArr2;
     //                    }
     //                }
     //            })
     var tree = layui.tree
         , layer = layui.layer
         , util = layui.util
         , data = arr;

     //渲染数据
     var belong = "";
     tree.render({
         elem: '#tree'//div的ID
         , data: data
         , showCheckbox: false  //是否显示复选框
         , id: 'demoId1'
         , isJump: false //是否允许点击节点时弹出新窗口跳转
         , click: function (obj) {
             var data = obj.data;  //获取当前点击的节点数据
             belong = data.PathName;
             $('#belong').val(data.PathName);
         }
     });
     $('#submit').on('click', function () {
         var name = $('#name').val();
         var phone = $('#phone').val();
         if (name == '') {
             mui.toast('真实姓名不能为空！');
             return false;
         }
         if (phone == '') {
             mui.toast('手机号码不能为空！');
             return false;
         }
         if (phone.length != 11) {
             mui.toast('手机号码位数有误！');
             return false;
         }
         if (belong == "") {
             mui.toast('请选择所属党支部！');
             return false;
         }
         if (belong.length > 1) {
             var arr = belong.split(',');
             if (arr.length < 3) {
                 mui.toast('所属党支部没有选择完毕，请继续选择');
                 return false;
             }
         }
         mui.alert('提交成功，若审核通过，我们会以短信形式通知您', '提示', function () {

         });
     })
     });


     

</script>


