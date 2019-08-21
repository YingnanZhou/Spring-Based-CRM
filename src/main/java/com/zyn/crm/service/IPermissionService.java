package com.zyn.crm.service;

import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.Permission;
import com.zyn.crm.query.PermissionQueryObject;

import java.util.List;

public interface IPermissionService {
    void saveOrUpdate(Permission permission);

    void delete(Long id);

    Permission get(Long id);

    PageInfo query(PermissionQueryObject qo);

    List<Permission> list();

    void reload();

    List<String> queryByEmployeeId(Long employeeId);
}
