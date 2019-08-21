package com.zyn.crm.web.controller;

import com.github.pagehelper.PageInfo;
import com.zyn.crm.util.JsonResult;
import com.zyn.crm.query.PermissionQueryObject;
import com.zyn.crm.service.IPermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/permission")
public class PermissionController {
    @Autowired
    private IPermissionService permissionService;

    @RequestMapping("/list")
    public String list(Model model, @ModelAttribute("qo") PermissionQueryObject qo) {
        PageInfo pageInfo = permissionService.query(qo);
        model.addAttribute("pageInfo", pageInfo);
        return "permission/list";
    }



    @RequestMapping("/delete")
    @ResponseBody
    public JsonResult delete(Long id) {
        JsonResult result = new JsonResult();
        try {
            permissionService.delete(id);
        } catch (Exception e) {
            e.printStackTrace();
            result.mark("something went wrong");
        }
        return result;
    }



    @RequestMapping("/reload")
    @ResponseBody
    public JsonResult reload() {
        System.out.println(11);
        try {
            permissionService.reload();
        } catch (Exception e) {
            e.printStackTrace();
            return new JsonResult(false, "something went wrong");
        }
        return new JsonResult(true, "success");
    }
}
