package com.board.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.board.domain.MemberVO;
import com.board.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {

private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Inject
	MemberService service;
	
	@Autowired
	BCryptPasswordEncoder passEncoder;
	
	// 회원 가입 get
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void getRegister() throws Exception {
		logger.info("get register");
	}
	
	// 회원 가입 post
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String postRegister(MemberVO vo) throws Exception {
		logger.info("post register");
		
		// 암호화
		// 회원가입시 입력하는 MemberVO에서 getUserPw만 받아와서 암호화한뒤, setUserPw에 넣어줌
		String inputPass = vo.getUserPw();
		String pass = passEncoder.encode(inputPass);
		vo.setUserPw(pass);
		
		service.register(vo);
		
		return "redirect:/";
	}
	
	// 로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(MemberVO vo, HttpServletRequest req, RedirectAttributes rttr) throws Exception {
		logger.info("post login");
		
		HttpSession session = req.getSession();
		
		MemberVO login = service.login(vo);
		
		boolean passMatch = passEncoder.matches(vo.getUserPw(), login.getUserPw());
		
		if(login != null && passMatch) {
			session.setAttribute("member", login);
		} else {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
		}
		
		/*if(login == null) {
			session.setAttribute("member", null);
			// msg라는 정보에 false라는 값이 들어가서 전송됨
			// 이 값은 다른 페이지로 이동하거나 새로고침을 하면 없어지는 일회용값
			rttr.addFlashAttribute("msg", false);
		} else {
			session.setAttribute("member", login);
		}*/
		
		return "redirect:/";
	}
	
	// 로그아웃
	// 로그아웃은 DB에 접근할 필요가 없어 현재 가진 세션값을 제거해주면 됨
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception {
		logger.info("get logout");
		
		session.invalidate();
		
		return "redirect:/";
	}
	
	// 회원정보 수정 get
	@RequestMapping(value = "/memModify", method = RequestMethod.GET)
	public void getModify() throws Exception {
		logger.info("get modify");
	}
	
	// 회원정보 수정 post
	@RequestMapping(value = "/memModify", method = RequestMethod.POST)
	public String postModify(HttpSession session, MemberVO vo) throws Exception {
		logger.info("post modify");
		
		// 암호화
		// 회원가입시 입력하는 MemberVO에서 getUserPw만 받아와서 암호화한뒤, setUserPw에 넣어줌
		String inputPass = vo.getUserPw();
		String pass = passEncoder.encode(inputPass);
		vo.setUserPw(pass);
		
		service.modify(vo);
		
		logout(session);
		
		return "redirect:/";
	}
	
	// 회원탈퇴 get
	@RequestMapping(value = "/memDelete", method = RequestMethod.GET)
	public void getDelete() throws Exception {
		logger.info("get delete");
	}
	
	// 회원탈퇴 post
	@RequestMapping(value = "/memDelete", method = RequestMethod.POST)
	public String postDelete(HttpSession session, MemberVO vo, RedirectAttributes rttr) throws Exception {
		logger.info("post delete");
		
		// session.getAttribute("member");를 이용하여 로그인할 때 생성되는 세션에서 member값을 받아옴
		// 받아오는 데이터 타입은 오브젝트 타입이므로, 오브젝트 변수를 생성하여 받거나 형변환을 해줘야함
		MemberVO member = (MemberVO)session.getAttribute("member");
		
		String pw = member.getUserPw();
		String checkPw = vo.getUserPw();
		
		boolean passMatch = passEncoder.matches(checkPw, pw);
		logger.info(pw);
		logger.info(checkPw);
		
		// member에 있는 비밀번호와 입력한 check용 비밀번호를 비교
		// 같으면 넘어가고 다르면 회원탈퇴 페이지로 이동
		/*if(!(pw.equals(checkPw))) {
			rttr.addFlashAttribute("msg", false);
			return "redirect:/member/memDelete";
		}*/
		
		if(passMatch) {
			service.delete(vo);
			session.invalidate();
			return "redirect:/";
		} else {
			rttr.addFlashAttribute("msg", false);
			return "redirect:/member/memDelete";
		}
	}
	
	// 회원 확인
	// 아이디 중복 검사는 다른 페이지로 이동하지 않고 가입 페이지에서만 작동함. 페이지 이동이 된다면 기존에 입력한 내용이 모두 사라짐
	// 그래서 비동기 전송 기술인 Ajax를 사용함
	// Ajax를 사용하면 jsp파일이 필요없기 때문에, 메서드 앞에 어노테이션 @ResponseBody	를 추가함
	// HttpServletRequest를 이용하여 jsp에서 넘어온 값을 받고, 이 값을 이용하여 Service와 DAO, 그리고 매퍼를 통하여
	// 테이블에 접속해 결과를 받아올 수 있음.
	@ResponseBody
	@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
	public int postIdCheck(HttpServletRequest req) throws Exception {
		logger.info("post idCheck");
		
		String userId = req.getParameter("userId");
		MemberVO idCheck = service.idCheck(userId);
		
		int result = 0;
		
		if(idCheck != null) {
			result = 1;
		}
		
		return result;
	}

}
