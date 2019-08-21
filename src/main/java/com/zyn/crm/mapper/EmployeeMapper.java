package com.zyn.crm.mapper;

import com.zyn.crm.domain.Employee;
import com.zyn.crm.query.EmployeeQueryObject;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface EmployeeMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Employee record);

    Employee selectByPrimaryKey(Long id);

    List<Employee> selectAll();

    int updateByPrimaryKey(Employee record);


    List<Employee> queryForList(EmployeeQueryObject qo);

    void insertRelation(@Param("employeeId") Long employeeId, @Param("roleId") Long roleId);

    void deleteRelation(Long id);

    Employee selectByUsername(String username);

    void deleteByEmployeeIds(Long[] ids);

    List<Employee> selectEmployeeBySpecRoles(@Param("market") String market, @Param("market_manager") String market_manager);
}