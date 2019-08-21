package com.zyn.crm.mapper;

import com.zyn.crm.domain.Role;
import com.zyn.crm.query.RoleQueryObject;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RoleMapper {
    int deleteByPrimaryKey(Long id);

    int insert(Role record);

    Role selectByPrimaryKey(Long id);

    List<Role> selectAll();

    int updateByPrimaryKey(Role record);

    int queryForCount(RoleQueryObject qo);

    List<Role> queryForList(RoleQueryObject qo);

    //Role selectByEmployeeId();

    void insetRelation(@Param("roleId") Long roleId, @Param("permissionId") Long permissionId);

    void deleteRelation(Long id);

    Role selectByEmployeeId(Long employeeId);

    List<String> selectRoleSnsByEmployeeId(Long id);
}