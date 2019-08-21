package com.zyn.crm.service;

import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.Role;
import com.zyn.crm.query.RoleQueryObject;

import java.util.List;

public interface IRoleService {
    void saveOrUpdate(Role role, Long[] ids);

    void delete(Long id);

    Role get(Long id);

    PageInfo query(RoleQueryObject qo);

    List<Role> list();
}
