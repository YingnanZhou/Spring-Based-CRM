<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Employee Management</title>
    <#include "../common/link.ftl">


    <script type="text/javascript">
        var $roleDiv;
        $(function () {
            //if the employee is admin(checked is true), he has all the permissions, so hide the field use to setting
            //roles for employees
            $('#admin').change(function () {
                var checked = $(this).prop('checked');

                if (checked) {
                    $roleDiv = $('#role').detach();
                } else {
                    $(this).closest('div').after($roleDiv);
                }
            });

            //when edit an employee, if he is admin, hide the field use to setting roles for employees
            var checked = $('#admin').prop('checked');
            if (checked) {
                $roleDiv = $('#role').detach();
            }

            //deduplicate among two selected field
            var roleIds = [];

            $('.selfRoles > option').each(function (index, optionEle) {
                roleIds.push($(optionEle).val());
            });


            $('.allRoles > option').each(function (index, optionEle) {
                var roleId = $(optionEle).val();
                if ($.inArray(roleId, roleIds) >= 0) {
                    $(optionEle).remove();
                }
            });


            //manually select all the roles should be submitted, manually submit the button
            $('#btn_submit').click(function () {

                $('.selfRoles > option').prop('selected', true);
                $('#editForm').submit();
            });


            //输入验证提示
            $('#editForm').validate({
                rules: {
                    name: {
                        required: true,
                        minlength: 3
                    },
                    password: {
                        required: true,
                        minlength: 3
                    },
                    repassword: {
                        required: true,
                        minlength: 3,
                        equalTo: "#password"
                    },
                    email:{
                        required:true,
                        email:true
                    },
                    age:{
                        required:true,
                        min:18
                    }
                },
                messages: {
                    name: {
                        required: "name is required",
                        minlength: "minimum length is 3"
                    },
                    password: {
                        required: "password is required",
                        minlength: "minimum length is 3"
                    },
                    repassword: {
                        required: "please enter password again",
                        minlength: "minimum length is 3",
                        equalTo: "two passwords should be same"
                    },
                    email:{
                        required:"email is required",
                        email:"please enter an email"
                    },
                    age:{
                        min:"minimum age should greater than 18"
                    }
                }
            })

            })


        //move the roles between two select field8
        function moveSelected(srcClass, targetClass) {
            $('.' + targetClass).append($('.' + srcClass + ' > option:selected'));
        }

        function moveAll(srcClass, targetClass) {
            $('.' + targetClass).append($('.' + srcClass + ' > option'));
        }
    </script>


</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <#include "../common/navbar.ftl">
    <!--菜单回显-->
    <c:set var="currentMenu" value="department"/>
    <#include "../common/menu.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>Employee Edit</h1>
        </section>
        <section class="content">
            <div class="box">
                <br>
                <form class="form-horizontal" action="/employee/saveOrUpdate.do" method="post" id="editForm">
                    <input type="hidden" value="${(employee.id)!}" name="id">
                    <div class="form-group">
                        <label for="name" class="col-sm-2 control-label">name：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="name" name="name" value="${(employee.name)!}"
                                   placeholder="please enter name">
                        </div>
                    </div>

                    <#--if this operation is edit(employee != null), then hide the password, it is not allowed to edit password in backend-->
                    <#if !employee??>

                        <div class="form-group">
                            <label for="password" class="col-sm-2 control-label">password：</label>
                            <div class="col-sm-6">
                                <input type="password" class="form-control" id="password" name="password"
                                       placeholder="please enter password">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="repassword" class="col-sm-2 control-label">password：</label>
                            <div class="col-sm-6">
                                <input type="password" class="form-control" name="repassword" id="repassword" placeholder="please enter password again">
                            </div>
                        </div>
                    </#if>
                    <div class="form-group">
                        <label for="email" class="col-sm-2 control-label">Email：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="email" name="email" value="${(employee.email)!}"
                                   placeholder="请输入邮箱">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="age" class="col-sm-2 control-label">age：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="age" name="age" value="${(employee.age)!}"
                                   placeholder="please enter age">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="dept" class="col-sm-2 control-label">department：</label>
                        <div class="col-sm-6">
                            <#--echo all the departments from the employeeController-->
                            <select class="form-control" id="dept" name="dept.id">
                                <#list departments as d>
                                    <option value="${d.id}">${d.name}</option>
                                </#list>
                            </select>
                            <script>
                                //show the current department when editing the employee
                                $("#dept option[value='${(employee.dept.id)!}']").prop("selected", true);
                            </script>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="admin" class="col-sm-2 control-label">admin：</label>
                        <label class="checkbox-inline" style="margin-left: 15px;">
                            <input type="checkbox" id="admin" name="admin">
                            <script>
                                <#if employee?? && employee.admin>
                                    $('#admin').click();
                                </#if>
                            </script>
                        </label>
                    </div>
                    <div class="form-group" id="role">
                        <div>
                            <label for="role" class="control-label" style="margin-left: 60px">role：</label>
                        </div>
                        <div class="row" style="margin-top: 10px">

                            <#--Echo all roles in the employee's input.ftl page-->
                            <#--all rhe roles query from database-->
                            <div class="col-sm-4 col-sm-offset-1">
                                <select multiple class="form-control allRoles" size="15">

                                    <#list roles as role>
                                    <option value="${role.id}">${role.name}</option>
                                    </#list>
                                </select>
                            </div>

                            <div class="col-sm-2" style="margin-top: 60px;" align="center">
                                <div>
                                    <a type="button" class="btn btn-info  " style="margin-top: 10px"
                                       onclick="moveSelected('allRoles', 'selfRoles')">&nbsp;&gt;&nbsp;</a>
                                    <br>
                                    <a type="button" class="btn btn-info " style="margin-top: 10px"
                                       onclick="moveSelected('selfRoles', 'allRoles')">&nbsp;&lt;&nbsp;</a>
                                    <br>
                                    <a type="button" class="btn btn-info " style="margin-top: 10px"
                                       onclick="moveAll('allRoles', 'selfRoles')">&gt;&gt;</a>
                                    <br>
                                    <a type="button" class="btn btn-info " style="margin-top: 10px"
                                       onclick="moveAll('selfRoles', 'allRoles')">&lt;&lt;</a>
                                </div>
                            </div>
                                <#--all rhe roles the employee has-->
                            <div class="col-sm-4">
                                <select multiple class="form-control selfRoles" size="15" name="ids">
                                    <#--show all the roles this employee currently has-->
                                    <#if employee??>
                                    <#list employee.roles as role>
                                    <option value="${role.id}">${role.name}</option>
                                    </#list>
                                    </#if>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-sm-offset-1 col-sm-6">
                            <button type="button" id="btn_submit" class="btn btn-default">save</button>
                            <button type="reset" class="btn btn-default">reset</button>
                        </div>
                    </div>
                </form>
                <br>

            </div>

        </section>
    </div>
    <#include "../common/footer.ftl">
</div>
</body>
</html>
