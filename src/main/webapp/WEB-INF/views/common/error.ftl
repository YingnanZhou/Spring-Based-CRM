<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Relationship Management</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="/css/error_css.css" rel="stylesheet" type="text/css" />
    <#include "../common/link.ftl">
</head>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
    <#include "../common/navbar.ftl">
    <#include "../common/menu.ftl">
    <div class="content-wrapper">
        <section class="content-header">
            <h1>Error</h1>
        </section>
        <section class="content">
            <div class="box">
                <div style="margin: 10px;">
                    <div class="row col-sm-10" >
                        <div id="login_center">
                            <div id="login_area">
                                <div id="login_box">
                                    <div id="login_form">
                                        <H2>Something went wrong！</H2>
                                        <span>here is an exception：</span>
                                        <span class="error">${ex.message}</span>
                                        <span>please contact admin</span>
                                        <span>email：zyn@gwu.edu</span>
                                        <span>Yingnan</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </section>
    </div>
    <#include "../common/footer.ftl">
</div>
</body>
</html>
