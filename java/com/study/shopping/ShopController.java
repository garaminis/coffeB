package com.study.shopping;

import java.util.ArrayList;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Conditional;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ShopController {
	@Autowired
	private ShopDAO sdao;
	@Autowired
	private GoodsDAO gdao;
	
	
	@GetMapping("/")
	public String home(Model model) {
		ArrayList<GoodsDTO> item = gdao.itemList(2, 0, 16);
		System.out.println(item);
	    model.addAttribute("itemList", item);
		return "home";
	}
	
	@GetMapping("/community")
	public String community() {
		return "community";
	}
	
	@GetMapping("/mypage")
	public String my_page() {
		return "mypage";
	}
	@GetMapping("/myUpdate")
	public String myUpdate() {
		return "myUpdate";
	}
	@GetMapping("/write")
	public String write(HttpServletRequest req,Model model) {
		String id = req.getParameter("id");
	    model.addAttribute("id",id);
		return "/write";
	}

	
//	@PostMapping("/myLoad")
//	@ResponseBody
//	public String update(HttpServletRequest req) {
//		String id = req.getParameter("user_id");
//		ArrayList<MemberDTO> data = sdao.myLoad(id);
//		System.out.println("id : " + id);
//		System.out.println("data : " + data);
//		JSONArray ja = new JSONArray();
//		for(int i=0; i < data.size(); i++) {
//			JSONObject jo = new JSONObject();
//			jo.put("id",data.get(i).id);
//			jo.put("name",data.get(i).name);
//			jo.put("birth",data.get(i).birth);
//			jo.put("zipcode",data.get(i).zipcode);
//			jo.put("adress",data.get(i).adress);
//			jo.put("adress2",data.get(i).adress2);
//			jo.put("mobile",data.get(i).mobile);
//			jo.put("mail",data.get(i).mail);
//			ja.add(jo);
//		}
//		System.out.println("ja : " + ja);
//		return ja.toJSONString();
//	}
	@GetMapping("/customer")
	public String customer() {
		return "customer";
	}
	@GetMapping("/notice") // 게시판리스트
	public String doList(Model model) {
		int category=1;
		ArrayList<BoardDTO> boards= sdao.boardList(category);
		model.addAttribute("boardlist",boards);
		return "notice";
	}
	@GetMapping("/faq") // 게시판리스트
	public String doFna(Model model) {
		int category=2;
		ArrayList<BoardDTO> boards= sdao.boardList(category);
		model.addAttribute("boardlist",boards);
		return "faq";
	}
	@GetMapping("/Qna")
	public String Qna(Model model) {
		int category=3;
		ArrayList<directQnADTO> directQnA = sdao.directQnAList(category);
		model.addAttribute("directQnAlist", directQnA);
		return "Qna";
	}
	@GetMapping("/myAbout")
	public String myAbout(Model model) {
	    int[] categories = {4, 5, 6, 7, 8};

	    // 모든 카테고리에 대한 directQnAList 가져오기
	    ArrayList<directQnADTO> DirectQnA = new ArrayList<>();
	    for (int category : categories) {
	        ArrayList<directQnADTO> directQnA = sdao.directQnAList(category);
	        DirectQnA.addAll(directQnA);
	    }
	    model.addAttribute("directQnAlist", DirectQnA);     
	    return "myAbout";
	}
	
//	@PostMapping("/doSignup") //회원가입
//	@ResponseBody
//	public String goSignup(HttpServletRequest req) {
//		String userId=req.getParameter("userId");
//		String psw=req.getParameter("psw");
//		String name=req.getParameter("name");
//		String mobile=req.getParameter("mobile");
//		String mail=req.getParameter("mail");
//		String birth=req.getParameter("birth");
//		String adress=req.getParameter("adress");
//		String zipcode=req.getParameter("zipcode");
//		String gender=req.getParameter("gender");
//		String adress2=req.getParameter("adress2");
//		
//		int n=sdao.add(userId,psw,name,mobile,mail,birth,adress,zipcode,gender,adress2);
//		return ""+n;
//	}
//	
//	@PostMapping("/dologin") //로그인
//	   @ResponseBody
//	   public String doLogin(HttpServletRequest req) {
//	       String id = req.getParameter("loginId");
//	       String psw = req.getParameter("passwd");
//	       HttpSession sess = req.getSession(); // 세션 객체를 얻고(꺼내고) sess변수에 저장
//	       int ad = sdao.adlogin(id, psw);
//	       int isMember = sdao.idchk(id); // 회원 여부 확인
//	       if (ad == 0 && isMember == 1) { // 관리자가 아니고 회원으로 등록된 경우에만 로그인 처리
//	           int n = sdao.dologin(id, psw);
//	           sess.setAttribute("id", id);
//	           return "" + n;
//	       } else if (ad == 0 && isMember == 0) { // 회원으로 등록되지 않은 경우
//	           return "-1"; // 회원으로 등록되지 않았음을 클라이언트에게 알림
//	       }
//	       sess.setAttribute("id", id);
//	       sess.setAttribute("admin", id);
//	       return "2";
//	   }
//
//	
//	@PostMapping("/logout") //로그아웃
//	@ResponseBody
//	public String dologout(HttpServletRequest req) {
//		HttpSession sess= req.getSession(); 
//		sess.invalidate();
//		return "1" ;
//	}
//	
//	@PostMapping("/idcheck") //아이디 중복체크
//	@ResponseBody
//	public String doIdcheck(HttpServletRequest req) {
//		String userId=req.getParameter("userId");
//		int n= sdao.idchk(userId);
//		return ""+n;
//	}
//	
//	@PostMapping("/myModify") //회원정보수정
//	@ResponseBody
//	public String doMymodify(HttpServletRequest req) {
//		String userId=req.getParameter("user_id");
//		String name=req.getParameter("name");
//		String birth=req.getParameter("birth");
//		String zipcode=req.getParameter("zip_code");
//		String adress=req.getParameter("adress");
//		String adress2=req.getParameter("adress2");
//		String mobile=req.getParameter("mobile");
//		String mail=req.getParameter("mail");
//		
//		int n= sdao.modify(userId, name, birth, zipcode, adress, adress2, mobile, mail);
//		System.out.println(n);
//		return ""+n;
//	}
	
	@GetMapping("/catagoryboard") //카테고리 select option에 로드
	@ResponseBody
	public String doCategory() {
		ArrayList<BoardCategoryDTO> categorys = sdao.category();
		
		JSONArray ja=new JSONArray();
		for(int i=0; i<categorys.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("id",categorys.get(i).id);
			jo.put("name", categorys.get(i).name);
			ja.add(jo);
		}
		return ja.toJSONString();
	}
	
//	@GetMapping("/answerstate") //답변 상태 로드
//	@ResponseBody
//	public String answerstate() {
//		ArrayList<answerstateDTO> answerstate = sdao.answerstate();
//		
//		JSONArray ja=new JSONArray();
//		for(int i=0; i<answerstate.size(); i++) {
//			JSONObject jo = new JSONObject();
//			jo.put("id",answerstate.get(i).getId());
//			jo.put("name", answerstate.get(i).getName());
//			ja.add(jo);
//		}
//		return ja.toJSONString();
//	}
	
	@PostMapping("/doWrite") // 글 작성
	@ResponseBody
	public String doWrite(HttpServletRequest req) {
	    String title = req.getParameter("title");
	    String writer = req.getParameter("writer");
	    String content = req.getParameter("content");
	    String categoryParam = req.getParameter("category");
	    String memberIDParam = req.getParameter("memberID");
	    String nickname = req.getParameter("nickname");
	    
	    int answer = 1;
	    if (categoryParam != null && memberIDParam != null) {
	        int category = Integer.parseInt(categoryParam);
	        int memberID = Integer.parseInt(memberIDParam);
	        
	        if (category <= 2) {
	            int n = sdao.myWrite(title, writer, content, category,nickname); //관리자 글 작성
	            return String.valueOf(n);
	        } else if (category >= 3) {
	            int n = sdao.customerWrite(memberID, category, title, writer, content, answer,nickname); //회원 글 작성
	            return "2";
	        }
	    }
	    return "0";
	}
	
	
	@PostMapping("/boardModify") // 글 수정
	@ResponseBody
	public String doBoardmodify(HttpServletRequest req) {
	    String title = req.getParameter("title");
	    String content = req.getParameter("content");
	    int uniq = Integer.parseInt(req.getParameter("uniq"));

	    int categoryParam;
	    String categoryStr = req.getParameter("category");
	    
	    if (categoryStr != null) {
	        categoryParam = Integer.parseInt(categoryStr);
	    } else {
	        categoryParam = -1; 
	    }

	    if (categoryParam == 1 || categoryParam == 2) { 
	        int n = sdao.modifyBoard(title, content, uniq); //관리자 글 수정
	        return String.valueOf(n);
	    } else if (categoryParam >= 3) {
	        sdao.modifyDirectQnA(title, content, uniq); //회원 글 수정
	        return "2";
	    }
	    return "0";
	}


	@PostMapping("/boardDelete") // 글 삭제
	@ResponseBody
	public String doBoarddelete(HttpServletRequest req) {
	    int uniq = Integer.parseInt(req.getParameter("uniq"));

	
	    int categoryParam;
	    String categoryStr = req.getParameter("category");
	    
	    if (categoryStr != null) {
	        categoryParam = Integer.parseInt(categoryStr);
	    } else {
	        categoryParam = -1; 
	    }

	    
	    if (categoryParam == 1 || categoryParam == 2) {
	        int n = sdao.delete(uniq); //관리자 글 삭제
	        return String.valueOf(n);
	    } else if (categoryParam >= 3) {
	        sdao.deleteDirectQnA(uniq); //회원 글 삭제 
	        return "2";
	    }
	    return "0";
	}

	@PostMapping("/doComment") // 답변 작성 및 수정
	@ResponseBody
	public String doComment(HttpServletRequest req) {
	    int directID = Integer.parseInt(req.getParameter("uniq"));// 글번호 
	    String writer = req.getParameter("writer");
	    int category = Integer.parseInt(req.getParameter("category"));
	    String Qwriter = req.getParameter("Qwriter");
	    String comment = req.getParameter("comment");
	    String comment_id = req.getParameter("comment_id");
	    int n=0;
	    
	    if(comment_id == "") {
			n = sdao.comment(directID, writer, category, Qwriter, comment);
			return ""+n;
	    } else if(comment_id != null && !comment_id.isEmpty()){
		    n = sdao.commentModify(Integer.parseInt(comment_id), comment);
		    return "2";
	    } 
	    return "0";
	    
	   
	}
//	@PostMapping("/QnaModify") // 답변 수정
//	@ResponseBody
//	public String qnaModify(HttpServletRequest req) {
//	    String comment_id = req.getParameter("comment_id");
//	    String comment = req.getParameter("comment");
//
//	    // comment_id 값이 비어 있는지 확인하여 처리합니다.
//	    if (comment_id != null && !comment_id.isEmpty()) {
//	        int n = sdao.commentModify(Integer.parseInt(comment_id), comment);
//	       // System.out.println(n);
//	        return String.valueOf(n);
//	    } else {
//	        // comment_id가 비어 있을 경우에 대한 처리
//	        return "0"; // 예: 오류 코드 또는 기본 반환값
//	    }
//	}

	@PostMapping("/commentLoad") // 답변 요청
	@ResponseBody
	public String commentLoad (HttpServletRequest req) {
		ArrayList<directQnAanswerDTO> directQnAanswer = sdao.directQnAanswer();
		
		JSONArray ja=new JSONArray();
		for(int i=0; i<directQnAanswer.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("id",directQnAanswer.get(i).getId());
			jo.put("content", directQnAanswer.get(i).getContent());
			jo.put("Commet_id",directQnAanswer.get(i).getCommentID());
			jo.put("Qwriter",directQnAanswer.get(i).getQwriter());
			ja.add(jo);
			
		}
		return ja.toJSONString();
			
	}
	@PostMapping("/QnaDelete") // 답변 삭제
	@ResponseBody
	public String qnaDelete(HttpServletRequest req) {
	    String comment_id = req.getParameter("comment_id");

	    // comment_id 값이 비어 있는지 확인하여 처리합니다.
	    if (comment_id != null && !comment_id.isEmpty()) {
	        int n = sdao.QnAdelete(Integer.parseInt(comment_id));
	        return String.valueOf(n);
	    } else {
	        // comment_id가 비어 있을 경우에 대한 처리
	        return "0"; // 예: 오류 코드 또는 기본 반환값
	    }
	}
	@PostMapping("/doAnswer") // 답변 삭제
	@ResponseBody
	public String doanswer(HttpServletRequest req) {
	    String answer="2";
	    String id = req.getParameter("comment_id");
	    
	    int n= sdao.commentAnswer(answer,Integer.parseInt(id));
	    return ""+n;
  
	}


	
	@PostMapping("/orderData")
	@ResponseBody
	public String doOrderData(HttpServletRequest req) {
		String id = req.getParameter("user_id");
		ArrayList<MemberDTO> order = sdao.orderData(id);
		System.out.println("id : " + id);
		System.out.println("order : " + order);
		JSONArray ja = new JSONArray();
		for(int i=0; i < order.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("name",order.get(i).name);
			jo.put("mail",order.get(i).mail);
			jo.put("mobile",order.get(i).mobile);
			jo.put("adress",order.get(i).adress);
			ja.add(jo);
		}
		//System.out.println("ja : " + ja);
		return ja.toJSONString();
	}
	@PostMapping("/boardData")
	@ResponseBody
	public String boardData(HttpServletRequest req) {
		
		String id = req.getParameter("id");
		System.out.println(id);
		BoardDTO boarddto = sdao.boardData(Integer.parseInt(id));

		JSONObject jo = new JSONObject();   
			jo.put("category",boarddto.category);
			jo.put("title",boarddto.title);
			jo.put("content",boarddto.content);
		
		return jo.toJSONString();
	}


}
