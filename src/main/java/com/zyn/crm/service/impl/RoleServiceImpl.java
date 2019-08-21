package com.zyn.crm.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.Role;
import com.zyn.crm.mapper.RoleMapper;
import com.zyn.crm.query.RoleQueryObject;
import com.zyn.crm.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements IRoleService{
    @Autowired
    private RoleMapper roleMapper;
    @Override
    public void saveOrUpdate(Role role, Long[] ids) {
        if(role.getId() != null) {
            roleMapper.updateByPrimaryKey(role);
            roleMapper.deleteRelation(role.getId());
        }
        else {
            roleMapper.insert(role);
        }

        if(ids != null && ids.length > 0) {
            for (Long permissionId : ids) {
                roleMapper.insetRelation(role.getId(), permissionId);
            }
        }

    }

    @Override
    public void delete(Long id) {
        roleMapper.deleteRelation(id);
        roleMapper.deleteByPrimaryKey(id);
    }

    @Override
    public Role get(Long id) {
        return roleMapper.selectByPrimaryKey(id);
    }

    @Override
    public PageInfo query(RoleQueryObject qo) {
        PageHelper.startPage(qo.getCurrentPage(), qo.getPageSize());
        List<Role> list = roleMapper.queryForList(qo);
        return new PageInfo(list);

    }

    @Override
    public List<Role> list() {
        return roleMapper.selectAll();
    }
}
