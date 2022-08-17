package com.demo.controller;

import com.demo.service.UserService;
import com.demo.util.Util;
import com.demo.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.imageio.ImageIO;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

@Controller
public class AuthController extends HttpServlet {
    @Autowired
    private UserService userService;

    @RequestMapping("authLogin")
    public void login(HttpServletResponse response, HttpServletRequest request) throws IOException, ServletException {
        String username = Util.decode(request, "username");
        String password = Util.decode(request, "password");


        Map<String, Object> params = new HashMap();
        params.put("searchColumn", "username");//使用`username`字段进行模糊查询
        params.put("keyword", username);
        List<User> list = (List<User>) userService.list(params).get("list");
        for (User user : list) {
            if (user.getUsername().equals(username) && user.getPassword().equals(password)) {//找到这个管理员了
                request.getSession().setAttribute("loginUser", user);
				request.getSession().setMaxInactiveInterval(Integer.MAX_VALUE);
                request.getRequestDispatcher("userList").forward(request, response);
                return;
            }
        }
        request.getSession().setAttribute("alert_msg", "错误：用户名或密码错误！");//提示框显示
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @RequestMapping("authRegister")
    public void register(HttpServletResponse response, HttpServletRequest request) throws IOException, ServletException {
        String username = Util.decode(request, "username");
        String password = Util.decode(request, "password");
        System.out.println("username=" + username);
        System.out.println("password=" + password);

        Map<String, Object> params = new HashMap();
        params.put("searchColumn", "username");//使用`username`字段进行模糊查询
        params.put("keyword", username);
        params.put("startIndex", 0);
        params.put("pageSize", Long.MAX_VALUE);
        List<User> list = (List<User>) userService.list(params).get("list");
        for (User user : list) {
            if (user.getUsername().equals(username) /*&& user.getPassword().equals(password)*/) {//说明该用户名已存在，必须换个用户名才能注册
                request.getSession().setAttribute("alert_msg", "错误：用户名已存在！");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
        }
        User vo = new User();
        vo.setUsername(username);
        vo.setPassword(password);
        //vo.setUserType("普通用户");//需要设置一个默认值
        userService.insert(vo);
        request.getSession().setAttribute("alert_msg", "注册成功！用户名：[" + username + "]");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @RequestMapping("authLogout")
    public void logout(HttpServletResponse response, HttpServletRequest request) throws IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("loginUser");
        if (user != null) {
            session.removeAttribute("loginUser");
        }
        response.sendRedirect("login.jsp");
    }

}
