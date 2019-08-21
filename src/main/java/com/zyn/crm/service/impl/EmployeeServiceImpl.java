package com.zyn.crm.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.Employee;
import com.zyn.crm.mapper.EmployeeMapper;
import com.zyn.crm.query.EmployeeQueryObject;
import com.zyn.crm.service.IEmployeeService;
import com.zyn.crm.shiro.CRMRealm;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.crypto.hash.Md5Hash;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeServiceImpl implements IEmployeeService{
    @Autowired
    private EmployeeMapper employeeMapper;

    @Autowired
    private CRMRealm crmRealm;
    @Override
    public void saveOrUpdate(Employee employee, Long[] ids) {
        //if the id of the current employee is null, then it is update operation
        //otherwise it is insert

        if(employee.getId() != null) {
            crmRealm.clearCached();
            //when edit the roles, delete all the roles first, then add the new relations
            employeeMapper.updateByPrimaryKey(employee);
            employeeMapper.deleteRelation(employee.getId());

            if(ids != null && ids.length > 0) {
                for(Long roleId : ids) {
                    employeeMapper.insertRelation(employee.getId(), roleId);
                }
            }

        }
        else {
            //密码加密,使用用户名作为加密的“盐”
            employee.setPassword(
                    new Md5Hash(employee.getPassword(),employee.getName()).toString());
            employeeMapper.insert(employee);
            //if ids is valid, insert the relation between this employee and the roles into the employee_role table in database
            if(ids != null && ids.length > 0) {
                for (Long roleId : ids) {
                    employeeMapper.insertRelation(employee.getId(), roleId);
                }
        }
        }
    }

    @Override
    public void delete(Long id) {
        //when delete an employee, delete the relations with this employee first
        employeeMapper.deleteRelation(id);
        employeeMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Employee get(Long id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    @Override
    public List<Employee> list() {
        return employeeMapper.selectAll();
    }

    @Override
    public PageInfo query(EmployeeQueryObject qo) {
        System.out.println(1);
        PageHelper.startPage(qo.getCurrentPage(),qo.getPageSize());
        List<Employee> list = employeeMapper.queryForList(qo);
        return new PageInfo(list);

    }

    @Override
    public void deleteByEmployeeIds(Long[] ids) {
        employeeMapper.deleteByEmployeeIds(ids);
    }

    @Override
    public List<Employee> QueryEmployeeBySpecRoles(String market, String market_manager) {
        return employeeMapper.selectEmployeeBySpecRoles(market, market_manager);
    }

}
