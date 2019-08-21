<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Role Management</title>
    <#include "../common/link.ftl">

    <script>
        function moveSelected(srcClass, targetClass) {
            $('.' + targetClass).append($('.' + srcClass + '> option:selected'));
        }

        function moveAll(srcClass, targetClass) {
            $('.' + targetClass).append($('.' + srcClass + '> option'));
        }

        $(function () {
            $('#submitBtn').click(function () {
                //右边option全选中
                $('.selfPermissions > option').prop('selected', true);
                //提交表单
                $('#editForm').submit();
            });

            //角色去重
            var permissionIds = [];
            $('.selfPermissions > option').each(function (index, optionEle) {
                permissionIds.push($(optionEle).val());
            })
            $('.allPermissions > option').each(function (index, optionEle) {
                var permissionId = $(optionEle).val();
                if ($.inArray(permissionId, permissionIds) >= 0) {
                    $(optionEle).remove();
                }
            })
        })
    </script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <
    <#include "../common/navbar.ftl">
<#--菜单回显-->
    <#assign currentMenu="role">
    <#include "../common/menu.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>Role Edit</h1>
        </section>
        <section class="content">
            <div class="box">
                <form class="form-horizontal" action="/role/saveOrUpdate.do" method="post" id="editForm">
                    <input type="hidden" value="${(role.id)!}" name="id">
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="name" class="col-sm-1 control-label">name：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="name" name="name" value="${(role.name)!}"
                                   placeholder="请输入部门名">
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="sn" class="col-sm-1 control-label">sn：</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" id="sn" name="sn" value="${(role.sn)!}"
                                   placeholder="请输入部门编码">
                        </div>
                    </div>
                    <div class="form-group" id="permission">
                        <div>
                            <label for="permission" class="control-label" style="margin-left: 60px">permission：</label>
                        </div>
                        <div class="row" style="margin-top: 10px">
                            <div class="col-sm-4 col-sm-offset-1">
                                <select multiple class="form-control allPermissions" size="12">
                                    <#list permissions as p>
                                        <option value="${p.id}">${p.name}</option>
                                    </#list>
                                </select>

                            </div>

                            <div class="col-sm-2" style="margin-top: 60px;" align="center">
                                <div>
                                    <a type="button" class="btn btn-info  " style="margin-top: 10px"
                                       onclick="moveSelected('allPermissions', 'selfPermissions')">&nbsp;&gt;&nbsp;</a>
                                    <br>
                                    <a type="button" class="btn btn-info " style="margin-top: 10px"
                                       onclick="moveSelected('selfPermissions', 'allPermissions')">&nbsp;&lt;&nbsp;</a>
                                    <br>
                                    <a type="button" class="btn btn-info " style="margin-top: 10px"
                                       onclick="moveAll('allPermissions', 'selfPermissions')">&gt;&gt;</a>
                                    <br>
                                    <a type="button" class="btn btn-info " style="margin-top: 10px"
                                       onclick="moveAll('selfPermissions', 'allPermissions')">&lt;&lt;</a>
                                </div>
                            </div>

                            <div class="col-sm-4">
                                <select multiple class="form-control selfPermissions" size="12" name="ids">
                                <#--回显角色已有的权限-->
                                    <#if role??>
                                        <#list role.permissions as p>
                                        <option value="${p.id}">${p.name}</option>
                                        </#list>
                                    </#if>

                                </select>
                            </div>

                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-offset-1 col-sm-6">
                            <button type="button" id="submitBtn" type="submit" class="btn btn-primary">save</button>
                            <button type="reset" class="btn btn-danger">reset</button>
                        </div>
                    </div>

                </form>

            </div>

        </section>
    </div>
    <#include "../common/footer.ftl">
</div>
</body>
</html>
