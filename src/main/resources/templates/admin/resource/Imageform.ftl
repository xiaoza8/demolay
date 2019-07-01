<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">


    <title> - 表单验证 jQuery Validation</title>
    <meta name="keywords" content="">
    <meta name="description" content="">

    <link rel="shortcut icon" href="favicon.ico"> 
    <link href="${ctx!}/assets/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="${ctx!}/assets/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="${ctx!}/assets/css/animate.css" rel="stylesheet">
    <link href="${ctx!}/assets/css/style.css?v=4.1.0" rel="stylesheet">

</head>

<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">

        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>编辑</h5>
                    </div>
                    <div class="ibox-content">
                        <form class="form-horizontal m-t" id="frm" method="post" enctype="multipart/form-data" action="${ctx!}/admin/resource/edit">
                           <div class="form-group">
                              <div class="col-sm-8 col-sm-offset-3">
                        	      <input type="text" name="head" >
                        	  </div>
                        	</div>
                        	 <div class="form-group">
                                  <div class="col-sm-8 col-sm-offset-3">
                                     <input type="text" name="body">
                                  </div>
                              </div>
                               <div class="form-group">
                                         <div class="col-sm-8 col-sm-offset-3">
                                            <input type="file" name="newpic"  class="myfile"/>
                                    </div>
                               </div>


                            <div class="form-group">
                                <div class="col-sm-8 col-sm-offset-3">
                                    <button class="btn btn-primary" type="submit">提交</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </div>


    <!-- 全局js -->
    <script src="${ctx!}/assets/js/jquery.min.js?v=2.1.4"></script>
    <script src="${ctx!}/assets/js/bootstrap.min.js?v=3.3.6"></script>

    <!-- 自定义js -->
    <script src="${ctx!}/assets/js/content.js?v=1.0.0"></script>

    <!-- jQuery Validation plugin javascript-->
    <script src="${ctx!}/assets/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="${ctx!}/assets/js/plugins/validate/messages_zh.min.js"></script>
    <script src="${ctx!}/assets/js/plugins/layer/layer.min.js"></script>
    <script src="${ctx!}/assets/js/plugins/layer/laydate/laydate.js"></script>
     <script src="${ctx!}/assets/js/fileinput.min.js"></script>
    <script type="text/javascript">
    $(document).ready(function () {
	  	
	    $("#frm").validate({
    	    rules: {
    	    	name: {
    	        required: true,
    	        minlength: 4,
    	    	maxlength: 20
    	      },
    	      	sourceKey: {
    	        required: true,
    	        minlength: 4,
    	    	maxlength: 40
    	      },
    	      	type: {
    	        required: true
    	      },
    	      	sourceUrl: {
    	        required: true
    	      },
    	      	level: {
    	        required: true,
    	        number:true
    	      },
    	      	sort: {
    	      	number:true,
    	        required: true
    	      },
    	      	icon: {
    	        maxlength: 40
    	      },
    	      	isHide: {
    	        required: true
    	      },
    	      	description: {
    	        required: true,
    	        maxlength: 40
    	      }
    	    },
    	    messages: {},
    	    submitHandler:function(form){
    	    	$.ajax({
   	    		   type: "POST",
   	    		   dataType: "json",
   	    		   url: "${ctx!}/admin/resource/edit",
   	    		   data: $(form).serialize(),
   	    		   success: function(msg){
	   	    			layer.msg(msg.message, {time: 2000},function(){
	   						var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	   						parent.layer.close(index); 
	   					});
   	    		   }
   	    		});
            } 
    	});
    });

    $(".myfile").fileinput({
          uploadUrl:"${APP_PATH}/news/uploadFile", //接受请求地址
          uploadAsync : true, //默认异步上传
          showUpload : false, //是否显示上传按钮,跟随文本框的那个
          showRemove : false, //显示移除按钮,跟随文本框的那个
          showCaption : true,//是否显示标题,就是那个文本框
          showPreview : true, //是否显示预览,不写默认为true
          dropZoneEnabled : false,//是否显示拖拽区域，默认不写为true，但是会占用很大区域
          //minImageWidth: 50, //图片的最小宽度
          //minImageHeight: 50,//图片的最小高度
          //maxImageWidth: 1000,//图片的最大宽度
          //maxImageHeight: 1000,//图片的最大高度
          //maxFileSize: 0,//单位为kb，如果为0表示不限制文件大小
          //minFileCount: 0,
          maxFileCount : 1, //表示允许同时上传的最大文件个数
          enctype : 'multipart/form-data',
          validateInitialCount : true,
          previewFileIcon : "<i class='glyphicon glyphicon-king'></i>",
          msgFilesTooMany : "选择上传的文件数量({n}) 超过允许的最大数值{m}！",
          allowedFileTypes : [ 'image' ],//配置允许文件上传的类型
          allowedPreviewTypes : [ 'image' ],//配置所有的被预览文件类型
          allowedPreviewMimeTypes : [ 'jpg', 'png', 'gif' ],//控制被预览的所有mime类型
          language : 'zh'
      })
      //异步上传返回结果处理
      $('.myfile').on('fileerror', function(event, data, msg) {
          console.log("fileerror");
          console.log(data);
      });
      //异步上传返回结果处理
      $(".myfile").on("fileuploaded", function(event, data, previewId, index) {
          console.log("fileuploaded");
          var ref = $(this).attr("data-ref");
          $("input[name='" + ref + "']").val(data.response.url);

      });

      //上传前
      $('.myfile').on('filepreupload', function(event, data, previewId, index) {
          console.log("filepreupload");
      });
    </script>

</body>

</html>
