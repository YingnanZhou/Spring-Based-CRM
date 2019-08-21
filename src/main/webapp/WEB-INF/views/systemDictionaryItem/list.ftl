<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>DictionaryItem Management</title>
    <#include "../common/link.ftl"/>

    <script>
        $(function () {
            $(".inputBtn").click(function () {
                var pid = '${(qo.parentId)!}';
                console.log(pid);

                if(!pid || pid == -1){
                    $.messager.alert("reminder", "please check at least one first")
                    return ;
                }

                //修改模态框标题
                $(".modal-title").html("add");
                //数据复原
                $("#editForm")[0].reset();

                //字典目录
                var data = $(this).data("json");
                //弹出模态框
                $("#editModal").modal("show");

                $("input[name=parentName]").val('${(parent.title)!}');


                $("#editForm input[name='parentId']").val(${(parent.id)!});

                //数据字典回显数据


                if(data){
                    $(".modal-title").html("edit");
                    $("#editForm input[name='id']").val(data.id);
                    $("#editForm input[name='title']").val(data.title);
                    $("#editForm input[name='sequence']").val(data.sequence);
                }
            })
        })
        //提交编辑表单
        $(function () {
            $(".btn_submit").click(function () {
                $("#editForm").ajaxSubmit(function (data) {
                    if(data.success){
                        $.messager.confirm("reminder", "successed", function () {
                            window.location.reload();
                        })
                    }else{
                        $.messager.alert("reminder", data.msg)
                    }
                })
            })
        })

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
        //字典目录点击
        $(function () {
            $('.dicDir').click(function () {
                var pid = $(this).data('pid');
                $('#parentId').val(pid);
                $('#searchForm').submit();
            })

        })
    </script>

    </head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <#include "../common/navbar.ftl"/>
    <!--菜单回显-->
    <#assign currentMenu="systemDictionaryItem">
    <#include "../common/menu.ftl"/>
    <div class="content-wrapper">
        <section class="content-header">
            <h1>DictionaryItem Management</h1>
        </section>
        <section class="content">
            <div class="box">

                <div class="row">
                    <div class="col-sm-3">
                        <div class="panel panel-info">
                            <div class="panel-heading"><strong>Dictionary Item</strong></div>
                            <ul class="list-group" id="dicDirUl">
                <#list list as d>
                    <li class="list-group-item"><a class="dicDir" data-pid="${(d.id)!}" href="javascript:;">${(d.title)!}</a></li>
                </#list>
                                <script>
                                    $(".dicDir[data-pid='${(qo.parentId)!}']").closest("li").addClass("active");
                                    $(".dicDir[data-pid='${(qo.parentId)!}']").css("color", "white")
                                </script>
                            </ul>
                        </div>
                    </div>

                    <div class="col-sm-9">
                        <form class="form-inline" id="searchForm" action="/systemDictionaryItem/list.do" method="post">
                            <input type="hidden" name="currentPage" id="currentPage" value="1">
                            <input type="hidden" name="parentId" id="parentId" value="${(qo.parentId)!}">
                            <div class="form-group">
                                <a href="javascript:;" class="btn btn-success btn-input" style="margin: 10px">
                                    <spfan class="glyphicon glyphicon-plus inputBtn">add</spfan>
                                </a>
                            </div>
                        </form>
                        <div class="box-body table-responsive no-padding ">
                            <table class="table table-hover table-bordered">
                                <tr>
                                    <th>sn</th>
                                    <th>name</th>
                                    <th>sequence</th>
                                    <th>action</th>
                                </tr>
                        <#list pageInfo.list as entity>
                            <tr>
                                <td>${entity_index +1}</td>
                                <td>${entity.title}</td>
                                <td>${entity.sequence}</td>
                                <td>
                                    <a class="btn btn-info btn-xs inputBtn" data-json='${entity.json}'
                                       href="javascript:;">
                                    <#--data-json='${entity.json}'-->
                                        <span class="glyphicon glyphicon-pencil">edit</span>
                                    </a>
                                    <a href="javascript:;" data-url="/systemDictionaryItem/delete.do?id=${entity.id}"
                                       class="btn btn-danger btn-xs btn-delete">
                                        <span class="glyphicon glyphicon-trash">delete</span>
                                    </a>
                                </td>
                            </tr>
                        </#list>
                            </table>
                            <!--分页-->
                            <#include "../common/page.ftl"/>

                        </div>
                    </div>

                </div>
                <!--高级查询--->

                <!--编写内容-->
            </div>
        </section>
    </div><#include "../common/footer.ftl"/>
</div>
<!-- Modal -->
<#--数据字典编辑模态框-->
<div class="modal fade" id="editModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">edit</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="/systemDictionaryItem/saveOrUpdate.do" method="post"
                      id="editForm">
                    <input type="hidden"  name="parentId" id="parentId">
                    <input type="hidden"  name="id" id="id">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">category：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" name="parentName" disabled>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">title：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" name="title" value="" placeholder="please enter title">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">sequence：</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" name="sequence" value="" placeholder="please enter sequence">
                        </div>
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary btn_submit">save</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">cancel</button>
            </div>
        </div>
    </div>
</div>


</body>
</html>
