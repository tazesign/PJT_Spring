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
import org.springframework.web.bind.annotation.RequestMethod;
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
@RequestMapping("/purchase/*")
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
	
	@RequestMapping(value="addPurchase", method=RequestMethod.GET)
	public ModelAndView addPurchase(@RequestParam("prod_no") String prodNo) throws Exception{
		
		System.out.println("/purchase/addPurchase : GET");
		
		//Business Logic
		Product product = productService.getProduct(Integer.parseInt(prodNo));
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("product", product);
		modelAndView.setViewName("forward:/purchase/addPurchaseView.jsp");
		
		return modelAndView;
	}
	
	
	@RequestMapping(value="addPurchase", method=RequestMethod.POST)
	public ModelAndView addPurchase(@RequestParam("prodNo") String prodNo, @ModelAttribute("purchase") Purchase purchase, HttpSession session) throws Exception{
		
		System.out.println("/purchase/addPurchase : POST");
		
		//���ǿ��� user���� ������ user��ü�� ���
		User user = (User)session.getAttribute("user");
		purchase.setBuyer(user);
		
		//���δ�Ʈ ��ü�� ��ü�̽� �ʵ忡 ���
		Product product = productService.getProduct(Integer.parseInt(prodNo));
		purchase.setPurchaseProd(product);
		
		purchase.setDivyDate(purchase.getDivyDate().replaceAll("-", ""));
		purchaseService.addPurchase(purchase);		
		
		//��ǰ����
		int prodQuantity = product.getQuantity();
		
		//���ż���
		int purchaseQuantity = purchase.getQuantity();
		prodQuantity = prodQuantity - purchaseQuantity;
		product.setQuantity(prodQuantity);
		
		System.out.println("��ǰ����===============>" + product.getQuantity());
		productService.updateProduct(product);
		System.out.println("������Ʈ���ٿ��»�ǰ����===============>" + product.getQuantity());
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/purchase/addPurchase.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	
	@RequestMapping(value="getPurchase", method=RequestMethod.GET)
	public ModelAndView getPurchase(@RequestParam("tranNo") String tranNo) throws Exception {
		
		System.out.println("/purchase/getPurchase : GET");
		
		Purchase purchase = purchaseService.getPurchase(Integer.parseInt(tranNo));
				
		System.out.println("����ü�̽�Ȯ��" + purchase);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/purchase/getPurchase.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	
	//������ �����̷� ��ȸ
	@RequestMapping(value="listPurchase")
	public ModelAndView listPurchase (@ModelAttribute("search") Search search, HttpSession session) throws Exception{
		System.out.println("/purchase/listPurchase : GET/POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		User user = (User)session.getAttribute("user");
		String buyerId = user.getUserId();
		
		System.out.println("���̾���̵� �ֳ���" + buyerId);
		// Business logic ����
		Map<String , Object> map = purchaseService.getPurchaseList(search, buyerId);
		
		System.out.println("���̾���̵� �ֳ���22222222222" + buyerId);

		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
			
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("forward:/purchase/listPurchase.jsp");
		
		return modelAndView;
	}
	
	
	//������ �α��ν� ��۰���
	@RequestMapping(value="listManageTran")
	public ModelAndView listManageTran (@ModelAttribute("search") Search search) throws Exception{
		System.out.println("/purchase/listManageTran : GET/POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		String buyerId = null;
		
		// Business logic ����
		Map<String , Object> map = purchaseService.getPurchaseList(search, buyerId);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("list", map.get("list"));
		modelAndView.addObject("resultPage", resultPage);
		modelAndView.addObject("search", search);
		modelAndView.setViewName("forward:/purchase/manageTran.jsp");
		
		return modelAndView;
	}
	
	
	@RequestMapping(value="updatePurchase", method=RequestMethod.GET)
	public ModelAndView updatePurchase(@RequestParam("tranNo") String tranNo) throws Exception{
		
		System.out.println("/purchase/updatePurchase : GET");
		
		Purchase purchase = purchaseService.getPurchase(Integer.parseInt(tranNo));
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/purchase/updatePurchaseView.jsp");
		modelAndView.addObject("purchase", purchase);
		
		return modelAndView;
	}
	
	
	@RequestMapping(value="updatePurchase", method=RequestMethod.POST)
	public ModelAndView updatePurchase(@RequestParam("tranNo") String tranNo, @ModelAttribute("purchase") Purchase purchase) throws Exception{
		
		System.out.println("/purchase/updatePurchase : POST");
		
		purchase.setTranNo(Integer.parseInt(tranNo));
		purchase.setDivyDate(purchase.getDivyDate().replaceAll("-", ""));
		purchaseService.updatePurchase(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/purchase/getPurchase?tranNo="+ tranNo);
		
		return modelAndView;
	}
	
	
	@RequestMapping(value="updateTranCode")
	public ModelAndView updateTranCode(@ModelAttribute("purchase") Purchase purchase, @RequestParam("tranNo") String tranNo, @RequestParam("tranCode") String tranCode) throws Exception{
		
		System.out.println("/purchase/updateTranCode : GET/POST");
		
		purchase.setTranNo(Integer.parseInt(tranNo));
		purchase.setTranCode(tranCode);
		purchaseService.updateTranCode(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/purchase/listPurchase");
		
		return modelAndView;
	}
	
	
	@RequestMapping(value="updateTranCodeByProd")
	public ModelAndView updateTranCodeByCode(@ModelAttribute("product") Product product, @ModelAttribute("purchase") Purchase purchase, @RequestParam("prodNo") String prodNo, @RequestParam("tranCode") String tranCode) throws Exception{
		
		System.out.println("/purchase/updateTranCodeByProd : GET/POST");
		
		product.setProdNo(Integer.parseInt(prodNo));
		
		purchase.setPurchaseProd(product);
		purchase.setTranCode(tranCode);
		
		purchaseService.updateTranCodeByProd(purchase);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/purchase/listManageTran");
		
		return modelAndView;
	}
	
}
