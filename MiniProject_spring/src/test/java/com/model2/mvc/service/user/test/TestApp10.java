package com.model2.mvc.service.user.test;



import org.apache.ibatis.session.SqlSession;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;

/*
 * FileName : MyBatisTestApp101.java
  */
public class TestApp10 {
	
	///main method
	public static void main(String[] args) throws Exception{
	
		//==> SqlSessionFactoryBean.getSqlSession()�� �̿� SqlSession instance GET
		SqlSession sqlSession = SqlSessionFactoryBean.getSqlSession();
		System.out.println("\n");
		
		//==> Test �� User instance ����  
		User user = new User("dhdh","����","dhdh","900000","010-999-9999","��⵵", "dhdh@naver.com");
		
//		//1. UserMapper.addUser Test  :: users table age/grade/redDate �Է°� Ȯ���Ұ� : OK 
//		System.out.println(":: 1. addUser(INSERT)  ? ");
//		System.out.println(":: "+ sqlSession.insert("UserMapper.addUser",user));
//		System.out.println("\n");
//		
		//2. UserMapper.getUser Test :: �ָ� inert Ȯ�� 
		System.out.println(":: 2. getUser(SELECT)  ? ");
		System.out.println(":: "+sqlSession.selectOne("UserMapper.getUser",user.getUserId()) );
		System.out.println("\n");
		
		//3. UserMapper.uadateUser Test  :: users table age/grade/redDate �Է°� Ȯ���Ұ� : OK
		//                                                    :: �ָ� ==> �´� ����
		user.setUserName("�ƾ�");
		System.out.println(":: 3. update(UPDATE)  ? ");
		System.out.println(":: "+ sqlSession.update("UserMapper.updateUser",user));
		System.out.println("\n");
		
		//4. UserMapper.getUserList Test  :: Dynamic Query Ȯ�� id=user04/name=�´� �˻�
		System.out.println(":: 4. getUser(SELECT)  ? ");
		System.out.println(":: "+sqlSession.selectOne("UserMapper.getUser",user.getUserId()) );
		System.out.println("\n");
		
//		//5. UserMapper10.removeUser Test
//		System.out.println(":: 5. Use10.removeUser (DELETE)  ? ");
//		System.out.println(":: "+sqlSession.delete("UserMapper10.removeUser", 
//																						   user.getUserId()) );
		System.out.println("\n");
		System.out.println("/////////////////////////////////////////////////////////////////////////////////////////////////");
		System.out.println("\n");
		
		//==> Test �� Search instance ���� 
		Search search = new Search();
		
		//1. UserMapper.getUserList Test 
		System.out.println(":: 1. getUserList(SELECT)  ? ");
		SqlSessionFactoryBean.printList( sqlSession.selectList("UserMapper.getUserList",search) );
		
		//2. UserMapper.getUserList Test 
		search.setSearchCondition("0");
		search.setSearchKeyword("user01");
		SqlSessionFactoryBean.printList( sqlSession.selectList("UserMapper.getUserList",search) );
		
		//3. UserMapper.getUserList Test 
		search.setSearchCondition("1");
		search.setSearchKeyword("�ƾ�");
		SqlSessionFactoryBean.printList( sqlSession.selectList("UserMapper.getUserList",search) );
		
		//END::SqlSession  close
		System.out.println("::END::SqlSession �ݱ�..");
		sqlSession.close();
		
	}//end of main
}//end of class