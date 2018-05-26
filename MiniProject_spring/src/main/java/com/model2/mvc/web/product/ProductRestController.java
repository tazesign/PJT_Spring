package com.model2.mvc.web.product;

import java.io.File;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.CookieGenerator;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserService;


//==> 상품관리 RestController
@RestController
@RequestMapping("/product/*")
public class ProductRestController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public ProductRestController(){
		System.out.println(this.getClass());
	}
	@RequestMapping(value="json/addProduct", method=RequestMethod.POST)
	public Product addProduct(@RequestBody Product product, @RequestParam("file") MultipartFile file) throws Exception {
		System.out.println("/json/addProduct : POST");
		
		File f = new File("C:\\Users\\Bit\\git\\PJT_Spring\\MiniProject_spring\\WebContent\\images\\uploadFiles\\" + file.getOriginalFilename());
		file.transferTo(f);
		product.setFileName(file.getOriginalFilename());
		
		product.setManuDate(product.getManuDate().replaceAll("-", ""));
		
//		.addProduct(product);
		return product; 
	}
	
	@RequestMapping( value="json/getProduct/{prodNo}", method=RequestMethod.GET )
	public Product getProduct(@PathVariable int prodNo, HttpServletRequest request, HttpServletResponse response) throws Exception{
		System.out.println("/json/getProduct : GET");
		//Business Logic
		
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
		
		CookieGenerator cookieGenerator = new CookieGenerator();
		cookieGenerator.setCookieName("history");
		cookieGenerator.addCookie(response, prodNo + "," + ck);
		
		return productService.getProduct(prodNo);
	}
	
	@RequestMapping( value="json/updateProduct", method=RequestMethod.POST )
	public Product updateProduct( @RequestBody Product product) throws Exception{
		System.out.println("/product/json/updateProduct : POST");
		
		//Business Logic
		productService.updateProduct(product);
		Product dbProduct = productService.getProduct(product.getProdNo());
		
		return dbProduct;
	}
	
	@RequestMapping( value="json/listProduct")
	public Map<String , Object> listProduct( @ModelAttribute Search search) throws Exception{
		System.out.println("/product/json/listProduct : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		
		int pageSize = 3;
		int pageUnit = 5;

		search.setPageSize(pageSize);
		
		//Business Logic
		Map<String , Object> map = productService.getProductList(search);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("리스트맵" + map);
		return map;
	}


}