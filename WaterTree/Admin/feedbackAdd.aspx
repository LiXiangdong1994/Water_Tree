<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="feedbackAdd.aspx.cs" Inherits="WaterTree.Admin.feedbackAdd" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
 <form id="form1" runat="server">
<!--主体部分开始-->
<div class="treeCareCommon messageAdd">
    <div class="common-type">
        <div class="public-head pt10" style="border: none;">
            <span>建议反馈主题</span>
        </div>
        <div class="mui-input-group public-form">
            <div class="mui-input-row" style="padding-top: 0;">
                <input type="text" id="Title" placeholder="请输入建议反馈"/>
            </div>
        </div>
    </div>
    <div class="common-info">
        <div class="public-head" style="display:flex;border: none;">
            <span>您的问题或建议</span>
        </div>
        <textarea name="" id="Suggest" cols="30" rows="10" placeholder="请输入建议反馈内容，不超过250字" onkeyup="javascript:setShowLength(this, 250, 'wordnum1'); " maxlength="250"></textarea>
        <div class="tips">
            <div id="wordnum1">0</div>/ 250
        </div>
    </div>
   <div class="common-ping">
        <div class="public-head pt10">
            <span>上传相关图片</span>
        </div>
        <div class="img_item">
            <div class="img_item_box">
                <div class="img_preview">
                    <img src="../img/pic.png" alt="" class="add"/>
                    <img src="" alt="" class="preview" id="1"/>
                    <input type="file" id="file1"/>
                </div>
                <div class="state">banner图</div>
            </div>
            <div class="img_item_box">
                <div class="img_preview">
                    <img src="../img/pic.png" alt="" class="add"/>
                    <img src="" alt="" class="preview" id="2"/>
                    <input type="file" id="file2"/>
                </div>
                <div class="state">banner图</div>
            </div>
            <div class="img_item_box">
                <div class="img_preview">
                    <img src="../img/pic.png" alt="" class="add"/>
                    <img src="" alt="" class="preview" id="3"/>
                    <input type="file" id="file3"/>
                </div>
                <div class="state">banner图</div>
            </div>
        </div>
    </div>
    <div class="tree-box layui-hide">
        <div id="tree" class="demo-tree-more"></div>
        <div class="btn" style="background: #4c4c4c">
            <span class="hide-tree" lay-demo="getChecked">提交反馈</span>
            <span class="hide-tree">关闭</span>
        </div>
    </div>
    <button  type="button" class="public-submit" id="submit">
        提交反馈
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
    </body>
</html>
<script>

     //图片上传
    function setImagePreview(avalue, input, image) {
        var docObj = input;
        //img
        var imgObjPreview = image;
        if (docObj.files && docObj.files[0]) {
            //火狐下，直接设img属性
            imgObjPreview.style.display = 'block';
            imgObjPreview.style.width = '100%';
            imgObjPreview.style.height = '100%';
            //imgObjPreview.src = docObj.files[0].getAsDataURL();
            //火狐7以上版本不能用上面的getAsDataURL()方式获取，需要一下方式;
            imgObjPreview.src = window.URL.createObjectURL(docObj.files[0]);
        } else {
            //IE下，使用滤镜;
            docObj.select();
            var imgSrc = document.selection.createRange().text;
            //var localImagId = document.getElementById("localImag");
            //必须设置初始大小
            imgSrc.style.width = "100%";
            imgSrc.style.height = "100%";
            //图片异常的捕捉，防止用户修改后缀来伪造图片;
            try {
                localImagId.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
                localImagId.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc;
            } catch (e) {
                alert("图片格式不正确，请重新选择!");
                return false;
            }
            imgObjPreview.style.display = 'none';
            document.selection.empty();
        }
      
        return true;
    }

    $(".img_preview input").on('change', function () {
        var file = $(this).val();
        var img = $(this).siblings(".preview")[0];
        setImagePreview(file, $(this)[0], img);
      
    });
   


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


    // layui


    $('#submit').on('click', function ()  {
        var Title = $('#Title').val();
        var Suggest = $('#Suggest').val();
        if (Title == '') {
            mui.toast('主题不能为空！');
            return false;
        }
        if (Suggest == '') {
            mui.toast('内容不能为空！');
            return false;
        }
        var paths = "";
        if ($("#file1").val() != "") {
            paths += $("#file1").val() + ",";
        }
        if ($("#file2").val() != "") {
            paths += $("#file2").val() + ",";
        }
        if ($("#file3").val() != "") {
            paths += $("#file3").val() + ",";
        }
        var data = new FormData();
        var fileUpload1 = $("#file1").get(0);
        var files1 = fileUpload1.files;
        for (var i = 0; i < files1.length; i++) {
            data.append("file1", files1[i]);
        }
        var fileUpload2 = $("#file2").get(0);
        var files2 = fileUpload2.files;
        for (var i = 0; i < files2.length; i++) {
            data.append("file2", files2[i]);
        }
        var fileUpload3 = $("#file3").get(0);
        var files3 = fileUpload3.files;
        for (var i = 0; i < files3.length; i++) {
            data.append("file3", files3[i]);
        }
        data.append("Title", Title);
        data.append("Suggest", Suggest);
        data.append("UserID", "3");
        data.append("paths", paths);
        $.ajax({
            type: "post",
            async: false,
            contentType: false,
            // 告诉jQuery不要去设置Content-Type请求头
            processData: false,
            // 告诉jQuery不要去处理发送的数据
            url: "/Admin/GetData.ashx?action=CommitSuggest",
            data: data,
            dataType: "json",
            success: function (result) {
                if (result.code == 0) {
                    alert(result.msg); 
                    window.location.href = "feedbackList.aspx";
                } else {
                    alert(result.msg);
                }
            },
            error: function (errmsg) {
                alert("服务器出错了！" + errmsg);
            }


        })
        });

</script>

