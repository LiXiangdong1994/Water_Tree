<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="messageAdd.aspx.cs" Inherits="WaterTree.Admin.messageAdd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0"/>
    <title>Title</title>
    <style>
        input:-moz-placeholder,textarea:-moz-placeholder{color:#666;}
        input:-ms-input-placeholder,textarea:-ms-input-placeholder{color:#666;}
        input::-webkit-input-placeholder,textarea::-webkit-input-placeholder{color:#666;}
        .layui-tree-txt{
            color:white;
        }
    </style>
</head>
<body>
<!--主体部分开始-->
     <form id="form1" runat="server">
<div class="treeCareCommon messageAdd">
    <div class="common-type">
        <div class="public-head pt10" style="border: none;">
            <span>消息主题</span>
        </div>
        <div class="mui-input-group public-form">
            <div class="mui-input-row" style="padding-top: 0;">
                <input type="text" placeholder="请输入消息主题"  id="MsgTitle">
            </div>
        </div>
    </div>
    <div class="common-info">
        <div class="public-head" style="display:flex;border: none;">
            <span>消息内容</span>
        </div>
        <textarea name="" id="MsgText" cols="30" rows="10" placeholder="请输入消息内容，不超过250字" onkeyup="javascript:setShowLength(this, 250, 'wordnum1'); " maxlength="250"></textarea>
        <div class="tips">
            <div id="wordnum1">0</div>/ 250
        </div>
    </div>
    <div class="common-ping">
        <div class="public-head pt10" style="border: none;">
            <span>选择发送对象</span>
        </div>
        <div class="mui-input-group public-form">
        <div class="mui-input-row" id="select" style="padding-top: 0;">
            <input type="text" id="belong" placeholder="请选择选择发送对象">
             <input type="text" id="belongHide" placeholder="请选择选择发送对象"  style="display:none">
        </div>
        </div>
    </div>
    <div class="tree-box layui-hide">
        <div id="tree" class="demo-tree-more"></div>
        <div class="btn" style="background: #4c4c4c">
            <span class="hide-tree" lay-demo="getChecked">确定</span>
            <span class="hide-tree">关闭</span>
        </div>
    </div>
    <button class="public-submit"  type="button" id="send">
        立即发送
    </button>
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
    // 文本域字数限制
    function setShowLength(obj, maxlength, id) {
        var rem = obj.value.length;
        var wid = id;
        if (rem < 0) {
            rem = 0;
        }
        if (rem >= maxlength) {
            rem = maxlength;
            $(obj).parent().find('.tips').addClass('fontred');
        } else {
            $(obj).parent().find('.tips').removeClass('fontred');
        }
        document.getElementById(wid).innerHTML = rem;
    }
    // 评分
    layui.use(['rate'], function(){
        var rate = layui.rate;
        //基础效果
        rate.render({
            elem: '#test1'
        });

        //显示文字
        rate.render({
            elem: '#star-select'
            ,value: 0 //初始值
            ,text: true //开启文本
            ,choose: function(value){
                console.log(value)
            }
        });
    });

</script>

    <script>
 
    var belong = "";
    var departID = "";
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
                url: "/Admin/GetData.ashx?action=GetUserTreeData",
                dataType: "json",
                success: function (data) {
                    data2=data;
                },
                error: function (errmsg) {
                    alert("获取服务器数据出错了！" + errmsg);
                }
            });
            return data2;
        }
    
    //通过下面函数循环将Json换成树形图需要的格式（已抛弃）
     var arr = GetLayerTreeData();
     var newArr = [];
        arr.forEach(function(item){
            var childrenArr = [];
           
            for (var i = 0; i < arr.length; i++) {
                //判断是否为最高级（入口）
                if (arr[i].ParentID == 0) {
                    newArr.push({
                        id: arr[i]['id'],
                        spread: false,
                        title: arr[i]['title'],
                        title2: arr[i]['title']//路径 供输入框显示
                    });
                    //最高级添加进去之后删除此条数据
                    arr.splice(i, 1);
                    //继续循环数据库拿出来的数据
                    for(var j=0;j<arr.length;j++){

                        if (arr[j].ParentID == item.id) {
                            childrenArr.push({
                                id: arr[j]['id'],
                                spread: false,
                                title: arr[j]['title'],
                                title2: arr[j]['PathName']
                            })
                            arr.splice(j,1);
                            j--;
                        }
                    }
                    // 加载第3级
                    childrenArr.forEach(function (item, index) {
                        var childrenArr2 = [];
                        for (var k = 0; k < arr.length; k++) {
                            if (arr[k].ParentID == childrenArr[index]['id']) {
                                childrenArr2.push({
                                    id: arr[k]['id'],
                                    spread: false,
                                    title: arr[k]['title'],
                                    title2: arr[k]['PathName']
                                })
                                arr.splice(k,1);
                                k--;
                                childrenArr[index].children = childrenArr2;
                            }
                        }
                        childrenArr2.forEach(function (item, index) {
                            var childrenArr3 = [];
                            for (var s = 0; s < arr.length; s++) {
                                if (arr[s].ParentID == childrenArr2[index]['id']) {
                                    childrenArr3.push({
                                        id: arr[s]['id'],
                                        spread: false,
                                        title: arr[s]['title'],
                                        title2: arr[s]['PathName']
                                    })
                                    arr.splice(s, 1);
                                    s--;
                                    childrenArr2[index].children = childrenArr3;
                                }
                            }
                        })
                    })
                   
                    newArr[0].children = childrenArr;
                }
            }
        });
     var tree = layui.tree
         , layer = layui.layer
         , util = layui.util
         , data = newArr;

     tree.render({
         elem: '#tree'
         , data: data
         , showCheckbox: true  //是否显示复选框
         , id: 'demoId1'
         , isJump: false //是否允许点击节点时弹出新窗口跳转
         , click: function (obj) {
             var data = obj.data;  //获取当前点击的节点数据
             // console.log(obj)
             // belong = data.title2;
         }
     });
    
     util.event('lay-demo', {
         getChecked: function (othis) {
             var html = "";
             var html2 = "";
             var array = new Array();
             var list = $(".layui-form-checked").parent('.layui-tree-main:last-child').find(".layui-tree-txt")
             for (var i = 0; i < list.length; i++) {
                 if (list[i].innerHTML.indexOf("委会") == -1 && list[i].innerHTML.indexOf("镇") == -1&& list[i].innerHTML.indexOf("党支部") == -1) {
                     array.push(list[i].innerHTML);
                 }
             }
             alert(array)
             $('#belong').val(array);
             var checkedData = tree.getChecked('demoId1'); //获取选中节点的数据
             checkedData.forEach(function (value, index) {
                 var arr2 = value.children;  // 社区级别
                 if (arr2 == undefined) {
                     return false
                 }
                 arr2.forEach(function (value, index) {
                     var arr3 = value.children;  // 党支部
                     if (arr3 == undefined) {
                         return false
                     }
                     arr3.forEach(function (value, index) {
                         var arr4 = value.children;  // 党员
                         if (arr4 == undefined) {
                             return false
                         }
                         arr4.forEach(function (value, index) {
                             console.log(value)
                             html += value.title;
                             html += ",";
                             html2 += value.id;
                             html2 += ",";
                         });
                       
                         $('#belongHide').val(html2);
                     })
                 })
             })
         }
     });


     });
    $('#send').on('click', function () {
        var MsgTitle = $('#MsgTitle').val();
        var MsgText = $('#MsgText').val();
        var belong = $('#belong').val();
        var belongHide = $('#belongHide').val();
        if (MsgTitle == '') {
            mui.toast('主题不能为空！');
            return false;
        }
        if (MsgText == '') {
            mui.toast('内容不能为空！');
            return false;
        }
        if (belong == '') {
            mui.toast('收件人不能为空！');
            return false;
        }
        $.ajax({
            type: "post",
            async: false,
            url: "/Admin/GetData.ashx?action=SendMessage",
            data: {
                'AcceptUserID':belongHide,
                'AcceptUserName':belong,
                'SendUserID': '3',
                'SendUserName':'刘映红',
                'MsgTitle': MsgTitle,
                'MsgText': MsgText,
                'SendToList': belongHide,
            },
            dataType: "json",
            success: function (result) {
                if (result.code == 0) {
                    alert(result.msg);
                    window.location.href = "messageList.aspx";
                } else {
                    alert(result.msg);
                }
            },
            error: function (errmsg) {
                alert("服务器出错了！" + errmsg);
            }
        })
    })

</script>
</body>
</html>