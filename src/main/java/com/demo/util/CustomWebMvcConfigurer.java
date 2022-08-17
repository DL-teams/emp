package com.demo.util;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Configuration

public class CustomWebMvcConfigurer implements WebMvcConfigurer {
    @Override
    public void addInterceptors(InterceptorRegistry registry)
    {
        //注册拦截器，拦截所有路径和页面
        registry.addInterceptor(new LoginInterceptor()).addPathPatterns("/*");
    }

    public class LoginInterceptor implements HandlerInterceptor {
        //预处理
        public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object o) throws Exception {
            request.setCharacterEncoding("utf-8");
            response.setCharacterEncoding("utf-8");
            //判断用户是否登录 判断session中有没有user
            HttpSession session = request.getSession();
            //移除错误提示
            session.removeAttribute("alert_msg");

            String uri = request.getRequestURI().substring(request.getRequestURI().lastIndexOf("/"));//符合请求跳转
            String[] access = new String[]{"error","login", "logout", "register", ".css", ".js", ".png", ".jpg", "validationCode","favicon"};
            for (String action : access) {
                    if (uri.toLowerCase().contains(action.toLowerCase())) {
                    return true;
                }
            }
            //登录拦截
            if (session.getAttribute("loginUser") == null) {  //
                session.setAttribute("alert_msg", "错误：请先登录！");//提示框
                response.sendRedirect("login.jsp");
                return false;
            }
            return true;
        }
    }
}