function login(){
    var username = document.getElementById("ID").value;
    var password = document.getElementById("PASSWORD").value;
    if(username==""){
        $.jGrowl("鐢ㄦ埛鍚嶄笉鑳戒负绌猴紒", { header: '鎻愰啋' });
    }else if(password==""){
        $.jGrowl("瀵嗙爜涓嶈兘涓虹┖锛�", { header: '鎻愰啋' });
    }else{
        AjaxFunc();
    }
}
function AjaxFunc()
{
    var username = document.getElementById("ID").value;
    var password = document.getElementById("PASSWORD").value;
    $.ajax({
        type: 'get',
        url: "",
        dataType: "json",
        data: {"username": username,"password": password},
        success: function (data) {
            
        },
        error: function (xhr, type) {
            console.log(xhr);
        }
    });
}