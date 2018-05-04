package com.model2.mvc.service.user.test;


import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.impl.UserDaoImpl;
import com.model2.mvc.service.user.impl.UserServiceImpl;


/*
 * FileName : MyBatisTestApp12.java
  * :: Business Layer unit Test : Service + Persistence (MyBatis + DAO)
  */
public class TestApp12 {
	
	///main method
	public static void main(String[] args) throws Exception{

		//==> SqlSessionFactoryBean.getSqlSession()을 이용 SqlSession instance GET
		SqlSession sqlSession = SqlSessionFactoryBean.getSqlSession();
		
		//==> UserDaoImpl11 생성 및 sqlSession instance setter injection
		UserDaoImpl userDao = new UserDaoImpl();
		userDao.setSqlSession(sqlSession);
		
		//==> MyBatisTestApp12 생성 및 userDao instance setter injection
		UserServiceImpl userService = new  UserServiceImpl();
		userService.setUserDao(userDao);
		System.out.println("\n");
		
		//==> Test 용 User instance 생성  
		User user = new User("eee","eee","eee","900000","010-999-9999","경기도", "eee@naver.com");
		
		//1. addUser Test  
		System.out.println(":: 1. addUser(INSERT)  ? ");
		userService.addUser(user); 
		System.out.println("\n");
		
		//2. getUser Test :: 주몽 inert 확인 
		System.out.println(":: 2. getUser(SELECT)  ? ");
		System.out.println(":: "+ userService.getUser(user.getUserId()) );
		System.out.println("\n");

		//3. uadateUser Test  :: 주몽 ==> 온달 수정
		user.setUserName("ㄷㄷㄷ");
		System.out.println(":: 3. update(UPDATE)  ? ");
		userService.updateUser(user);
		System.out.println("\n");
		
		//4. getUserList Test ::
		System.out.println(":: 4. getUserList(SELECT)  ? ");
		Search search = new Search();
		search.setSearchCondition("0");
		search.setSearchKeyword("eee");

		//6. getUserList Test 
		System.out.println(":: 6. getUserList(SELECT)  ? ");
		System.out.println("List<User> 내용 : "+ userService.getUserList(search) );
		System.out.println("\n");
		
		//END::SqlSession  close
		System.out.println("::END::SqlSession 닫기..");
		sqlSession.close();
		
	}//end of main
}//end of class