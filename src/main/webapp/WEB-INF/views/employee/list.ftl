<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Employee Management</title>

    <#include "../common/link.ftl">
    <script>
        $(function () {
            jQuery.ajaxSettings.traditional = true;

            $('.btn-delete').click(function () {
                var url = $(this).data('url');
                console.log(url);
                $.messager.confirm("reminder", "are you sure to delete?", function () {
                    $.get(url, function (data) {
                        if (data.success) {
                            $.messager.alert("reminder", "finished, will redirect in 1s");

                            window.setTimeout(function () {
                                window.location.reload();
                            }, 1000)
                        } else {
                            $.messager.alert("reminder", data.msg);
                        }
                    });
                })
            })


            $('#all').change(function () {
                $('.checkbox').prop("checked", this.checked);
            })


            $('.btn_batchDelete').click(function () {
                //点击按钮如果没有选择要删除的数据,给出提示
                //判断被勾选的复选框的个数
                if ($('.checkbox:checked').length == 0) {
                    $.messager.alert("reminder", "no data selected");
                    return;
                }
                //获取数据中的id
                //map:将一个数组转换成另一个数组
                var ids = $.map($('.checkbox:checked'), function (checkbox) {
                    return $(checkbox).data("id");
                })
                var url = $(this).data('url');
                //如果选了,确认删除
                $.messager.confirm("reminder", "are you sure to delete the data you selected?", function () {
                    //确认,发送请求,携带要删除的数据的id

                    $.get(url, {ids: ids}, function (data) {
                        if (data.success) {
                            $.messager.alert("reminder", "finished, will redirect in 1s");

                            window.setTimeout(function () {
                                window.location.reload();
                            }, 1000)
                        } else {
                            $.messager.alert("reminder", data.msg);
                        }
                    })
                })
            })

        })

    </script>

</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <#include "../common/navbar.ftl">
    <!--菜单回显-->
    <#assign currentMenu="employee">
     <#include "../common/menu.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>Employee Management</h1>
        </section>
        <section class="content">
            <div class="box">
                <!--高级查询--->
                <form class="form-inline" id="searchForm" action="/employee/list.do" method="post">
                    <br>
                    <input type="hidden" name="currentPage" id="currentPage" value="1">
                    <div class="form-group">
                        <label for="keyword">keyword:</label>
                        <input type="text" class="form-control" id="keyword" name="keyword" value="${(qo.keyword)!}"
                               placeholder="please enter name/email">
                    </div>
                    <div class="form-group">
                        <label for="dept"> department:</label>
                        <select class="form-control" id="dept" name="deptId">
                            <option value="-1">--Select--</option>
                             <#list departments as d>
                                 <option value="${d.id}">${d.name}</option>
                             </#list>
                        </select>
                        <script>
                            $("#dept option[value='${(qo.deptId)!}']").prop("selected", true);
                        </script>
                    </div>
                    <button id="btn_query" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span> search
                    </button>
                    <a href="/employee/input.do" class="btn btn-success"><span
                            class="glyphicon glyphicon-plus">add</span></a>
                    <a href="javascript:;" class="btn btn-danger btn_batchDelete" data-url="/employee/batchDelete.do">
                        <span class="glyphicon glyphicon-trash"></span> batch delete
                    </a>

                </form>

                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="all">
                        </th>
                        <th>no</th>
                        <th>name</th>
                        <th>email</th>
                        <th>age</th>
                        <th>admin</th>
                        <th>department</th>
                        <th>action</th>
                    </tr>
                    </thead>
                    <#list pageInfo.list as entity>
                        <tr>
                            <td>
                                <input type="checkbox" data-id="${entity.id}" class="checkbox">
                            </td>
                            <td>${entity_index + 1}</td>
                            <td>${(entity.name)!}</td>
                            <td>${(entity.email)!}</td>
                            <td>${(entity.age)!}</td>
                            <td>${(entity.admin)?string('yes', 'no')}</td>
                            <td>${(entity.dept.name)!}</td>
                            <td>
                                <a class="btn btn-info btn-xs" href="/employee/input.do?id=${entity.id}">
                                    <span class="glyphicon glyphicon-pencil"></span>edit
                                </a>
                        <@shiro.hasPermission name="employee:delete">
                                <a href="javascript:;" data-url="/employee/delete.do?id=${entity.id}"
                                   class="btn btn-danger btn-delete btn-xs">
                                    <span class="glyphicon glyphicon-trash">delete</span>
                                </a>
                        </@shiro.hasPermission>
                            </td>
                        </tr>
                    </#list>
                </table>
                <!--分页-->
                 <#include "../common/page.ftl">
            </div>
    </div>
    </section>
</div>
 <#include "../common/footer.ftl">
</div>
</body>
</html>
