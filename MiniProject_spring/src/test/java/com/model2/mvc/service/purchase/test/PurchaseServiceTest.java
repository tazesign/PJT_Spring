package com.model2.mvc.service.purchase.test;


import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.purchase.PurchaseService;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/commonservice.xml" })
public class PurchaseServiceTest {

	@Autowired
	@Qualifier("purchaseServiceImpl")
	PurchaseService purchaseService;
	
//	@Test
	public void testAddPurchase() throws Exception {
		
		Purchase purchase = new Purchase();
		
		User user = new User();
		user.setUserId("jooyeon");

		Product product = new Product();
		product.setProdNo(10080);
		
		purchase.setPurchaseProd(product);
		purchase.setBuyer(user);
		purchase.setDivyAddr("서울");
		purchase.setDivyDate("2018-04-30");
		purchase.setDivyRequest("빠른배송");
		purchase.setPaymentOption("0");
		purchase.setReceiverName("호호");
		purchase.setReceiverPhone("010-999-9999");
		purchase.setTranCode("1");
		
		purchaseService.addPurchase(purchase);		
		
		System.out.println(purchase + "구매완료확인");
		
//		purchase = purchaseService.getPurchase(10104);
		
		//==> API 확인
//		Assert.assertEquals("서울", purchase.getDivyAddr());
	}
	
	
//	@Test
	public void testGetPurchase() throws Exception {
		
		Purchase purchase = new Purchase();
		purchase = purchaseService.getPurchase(10104);

		//==> console 확인
		System.out.println("구매상세조회" + purchase);
		
		//==> API 확인
//		Assert.assertEquals(10080, product.getProdNo());
		Assert.assertEquals("서울", purchase.getDivyAddr());
//		Assert.assertEquals("우유", product.getProdDetail());
//		Assert.assertEquals("20180426", product.getManuDate());
//		Assert.assertEquals(1300, product.getPrice());
//		Assert.assertEquals("ddd", product.getFileName());
//
//		Assert.assertNotNull(productService.getProduct(10080));
//		Assert.assertNotNull(productService.getProduct(10060));
	}
	
//	@Test
	 public void testUpdateUser() throws Exception{
		 
		Purchase purchase = purchaseService.getPurchase(10104);
		Assert.assertNotNull(purchase);	//purchase안에 들어있는게 null 인지아닌지
		
		Assert.assertEquals("서울", purchase.getDivyAddr());
		
		purchase.setDivyAddr("경기");
		purchase.setDivyDate("2018-05-01");
		purchase.setDivyRequest("빠른배송");
		purchase.setPaymentOption("0");
		purchase.setReceiverName("히히");
		purchase.setReceiverPhone("010-888-8888");
		purchase.setTranNo(10104);
		
		purchaseService.updatePurchase(purchase);
				
		//==> console 확인
		System.out.println("상품수정확인" + purchase);
			
		//==> API 확인
		Assert.assertEquals("경기", purchase.getDivyAddr());
	 }
	 
		
	 @Test
	 public void testGetPurchaseListAll() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 		 	
	 	Map<String,Object> map = purchaseService.getPurchaseList(search, "jooyeon");
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());

	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println("구매건수확인" + totalCount);
	 		 	
	 	//==> console 확인
	 	System.out.println("모든구매리스트확인" + list);
	 	
	 }

}