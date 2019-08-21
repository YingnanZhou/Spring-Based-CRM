<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Failed Customer</title>
    <#include "../common/link.ftl"/>

    <script>
        $(function () {

        })
    </script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <#include "../common/navbar.ftl"/>
    <!--菜单回显-->
    <#assign currentMenu="customer_failed">
    <#include "../common/menu.ftl"/>
    <div class="content-wrapper">
        <section class="content-header">
            <h1>Failed Customer</h1>
        </section>
        <section class="content">
            <div class="box">
                <!--高级查询--->
                <form class="form-inline" id="searchForm" action="/customer/failedList.do" method="post">
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

</body>
</html>
