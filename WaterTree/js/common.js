$('body').on('tap','a',function(){
    window.top.location.href=this.href;
});