<#include "/templates/head.ftl"/>
<BODY LEFTMARGIN="0" TOPMARGIN="0">
 <table id="gradeBar" width="100%"></table>
 <form name="courseGradeForm" method="post" action="courseGradeDuplicate.do?method=save" onsubmit="return false;">
 <input type="hidden" name="params" value="&taskId=${courseGrade.task.id}"/>
 <input type="hidden" name="courseGrade.id" value="${courseGrade.id}"/>
 <#include "../stdGradeFormTable.ftl"/>
 </form>
 
 <table id="gradeAlterInfoBar" width="100%"></table>
 <#include "../courseGradeAlterInfo.ftl"/>
 </body>
 <script>
    var bar = new ToolBar("gradeBar","学生单科成绩信息",null,true,true);
    bar.addItem("<@msg.message key="action.save"/>","save()","save.gif");
    bar.addBackOrClose("<@msg.message key="action.back"/>", "<@msg.message key="action.close"/>");
    
    bar = new ToolBar("gradeAlterInfoBar","成绩修改信息",null,true,true);
    function save(){
       if(confirm("是否提交修改的成绩?"))
          courseGradeForm.submit();
    }
 </script>
<#include "/templates/foot.ftl"/>
