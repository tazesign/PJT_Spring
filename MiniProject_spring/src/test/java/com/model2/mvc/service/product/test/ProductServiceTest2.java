package com.model2.mvc.service.product.test;


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
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.user.UserService;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration	(locations = {	"classpath:config/context-common.xml",
																			"classpath:config/context-aspect.xml",
																			"classpath:config/context-mybatis.xml",
																			"classpath:config/context-transaction.xml" })
public class ProductServiceTest2 {
	
	
//	ApplicationContext context =
//			new ClassPathXmlApplicationContext(
//																new String[] {	"/config/commonservice.xml",
//																					"/config/userservice.xml" }
//								                                  );
//
//		//==> Bean/IoC Container 로 부터 획득한 UserService 인스턴스 획득
//		ProductService productService = (ProductService)context.getBean("productServiceImpl");
//		
	//==>@RunWith,@ContextConfiguration 이용 Wiring, Test 할 instance DI
	@Autowired
	@Qualifier("productServiceImpl")
	ProductService productService;
	
	//@Test
	public void testAddProduct() throws Exception {
		
		Product product = new Product();
		product.setProdNo(10080);
		product.setProdName("바나나우유");
		product.setProdDetail("우유");
		product.setManuDate("20180426");
		product.setPrice(1300);	
		product.setFileName("ddd");
		
		productService.addProduct(product);
		
		product = productService.getProduct(10080);

		System.out.println(product + "상품등록완료");
		
		//==> API 확인
		Assert.assertEquals(10080, product.getProdNo());
		Assert.assertEquals("바나나우유", product.getProdName());
		Assert.assertEquals("우유", product.getProdDetail());
		Assert.assertEquals("20180426", product.getManuDate());
		Assert.assertEquals(1300, product.getPrice());
		Assert.assertEquals("ddd", product.getFileName());	
	}
	
	
	//@Test
	public void testGetProduct() throws Exception {
		
		Product product = new Product();
		product = productService.getProduct(10080);

		//==> console 확인
		System.out.println(product + "상품확인");
		
		//==> API 확인
		Assert.assertEquals(10080, product.getProdNo());
		Assert.assertEquals("바나나우유", product.getProdName());
		Assert.assertEquals("우유", product.getProdDetail());
		Assert.assertEquals("20180426", product.getManuDate());
		Assert.assertEquals(1300, product.getPrice());
		Assert.assertEquals("ddd", product.getFileName());

		Assert.assertNotNull(productService.getProduct(10080));
		Assert.assertNotNull(productService.getProduct(10060));
	}
	
	//@Test
	 public void testUpdateUser() throws Exception{
		 
		Product product = productService.getProduct(10080); 
		Assert.assertNotNull(product);
		
		Assert.assertEquals(10080, product.getProdNo());
		Assert.assertEquals("바나나우유", product.getProdName());
		Assert.assertEquals("우유", product.getProdDetail());
		Assert.assertEquals("20180426", product.getManuDate());
		Assert.assertEquals(1300, product.getPrice());
		Assert.assertEquals("ddd", product.getFileName());
		
		product.setProdName("초코우유");
		product.setProdDetail("우유");
		product.setManuDate("20180426");
		product.setPrice(1500);	
		product.setFileName("vvv");
		
		productService.updateProduct(product);
		
		product = productService.getProduct(10080);
		Assert.assertNotNull(product);
		
		//==> console 확인
		System.out.println(product + "상품수정확인");
			
		//==> API 확인
		Assert.assertEquals("초코우유", product.getProdName());
		Assert.assertEquals(1500, product.getPrice());
		Assert.assertEquals("vvv", product.getFileName());
	 }
	 
	
	 @Test
	 public void testGetProductListAll() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	Map<String,Object> map = productService.getProductList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console 확인
	 	System.out.println("모든상품리스트확인1111" +list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("===============마이쮸확인========================");
	 	
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword("마이쮸");
	 	map = productService.getProductList(search);
	 	
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
	 	//==> console 확인
	 	System.out.println("모든상품리스트확인2222" +list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }

}