# BrunoNews
<h1>Server Code</h1>
function insert(item, user, request) {</br>
    if((item.title!="")&&(item.author!="")&&(item.contentNew!="")){</br>
        request.execute();</br>
    }else{</br>
        request.respond(statusCodes.BAD_REQUEST, 'Text must be a valid string');</br>
    }</br>
 </br>   
 </br>
}</br>
