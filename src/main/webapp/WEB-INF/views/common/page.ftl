<div style="text-align: center;">
    <ul id="pagination" class="pagination"></ul>
</div>
<script>
    //分页
    $(function(){
        $("#pagination").twbsPagination({
            totalPages: ${pageInfo.pages}||1,
                startPage: ${pageInfo.pageNum} || 1,
                visiblePages:5,
                initiateStartPageClick:false,
                onPageClick:function(event,page){
            $("#currentPage").val(page);
            $("#searchForm").submit();
        }
    });
    })
</script>