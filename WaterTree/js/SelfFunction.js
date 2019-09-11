var _sLocalValidCode = "cxj";

//////var strUrl = "http://www.zxcn.com";
var strUrl="http://www.sun-info.com:9007";
////域名根目录 cxj_add
var APP_DOMAIN_ROOT = strUrl;

//api连接前缀
var APP_DOMAIN = strUrl + "/WeiXin_Web_Water/WX_Web_Water_Handler.ashx";
////活动在服务器上的目录；
var APP_DOMAIN_USER_PIC_FOLDER = strUrl + "/imgtask/";
////树木上传的API地址
var APP_DOMAIN_WITH_PIC = strUrl + "/imgtree/";


localStorage.setItem("pub_departid",1);
localStorage.setItem("pub_departid_path",",1,");
localStorage.setItem("pub_departname","水乡管委会");
localStorage.setItem("pub_departname_path","水乡管委会");
localStorage.setItem("pub_is_login",1);

localStorage.setItem("pub_mobile",123456);
localStorage.setItem("pub_roleid",18);
localStorage.setItem("pub_rolename","系统管理员组");
localStorage.setItem("pub_userid",111);
localStorage.setItem("pub_username","系统管理员");
localStorage.setItem("pub_wx_avatarurl","http://thirdwx.qlogo.cn/mmopen/vi_32/Q0j4TwGTfTJefX7NRSzu6schicThZmjEfMFDZ4y8TYrGQcINEFMibzMLcRRjOHOFwiaicM369rFvicaP7c7nYIFvHQQ/132");

localStorage.setItem("pub_wx_nickname","cxj");
localStorage.setItem("pub_wx_openid","ojFZ2xE97PK8RK9H7tbN5u3Mk0U4");
localStorage.setItem("pub_wx_sex","男");









//登录信息检查 --作废
function CheckIsLogin() {
    var suserid = localStorage.getItem("pub_userid");
    var susername = localStorage.getItem("pub_wx_openid");
    var sislogin=localStorage.getItem("pub_is_login");
    if (suserid == "" || suserid == null || susername == "" || susername == null || sislogin !="1" ) {
        alert('登录数据为空！请重新登录或绑定！' + window.location);
         window.location.href = 'main.aspx';
    }

}

var spage = window.location.toString();
spage = spage.substr(spage.lastIndexOf('/') + 1);
// if (spage !="main.aspx" && spage !="reg.html") {
//     CheckIsLogin();
// }


 

// 获取url中的参数
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)");
    var r = window.location.search.substr(1).match(reg);
    if (r != null) {
        return unescape(r[2]);
    } else {
        return null;
    }
}


function getRadioRes(strName) {
    var rdsObj = document.getElementsByName(strName);
    var checkVal = null;
    for (i = 0; i < rdsObj.length; i++) {
        if (rdsObj[i].checked) { checkVal = rdsObj[i].value; }
    }
    return checkVal;
}

function getSelectRes(strName) {
    var rdsObj = document.getElementsByName(strName)[0];
    var checkVal = null;
    for (i = 0; i < rdsObj.length; i++) {
        if (rdsObj[i].selected) {
            checkVal = rdsObj[i].value;
        }
    }
    return checkVal;
}

function GetSecretCode() {
    var pub_encryptkeycode = "cxj";  /////加密用的密钥
    var myDate = new Date();
    var i = myDate.getFullYear() + (myDate.getMonth() + 1) * myDate.getDate();
    return pub_encryptkeycode + i.toString();
}
/**
 * @description 获取数据
 * @param {URIString} method  需要请求数据的接口地址
 * @param {Object} parm 提交的参数
 * */
function request(method, parm, callback, errcallback) {
 
 
    parm.secretcode = GetSecretCode();
    parm.keycode = md5(_sLocalValidCode + method);
    parm.opc = method;

    mui.ajax(APP_DOMAIN, {
        data: parm,
        // 		dataType: 'json', //要求服务器返回json格式数据
        // 		type: 'GET', //HTTP请求类型，要和服务端对应，要么GET,要么POST
        timeout: 60000, //超时时间设置为6秒；
        beforeSend: function () {
            mui.toast("加载中...");
        },
        success: function (data) {
            console.log(data);
            //alert(method+data)
            if (data && data != undefined) {
                callback(data);
            } else {
                mui.toast("服务器繁忙,请稍后再试..."); 
            }
        },
        error: function (xhr, type, errorThrown) { //失败，打一下失败的类型，主要用于调试和用户体验
            
           console.log (xhr.responseText + " " + xhr.status + " " + xhr.statusText)
           console.log ( '【AJAX:ERR】【' + method + '】错误T:' + type + '|H:' + errorThrown);
            if (type == 'timeout' || type == 'abort') {
                mui.toast("请求超时：请检查网络");
                 

            } else {
                mui.toast("服务器暂无法连接：" + type)

            }
            if (errcallback) {
                errcallback();
            }
        },
        complete: function () {
            console.log(  '【AJAX:END】【' + method + '】【命令执行完成】');
             

        }
    }); //ajax end
} //获取数据结束
 

var waitingStyle = {
    style: "black",
    color: "#FF0000",
    background: "rgba(0,0,0,0)",
    loading: {
        icon: "../img/loading.gif",
        display: "inline"
    }
}
function openNew(target, parm, autoShow) {

    var isAutoShow = autoShow || true;
    mui.openWindow({
        url: target,
        id: target,
        show: {
            autoShow: isAutoShow, //页面loaded事件发生后自动显示，默认为true
            aniShow: 'pop-in',
            duration: 200
        },
        waiting: {
            autoShow: true,
            options: waitingStyle
        },
        extras: {
            info: parm
        }
    })
}