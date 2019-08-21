<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Department Management</title>
    <#include "../common/link.ftl"/>

    <script>
        $(function () {
            $('.btn-input').click(function () {
                $('input').val('');
                var json = $(this).data('json');
                if (json) {
                    $('input[name=id]').val(json.id);
                    $('input[name=name]').val(json.name);
                    $('input[name=sn]').val(json.sn);
                }
                //show modal
                $('#myModal').modal('show');
            })


            $('.btn-submit').click(function () {
                $('#editForm').ajaxSubmit(function (data) {
                    //自动将表单提交请求改为异步
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
    <#include "../common/navbar.ftl"/>
    <!--菜单回显-->
    <#assign currentMenu="department">
    <#include "../common/menu.ftl"/>
    <div class="content-wrapper">
        <section class="content-header">
            <h1>Department Management</h1>
        </section>
        <section class="content">
            <div class="box">

                <form class="form-inline" id="searchForm" action="/department/list.do" method="post">
                    <input type="hidden" name="currentPage" id="currentPage" value="1">
                        <a href="javascript:;" class="btn btn-success btn-input" style="margin: 10px">
                            <span class="glyphicon glyphicon-plus"></span> add
                        </a>
                </form>
                <!--编写内容-->
                <div class="box-body table-responsive no-padding ">
                    <table class="table table-hover table-bordered">
                        <tr>
                            <th>no</th>
                            <th>department name</th>
                            <th>department sn</th>
                            <th>action</th>
                        </tr>
                        <#list pageInfo.list as entity>
                            <tr>
                                <td>${entity_index +1}</td>
                                <td>${entity.name}</td>
                                <td>${entity.sn}</td>
                                <td>
                                    <a class="btn btn-info btn-xs btn-input" data-json='${entity.json}'
                                       href="javascript:;">
                                    <#--data-json='${entity.json}'-->
                                        <span class="glyphicon glyphicon-pencil"></span> edit
                                    </a>
                            <@shiro.hasPermission name="department:delete">
                                    <a href="javascript:;" data-url="/department/delete.do?id=${entity.id}"
                                       class="btn btn-danger btn-xs btn-delete">
                                        <span class="glyphicon glyphicon-trash"></span> delete
                                    </a>
                            </@shiro.hasPermission>
                                </td>
                            </tr>
                        </#list>
                    </table>
                    <!--分页-->
                            <#include "../common/page.ftl"/>

                </div>
            </div>
        </section>
    </div><#include "../common/footer.ftl"/>
</div>
<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="/department/saveOrUpdate.do" method="post" id="editForm">
                    <input type="hidden" name="id">
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="name" class="col-sm-4 control-label">name：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="name" name="name"
                            placeholder="please enter department name">
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="sn" class="col-sm-4 control-label">sn：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="sn" name="sn"
                            placeholder="please enter department sn">
                        </div>
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">cancel</button>
                <button type="button" class="btn btn-primary btn-submit">save</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
