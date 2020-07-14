<%@ page contentType="image/JPEG" import="java.awt.*,java.awt.image.*,java.awt.Graphics2D,java.util.*,javax.imageio.*" pageEncoding="GBK"%>
 
<%!
	Color getRandColor(int lowcolor, int highcolor) {   
        Random random = new Random();   
        int r = lowcolor + random.nextInt(highcolor - lowcolor);   
        int g = lowcolor + random.nextInt(highcolor - lowcolor);   
        int b = lowcolor + random.nextInt(highcolor - lowcolor);   
        return new Color(r, g, b);   
    }
%>  
<%   
    //设置页面不缓存   
    response.setHeader("Pragma", "No-cache");   
    response.setHeader("Cache-Control", "no-cache");   
    response.setDateHeader("Expires", 0);   
  
    int width = 70;
	int height = 40;   
  
    // 创建图象   
    BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);   
    Graphics g = image.getGraphics();  
    Graphics2D g2d = (Graphics2D)g;
  
    //生成随机类   
    Random rand1 = new Random();   
  
    // 设定背景色   
    g2d.setColor(getRandColor(180, 250));   
    g2d.fillRect(0, 0, width, height);  
  
    //设定字体   
    g2d.setFont(new Font("宋体", Font.PLAIN, 32));   
  
  
    // 随机产生背景线   
    for (int i = 0; i < 120; i++) {   
    	g2d.setColor(getRandColor(130, 220)); 
    	rand1 = new Random();  
        int x1 = rand1.nextInt(width);   
        int y1 = rand1.nextInt(height);   
        int x2 = rand1.nextInt(25);   
        int y2 = rand1.nextInt(25);   
        g2d.drawLine(x1, y1, x1 + x2, y1 + y2);   
    }   
  
    // 随机产生4位认证码   
    String str1 = "1234567890abcdefghijklmnopqrstuvwxyz";
    String code1=""; 
    int len1=str1.length();  
    // 显示认证码到图象中   
    for (int i = 0; i < 4; i++) {
    	rand1 = new Random(); 
    	int istr= rand1.nextInt(len1-1);  
        String strtemp = str1.substring(istr,istr+1);   
        code1 += strtemp;   
    	g2d.setColor(getRandColor(30, 160));
    	
    	//将字旋转一定角度
    	rand1 = new Random();    
        int AngRot=rand1.nextInt(5)+1;
    	g2d.rotate(-Math.PI/30+Math.PI*AngRot/75);
        g2d.drawString(strtemp, 13 * i + 6, 32);   
    } 
  
    // 图象生效   
    g2d.dispose();
    g.dispose();   
    // 通过SESSION保存验证码   
    session.setAttribute("vericode", code1);   
 
 
    // 输出图象到页面   
    ImageIO.write(image, "JPEG", response.getOutputStream());   
    
    
  /*      out.clear();
       out = pageContext.pushBody(); */
    
    
    
    
    
%>