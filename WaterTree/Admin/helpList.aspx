<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="helpList.aspx.cs" Inherits="WaterTree.Admin.helpList" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
       <form id="form1" runat="server">
   <div class="treeCareList helpList">
    <div class="treeCareList-search" style="top: 0;">
        <div class="mui-input-row mui-search" style="width: 3.45rem;">
            <input type="search" class="mui-input-clear" placeholder="请输入关键字搜索">
        </div>
    </div>
    <div class="helpList-list">
        <ul class="mui-table-view helpList-list-item">
            <li class="mui-table-view-cell">
                <a class="mui-navigate-right" href="./helpDetail.html">
                    如何修改个人信息？
                </a>
            </li>
            <li class="mui-table-view-cell">
                <a class="mui-navigate-right" href="./helpDetail.html">
                    如何修改个人信息？
                </a>
            </li>
            <li class="mui-table-view-cell">
                <a class="mui-navigate-right" href="./helpDetail.html">
                    如何发布活动？
                </a>
            </li>
            <li class="mui-table-view-cell">
                <a class="mui-navigate-right" href="./helpDetail.html">
                    如何注销用户？
                </a>
            </li>
            <li class="mui-table-view-cell">
                <a class="mui-navigate-right" href="./helpDetail.html">
                    如何修改个人信息？
                </a>
            </li>
            <li class="mui-table-view-cell">
                <a class="mui-navigate-right" href="./helpDetail.html">
                    如何修改个人信息？
                </a>
            </li>
            <li class="mui-table-view-cell">
                <a class="mui-navigate-right" href="./helpDetail.html">
                    如何发布活动？
                </a>
            </li>
            <li class="mui-table-view-cell">
                <a class="mui-navigate-right" href="./helpDetail.html">
                    如何注销用户？
                </a>
            </li>
            <li class="mui-table-view-cell">
                <a class="mui-navigate-right" href="./helpDetail.html">
                    如何修改个人信息？
                </a>
            </li>
            <li class="mui-table-view-cell">
                <a class="mui-navigate-right" href="./helpDetail.html">
                    如何修改个人信息？
                </a>
            </li>
            <li class="mui-table-view-cell">
                <a class="mui-navigate-right" href="./helpDetail.html">
                    如何发布活动？
                </a>
            </li>
            <li class="mui-table-view-cell">
                <a class="mui-navigate-right" href="./helpDetail.html">
                    如何注销用户？
                </a>
            </li>
        </ul>
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
            elem: '.helpList-list-item', //流加载容器
            done: function (page, next) { //执行下一页的回调
                //模拟数据插入
                setTimeout(function () {
                    var lis = [];
                    var str = `<li class="mui-table-view-cell">
                <a class="mui-navigate-right" href="./helpDetail.html">
                    如何修改个人信息111？
                </a>
            </li>`;
                    for (var i = 0; i < 10; i++) {
                        lis.push(str)
                    }

                    // 执行下一页渲染，第二参数为：满足“加载更多”的条件，即后面仍有分页
                    // pages为Ajax返回的总页数，只有当前页小于总页数的情况下，才会继续出现加载更多
                    next(lis.join(''), page < 10); //假设总页数为 10
                }, 100);
            }
        });
    });
</script>
</body>
   </html>
