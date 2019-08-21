package com.zyn.crm.util;

import com.zyn.crm.domain.Employee;
import com.zyn.crm.domain.Permission;
import org.apache.shiro.SecurityUtils;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

public class UserContext {
    public static Employee getCurEmp() {
        return (Employee) SecurityUtils.getSubject().getPrincipal();
    }
}
