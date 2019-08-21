<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>TransferHistory Management</title>
    <#include "../common/link.ftl">
    <script>
        //编辑
        $(function () {


        })

    </script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <#include "../common/navbar.ftl">
    <!--菜单回显-->
    <#assign currentMenu="customerTransfer">
    <#include "../common/menu.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>TransferHistory Management</h1>
        </section>
        <section class="content">
            <div class="box">
                <!--高级查询--->
                <div style="margin: 10px;">
                    <!--高级查询--->
                    <form class="form-inline" id="searchForm" action="/customerTransfer/list.do" method="post">
                        <input type="hidden" name="currentPage" id="currentPage" value="1">
                        <div class="form-group">
                            <label for="keyword">keyword:</label>
                            <input type="text" class="form-control" id="keyword" name="keyword" value="${(qo.keyword)!""}" placeholder="请输入name">
                        </div>
                        <div class="form-group">
                        </div>
                        <button id="btn_query" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span>search</button>
                    </form>

                </div>
                <table class="table table-striped table-hover" >
                    <thead>
                    <tr>
                        <th>no</th>
                        <th>name</th>
                        <th>date</th>
                        <th>operator</th>
                        <th>old seller</th>
                        <th>new seller</th>
                        <th>transfer reason</th>
                    </tr>
                    </thead>
               <#list pageInfo.list as entity>
                   <tr>
                       <td>${entity_index+1}</td>
                       <td>${(entity.customer.name)!}</td>
                       <td>${(entity.operateTime?string('yyyy-MM-dd HH:mm:ss'))!}</td>
                       <td>${(entity.operator.name)!}</td>
                       <td>${(entity.oldSeller.name)!}</td>
                       <td>${(entity.newSeller.name)!}</td>
                       <td>${(entity.reason)!}</td>
                   </tr>
               </#list>
                </table>
            <#include "../common/page.ftl">
            </div>
        </section>
    </div>
    <#include "../common/footer.ftl">
</div>
</body>
</html>
