var app_config = {
	version: '1.0.0',
	cssAr: [
		'css/mui.min.css',
        'layui/css/layui.css',
        'css/style.css',
		'fonts/iconfont.css'
	],
	jsAr: [
        'js/rem.js',
        'js/jquery-3.3.1.min.js',
        'js/mui.min.js',
        'layui/layui.js',
        'js/common.js', 
		'js/md5.min.js', 
		'js/SelfFunction.js'
	]
}

 
 
Array.prototype._distinct = function() {
	var arr = this,
		result = [],
		_result = [],
		len = arr.length;
	arr.forEach(function(v, i, arr) {
		var _v = v.split('/')[v.split('/').length - 1];
		if(_result.indexOf(_v) === -1) {
			result.push(v);
			_result.push(_v);
		} else {
			//替换默认引入文件
			result[_result.indexOf(_v)] = v;
			_result[_result.indexOf(_v)] = _v;
		}
	})
	return result;
};
//////如果type为true ，则只包括传入的样式；为false或不输入，则在传入的基础上还加上上面配置的公共的样式；
function link(cssAr, type) {
	var cssAr = type ? cssAr._distinct() : app_config.cssAr.concat(cssAr || [])._distinct();
	for(var i = 0; i < cssAr.length; i++) {
		document.write('<link rel="stylesheet" href="' + cssAr[i] + '?version=' + app_config.version + '"/>');
	}
}
//////如果type为true ，则只包括传入的脚本；为false或不输入，则在传入的基础上还加上上面配置的公共的脚本；
function script(jsAr, type) {
	var jsAr = type ? jsAr._distinct() : app_config.jsAr.concat(jsAr || [])._distinct();
	for(var i = 0; i < jsAr.length; i++) {
		document.write('<script src="' + jsAr[i] + '?version=' + app_config.version + ' type="text/javascript" charset="utf-8"><\/script>');
	}
}