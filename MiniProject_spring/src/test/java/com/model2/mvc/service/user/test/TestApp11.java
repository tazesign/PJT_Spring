package com.model2.mvc.service.user.test;


import java.util.ArrayList;


import org.apache.ibatis.session.SqlSession;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.impl.UserDaoImpl;

/*
 * FileName : MyBatisTestApp11.java 
 *  :: Persistence Layer unit Test : MyBatis + DAO
  */
public class TestApp11 {
	
	///main method
	public static void main(String[] args) throws Exception{

		//==> SqlSessionFactoryBean.getSqlSession()을 이용 SqlSession instance GET
		SqlSession sqlSession = SqlSessionFactoryBean.getSqlSession();
		
		//==> UserDaoImpl11 생성 및 sqlSession instance setter injection
		UserDaoImpl userDao = new UserDaoImpl();
		userDao.setSqlSession(sqlSession);
		System.out.println("\n");
		
		//==> Test 용 User instance 생성  
		User user = new User("dhdh","오오","dhdh","900000","010-999-9999","경기도", "dhdh@naver.com");
		
		//1. addUser Test  
		System.out.println(":: 1. addUser(INSERT)  ? ");
		userDao.addUser(user);
		System.out.println("\n");

		//2. uadateUser Test  :: 주몽 ==> 온달 수정
		user.setUserName("아아");
		System.out.println(":: 2. update(UPDATE)  ? ");
		userDao.updateUser(user);
		System.out.println("\n");
		
		//5. getUserList Test ::
		System.out.println(":: 5. getUserList(SELECT)  ? ");
		Search search = new Search();
		search.setSearchCondition("1");
		search.setSearchKeyword("아아");
		
		System.out.println(":: List<User> 내용 : "+ userDao.getUserList(search) );
		System.out.println("\n");

		//END::SqlSession  close
		System.out.println("::END::SqlSession 닫기..");
		sqlSession.close();

	}//end of main
}//end of class