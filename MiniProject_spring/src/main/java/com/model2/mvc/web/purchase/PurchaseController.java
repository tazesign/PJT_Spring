package com.model2.mvc.web.purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;

@Controller
public class PurchaseController {

	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	public PurchaseController() {
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping("/addPurchaseView.do")
	public ModelAndView addPurchaseView(@RequestParam("prod_no") String prodNo) throws Exception{
		
		System.out.println("/addPurchaseView.do");
		
		//Business Logic
		Product product = productService.getProduct(Integer.parseInt(prodNo));
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("product", product);
		modelAndView.setViewName("forward:/purchase/addPurchaseView.jsp");
		
		return modelAndView;
	}
	
	
	@RequestMapping("/addPurchase.do")
	public ModelAndView addPurchase(@RequestParam("prodNo") String prodNo, @ModelAttribute("purchase") Purchase purchase, HttpSession session) throws Exception{
		
		System.out.println("/addPurchase.do");
		
		//세션에서 user정보 꺼내서 user객체에 담기
		User user = (User)session.getAttribute("user");
		purchase.setBuyer(user);
		
		//프로덕트 객체를 펄체이스 필드에 담기
		Product product = new Product();
		product.setProdNo(Integer.parseInt(prodNo));
		purchase.setPurchaseProd(product);
		
		purchase.setDivyDate(purchase.getDivyDate().replaceAll("-", ""));
		purchaseService.addPurchase(purchase);		
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/purchase/addPurchase.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	@RequestMapping("/getPurchase.do")
	public ModelAndView getPurchase(@RequestParam("tranNo") String tranNo) throws Exception {
		
		System.out.println("/getPurchase.do");
		
		Purchase purchase = purchaseService.getPurchase(Integer.parseInt(tranNo));
		
		System.out.println("겟펄체이스확인" + purchase);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/purchase/getPurchase.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	@RequestMapping("/listPurchase.do")
	public ModelAndView listPurchase (@ModelAttribute("search") Search search, HttpSession session) throws Exception{
		System.out.println("/listPurchase.do");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		User user = (User)session.getAttribute("user");
		String buyerId = user.getUserId();
		
		System.out.println("바이어아이디 있나요" + buyerId);
		// Business logic 수행
		Map<String , Object> map = purchaseService.getPurchaseList(search, buyerId);
		
		System.out.println("바이어아이디 있나요22222222222" + buyerId);

		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
			
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("forward:/purchase/listPurchase.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping("/updatePurchaseView.do")
	public ModelAndView updatePurchaseView(@RequestParam("tranNo") String tranNo) throws Exception{
		
		System.out.println("/updatePurchaseView.do");
		
		Purchase purchase = purchaseService.getPurchase(Integer.parseInt(tranNo));
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/purchase/updatePurchaseView.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	@RequestMapping("/updatePurchase.do")
	public ModelAndView updatePurchase(@RequestParam("tranNo") String tranNo, @ModelAttribute("purchase") Purchase purchase) throws Exception{
		
		System.out.println("/updatePurchase.do");
		
		purchase.setTranNo(Integer.parseInt(tranNo));
		purchase.setDivyDate(purchase.getDivyDate().replaceAll("-", ""));
		purchaseService.updatePurchase(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/getPurchase.do?tranNo="+ tranNo);
//		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	@RequestMapping("/updateTranCode.do")
	public ModelAndView updateTranCode(@ModelAttribute("purchase") Purchase purchase, @RequestParam("tranNo") String tranNo, @RequestParam("tranCode") String tranCode) throws Exception{
		
		System.out.println("/updateTranCode.do");
		
		purchase.setTranNo(Integer.parseInt(tranNo));
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/listPurchase.do");
		
		return modelAndView;
	}
	
	@RequestMapping("/updateTranCodeByProd.do")
	public ModelAndView updateTranCodeByCode(@ModelAttribute("product") Product product, @ModelAttribute("purchase") Purchase purchase, @RequestParam("prodNo") String prodNo, @RequestParam("tranCode") String tranCode) throws Exception{
		
		System.out.println("/updateTranCodeByProd.do");
		
		product.setProdNo(Integer.parseInt(prodNo));
		
		purchase.setPurchaseProd(product);
		purchase.setTranCode(tranCode);
		
		purchaseService.updateTranCodeByProd(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/listProduct.do");
		
		return modelAndView;
	}
	
}
