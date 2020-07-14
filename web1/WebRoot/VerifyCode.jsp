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
    //����ҳ�治����   
    response.setHeader("Pragma", "No-cache");   
    response.setHeader("Cache-Control", "no-cache");   
    response.setDateHeader("Expires", 0);   
  
    int width = 70;
	int height = 40;   
  
    // ����ͼ��   
    BufferedImage image = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);   
    Graphics g = image.getGraphics();  
    Graphics2D g2d = (Graphics2D)g;
  
    //���������   
    Random rand1 = new Random();   
  
    // �趨����ɫ   
    g2d.setColor(getRandColor(180, 250));   
    g2d.fillRect(0, 0, width, height);  
  
    //�趨����   
    g2d.setFont(new Font("����", Font.PLAIN, 32));   
  
  
    // �������������   
    for (int i = 0; i < 120; i++) {   
    	g2d.setColor(getRandColor(130, 220)); 
    	rand1 = new Random();  
        int x1 = rand1.nextInt(width);   
        int y1 = rand1.nextInt(height);   
        int x2 = rand1.nextInt(25);   
        int y2 = rand1.nextInt(25);   
        g2d.drawLine(x1, y1, x1 + x2, y1 + y2);   
    }   
  
    // �������4λ��֤��   
    String str1 = "1234567890abcdefghijklmnopqrstuvwxyz";
    String code1=""; 
    int len1=str1.length();  
    // ��ʾ��֤�뵽ͼ����   
    for (int i = 0; i < 4; i++) {
    	rand1 = new Random(); 
    	int istr= rand1.nextInt(len1-1);  
        String strtemp = str1.substring(istr,istr+1);   
        code1 += strtemp;   
    	g2d.setColor(getRandColor(30, 160));
    	
    	//������תһ���Ƕ�
    	rand1 = new Random();    
        int AngRot=rand1.nextInt(5)+1;
    	g2d.rotate(-Math.PI/30+Math.PI*AngRot/75);
        g2d.drawString(strtemp, 13 * i + 6, 32);   
    } 
  
    // ͼ����Ч   
    g2d.dispose();
    g.dispose();   
    // ͨ��SESSION������֤��   
    session.setAttribute("vericode", code1);   
 
 
    // ���ͼ��ҳ��   
    ImageIO.write(image, "JPEG", response.getOutputStream());   
    
    
  /*      out.clear();
       out = pageContext.pushBody(); */
    
    
    
    
    
%>