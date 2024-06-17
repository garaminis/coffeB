	
/**
 *에디터내용 저장 
 */
let oEditors = []; 
let imageFileNames = [];
let imagePath;

nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "txtContent",
	sSkinURI: "/libs/smarteditor/SmartEditor2Skin.html",
	fCreator: "createSEditor2",
	htParams: { 
		bUseToolbar: true, 
		bUseVerticalResizer: false, 
		bUseModeChanger: false 
	}
});
		   
		   
 function save() {
    // 에디터의 내용을 업데이트합니다.
    oEditors.getById["txtContent"].exec("UPDATE_CONTENTS_FIELD", []);
    
    // 제목과 내용을 가져옵니다.
    let id = $("#id").val();
    let title = $("#title").val();
    let category = $("#category").val();
    let content = $("#txtContent").val();

    console.log("save content:", content);

    let imageFileNames = [];  // imageFileNames 배열 초기화

    // 이미지 파일 이름 추출과 동시에 content 변수 수정
    let regex = /\/([^\/]+\.(jpg|jpeg|png|gif))/gi;
    let match;
    while (match = regex.exec(content)) {
        let imageName = match[1];
        imageFileNames.push(imageName);
        // content 변수 수정
        let pattern = new RegExp('(/image_' + boardName +'/temp_img/' + imageName + ')', 'g');
        content = content.replace(pattern, '/image_' + boardName +'/final_img/' + imageName); 
    }
    
 	// 제목이미지 업로드 경로(절대경로-> 이름만 추출)
    let titleImagePath = $("#titleImagePreview").attr("src");
    let titleimageName = titleImagePath.substring(titleImagePath.lastIndexOf('/') + 1);
    let finalImagePath = '/image_' + boardName +'/title_img/' + titleimageName; // 최종 이미지 경로

     let requestData = {
        imageFileNames: imageFileNames,
        operationType: boardName,
        id: id,
        category: category,
        title: title,
        title_img: finalImagePath,
        content: content// 또는 'other'
    };
    
    $.ajax({
        type: "POST",
        url: '/' + boardName + '/new',
        data: JSON.stringify(requestData), // 이미지 경로를 추가
        contentType: "application/json",  // contentType 추가
        success: function(response) {
            alert("내용이 성공적으로 저장되었습니다2!");
            location.href = document.referrer;
        },
        error: function(xhr, status, error) {
            alert("내용 저장 중 오류가 발생했습니다3: " + error);
        }
    });
};

function update() {
    // 에디터의 내용을 업데이트합니다.
    oEditors.getById["txtContent"].exec("UPDATE_CONTENTS_FIELD", []);
    
    // 제목과 내용을 가져옵니다.
    let id = $("#post_id").val();
    let title = $("#title").val();
    let category = $("#category").val();
    let content = $("#txtContent").val();

    console.log("save content:", content);

    let imageFileNames = [];  // imageFileNames 배열 초기화

    // 이미지 파일 이름 추출과 동시에 content 변수 수정
    let regex = /\/([^\/]+\.(jpg|jpeg|png|gif))/gi;
    let match;
    while (match = regex.exec(content)) {
        let imageName = match[1];
        imageFileNames.push(imageName);
        // content 변수 수정
        let pattern = new RegExp('(/image_' + boardName +'/temp_img/' + imageName + ')', 'g');
        content = content.replace(pattern, '/image_' + boardName +'/final_img/' + imageName); 
    }
    
 	// 제목이미지 업로드 경로(절대경로-> 이름만 추출)
    let titleImagePath = $("#titleImagePreview").attr("src");
    let titleimageName = titleImagePath.substring(titleImagePath.lastIndexOf('/') + 1);
    let finalImagePath = '/image_' + boardName +'/title_img/' + titleimageName; // 최종 이미지 경로

     let requestData = {
        imageFileNames: imageFileNames,
        operationType: boardName,
        id: id,
        category: category,
        title: title,
        title_img: finalImagePath,
        content: content// 또는 'other'
    };
    
    $.ajax({
        type: "PUT",
        url: '/' + boardName + '/edite',
        data: JSON.stringify(requestData), // 이미지 경로를 추가
        contentType: "application/json",  // contentType 추가
        success: function(response) {
            alert("내용이 성공적으로 수정되었습니다2!");
            location.href = document.referrer;
        },
        error: function(xhr, status, error) {
            alert("내용 저장 중 오류가 발생했습니다3: " + error);
        }
    });
};
    

function titleuploadImage(inputId) {
  let titlefileInput = $('#' + inputId)[0].files[0];
    	
	// 이미지 확장자 검사
	let extensions = ['jpg', 'gif', 'png', 'jpeg', 'bmp'];
	let filePath = titlefileInput.name.toLowerCase();
	let fileExtension = filePath.split('.').pop();

	if (!extensions.includes(fileExtension)) {
		alert('이미지 파일만 선택할 수 있습니다.');
		return false;
	}
        
	let formData = new FormData();
	formData.append('file', titlefileInput);
        
	// 이미지를 서버에 업로드합니다.
	$.ajax({
		type: "POST",
		url: "/titleuploadImage",
		data: formData,
		processData: false,
		contentType: false,
		success: function(data) {
			if (data) {
				let imageFileName = data.imageFileName;
				let imagePath = '/img/all_goods/' + imageFileName;
				$('#' + inputId).attr('src', imagePath);
				console.log("저장될 제목 이미지 경로 :" + imagePath)
			} else {
				alert("이미지 업로드에 실패했습니다.");
			}
		},
		error: function(xhr, status, error) {
			alert("이미지 업로드 중 오류가 발생했습니다: " + error);
		}
	}); 
};


//이미지 업로드 함수
function uploadImage(event) {
	let fileInput = event.target.files[0];
	
    // 이미지 확장자 검사
    let extensions = ['jpg', 'gif', 'png', 'jpeg', 'bmp'];
    let filePath = fileInput.name.toLowerCase();
    let fileExtension = filePath.split('.').pop();

    if (!extensions.includes(fileExtension)) {
        alert('이미지 파일만 선택할 수 있습니다.');
        return false;
    }
    
    let formData = new FormData();
    formData.append('file', fileInput);
    
    // 이미지를 서버에 업로드합니다.
    $.ajax({
        type: "POST",
        url: "/uploadImage",
        data: formData,
        processData: false,
        contentType: false,
        success: function(data) {
            if (data) {
                let imagePath = '/img/all_goods/' + data.imageFileName; // 이미지 저장 경로에 파일 이름을 추가합니다.  
                pasteHTML(imagePath);
            } else {
                alert("이미지 업로드에 실패했습니다.");
            }
        },
        error: function(xhr, status, error) {
            alert("이미지 업로드 중 오류가 발생했습니다: " + error);
        }
    }); 
};

//에디터에 이미지를 삽입하는 함수
function pasteHTML(filepath) {
    let sHTML = '<img src="' + filepath + '">';
    oEditors.getById["txtContent"].exec("PASTE_HTML", [sHTML]);
};


