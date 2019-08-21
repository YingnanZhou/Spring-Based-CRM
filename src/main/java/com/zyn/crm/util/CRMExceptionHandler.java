package com.zyn.crm.util;

import com.alibaba.fastjson.JSON;
import org.apache.shiro.authz.UnauthorizedException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.HandlerMethod;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@ControllerAdvice
public class CRMExceptionHandler {

    @ExceptionHandler(UnauthorizedException.class)
    public String handleUnathourizedException(Exception ex, Model model, HandlerMethod hm, HttpServletResponse response) throws ServletException, IOException {
        if (hm.getMethod().isAnnotationPresent(ResponseBody.class)) {
            response.setContentType("application/json; charset=UTF-8");
            //asyn request
            JsonResult result = new JsonResult();
            result.mark(" no permission");
            response.getWriter().print(JSON.toJSONString(result));
            return null;
        } else {
            model.addAttribute("ex", ex);
            return "common/nopermission";
        }
    }

    @ExceptionHandler(RuntimeException.class)
    public String handleException(Exception ex, Model model, HandlerMethod hm, HttpServletResponse response) throws ServletException, IOException {
        if (hm.getMethod().isAnnotationPresent(ResponseBody.class)) {
            response.setContentType("application/json; charset=UTF-8");
            //asyn request
            JsonResult result = new JsonResult();
            result.mark("action failed");
            response.getWriter().print(JSON.toJSONString(result));
            return null;
        } else {
            model.addAttribute("ex", ex);
            return "common/error";
        }
    }
}
