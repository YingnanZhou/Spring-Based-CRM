package com.zyn.crm.web.controller;

import com.github.pagehelper.PageInfo;
import com.zyn.crm.domain.Department;
import com.zyn.crm.util.JsonResult;
import com.zyn.crm.query.DepartmentQueryObject;
import com.zyn.crm.service.IDepartmentService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/department")
public class DepartmentController {
    @Autowired
    private IDepartmentService departmentService;

    @RequestMapping("/list")
    public String list(Model model, @ModelAttribute("qo") DepartmentQueryObject qo) {
        PageInfo pageInfo = departmentService.query(qo);
        model.addAttribute("pageInfo", pageInfo);
        return "department/list";
    }


    @RequestMapping("/delete")
    @ResponseBody
    @RequiresPermissions(value={"department_delete", "department:delete"}, logical = Logical.OR)
    public JsonResult delete(Long id) {

        JsonResult result = new JsonResult();
        try {
            departmentService.delete(id);
        } catch (Exception e) {
            result.mark("something went wrong");
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    @RequiresPermissions(value={"department_saveOrUpdate", "department:saveOrUpdate"}, logical = Logical.OR)
    public JsonResult saveOrUpdate(Department department) {
        JsonResult result = new JsonResult();
        try {
            departmentService.saveOrUpdate(department);
        } catch (Exception e) {
            result.mark("something went wrong");
            e.printStackTrace();
        }
        return result;
    }

}
