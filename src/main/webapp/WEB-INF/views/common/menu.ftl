<aside class="main-sidebar">
    <section class="sidebar">
        <!-- search form -->
        <form action="#" method="get" class="sidebar-form">
            <div class="input-group">
                <input type="text" name="q" class="form-control" placeholder="Search...">
                <span class="input-group-btn">
                <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
                </button>
              </span>
            </div>
        </form>
        <ul class="sidebar-menu" data-widget="tree">
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-dashboard"></i> <span>System Management</span>
                    <span class="pull-right-container">
                        <i class="fa fa-angle-left pull-right"></i>
                    </span>
                </a>
                <ul class="treeview-menu">
                    <li name="department"><a href="/department/list.do"><i class="fa fa-circle-o"></i> Department Management</a></li>
                    <li name="employee"><a href="/employee/list.do"><i class="fa fa-circle-o"></i> Employee Management</a></li>
                    <li name="permission"><a href="/permission/list.do"><i class="fa fa-circle-o"></i> Permission Management</a></li>
                    <li name="role"><a href="/role/list.do"><i class="fa fa-circle-o"></i> Role Management</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-files-o"></i>
                    <span>Data Management</span>
                    <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li name="systemDictionary"><a href="/systemDictionary/list.do"><i class="fa fa-circle-o"></i> System Dictionary</a>
                    </li>
                    <li name="systemDictionaryItem"><a href="/systemDictionaryItem/list.do"><i
                            class="fa fa-circle-o"></i> Dictionary Item</a></li>
                </ul>
            </li>

            <li class="treeview">
                <a href="#">
                    <i class="fa fa-pie-chart"></i>
                    <span>Customer Management</span>
                    <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">
                    <li name="customer"><a href="/customer/list.do"><i class="fa fa-circle-o"></i> Customer List</a></li>
                    <li name="customer_potential"><a href="/customer/potentialList.do"><i class="fa fa-circle-o"></i>
                        Potential List</a></li>
                    <li name="customer_pool"><a href="/customer/poolList.do"><i class="fa fa-circle-o"></i> Customer Pool</a></li>
                    <li name="customer_failed"><a href="/customer/failedList.do"><i class="fa fa-circle-o"></i> Failed Customer</a></li>
                    <li name="customer_formal"><a href="/customer/formalList.do"><i class="fa fa-circle-o"></i> Formal Customer</a></li>
                    <li name="customer_loss"><a href="/customer/lossList.do"><i class="fa fa-circle-o"></i> Loss Customer</a></li>
                </ul>
            </li>
            <li class="treeview">
                <a href="#">
                    <i class="fa fa-edit"></i>
                    <span>Customer History</span>
                    <span class="pull-right-container">
              <i class="fa fa-angle-left pull-right"></i>
            </span>
                </a>
                <ul class="treeview-menu">

                    <li name="customerTraceHistory"><a href="/customerTraceHistory/list.do"><i
                            class="fa fa-circle-o"></i> Trace History</a></li>
                    <li name="customerTransfer"><a href="/customerTransfer/list.do"><i class="fa fa-circle-o"></i> Transfer History</a>
                    </li>
                </ul>
            </li>


        </ul>
    </section>
</aside>

<script>
    $(function () {
        //菜单初始
        $('.sidebar-menu').tree();
        //菜单激活
        var cuLi = $(".treeview-menu li[name='${currentMenu!}']");
        cuLi.addClass("active");
        cuLi.closest(".treeview").addClass("active")
    })
</script>