package com.zyn.crm.service;

import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.Employee;
import com.zyn.crm.query.EmployeeQueryObject;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IEmployeeService {
    /**
     *
     * @param employee
     * @param ids
     */
    void saveOrUpdate(Employee employee, Long[] ids);

    void delete(Long id);

    Employee get(Long id);

    List<Employee> list();

    PageInfo query(EmployeeQueryObject qo);

    void deleteByEmployeeIds(Long[] ids);

    List<Employee> QueryEmployeeBySpecRoles(String market, String market_manager);
}
