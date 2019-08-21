package com.zyn.crm.web.controller;

import com.github.pagehelper.PageInfo;
import com.zyn.crm.util.JsonResult;
import com.zyn.crm.domain.SystemDictionary;
import com.zyn.crm.domain.SystemDictionaryItem;
import com.zyn.crm.query.SystemDictionaryItemQueryObject;
import com.zyn.crm.service.ISystemDictionaryItemService;
import com.zyn.crm.service.ISystemDictionaryService;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/systemDictionaryItem")
public class SystemDictionaryItemController {
    @Autowired
    private ISystemDictionaryItemService systemDictionaryItemService;
    @Autowired
    private ISystemDictionaryService systemDictionaryService;

    @RequestMapping("/list")
    @RequiresPermissions(value={"sditemlist", "SystemDictionaryItem:list"}, logical = Logical.OR)
    public String list(Model model, @ModelAttribute("qo") SystemDictionaryItemQueryObject qo) {
        PageInfo pageInfo = systemDictionaryItemService.query(qo);
        model.addAttribute("pageInfo", pageInfo);


        SystemDictionary parent = systemDictionaryService.get(qo.getParentId());
        model.addAttribute("parent", parent);
        List<SystemDictionary> list = systemDictionaryService.list();
        model.addAttribute("list", list);
        return "systemDictionaryItem/list";
    }

    @RequestMapping("/input")
    @RequiresPermissions(value={"sditeminput", "SystemDictionaryItem:input"}, logical = Logical.OR)
    public String input(Model model, Long id) {

        if(id != null) {
            SystemDictionaryItem dept = systemDictionaryItemService.get(id);
            model.addAttribute("dept", dept);
        }
        return "systemDictionaryItem/input";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public JsonResult delete(Long id) {

        JsonResult result = new JsonResult();
        try {
            systemDictionaryItemService.delete(id);
        } catch (Exception e) {
            result.mark("something went wrong");
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping("/saveOrUpdate")
    @ResponseBody
    public JsonResult saveOrUpdate(SystemDictionaryItem systemDictionaryItem) {
        System.out.println(1);
        JsonResult result = new JsonResult();
        try {
            systemDictionaryItemService.saveOrUpdate(systemDictionaryItem);
        } catch (Exception e) {
            result.mark("something went wrong");
            e.printStackTrace();
        }
        return result;
    }

}
