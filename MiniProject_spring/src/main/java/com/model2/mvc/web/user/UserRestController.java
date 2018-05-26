package com.model2.mvc.web.user;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.user.UserService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/user/*")
public class UserRestController {
	
	///Field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method 구현 않음
		
	public UserRestController(){
		System.out.println(this.getClass());
	}
	@RequestMapping(value="json/addUser", method=RequestMethod.POST)
	public void addUser(@RequestBody User user) throws Exception {
		System.out.println("/json/addUser : POST");
		userService.addUser(user); 
		//가입한 유저정보를 어떤형태로든 알려주기위해
		//유저아이디로 디비갔다온 유저정보를 다시 보내줌
//		User dbUser=userService.getUser(user.getUserId());
//		return dbUser; 
		
	}
	
	@RequestMapping( value="json/getUser/{userId}", method=RequestMethod.GET )
	public User getUser( @PathVariable String userId ) throws Exception{
		System.out.println("/user/json/getUser : GET");
		//Business Logic
		return userService.getUser(userId);
	}
	
//	@RequestMapping( value="json/updateUser/{userId}", method=RequestMethod.GET )
//	public User updateUser( @PathVariable String userId ) throws Exception{
//		System.out.println("/user/json/getUser : GET");
//		//Business Logic
//		User user = userService.getUser(userId);
//		return user;
//	}
	
	@RequestMapping( value="json/updateUser", method=RequestMethod.POST )
	public User updateUser( @RequestBody User user) throws Exception{
		System.out.println("/user/json/updateUser : POST");
		
		//Business Logic
		userService.updateUser(user);
		User dbUser=userService.getUser(user.getUserId());
		
		return dbUser;
	}
	
	@RequestMapping( value="json/listUser")
	public Map<String , Object> listUser( @ModelAttribute Search search) throws Exception{
		System.out.println("/user/json/listUser : GET / POST");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		
		int pageSize = 3;
		int pageUnit = 5;

		search.setPageSize(pageSize);
		
		//Business Logic
		Map<String , Object> map = userService.getUserList(search);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("리스트맵" + map);
		return map;
	}

	@RequestMapping( value="json/login", method=RequestMethod.POST )
	public User login(@RequestBody User user,
									HttpSession session ) throws Exception{
	
		System.out.println("/user/json/login : POST");
		//Business Logic
		System.out.println("::"+user);
		User dbUser=userService.getUser(user.getUserId());
		
//		if( user.getPassword().equals(dbUser.getPassword())){
//			session.setAttribute("user", dbUser);
//		}
		
		return dbUser;
	}
}