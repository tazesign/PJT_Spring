package com.model2.mvc.service.user.test;


import java.util.ArrayList;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;

/*
 * FileName : MyBatisTestApp13.java
  * :: Business Layer unit Test : Service + Persistence (Spring +mybatis + DAO)
  */
public class TestApp13 {
	
	///main method
	public static void main(String[] args) throws Exception{

		ApplicationContext context =
			new ClassPathXmlApplicationContext(
																new String[] {	"/config/commonservice.xml",
																					"/config/userservice.xml" }
								                                  );
		System.out.println("\n");

		//==> Bean/IoC Container �� ���� ȹ���� UserService �ν��Ͻ� ȹ��
		UserService userService = (UserService)context.getBean("userServiceImpl");
		
		System.out.println("\n");
		
		//==> Test �� User instance ����  
		User user = new User("bbb","bbb","bbb","900000","010-1111-1111","��⵵", "bbb@naver.com");

		//1. addUser Test  
		System.out.println(":: 1. addUser(INSERT)  ? ");
		userService.addUser(user); 
		System.out.println("\n");
		
		//2. getUser Test :: aaa inert Ȯ�� 
		System.out.println(":: 2. getUser(SELECT)  ? ");
		System.out.println(":: "+ userService.getUser(user.getUserId()) );
		System.out.println("\n");

		//3. uadateUser Test 
		user.setUserName("����");
		System.out.println(":: 3. update(UPDATE)  ? ");
		userService.updateUser(user);
		System.out.println("\n");
		
		//4. getUserList Test ::
		System.out.println(":: 4. getUserList(SELECT)  ? ");
		Search search = new Search();
		search.setSearchCondition("0");
		search.setSearchKeyword("bbb");
		System.out.println("List<User> ���� : "+userService.getUserList(search) );
		System.out.println("\n");

		//5. getUserList Test 
		System.out.println(":: 5. getUserList(SELECT)  ? ");
		System.out.println("List<User> ���� : "+ userService.getUserList(search) );
		System.out.println("\n");
	
	}//end of main
}//end of class