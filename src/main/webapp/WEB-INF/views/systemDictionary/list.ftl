<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>SystemDictionary Management</title>
    <#include "../common/link.ftl"/>

    <script>
        $(function () {
            $('.btn-input').click(function () {
                $('input').val('');
                var json = $(this).data('json');
                if (json) {
                    $('input[name=id]').val(json.id);
                    $('input[name=sn]').val(json.sn);
                    $('input[name=title]').val(json.title);
                    $('input[name=intro]').val(json.intro);
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
                        alert("reminder", data.msg);
                    }
                })
            })


        })
    </script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <#include "../common/navbar.ftl"/>
    <!--菜单回显-->
    <#assign currentMenu="systemDictionary">
    <#include "../common/menu.ftl"/>
    <div class="content-wrapper">
        <section class="content-header">
            <h1>SystemDictionary Management</h1>
        </section>
        <section class="content">
            <div class="box">
                <!--高级查询--->
                <form class="form-inline" id="searchForm" action="/systemDictionary/list.do" method="post">
                    <input type="hidden" name="currentPage" id="currentPage" value="1">
                    <div class="form-group">
                    <#--&nbsp;-->
                    <#--<label for="keyword">关键字:</label>-->
                    <#-- <input type="text" class="form-control" id="keyword"
                            name="keyword" value="${qo.keyword}" placeholder="请输入姓名/邮箱" style="width: 130px">-->
                    <#--<button type="submit" id="btn_query" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span> 查询</button>-->
                        <a href="javascript:;" class="btn btn-success btn-input" style="margin: 10px">
                            <span class="glyphicon glyphicon-plus"></span> add
                        </a>
                    </div>
                </form>
                <!--编写内容-->
                <div class="box-body table-responsive no-padding ">
                    <table class="table table-hover table-bordered">
                        <tr>
                            <th>no</th>
                            <th>sn</th>
                            <th>title</th>
                            <th>intro</th>
                            <th>action</th>
                        </tr>
                        <#list pageInfo.list as entity>
                            <tr>
                                <td>${entity_index +1}</td>
                                <td>${entity.sn}</td>
                                <td>${entity.title}</td>
                                <td>${entity.intro}</td>
                                <td>
                            <@shiro.hasPermission name="systemDictionary:saveOrUpdate">
                                    <a class="btn btn-info btn-xs btn-input" data-json='${entity.json}'
                                       href="javascript:;">
                                        <span class="glyphicon glyphicon-pencil"></span> edit
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
                <form class="form-horizontal" action="/systemDictionary\/saveOrUpdate.do" method="post" id="editForm">
                    <input type="hidden" name="id">
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="name" class="col-sm-4 control-label">sn：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="sn" name="sn"
                            placeholder="SN">
                        </div>
                    </div>
                    <div class="form-group" style="margin-top: 10px;">
                        <label for="sn" class="col-sm-4 control-label">title：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="title" name="title"
                            placeholder="title">
                        </div>
                    </div>

                    <div class="form-group" style="margin-top: 10px;">
                        <label for="sn" class="col-sm-4 control-label">intro：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" id="intro" name="intro"
                            placeholder="intro">
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
