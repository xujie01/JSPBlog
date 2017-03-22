package cap.util;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import cap.bean.Counter;
import cap.service.CounterService;
import cap.service.impl.CounterServiceImpl;
@WebListener
public class CountOnlineListener implements HttpSessionListener {
	 private CounterService cntService=new CounterServiceImpl();
	
	 //监听对话，网站访问数加1
	 public void sessionCreated(HttpSessionEvent hse)  
     {  
		 Counter cnt = cntService.getCounter();
		 int num = cnt.getCount();	
		 HttpSession session = hse.getSession();
		 if (session.isNew()) {
			 num = num + 1;
		 }		 
		 session.setAttribute("num", num);
     }  
	 
     public void sessionDestroyed(HttpSessionEvent hse)  
     {  
    	 HttpSession session = hse.getSession();
    	 int num = (Integer)session.getAttribute("num");    	 
    	 //写入DB
    	 cntService.setNum(num);
     }  
}
