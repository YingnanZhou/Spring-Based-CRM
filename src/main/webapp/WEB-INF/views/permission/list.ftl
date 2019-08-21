<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>permission management</title>
    <#include "../common/link.ftl">

    <script>
        $(function () {
            $('#reload').click(function(){


                $.post('/permission/reload.do', function(data){
                    console.log(1);
                    if(data.success) location.href = '/permission/list.do';
                    else alert('some thing went wrong');
                });
            });

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
        });
    </script>

</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

    <#include "../common/navbar.ftl">
    <!--菜单回显-->
    <#assign currentMenu="permission">
    <#include "../common/menu.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>Permission Management</h1>
        </section>
        <section class="content">
            <div class="box">
                <!--高级查询--->
                <br>
                <form class="form-inline" id="searchForm" action="/permission/list.do" method="post">
                    <input type="hidden" name="currentPage" id="currentPage" value="1">
                    <button id="reload" type="button" class="btn btn-primary">
                        <span class="glyphicon glyphicon-refresh" aria-hidden="true">
                        </span> reload
                    </button>
                </form>
                <br>
                </form>
                <!--编写内容-->
                <div class="box-body table-responsive no-padding ">
                    <table class="table table-hover table-bordered">
                        <tr>
                            <th>no</th>
                            <th>name</th>
                            <th>expression</th>
                            <th>action</th>
                        </tr>
                        <#list pageInfo.list as entity>
                            <tr>
                                <td>${entity_index + 1}</td>
                                <td>${entity.name}</td>
                                <td>${entity.expression}</td>
                                <td>
                            <@shiro.hasPermission name="permission:delete">
                                    <a href="javascript:;"  data-url="/permission/delete.do?id=${entity.id}" class="btn btn-danger btn-xs btn-delete">
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

