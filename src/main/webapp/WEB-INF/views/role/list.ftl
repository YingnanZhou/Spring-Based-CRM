<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Role Management</title>
    <#include "../common/link.ftl">
    <script>

        $(function () {
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
        })
    </script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <#include "../common/navbar.ftl">
    <!--菜单回显-->
    <#assign currentMenu="role">
    <#include "../common/menu.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>Role Management</h1>
        </section>
        <section class="content">
            <div class="box">
                <!--高级查询--->
                <form class="form-inline" id="searchForm" action="/role/list.do" method="post">
                    <input type="hidden" name="currentPage" id="currentPage" value="1">
                    <a href="/role/input.do" class="btn btn-success btn-input" style="margin: 10px">
                        <span class="glyphicon glyphicon-plus"></span> add
                    </a>
                </form>
                <!--编写内容-->
                <div class="box-body table-responsive no-padding ">
                    <table class="table table-hover table-bordered">
                        <tr>
                            <th>no</th>
                            <th>number</th>
                            <th>sn</th>
                            <th>action</th>
                        </tr>
                        <#list pageInfo.list as entity>
                            <tr>
                                <td>${entity_index + 1}</td>
                                <td>${entity.name}</td>
                                <td>${entity.sn}</td>
                                <td>
                                    <a class="btn btn-info btn-xs btn-input" href="/role/input.do?id=${entity.id}">
                                        <span class="glyphicon glyphicon-pencil"></span> edit
                                    </a>
                            <@shiro.hasPermission name="role:delete">
                                    <a href="javascript:;" data-url="/role/delete.do?id=${entity.id}" class="btn btn-danger btn-xs btn-delete">
                                        <span class="glyphicon glyphicon-trash"></span> delete
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
