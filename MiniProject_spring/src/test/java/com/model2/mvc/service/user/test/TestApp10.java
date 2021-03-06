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
	
		//==> SqlSessionFactoryBean.getSqlSession()을 이용 SqlSession instance GET
		SqlSession sqlSession = SqlSessionFactoryBean.getSqlSession();
		System.out.println("\n");
		
		//==> Test 용 User instance 생성  
		User user = new User("dhdh","오오","dhdh","900000","010-999-9999","경기도", "dhdh@naver.com");
		
//		//1. UserMapper.addUser Test  :: users table age/grade/redDate 입력값 확인할것 : OK 
//		System.out.println(":: 1. addUser(INSERT)  ? ");
//		System.out.println(":: "+ sqlSession.insert("UserMapper.addUser",user));
//		System.out.println("\n");
//		
		//2. UserMapper.getUser Test :: 주몽 inert 확인 
		System.out.println(":: 2. getUser(SELECT)  ? ");
		System.out.println(":: "+sqlSession.selectOne("UserMapper.getUser",user.getUserId()) );
		System.out.println("\n");
		
		//3. UserMapper.uadateUser Test  :: users table age/grade/redDate 입력값 확인할것 : OK
		//                                                    :: 주몽 ==> 온달 수정
		user.setUserName("아아");
		System.out.println(":: 3. update(UPDATE)  ? ");
		System.out.println(":: "+ sqlSession.update("UserMapper.updateUser",user));
		System.out.println("\n");
		
		//4. UserMapper.getUserList Test  :: Dynamic Query 확인 id=user04/name=온달 검색
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
		
		//==> Test 용 Search instance 생성 
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
		search.setSearchKeyword("아아");
		SqlSessionFactoryBean.printList( sqlSession.selectList("UserMapper.getUserList",search) );
		
		//END::SqlSession  close
		System.out.println("::END::SqlSession 닫기..");
		sqlSession.close();
		
	}//end of main
}//end of class