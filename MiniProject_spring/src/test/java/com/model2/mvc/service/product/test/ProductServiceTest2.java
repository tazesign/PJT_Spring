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
//		//==> Bean/IoC Container �� ���� ȹ���� UserService �ν��Ͻ� ȹ��
//		ProductService productService = (ProductService)context.getBean("productServiceImpl");
//		
	//==>@RunWith,@ContextConfiguration �̿� Wiring, Test �� instance DI
	@Autowired
	@Qualifier("productServiceImpl")
	ProductService productService;
	
	//@Test
	public void testAddProduct() throws Exception {
		
		Product product = new Product();
		product.setProdNo(10080);
		product.setProdName("�ٳ�������");
		product.setProdDetail("����");
		product.setManuDate("20180426");
		product.setPrice(1300);	
		product.setFileName("ddd");
		
		productService.addProduct(product);
		
		product = productService.getProduct(10080);

		System.out.println(product + "��ǰ��ϿϷ�");
		
		//==> API Ȯ��
		Assert.assertEquals(10080, product.getProdNo());
		Assert.assertEquals("�ٳ�������", product.getProdName());
		Assert.assertEquals("����", product.getProdDetail());
		Assert.assertEquals("20180426", product.getManuDate());
		Assert.assertEquals(1300, product.getPrice());
		Assert.assertEquals("ddd", product.getFileName());	
	}
	
	
	//@Test
	public void testGetProduct() throws Exception {
		
		Product product = new Product();
		product = productService.getProduct(10080);

		//==> console Ȯ��
		System.out.println(product + "��ǰȮ��");
		
		//==> API Ȯ��
		Assert.assertEquals(10080, product.getProdNo());
		Assert.assertEquals("�ٳ�������", product.getProdName());
		Assert.assertEquals("����", product.getProdDetail());
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
		Assert.assertEquals("�ٳ�������", product.getProdName());
		Assert.assertEquals("����", product.getProdDetail());
		Assert.assertEquals("20180426", product.getManuDate());
		Assert.assertEquals(1300, product.getPrice());
		Assert.assertEquals("ddd", product.getFileName());
		
		product.setProdName("���ڿ���");
		product.setProdDetail("����");
		product.setManuDate("20180426");
		product.setPrice(1500);	
		product.setFileName("vvv");
		
		productService.updateProduct(product);
		
		product = productService.getProduct(10080);
		Assert.assertNotNull(product);
		
		//==> console Ȯ��
		System.out.println(product + "��ǰ����Ȯ��");
			
		//==> API Ȯ��
		Assert.assertEquals("���ڿ���", product.getProdName());
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
	 	
		//==> console Ȯ��
	 	System.out.println("����ǰ����ƮȮ��1111" +list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 	
	 	System.out.println("===============������Ȯ��========================");
	 	
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword("������");
	 	map = productService.getProductList(search);
	 	
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
	 	//==> console Ȯ��
	 	System.out.println("����ǰ����ƮȮ��2222" +list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }

}