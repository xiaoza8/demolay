package com.hxkc.controller.admin.system;

import java.util.List;

import com.hxkc.common.JsonResult;
import com.hxkc.entity.AddedinputResource;
import com.hxkc.service.IResourceAddinputService;
import com.hxkc.vo.ZtreeView;
import com.hxkc.entity.AddedResource;
import com.hxkc.service.IResourceAddService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hxkc.controller.BaseController;
import com.hxkc.entity.Resource;
import com.hxkc.service.IResourceService;

//https://github.com/iwin4aids/layui-upload-demo/tree/master/src

@Controller
@RequestMapping("/admin/resource")
public class ResourceController extends BaseController {
	@RequestMapping("news/uploadFile")
	public String uploadFile(MultipartFile newpic)
			throws IllegalStateException, IOException {
		// 原始图片名称
		String oldFileName = newpic.getOriginalFilename(); // 获取上传文件的原名
		// 存储路径
		String saveFilePath = "D://新建文件夹 (4)//house//src//main//webapp//housepic";
		// 新的图片名称
		String newFileName = UUID.randomUUID() + oldFileName.substring(oldFileName.lastIndexOf("."));
		// 新图片
		File newFile = new File(saveFilePath + "\\" + newFileName);
		// 将内存中的数据写入磁盘
		newpic.transferTo(newFile);
		// 将路径名存入全局变量mynewpic
		mynewpic = "./housepic/"+newFileName;
	}


	@RestController
	//@RequestParam("images") 这里的images对应表单中name 然后MultipartFile 参数名就可以任意了
	@RequestMapping(value = "/image/save-test",method = RequestMethod.POST)
	public UploadResponseData saveImg(@RequestParam("images") MultipartFile file) throws IOException {
		String pathname = "";
		String returnPath = "";
		if (!file.isEmpty()){
			String fileName = file.getOriginalFilename();
			File path = new File(ResourceUtils.getURL("classpath:").getPath());//获取Spring boot项目的根路径，在开发时获取到的是/target/classes/
			System.out.println(path.getPath());//如果你的图片存储路径在static下，可以参考下面的写法
			File uploadFile = new File(path.getAbsolutePath(), "static/images/upload/");//开发测试模式中 获取到的是/target/classes/static/images/upload/
			if (!uploadFile.exists()){
				uploadFile.mkdirs();
			}
			//获取文件后缀名
			String end = FilenameUtils.getExtension(file.getOriginalFilename());
			DateFormat df = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			//图片名称 采取时间拼接随机数
			String name = df.format(new Date());
			Random r = new Random();
			for(int i = 0 ;i < 3 ;i++){
				name += r.nextInt(10);
			}
			String diskFileName = name + "." +end; //目标文件的文件名
			pathname = uploadFile.getPath()+ "/" + diskFileName;
			System.out.println(pathname);
			returnPath = "images/upload/" + diskFileName;//这里是我自己做返回的字符串

			file.transferTo(new File(pathname));//文件转存
		}//UploadResponseData 自定义返回数据类型实体{int code, String msg, Object data}
		return new UploadResponseData(CodeEnum.SUCCESS.getCode(),MsgEnum.SUCCESS.getMsg(),new Img(returnPath,new Date()));
	}
}
