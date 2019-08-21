<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Customer Management</title>
    <#include "../common/link.ftl"/>

    <script>
        $(function () {

            $('.absorbBtn').click(function () {
                var json = $(this).data('json');
                if (json) {
                    $("#absorbForm input[name='customer.id']").val(json.id);
                    $("#absorbForm input[name='oldSeller.id']").val(json.sellerId);

                }
                //show modal
                $('#absorbModal').modal('show');
            })

            $('.absorbSubmit').click(function () {
                $('#absorbForm').ajaxSubmit(function (data) {
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



        })
    </script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <#include "../common/navbar.ftl"/>
    <!--菜单回显-->
    <#assign currentMenu="customer_pool">
    <#include "../common/menu.ftl"/>
    <div class="content-wrapper">
        <section class="content-header">
            <h1>Customer Pool</h1>
        </section>
        <section class="content">
            <div class="box">
                <!--高级查询--->
                <form class="form-inline" id="searchForm" action="/customer/poolList.do" method="post">
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

                                    <a class="btn btn-info btn-xs absorbBtn" data-json='${entity.json!}'>
                                        <span class="glyphicon glyphicon-pencil"></span>absorb
                                    </a>

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

<#--吸纳模态框-->
<div id="absorbModal" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">absorb</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" action="/customerTransfer/absorb.do" method="post" id="absorbForm" style="margin: -3px 118px">
                    <input type="hidden" name="id"/>
                    <input type="hidden" class="form-control" name="oldSeller.id">
                    <input type="hidden" class="form-control" name="customer.id">

                    <div class="form-group">
                        <label for="sn" class="col-sm-4 control-label">mark：</label>
                        <div class="col-sm-8">
                            <textarea type="text" class="form-control" name="reason" cols="10"></textarea>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">close</button>
                <button type="button" class="btn btn-primary absorbSubmit">save</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>
</html>
