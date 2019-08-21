package com.zyn.crm.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.Permission;
import com.zyn.crm.mapper.PermissionMapper;
import com.zyn.crm.query.PermissionQueryObject;
import com.zyn.crm.service.IPermissionService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import java.lang.reflect.Method;
import java.util.*;

@Service
public class PermissionServiceImpl implements IPermissionService{
    @Autowired
    private PermissionMapper permissionMapper;

    @Autowired
    private ApplicationContext ctx;

    @Override
    public void saveOrUpdate(Permission permission) {
        if(permission.getId() == null) permissionMapper.insert(permission);
        else permissionMapper.updateByPrimaryKey(permission);

    }

    @Override
    public void delete(Long id) {
        permissionMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Permission get(Long id) {
        return permissionMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageInfo query(PermissionQueryObject qo) {

        PageHelper.startPage(qo.getCurrentPage(), qo.getPageSize());
        List<Permission> list = permissionMapper.queryForList(qo);
        return new PageInfo(list);

    }

    @Override
    public List<Permission> list() {
        return permissionMapper.selectAll();
    }

    @Override
    public void reload() {
        //get all permissions from the database
        List<Permission> permissions = permissionMapper.selectAll();
        //use a set to deduplicate, do not add permission twice into database
        Set<String> permissionExpressions = new HashSet<>();

        for(Permission permission : permissions) {
            permissionExpressions.add(permission.getExpression());
        }

        //get all the beans with @Controller annotation

        Map<String, Object> controllerBeanMap = ctx.getBeansWithAnnotation(Controller.class);

        //get all controllers
        Collection<Object> controllers = controllerBeanMap.values();

        for(Object controller : controllers) {
            //get methods in controller
            System.out.println(controller);
            Method[] methods = controller.getClass().getSuperclass().getDeclaredMethods();
            System.out.println(methods.length);

            for(Method method : methods) {
                //see if this method has annotation @RequiredPermission
                //if it has. return @RequiredPermission object
                if(method.isAnnotationPresent(RequiresPermissions.class)) {
                    String expression = method.getAnnotation(RequiresPermissions.class).value()[1];
                    System.out.println(expression);

                    //if database does not exist this permission expression, then add in

                    if(!permissionExpressions.contains(expression)) {
                        Permission permission = new Permission();
                        permission.setName(method.getAnnotation(RequiresPermissions.class).value()[0]);
                        permission.setExpression(expression);
                        permissionMapper.insert(permission);
                    }
                }
            }
        }

    }

    @Override
    public List<String> queryByEmployeeId(Long employeeId) {
     return permissionMapper.queryByEmployeeId(employeeId);
    }
}
