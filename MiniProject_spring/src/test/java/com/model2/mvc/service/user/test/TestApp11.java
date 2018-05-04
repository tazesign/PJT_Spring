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

		//==> SqlSessionFactoryBean.getSqlSession()�� �̿� SqlSession instance GET
		SqlSession sqlSession = SqlSessionFactoryBean.getSqlSession();
		
		//==> UserDaoImpl11 ���� �� sqlSession instance setter injection
		UserDaoImpl userDao = new UserDaoImpl();
		userDao.setSqlSession(sqlSession);
		System.out.println("\n");
		
		//==> Test �� User instance ����  
		User user = new User("dhdh","����","dhdh","900000","010-999-9999","��⵵", "dhdh@naver.com");
		
		//1. addUser Test  
		System.out.println(":: 1. addUser(INSERT)  ? ");
		userDao.addUser(user);
		System.out.println("\n");

		//2. uadateUser Test  :: �ָ� ==> �´� ����
		user.setUserName("�ƾ�");
		System.out.println(":: 2. update(UPDATE)  ? ");
		userDao.updateUser(user);
		System.out.println("\n");
		
		//5. getUserList Test ::
		System.out.println(":: 5. getUserList(SELECT)  ? ");
		Search search = new Search();
		search.setSearchCondition("1");
		search.setSearchKeyword("�ƾ�");
		
		System.out.println(":: List<User> ���� : "+ userDao.getUserList(search) );
		System.out.println("\n");

		//END::SqlSession  close
		System.out.println("::END::SqlSession �ݱ�..");
		sqlSession.close();

	}//end of main
}//end of class