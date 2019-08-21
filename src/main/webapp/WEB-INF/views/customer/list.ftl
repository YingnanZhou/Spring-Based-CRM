<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>Customer Management</title>
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
    <#assign currentMenu="customer">
    <#include "../common/menu.ftl"/>
    <div class="content-wrapper">
        <section class="content-header">
            <h1>Customer Management</h1>
        </section>
        <section class="content">
            <div class="box">
                <!--高级查询--->
                <form class="form-inline" id="searchForm" action="/customer/list.do" method="post">
                    <br>
                    <input type="hidden" name="currentPage" id="currentPage" value="1">
                    <div class="form-group">
                        <label for="keyword">keyword:</label>
                        <input type="text" class="form-control" id="keyword" name="keyword" value="${(qo.keyword)!}"
                               placeholder="please enter name/tel">
                    </div>

                    <div class="form-group">
                        <label for="status">status:</label>
                        <select class="form-control" id="status" name="status">
                            <option value="-1">all</option>
                            <option value="0">potential customer</option>
                            <option value="1">formal customer</option>
                            <option value="2">customer pool</option>
                            <option value="3">failed customer</option>
                            <option value="4">loss customer</option>
                        </select>
                        <script>
                            $("#status option[value='${(qo.status)!}']").prop("selected", true);
                        </script>
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


                    <button id="btn_query" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span> 查询
                    </button>

                </form>

                <!--编写内容-->
                <div class="box-body table-responsive no-padding ">
                    <table class="table table-hover table-bordered">
                        <tr>
                            <th>no</th>
                            <th>name</th>
                            <th>gender</th>
                            <th>age</th>
                            <th>tel</th>
                            <th>qq</th>
                            <th>job</th>
                            <th>source</th>
                            <th>seller</th>
                            <th>status</th>
                        </tr>
                        <#list pageInfo.list as entity>
                            <tr>
                                <td>${entity_index +1}</td>
                                <td>${(entity.name)!}</td>
                                <td>${(entity.gender)!}</td>
                                <td>${(entity.age)!}</td>
                                <td>${(entity.tel)!}</td>
                                <td>${(entity.qq)!}</td>
                                <td>${(entity.job.title)!}</td>
                                <td>${(entity.source.title)!}</td>
                                <td>${(entity.seller.name)!}</td>
                                <td>${(entity.statusName)!}</td>

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
