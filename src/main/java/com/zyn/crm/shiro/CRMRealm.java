package com.zyn.crm.shiro;

import com.zyn.crm.domain.Employee;
import com.zyn.crm.mapper.EmployeeMapper;
import com.zyn.crm.mapper.PermissionMapper;
import com.zyn.crm.mapper.RoleMapper;
import com.zyn.crm.service.IEmployeeService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.credential.CredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.security.Principal;
import java.util.List;

@Component("crmRealm")
public class CRMRealm extends AuthorizingRealm{

    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private PermissionMapper permissionMapper;

    @Autowired
    public void setCredentialsMatcher(CredentialsMatcher credentialsMatcher) {
        super.setCredentialsMatcher(credentialsMatcher);
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        String username = (String)authenticationToken.getPrincipal();
        Employee employee = employeeMapper.selectByUsername(username);

        if(employee != null) {
            return new SimpleAuthenticationInfo(
                    employee, employee.getPassword(),
                    ByteSource.Util.bytes(employee.getName()),//salt
                    "crmRealm");
        }
        return null;
    }

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        Employee employee = (Employee)principalCollection.getPrimaryPrincipal();

        if(employee.isAdmin()) {
            info.addRole("admin");
            info.addStringPermission("*:*");
        }else {
            List<String> roleSns = roleMapper.selectRoleSnsByEmployeeId(employee.getId());

            List<String> expressions = permissionMapper.queryByEmployeeId(employee.getId());
            System.out.println(1);
            for (String expression : expressions) {

                System.out.println(expression);
            }

            info.addRoles(roleSns);
            info.addStringPermissions(expressions);
        }
        return info;

    }

    public void clearCached() {
        PrincipalCollection principals = SecurityUtils.getSubject().getPrincipals();
        super.clearCache(principals);
    }
}
