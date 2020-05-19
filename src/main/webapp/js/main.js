function initToastr() {
    toastr.options = {
        closeButton: true,
        progressBar: true,
        timeOut: "2000",
        positionClass: "toast-bottom-right",
        debug: false
    };

}

function sleep(milliSeconds) {
    var startTime = new Date().getTime();
    while (new Date().getTime() < startTime + milliSeconds) {
        console.log(new Date().getTime());
    }
}


function getUserAvatarPath(username) {
    var userAvatarPath = "";
    $.ajax({
        async: false,
        type: 'GET',
        url: 'v1/user/avatar/' + username,
        dataType: 'json',
        success: function (result) {
            userAvatarPath = result.userAvatarPath;
        },
        error: function (result) {
            toastr.error('There is a issue with your internet.', 'Error');
        }
    });
    return userAvatarPath;
}

function getImageInfoById(imageId) {
    var ajaxSuccess = false;
    var imageData = "";
    $.ajax({
        async: false,
        type: 'GET',
        url: 'v1/image/' + imageId,
        dataType: 'json',
        success: function (result) {
            imageData = result;
        },
        error: function (result) {
            toastr.error('There is a issue with your internet.', 'Error');
        }
    });

    return imageData;
}



function gotoImageViewPageWithImageId(imageId) {
    var url = "v1/view/image/" + imageId;
    window.location.href = url;
}

function gotoSearchPage(searchType, keyword, pageNum) {
    var url = "v1/view/search?searchType=" + searchType + "&keyword=" + keyword + "&pageNum=" + pageNum;
    window.location.href = url;
}

function getRequestArgs(strParame) {
    var args = new Object();
    var query = location.search.substring(1);


    var pairs = query.split("&");
    for(var i = 0; i < pairs.length; i++) {
        var pos = pairs[i].indexOf("=");
        if (pos == -1) continue;
        var argname = pairs[i].substring(0,pos);
        var value = pairs[i].substring(pos+1);
        value = decodeURIComponent(value);
        args[argname] = value;
    }
    return args[strParame];
}

function displayImageInGallery(containerId, imagesRawData) {
    var imageGalleryContainer = document.getElementById(containerId);
    var imageGalleryHTML = "";
    var imagesData = imagesRawData.content;
    for (i in imagesData) {
        var imageHTML = "<div class=\"col-lg-4 col-md-6 mb-4\">\n" +
            "            <div class=\"card border-0 image-card\" onclick=\"gotoImageViewPageWithImageId('" + imagesData[i].imageId + "')\" style=\"cursor: pointer\">\n" +
            "                <img class=\"card-img-top imageGallery-ind\" src=\"" + imagesData[i].path + "\" alt=\"\">\n" +
            "                <div class=\"card-footer bg-dark text-light\">\n" +
            "                    <div align=\"left\">\n" +
            "                        <span class=\"text-left\" style=\"float:left\">" + imagesData[i].title + "</span>\n" +
            "                    </div>\n" +
            "                    <div align=\"right\">\n" +
            "                        <span>" + imagesData[i].numComments + "</span>\n" +
            "                        <i class=\"far fa-comment pr-2\"></i>\n" +
            "                        <span>" + imagesData[i].views + "</span>\n" +
            "                        <i class=\"far fa-eye\"></i>\n" +
            "                    </div>\n" +
            "                </div>\n" +
            "            </div>\n" +
            "        </div>";

        imageGalleryHTML += imageHTML;
    }

    imageGalleryContainer.innerHTML = imageGalleryHTML;

}