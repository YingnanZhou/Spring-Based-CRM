package com.zyn.crm.shiro;

import com.alibaba.fastjson.JSON;
import com.zyn.crm.util.JsonResult;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authc.FormAuthenticationFilter;
import org.springframework.stereotype.Component;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
@Component("crmFormAuthenticationFilter")
public class CRMFormAuthenticationFilter  extends FormAuthenticationFilter{

    @Override
    protected boolean onLoginSuccess(AuthenticationToken token, Subject subject, ServletRequest request, ServletResponse response) throws Exception {
        response.setContentType("application/json;charset=utf-8");
        JsonResult result = new JsonResult();
        response.getWriter().print(JSON.toJSONString(result));
        return false;

    }

    @Override
    protected boolean onLoginFailure(AuthenticationToken token, AuthenticationException e, ServletRequest request, ServletResponse response) {

        try {
            JsonResult result = new JsonResult();
            response.setContentType("application/json;charset=UTF-8");
            if (e instanceof UnknownAccountException || e instanceof IncorrectCredentialsException) {
                result.mark("username or password is wrong");
            } else {
                result.mark("unknown error");
            }
            response.getWriter().print(JSON.toJSONString(result));
        } catch (Exception e1) {
            e1.printStackTrace();
        }

        return false;
    }


}
