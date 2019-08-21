<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Customer Management</title>
    <#include "../common/link.ftl"/>

    <script>
        $(function () {
            $('.btn-input').click(function () {
                $('input').val('');
                var json = $(this).data('json');
                if (json) {
                    $(".inputTitle").html("customer edit");
                    $("#editForm input[name=id]").val(json.id);
                    $("#editForm input[name=name]").val(json.name);
                    $("#editForm input[name=age]").val(json.age);
                    $("#editForm input[name=gender]").val(json.gender);
                    $("#editForm input[name=tel]").val(json.tel);
                    $("#editForm input[name=qq]").val(json.qq);
                    $("#editForm select[name='job.id']").val(json.jobId);
                    $("#editForm select[name='source.id']").val(json.sourceId);
                    $("#editForm select[name='seller.id']").val(json.sellerId);
                }
                //show modal
                $('#editModal').modal('show');
            })

            $('.inputSubmit').click(function () {
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


            $('.statusBtn').click(function () {
                var data = $(this).data('json');
                //console.log(date.name);
                if (data) {

                    $("#statusForm input[name=cid]").val(data.id);

                    $("#statusForm input[name=name]").val(data.name);
                    $("#statusForm select[name='status.id']").val(data.status);

                }
                //显示出模态框
                $('#statusModal').modal('show');
            })

            $('.statusSubmit').click(function () {
                $('#statusForm').ajaxSubmit(function (data) {
                    //自动将表单提交请求的方式修改为异步请求
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


            $('.traceBtn').click(function () {
                var data = $(this).data('json');


                if (data) {

                    $("#traceForm input[name='customer.id']").val(data.id);

                    $("#traceForm input[name=name]").val(data.name);

                }
                //显示出模态框
                $('#traceModal').modal('show');
            })


            $('.traceSubmit').click(function () {
                $('#traceForm').ajaxSubmit(function (data) {
                    //自动将表单提交请求的方式修改为异步请求
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




            //移交
            $('.btn-transfer').click(function () {
                var data = $(this).data('json');
                if(data){
                    console.log(data.oldSellerId);
                    $("#transferForm input[name='customer.id']").val(data.id);
                    $("#transferForm input[name='customer.name']").val(data.name);
                    $("#transferForm input[name='oldSeller.id']").val(data.sellerId);
                    $("#transferForm input[name='oldSeller.name']").val(data.sellerName);

                }
                $('#transferModal').modal('show');
            })




            $('.transferSubmit').click(function () {
                $('#transferForm').ajaxSubmit(function (data) {
                    //自动将表单提交请求的方式修改为异步请求
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
    </script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <#include "../common/navbar.ftl"/>
    <!--菜单回显-->
    <#assign currentMenu="customer_potential">
    <#include "../common/menu.ftl"/>
    <div class="content-wrapper">
        <section class="content-header">
            <h1>Customer Management</h1>
        </section>
        <section class="content">
            <div class="box">
                <!--高级查询--->
                <form class="form-inline" id="searchForm" action="/customer/potentialList.do" method="post">
                    <br>
                    <input type="hidden" name="currentPage" id="currentPage" value="1">
                    <div class="form-group">
                        <label for="keyword">keyword:</label>
                        <input type="text" class="form-control" id="keyword" name="keyword" value="${(qo.keyword)!}"
                               placeholder="please enter name/tel">
                    </div>


                    <div class="form-group">
                        <label for="seller">seller:</label>
                        <select class="form-control" id="seller" name="sellerId">
                            <option value="-1">all</option>

                        <#list sellers! as s>
                        <option value="${s.id}">${s.name}</option>
                        </#list>
                        </select>
                        <script>
                            $("#seller option[value='${(qo.sellerId)!}']").prop("selected", true);
                        </script>
                    </div>


                    <button id="btn_query" class="btn btn-primary">
                        <span class="glyphicon glyphicon-search"></span> search
                    </button>

                    <div class="form-group">
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
                            <th>name</th>
                            <th>tel</th>
                            <th>qq</th>
                            <th>job</th>
                            <th>source</th>
                            <th>seller</th>
                            <th>status</th>
                            <th>action</th>

                        </tr>
                        <#list pageInfo.list as entity>
                            <tr>
                                <td>${entity_index +1}</td>
                                <td>${(entity.name)!}</td>
                                <td>${(entity.tel)!}</td>
                                <td>${(entity.qq)!}</td>
                                <td>${(entity.job.title)!}</td>
                                <td>${(entity.source.title)!}</td>
                                <td>${(entity.seller.name)!}</td>
                                <td>${(entity.statusName)!}</td>
                                <td>
                                    <a class="btn btn-info btn-xs btn-input" data-json='${entity.json!}'>
                                        <span class="glyphicon glyphicon-pencil"></span>edit
                                    </a>

                                    <a class="btn btn-primary btn-xs traceBtn" data-json='${entity.json!}'>
                                        <span class="glyphicon glyphicon-pencil"></span>trace
                                    </a>
                               <@shiro.hasAnyRoles name="Market_Manager, admin">
                               <a class="btn btn-warning btn-xs btn-transfer" data-json='${entity.json!}'>
                                   <span class="glyphicon glyphicon-pencil"></span>transfer
                               </a>
                               </@shiro.hasAnyRoles>
                            <@shiro.hasAnyRoles name="admin">
                                    <a class="btn btn-danger btn-xs statusBtn" data-json='${entity.json!}'>
                                        <span class="glyphicon glyphicon-pencil"></span>change status
                                    </a>
                            </@shiro.hasAnyRoles>
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

<div class="modal fade" id="editModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title inputTitle">customer input</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="/customer/saveOrUpdate.do" method="post" id="editForm">
                    <input type="hidden" value="" name="id">
                    <div class="form-group">
                        <label class="col-sm-3 control-label">name</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" name="name"
                                   placeholder="name"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">age</label>
                        <div class="col-sm-6">
                            <input type="number" class="form-control" name="age"
                                   placeholder="age"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">gender</label>
                        <div class="col-sm-6">
                            <select class="form-control" name="gender">
                                <option value="1">male</option>
                                <option value="0">female</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">tel</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" name="tel"
                                   placeholder="tel"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">qq</label>
                        <div class="col-sm-6">
                            <input type="text" class="form-control" name="qq"
                                   placeholder="qq"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">job</label>
                        <div class="col-sm-6">
                            <select class="form-control" name="job.id">
                                <#list jobs as j>
                                    <option value="${j.id}">${j.title}</option>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label">source</label>
                        <div class="col-sm-6">
                            <select class="form-control" name="source.id">
                                <#list sources as s>
                                    <option value="${s.id}">${s.title}</option>
                                </#list>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label">sellers</label>
                        <div class="col-sm-6">
                            <select class="form-control" name="seller.id">
                               <#list sellers as e>
                                   <option value="${e.id}">${e.name}</option>
                               </#list>
                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary inputSubmit">submit</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">cancal</button>
            </div>
        </div>
    </div>
</div>


<#--修改状态-->
<div class="modal fade" id="statusModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">change status</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="/customer/updateStatus.do" method="post" id="statusForm">
                    <input type="hidden" name="cid"/>
                    <div class="form-group">
                        <label class="col-lg-4 control-label">name：</label>
                        <div class="col-lg-6">
                            <input type="text" class="form-control" name="name"
                                   readonly placeholder="请输入客户名称"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-4 control-label">status：</label>
                        <div class="col-lg-6">
                            <select class="form-control" name="status">
                                <option value="0">potential customer</option>
                                <option value="1">to formal customer</option>
                                <option value="2">to customer pool</option>
                                <option value="3">failed</option>
                                <option value="4">loss</option>
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">close</button>
                <button type="button" class="btn btn-primary statusSubmit">save</button>
            </div>
        </div>
    </div>
</div>

<#--跟进历史-->
<div class="modal fade" id="traceModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title">trace</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="/customerTraceHistory/saveOrUpdate.do" method="post"
                      id="traceForm">
                <#--新增,新增跟进历史没有ID,客户应该要有ID,不然就不知道当前是哪个客户的跟进历史-->
                    <input type="hidden" name="customer.id"/>
                    <div class="form-group">
                        <label class="col-lg-4 control-label">name：</label>
                        <div class="col-lg-6">
                            <input type="text" class="form-control" readonly name="name"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-4 control-label">time：</label>
                        <div class="col-lg-6 ">
                            <input type="text" class="form-control " name="traceTime" onfocus=""
                                   placeholder="请输入跟进时间">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-4 control-label">record：</label>
                        <div class="col-lg-6">
                            <input type="text" class="form-control" name="traceDetails"
                                   placeholder="请输入跟进记录"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-4 control-label">communication method：</label>
                        <div class="col-lg-6">
                            <select class="form-control" name="traceType.id">
                                <#list ccts as c>
                                    <option value="${c.id}">${c.title}</option>
                                </#list>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-4 control-label">result：</label>
                        <div class="col-lg-6">
                            <select class="form-control" name="traceResult">
                                <option value="3">good</option>
                                <option value="2">medium</option>
                                <option value="1">bad</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-lg-4 control-label">remark：</label>
                        <div class="col-lg-6">
                            <textarea type="text" class="form-control" name="remark"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary traceSubmit">save</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">close</button>
            </div>
        </div>
    </div>
</div>

<#--移交模态框-->
<div id="transferModal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">transfer</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="/customerTransfer/saveOrUpdate.do" method="post" id="transferForm" style="margin: -3px 118px">
                    <input type="hidden" name="id" id="customerTransferId"/>
                    <div class="form-group" >
                        <label for="name" class="col-sm-4 control-label">name：</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control"  name="customer.name"   readonly >
                            <input type="hidden" class="form-control"  name="customer.id">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="sn" class="col-sm-4 control-label">old seller：</label>
                        <div class="col-sm-8">
                            <input type="text" class="form-control" name="oldSeller.name" readonly>
                            <input type="hidden" class="form-control" name="oldSeller.id">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="sn" class="col-sm-4 control-label">new seller：</label>
                        <div class="col-sm-8">
                            <select name="newSeller.id" id="newSeller" class="form-control">
                                <#list sellers as e>
                                    <option value="${e.id}">${e.name}</option>
                                </#list>
                            </select>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="sn" class="col-sm-4 control-label">transfer reason：</label>
                        <div class="col-sm-8">
                            <textarea type="text" class="form-control" id="reason" name="reason" cols="10" ></textarea>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">close</button>
                <button type="button" class="btn btn-primary transferSubmit" >save</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>
</html>
