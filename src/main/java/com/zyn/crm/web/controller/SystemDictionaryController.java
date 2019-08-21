package com.zyn.crm.web.controller;

import com.github.pagehelper.PageInfo;
import com.zyn.crm.util.JsonResult;
import com.zyn.crm.domain.SystemDictionary;
import com.zyn.crm.query.SystemDictionaryQueryObject;
import com.zyn.crm.service.ISystemDictionaryService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/systemDictionary")
public class SystemDictionaryController {
    @Autowired
    private ISystemDictionaryService systemDictionaryService;

    @RequestMapping("/list")
    //@RequiresPermissions(value={"字典目录list", "systemDictionary:list"}, logical = Logical.OR)
    public String list(Model model, @ModelAttribute("qo") SystemDictionaryQueryObject qo) {
        PageInfo pageInfo = systemDictionaryService.query(qo);
        model.addAttribute("pageInfo", pageInfo);
        return "systemDictionary/list";
    }


    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    @RequiresPermissions(value={"字典目录新增和删除", "systemDictionary:saveOrUpdate"}, logical = Logical.OR)
    public JsonResult saveOrUpdate(SystemDictionary systemDictionary) {
        JsonResult result = new JsonResult();
        try {
            systemDictionaryService.saveOrUpdate(systemDictionary);
        } catch (Exception e) {
            result.mark("something went wrong");
            e.printStackTrace();
        }
        return result;
    }

}
