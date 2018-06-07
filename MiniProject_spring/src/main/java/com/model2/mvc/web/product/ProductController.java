package com.model2.mvc.web.product;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.DiskFileUpload;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.CookieGenerator;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.product.impl.ProductServiceImpl;


//==> 회원관리 Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	         
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping(value="addProduct", method=RequestMethod.GET)
	public String addProduct() throws Exception {

		System.out.println("/product/addProduct : GET");
		
		return "forward:/product/addProductView.jsp";
	}	
	
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public String addProduct( @ModelAttribute("product") Product product,HttpServletRequest request, @RequestParam("file") MultipartFile file) throws Exception {

		System.out.println("/product/addProduct : POST");
		
		File f = new File("C:\\Users\\Bit\\git\\PJT_Spring\\MiniProject_spring\\WebContent\\images\\uploadFiles\\" + file.getOriginalFilename());
		file.transferTo(f);
		product.setFileName(file.getOriginalFilename());
		System.out.println("상품수량있냐" + product.getQuantity());
		
		
		/*if(FileUpload.isMultipartContent(request)) {
			String temDir = "C:\\Users\\Bit\\git\\PJT_Spring\\MiniProject_spring\\WebContent\\images\\uploadFiles\\";
			
			DiskFileUpload fileUpload = new DiskFileUpload();
			fileUpload.setRepositoryPath(temDir);
			fileUpload.setSizeMax(1024 * 1024 * 10);
			fileUpload.setSizeThreshold(1024 * 100);
			
			if(request.getContentLength() < fileUpload.getSizeMax()) {
				StringTokenizer token = null;
				
				List fileItemList = fileUpload.parseRequest(request);
				int size = fileItemList.size();
				for (int i = 0; i < size; i++) {
					FileItem fileItem = (FileItem)fileItemList.get(i);
					if(fileItem.isFormField()) {
						if(fileItem.getFieldName().equals("manuDate")) {
							token = new StringTokenizer(fileItem.getString("euc-kr"),"-");
							String manuDate = token.nextToken() + token.nextToken() + token.nextToken();
							product.setManuDate(manuDate);
						}
						else if(fileItem.getFieldName().equals("prodName")) {
							product.setProdName(fileItem.getString("euc-kr"));
						}
						else if(fileItem.getFieldName().equals("prodDetail")) {
							product.setProdDetail(fileItem.getString("euc-kr"));
						}
						else if(fileItem.getFieldName().equals("price")) {
							product.setPrice(Integer.parseInt(fileItem.getString("euc-kr")));
						}
						else if(fileItem.getFieldName().equals("quantity")) {
							product.setQuantity(Integer.parseInt(fileItem.getString("euc-kr")));
						}
					}else { //파일형식이면
						if(fileItem.getSize()>0){
							int idx = fileItem.getName().lastIndexOf("\\");
							if(idx ==-1) {
								idx = fileItem.getName().lastIndexOf("/");
							}
							String fileName = fileItem.getName().substring(idx+1);
							product.setFileName(fileName);
							try {
								File uploadedFile = new File(temDir,fileName);
								fileItem.write(uploadedFile);
							}catch (IOException e) {
								System.out.println(e);
							}
						}else {
							product.setFileName("../../images/empty.GIF");
						}
					}
				}
					request.setAttribute("product", product);					
			}else {
				int overSize = (request.getContentLength() / 1000000);
				System.out.println("파일의 크기는 1MB까지 입니다. 올리신 파일 용량은 + " +overSize + "MB입니다.");
				System.out.println("history.back();<script>");
			}			
		}else {
			System.out.println("인코딩 타입이 multipart/form-data가 아닙니다...");
		}*/
		
		product.setManuDate(product.getManuDate().replaceAll("-", ""));
		productService.addProduct(product);
		System.out.println("상품수량있냐2222222222222" + product.getQuantity());
		
		return "forward:/product/addProduct.jsp";
	}
	
	@RequestMapping(value="getProduct", method=RequestMethod.GET)
	public String getProduct( @RequestParam("prodNo") int prodNo , Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		System.out.println("/product/getProduct : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		Cookie[] c = request.getCookies();
		String ck = null;
		if (c!=null && c.length > 0) {
			for (int i = 0; i<c.length; i++) {
				Cookie cookie = c[i];
				if (cookie.getName().equals("history")) {
					ck  = c[i].getValue();
				}
			}
		}

//		Cookie cookie = new Cookie("history", prodNo + "," + ck);
//		response.addCookie(cookie);
//		System.out.println("[ 쿠키값 ]" + cookie);
		
		CookieGenerator cookieGenerator = new CookieGenerator();
		cookieGenerator.setCookieName("history");
		cookieGenerator.addCookie(response, prodNo + "," + ck);
		
		return "forward:/product/getProduct.jsp";
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public String updateProduct( @RequestParam("prodNo") int prodNo, Model model ) throws Exception{

		System.out.println("/product/updateProduct : GET");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		return "forward:/product/updateProductView.jsp";
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public String updateProduct( @ModelAttribute("product") Product product , @RequestParam("file") MultipartFile file) throws Exception{

		System.out.println("업뎃프로덕트시작넘버===========" + product.getProdNo());
		System.out.println("/product/updateProduct : POST");
		
		File f = new File("C:\\Users\\Bit\\git\\PJT_Spring\\MiniProject_spring\\WebContent\\images\\uploadFiles\\" + file.getOriginalFilename());
		file.transferTo(f);
		product.setFileName(file.getOriginalFilename());
		product.setManuDate(product.getManuDate().replaceAll("-", ""));
		
		//Business Logic
		productService.updateProduct(product);
		System.out.println("업뎃프로덕트끝넘버===========" + product.getProdNo());
		
		
		return "redirect:/product/getProduct?prodNo="+ product.getProdNo() +"&menu=manage";
	}
	
	@RequestMapping(value="listProduct")
	public String listProduct( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/product/listProduct : GET/POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		System.out.println("=================테스트1111111===================");
		
		// Business logic 수행
		Map<String , Object> map= productService.getProductList(search);
		System.out.println("=================테스트2222222===================");
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		String result = "";
		if(request.getParameter("menu").equals("search")) {
			result = "forward:/product/listProductSCH.jsp";
		}else {
			result = "forward:/product/listProductMG.jsp";
		}
		
		return result;
	}
}