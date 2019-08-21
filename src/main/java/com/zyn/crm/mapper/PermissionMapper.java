package com.zyn.crm.mapper;

import com.zyn.crm.domain.Permission;
import com.zyn.crm.query.PermissionQueryObject;
import java.util.List;

public interface PermissionMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Permission record);

    Permission selectByPrimaryKey(Long id);

    List<Permission> selectAll();

    int updateByPrimaryKey(Permission record);

    int queryForCount(PermissionQueryObject qo);

    List<Permission> queryForList(PermissionQueryObject qo);

    Permission selectByRoleId(Long RoleId);

    List<String> queryByEmployeeId(Long employeeId);


}