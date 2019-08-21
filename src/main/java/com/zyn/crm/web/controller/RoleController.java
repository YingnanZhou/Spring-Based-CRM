package com.zyn.crm.web.controller;

import com.github.pagehelper.PageInfo;
import com.zyn.crm.util.JsonResult;
import com.zyn.crm.domain.Permission;
import com.zyn.crm.domain.Role;
import com.zyn.crm.query.RoleQueryObject;
import com.zyn.crm.service.IPermissionService;
import com.zyn.crm.service.IRoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/role")
public class RoleController {
    @Autowired
    private IRoleService roleService;
    @Autowired
    private IPermissionService permissionService;

    @RequestMapping("/list")
    public String list(Model model, @ModelAttribute("qo") RoleQueryObject qo) {
        PageInfo pageInfo = roleService.query(qo);
        model.addAttribute("pageInfo", pageInfo);
        return "role/list";
    }

    @RequestMapping("/input")
    public String input(Model model, Long id) {
        List<Permission> permissions = permissionService.list();
        model.addAttribute("permissions", permissions);
        if(id != null) {
            Role role = roleService.get(id);
            model.addAttribute("role", role);
        }
        return "role/input";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public JsonResult delete(Long id) {
        JsonResult result = new JsonResult();
        try {
            roleService.delete(id);
        } catch (Exception e) {
            e.printStackTrace();
            result.mark("something went wrong");
        }
        return result;
    }

    @RequestMapping("/saveOrUpdate")
    public String saveOrUpdate(Role role, Long[] ids) {
        roleService.saveOrUpdate(role, ids);
        return "redirect:/role/list.do";
    }

}
