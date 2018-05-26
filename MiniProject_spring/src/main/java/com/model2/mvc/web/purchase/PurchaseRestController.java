package com.model2.mvc.web.purchase;

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
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;


//==> 구매관리 RestController
@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
		
	public PurchaseRestController(){
		System.out.println(this.getClass());
	}
	@RequestMapping(value="json/addPurchase", method=RequestMethod.POST)
	public void addPurchase(@RequestBody Purchase purchase, HttpSession session) throws Exception {
		System.out.println("/json/addPurchase : POST");
		
		purchase.setDivyDate(purchase.getDivyDate().replaceAll("-", ""));
		purchaseService.addPurchase(purchase);		
		
		System.out.println("디비다녀옴");
		int prodNo = purchase.getPurchaseProd().getProdNo();
		System.out.println("프로드넘버" + prodNo);
		Product product = productService.getProduct(prodNo);
		
		//상품수량
		int prodQuantity = product.getQuantity();
		System.out.println("상품수량" + prodQuantity);
		//구매수량
		int purchaseQuantity = purchase.getQuantity();
		System.out.println("구매수량" +purchaseQuantity);
		prodQuantity = prodQuantity - purchaseQuantity;
		product.setQuantity(prodQuantity);
		
		System.out.println("상품수량===============>" + product.getQuantity());
		productService.updateProduct(product);
		System.out.println("업데이트갔다오는상품수량===============>" + product.getQuantity());
		
//		Purchase dbpurchase = purchaseService.getPurchase(Integer.parseInt(prodNo));
//		return dbpurchase;

	}
	
	@RequestMapping( value="json/getPurchase/{tranNo}", method=RequestMethod.GET )
	public Purchase getPurchase(@PathVariable String tranNo) throws Exception{
		System.out.println("/json/getPurchase : GET");
		
		return purchaseService.getPurchase(Integer.parseInt(tranNo));
	}
	
	@RequestMapping( value="json/updatePurchase", method=RequestMethod.POST )
	public Purchase updatePurchase( @RequestBody Purchase purchase) throws Exception{
		System.out.println("/purchase/json/updatePurchase : POST");
		
		//Business Logic
		purchaseService.updatePurchase(purchase);
		Purchase dbPurchase = purchaseService.getPurchase(purchase.getTranNo());
		
		return dbPurchase;
	}
	
	@RequestMapping( value="json/updateTranCode", method=RequestMethod.POST )
	public void updateTranCode(@RequestBody Purchase purchase) throws Exception{
		System.out.println("/purchase/json/updateTranCode : POST");
		
		//Business Logic
		int tranNo =  purchase.getTranNo();
		purchase.setTranNo(tranNo);
		String tranCode = purchase.getTranCode();
		purchase.setTranCode(tranCode);
		
		purchaseService.updateTranCode(purchase);
	}

	@RequestMapping( value="json/listPurchase")
	public Map<String , Object> listPurchase(@RequestBody Search search) throws Exception{
		System.out.println("/purchase/json/listPurchase : GET / POST");
		
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