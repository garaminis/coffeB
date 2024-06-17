package com.study.shopping;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ItemControlle {

	@Autowired
	private GoodsDAO gdao; 
	@Autowired
	private ReviewDAO rdao;
	@Autowired
	private ShopDAO sdao;
	
	private final static String rootPath = System.getProperty("user.dir");
	
	@Configuration
	public class WebMvcConfig implements WebMvcConfigurer {
		@Override
		public void addResourceHandlers(ResourceHandlerRegistry registry) {
			registry.addResourceHandler("/**").addResourceLocations("file:src/main/resources/static/");
		}
	}
	
	@GetMapping("/itemView")
	public String itemView(@RequestParam("id") String id,Model model) {
		System.out.println(id.length());
		int pageStart = 0;
		int pageEnd = 16;
		
		if(id.length() == 1) {
			ArrayList<GoodsDTO> item = gdao.itemList(Integer.parseInt(id), pageStart, pageEnd);
			System.out.println(item);
		    model.addAttribute("itemList", item);
		    return "/itemView";
		} else {
			String search = (String) id;
			ArrayList<GoodsDTO> result = gdao.search(search);
			model.addAttribute("itemList", result);
			return "/itemView";
		}

	}
	  
	@GetMapping("/goods")
	public String goodsView(@RequestParam("id") String id,Model model) {
	    System.out.println(id);
	    ArrayList<GoodsDTO> item = gdao.itemInfo(Integer.parseInt(id));
		System.out.println(item);
		model.addAttribute("itemInfo", item);
		return "/goods";
	}
	
	@GetMapping("/announ")
	public String getAnnoun() {
		return "announ";
	}
	
	@PostMapping("/writeReview")
	public String writeReview(HttpServletRequest req,Model model) {
		String order_id = req.getParameter("order_id");
		String goods_id = req.getParameter("goods_id");
		model.addAttribute("order_id", order_id);
		model.addAttribute("goods_id", goods_id);
		return "writeReview";
	}
	

	
	@PostMapping("/addReview")
	@ResponseBody
	public String addReview(HttpServletRequest req) {
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");
		int member_id = gdao.getIdNum(id);
		
		String order_id = req.getParameter("order_id");
		String goods_id = req.getParameter("goods_id");
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		String rating = req.getParameter("rating");
		
		int n = rdao.addReview(member_id, Integer.parseInt(goods_id), title, content, Integer.parseInt(rating));
		
		int review_id = rdao.getReviewId(member_id, Integer.parseInt(goods_id), title, content, Integer.parseInt(rating));
		System.out.println(review_id);
		int m = gdao.addReviewId(review_id,Integer.parseInt(order_id));
		
		return "" + n;
	}
	
	@PostMapping("/writeQna")
	public String writeQna(HttpServletRequest req,Model model) {
		String goods_id = req.getParameter("goods_id");
		model.addAttribute("goods_id", goods_id);
		return "writeQna";
	}
	
	@PostMapping("/addQna")
	@ResponseBody
	public String addQna(HttpServletRequest req) {
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");
		int member_id = gdao.getIdNum(id);
		
		String goods_id = req.getParameter("goods_id");
		String content = req.getParameter("content");
		
		int n = rdao.addQna(member_id, Integer.parseInt(goods_id), content, id);

		return "" + n;
	}
	
	@GetMapping("/serch")
	public String doSerch(HttpServletRequest req) {
		String goods_id = req.getParameter("serch");
		return "/serchList";
	}
	
//	@GetMapping("/tkorder")
//	public String getTKOrder(HttpServletRequest req,Model model) {
//		//goods.jps에서 받은 이미지 상품제목 갯수 가격받아오기
//		String img = req.getParameter("img");
//		model.addAttribute("img",img);
//		String goodsName = req.getParameter("goodsName");
//		model.addAttribute("goodsName",goodsName);
//		String goodsSend = req.getParameter("goodsSend");
//		model.addAttribute("goodsSend",goodsSend);
//		int result = Integer.parseInt(req.getParameter("result"));
//		model.addAttribute("result",result);
//		int goodsPrice = result*Integer.parseInt(req.getParameter("goodsPrice").trim());
//		model.addAttribute("goodsPrice",goodsPrice);
//			
//		return "/order";
//	}
	
	@GetMapping("/order")
	public String getOrder(HttpServletRequest req,Model model) {
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");
		String goods_id = req.getParameter("goodsNumber");
		String cnt = req.getParameter("result");
		String price = req.getParameter("goodsPrice");
		String cart_id = req.getParameter("sendOrder");

		ArrayList<GoodsDTO> cartItems = new ArrayList<>();
			
		System.out.println("cart_id : " + cart_id);
		System.out.println("goods_id : " + goods_id);
		System.out.println("id : " + id);
		if (goods_id != null) { // 상세페이지에서 온경우 제품정보를 모아서 처리
			cartItems = gdao.itemInfo(Integer.parseInt(goods_id));
			model.addAttribute("cartItems", cartItems);
			System.out.println("goodsPage");
			ArrayList<MemberDTO> userInfo = sdao.myLoad(id);
			model.addAttribute("userInfo", userInfo);
			model.addAttribute("cnt", cnt);
			model.addAttribute("price", price);
			System.out.println(model);
			
			return "order";
				
		} else if (cart_id != null) { // 카트에서온경우 장바구니정보를 모아서 처리
			String[] orderList = cart_id.split(",");
			System.out.println("cartPage");
			for(int i = 0; i < orderList.length; i++) {
				System.out.println(orderList[i]);
				System.out.println("for진입");
				cartItems.add(gdao.cartOrder(Integer.parseInt(orderList[i])));
			}
			for(int i = 0; i < cartItems.size(); i++) {
				System.out.println(cartItems.get(i));
				System.out.println("fooor");
			}
			model.addAttribute("cartItems", cartItems);
			
			ArrayList<MemberDTO> userInfo = sdao.myLoad(id);
			model.addAttribute("userInfo", userInfo);
			model.addAttribute("cnt", null);
			
			return "order";
			}    
		return "";
	}
	
	@PostMapping("/saveOrder")
	@ResponseBody
	public String addOrder(HttpServletRequest req) {
		HttpSession session = req.getSession();
		String id = (String) session.getAttribute("id");
		
		String goods_id_str = req.getParameter("goods_id");
		String cnt_str = req.getParameter("cnt");
		String price_str = req.getParameter("price");
		
		String g_id = req.getParameter("g_id");

		String cart_id_str = req.getParameter("cart_id");
		int member_id = gdao.getIdNum(id);
		System.out.println("goods_id_str = " + goods_id_str);
		System.out.println("cnt_str = " + cnt_str);
		System.out.println("price_str = " + price_str);
		System.out.println("g_id = " + g_id);
		System.out.println("cart_id_str = " + cart_id_str);
		
//		String[] cart_id = cart_id_str.split(",");

		String delname = req.getParameter("delname");
		String delzipcode = req.getParameter("delzipcode");
		String deladress = req.getParameter("deladress");
		String deladress2 = req.getParameter("deladress2");
		String delmobile = req.getParameter("delmobile");
		String delreq = req.getParameter("delreq");
		String delprice = req.getParameter("delprice");
		String payment = req.getParameter("payment");
		
		System.out.println("delname = " + delname);
		System.out.println("delzipcode = " + delzipcode);
		System.out.println("deladress = " + deladress);
		System.out.println("deladress2 = " + deladress2);
		System.out.println("delmobile = " + delmobile);
		System.out.println("delreq = " + delreq);
		System.out.println("delprice = " + delprice);
		System.out.println("payment = " + payment);
		
		int n = sdao.saveOrder(delname,delzipcode,deladress,deladress2,delmobile,delreq,Integer.parseInt(delprice),Integer.parseInt(payment));
		System.out.println(n);
		int orderId = sdao.getOrderId(delname,delzipcode,deladress,deladress2,delmobile,delreq,Integer.parseInt(delprice),Integer.parseInt(payment));
		System.out.println(orderId);
		
		if(g_id.equals("0")) { // 장바구니에서 온거
			String[] goods_id = goods_id_str.split(",");
			String[] cnt = cnt_str.split(",");
			String[] price = price_str.split(",");
			String[] cart_id = cart_id_str.split(",");
			
			for(int i = 0; i < goods_id.length; i++) {
				int a = sdao.addOrder(member_id,Integer.parseInt(goods_id[i]),Integer.parseInt(cnt[i]),Integer.parseInt(price[i]),orderId);
			}
			for(int i = 0; i < cart_id.length; i++) {
				int b = gdao.delCart(Integer.parseInt(cart_id[i]));
			}
		} else {
			int c = sdao.addOrder(member_id,Integer.parseInt(g_id),Integer.parseInt(cnt_str),Integer.parseInt(price_str),orderId);
		}
		
		return "" + n;
	}
		
	@GetMapping("/orderEnd")
	public String getOrderEnd() {
		return "orderEnd";
	}

	@GetMapping("/itemScroll")
	@ResponseBody
	public String itemScroll(HttpServletRequest req) {
		String id = req.getParameter("id");
		String lastItem = req.getParameter("lastItem");
		int page = Integer.parseInt(req.getParameter("page")) * 16;
		int pageMax = page + 16;
		System.out.println("id : " + id);
		System.out.println("page : " + page);
		System.out.println("pagemax : " + pageMax);
			
		ArrayList<GoodsDTO> item = gdao.itemList(Integer.parseInt(id),page, pageMax);
		System.out.println(item);
			
		JSONArray ja = new JSONArray();
			for(int i=0; i < item.size(); i++) {
				JSONObject jo = new JSONObject();
				jo.put("name",item.get(i).name);
				jo.put("id",item.get(i).id);
				jo.put("img1",item.get(i).img1);
				jo.put("title",item.get(i).title);
				jo.put("price",item.get(i).price);
				ja.add(jo);
			}
		System.out.println("ja : " + ja);
		return ja.toJSONString();
	}
		  
	@GetMapping("/cart")
	public String getCart(HttpServletRequest req,Model model) {
		HttpSession session = req.getSession();
			    
		String id = (String) session.getAttribute("id");
			    
		if (id != null) {
			ArrayList<GoodsDTO> cartItems = gdao.getCart(id);
			model.addAttribute("cartItems", cartItems);
			return "cart";
		}
		return "cart";
	}
			
	@PostMapping("/addCart")
	@ResponseBody
	public String addCart(HttpServletRequest req) {
		String user_id = req.getParameter("member_id");
		System.out.println("user_id : " + user_id);
		int member_id = gdao.getIdNum(user_id);
				
		String goods_id = req.getParameter("goods_id");
		String cnt = req.getParameter("cnt");
		int m = gdao.checkCart(member_id, Integer.parseInt(goods_id));
		System.out.println("member_id : " + member_id);
		System.out.println("goods_id : " + goods_id);
		System.out.println("cnt : " + cnt);
		if(m == 0) {
			int n = gdao.addCart(member_id, Integer.parseInt(goods_id), Integer.parseInt(cnt));
			System.out.println("n:" + n);
			return "" + n;
		} else {
			System.out.println("m:" + m);
			return ""+0;
		}
				
	}
			  
	@PostMapping("/delCart")
	@ResponseBody
	public String delCart(@RequestParam(value="checked[]") Integer[] cartValues) {
		int n = 0;
		for(int i = 0; i < cartValues.length; i++) {
			int value = cartValues[i];
			System.out.println("value: " + value);
			n = gdao.delCart(value);
		}
		return "" + n;
	}
			  
	@PostMapping("/getReview")
	@ResponseBody
	public String getRiview(HttpServletRequest req) {
		String id = req.getParameter("id");
		System.out.println("id : " + id);
		ArrayList<ReviewDTO> review = rdao.reviewList(Integer.parseInt(id));
		System.out.println("review : " + review);
				
		JSONArray ja = new JSONArray();
		for(int i=0; i < review.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("id",review.get(i).id);
			jo.put("rating",review.get(i).rating);
			jo.put("user_id",review.get(i).user_id);
			jo.put("created",review.get(i).created);
			jo.put("title",review.get(i).title);
			jo.put("content",review.get(i).content);
			ja.add(jo);
	}
		System.out.println("ja : " + ja);
		return ja.toJSONString();
	}	
			  
	@PostMapping("/updateCart")
	@ResponseBody
	public String updateCart(HttpServletRequest req) {
		String id = req.getParameter("id");
		String cnt = req.getParameter("cnt");
				  
		int n = gdao.updateCart(Integer.parseInt(id),Integer.parseInt(cnt));
				 
		return "" + n;
	}
	
	@PostMapping("/getQna")
	@ResponseBody
	public String getQna(HttpServletRequest req) {
		String id = req.getParameter("id");
		System.out.println("id : " + id);
		ArrayList<ReviewDTO> qna = rdao.qnaList(Integer.parseInt(id));
		System.out.println("qna : " + qna);
				
		JSONArray ja = new JSONArray();
		for(int i=0; i < qna.size(); i++) {
			JSONObject jo = new JSONObject();
			jo.put("id",qna.get(i).id);
			jo.put("member_id",qna.get(i).member_id);
			jo.put("content",qna.get(i).content);
			jo.put("qwriter",qna.get(i).qwriter);
			jo.put("qusdate",qna.get(i).qusdate);
			jo.put("answer",qna.get(i).answer);
			jo.put("awriter",qna.get(i).awriter);
			jo.put("ansdate",qna.get(i).ansdate);
			jo.put("state",qna.get(i).state);
			jo.put("name",qna.get(i).name);
			ja.add(jo);
		}
		System.out.println("ja : " + ja);
		return ja.toJSONString();
	}
			  
	@PostMapping("/setAnswer")
	@ResponseBody
	public String setAnswer(HttpServletRequest req) {
		String qwriter = req.getParameter("member_name");
		String member_id = req.getParameter("member_id");// 멤버id
		String id = req.getParameter("id");// 상품id
		String qna_id = req.getParameter("qna_id");
		String content = req.getParameter("content");
				
		System.out.println("id : " + id);
		System.out.println("qna_id : " + qna_id);
		System.out.println("content : " + content);
		System.out.println("qwriter : " + qwriter);
		int n = rdao.qnaSave(qwriter, Integer.parseInt(member_id), Integer.parseInt(id), Integer.parseInt(qna_id), content);
		int n2 = rdao.qnaUpdate(Integer.parseInt(qna_id));
		return "" + n;
	}
	
	@GetMapping("/myOrderList")
	public String getOrderList(HttpServletRequest req,Model model) {
		HttpSession session = req.getSession();
			    
		String id = (String) session.getAttribute("id");
		int member_id = gdao.getIdNum(id);
		
		if (id != null) {
			ArrayList<GoodsDTO> orderItem = gdao.getOrderList(member_id);
			model.addAttribute("orderItems", orderItem);
			System.out.println(orderItem);
			return "myOrderList";
		}
		return "myOrderList";
	}
	
	@PostMapping("/stateUpdate")
	@ResponseBody
	public String setState(HttpServletRequest req) {
		String order_id = req.getParameter("order_id");
		System.out.println(order_id);
		int n = gdao.updateState(Integer.parseInt(order_id));
		return "" + n;
	}

	
	@PostMapping("/titleuploadImage")
	public ResponseEntity<?> titleuploadImage(@RequestParam("file") MultipartFile file) {
	    try {
	        String savePath = rootPath + "\\src\\main\\resources\\static\\img\\all_goods";

	        String uploadFolderPath = Paths.get(savePath).toString();
	        String imageName = file.getOriginalFilename();
	        String imageFileName = UUID.randomUUID().toString() + "_" + imageName;
	        String filePath = Paths.get(uploadFolderPath, imageFileName).toString();
	        file.transferTo(new File(filePath));

	        return ResponseEntity.ok().body(Map.of("success", true, "imageFileName", imageFileName));
	    } catch (IOException e) {
	        e.printStackTrace();
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("success", false, "message", "Error occurred while uploading image"));
	    }
	}
	
	// 이미지 업로드
	@PostMapping("/uploadImage")
	public ResponseEntity<?> uploadImage(@RequestParam("file") MultipartFile file) {
	    try {
	        String savePath = rootPath + "\\src\\main\\resources\\static\\img\\all_goods";

	        String uploadFolderPath = Paths.get(savePath).toString();
	        String imageName = file.getOriginalFilename();
	        String imageFileName = UUID.randomUUID().toString() + "_" + imageName;
	        String filePath = Paths.get(uploadFolderPath, imageFileName).toString();

	        file.transferTo(new File(filePath));

	        // 이미지 업로드 성공 시, 이미지 파일 경로를 응답합니다.
	        return ResponseEntity.ok().body(Map.of("success", true, "imageFileName", imageFileName));
	    } catch (IOException e) {
	        e.printStackTrace();
	        // 업로드 실패 시, 내부 서버 오류를 응답합니다.
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("success", false));
	    }
	}
}