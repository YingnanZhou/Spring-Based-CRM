<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>TraceHistory Management</title>
    <#include "../common/link.ftl">
    <script type="text/javascript">
        $(function () {
            $("#btn_query").click(function () {
                $("#currentPage").val(1);
                $("#searchForm").submit();
            });
        })
        //编辑
        $(function () {
            $(".inputBtn").click(function () {

                //弹出模态框
                $("#traceHistoryModal").modal("show");
                //数据复原
                $("#traceHistoryForm")[0].reset();

                //客户回显数据
                var data = $(this).data("json");
                if (data) {

                    $("#traceHistoryForm input[name='id']").val(data.id);
                    $("#traceHistoryForm input[name='customer.id']").val(data.customerId);
                    $("#traceHistoryForm input[name='customer.name']").val(data.customerName);
                    $("#traceHistoryForm input[name='traceTime']").val(data.traceTime);
                    $("#traceHistoryForm input[name='traceDetails']").val(data.traceDetails);
                    $("#traceHistoryForm select[name='traceType.id']").val(data.traceTypeId);

                    $("#traceHistoryForm select[name='traceResult']").val(data.traceResult);
                    $("#traceHistoryForm textarea[name='remark']").val(data.remark);
                }
            })
        })

        //提交编辑表单
        $(function () {
            $(".traceHistorySubmit").click(function () {
                $("#traceHistoryForm").ajaxSubmit(function (data) {
                    if (data.success) {
                        window.location.reload();
                    } else {
                        $.messager.alert("温馨提示", data.msg)
                    }
                })
            })
        })
    </script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <#include "../common/navbar.ftl">
    <!--菜单回显-->
    <#assign currentMenu="customerTraceHistory">
    <#include "../common/menu.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>raceHistory Management</h1>
        </section>
        <section class="content">
            <div class="box">
                <form class="form-inline" id="searchForm" action="/customerTraceHistory/list.do" method="post">
                    <input type="hidden" name="currentPage" id="currentPage" value="1">

                </form>

                <table class="table table-striped table-hover">
                    <thead>
                    <tr>
                        <th>no</th>
                        <th>name</th>
                        <th>trace data</th>
                        <th>trace detail</th>
                        <th>trace method</th>
                        <th>trace result</th>
                        <th>record employee</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <#list pageInfo.list as entity>
                        <tr>
                            <td>${entity_index+1}</td>
                            <td>${(entity.customer.name)!}</td>
                            <td>${(entity.traceTime?string('yyyy-MM-dd'))!}</td>
                            <td>${(entity.traceDetails)!}</td>
                            <td>${(entity.traceType.title)!""}</td>
                            <td>${(entity.resultName)!} </td>
                            <td>${(entity.inputUser.name)!}</td>
                            <td>
                                <a class="btn btn-info btn-xs inputBtn" data-json='${(entity.json)!}'>
                                    <span class="glyphicon glyphicon-pencil"></span> edit
                                </a>
                            </td>
                        </tr>
                    </#list>
                        </table>
                <#include "../common/page.ftl">
            </div>
        </section>
    </div>
    <#include "../common/footer.ftl">
</div>

<#--编辑-->
<div id="traceHistoryModal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">add/edit</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="/customerTraceHistory/saveOrUpdate.do" method="post" id="traceHistoryForm"
                      style="margin: -3px 118px">
                    <input type="hidden" name="id" id="customerTraceHistoryId"/>
                    <div class="form-group">
                        <label for="name" class="col-sm-4 control-label">name：</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" name="customer.name" readonly>
                            <input type="hidden" class="form-control" name="customer.id">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="sn" class="col-sm-4 control-label">trace date：</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control " name="traceTime" onfocus="">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="sn" class="col-sm-4 control-label">trace detail：</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" name="traceDetails">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="sn" class="col-sm-4 control-label">trace method：</label>
                        <div class="col-sm-8">
                            <select name="traceType.id" class="form-control">
                                <#list ccts as t>
                                    <option value="${t.id}">${t.title}</option>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="sn" class="col-sm-4 control-label">trace result：</label>
                        <div class="col-sm-8">
                            <select name="traceResult" class="form-control">
                                <option value="3">good</option>
                                <option value="2">medium</option>
                                <option value="1">bad</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="sn" class="col-sm-4 control-label">remark：</label>
                        <div class="col-sm-8">
                            <textarea type="text" class="form-control" name="remark">
                            </textarea>
                        </div>
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">close</button>
                <button type="button" class="btn btn-primary traceHistorySubmit">save</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->

</body>
</html>
