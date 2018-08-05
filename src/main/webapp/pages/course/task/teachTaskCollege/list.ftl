<#include "/templates/head.ftl"/>
<body >
  <table id="taskBar"></table>
  <script>
     var bar = new ToolBar('taskBar', '院系任务管理列表', null, true, false);
     bar.setMessage('<@getMessage/>');
     bar.addItem('<@msg.message key="course.suggestTime"/>', 'suggestTime()');
     menu = bar.addMenu('<@msg.message key="action.batchEdit"/>', 'batchEdit()');
     menu.addItem('<@msg.message key="task.arrangeInfo"/>', 'batchUpdateArrangeInfo()');
     menu.addItem('<@msg.message key="course.courseCredit"/>', 'batchUpdateCourseSetting()');
     menu.addItem('<@msg.message key="course.choiceRequirement"/>', 'batchUpdateElectInfoSetting()');
     menu.addItem('<@msg.message key="course.courseRequirement"/>', 'batchUpdateRequirement()');
     menu1 = bar.addMenu('<@msg.message key="attr.option"/>',null);
     menu1.addItem('<@bean.message key="action.split"/>','splitTeachTask()');
     menu1.addItem('<@bean.message key="action.merge"/>','mergeTeachTask()');
     menu1.addItem('<@bean.message key="action.export"/>','exportTeachPlanPrompt()');
     menu1.addItem('<@msg.message key="course.exportStdList"/>','exportStdList()');
     menu1.addItem('<@msg.message key="course.defaultExport"/>','exportDefault()');
     menu1.addItem('<@msg.message key="adminClass.planStdsRecount"/>','calcPlanStdCountByAdminClass()',"action.gif","<@msg.message key="teachPlan.recount.explain"/>");
     menu2 = bar.addMenu('<@msg.message key="action.print"/>..',"printAction('printTaskList')",'print.gif');
     menu2.addItem("<@msg.message key="adminClass.rollBook"/>","printAction('printStdListForDuty')",'print.gif');
     menu2.addItem("<@msg.message key="adminClass.stdNamesList"/>","printAction('printStdList')",'print.gif');
     menu2.addItem("<@msg.message key="adminClass.regScoreList"/>","printAction('printStdListForGrade')",'print.gif');
     menu2.addItem("<@msg.message key="teachTask.taskBook"/>","printAction('taskTemplate')",'print.gif');
     bar.addItem('<@bean.message key="action.modify"/>', 'editTeachTask()');
</script>
  <#include "/pages/course/task/teachTaskList.ftl"/>
  <form name="actionForm" method="post" action="" onsubmit="return false;">
     <input type="hidden" name="task.calendar.id" value="${RequestParameters['task.calendar.id']}"/>
     <input type="hidden" name="calendar.id" value="${RequestParameters['task.calendar.id']}"/>
     <input type="hidden" name="params" value=""/>
     <input type="hidden" name="actionName" value="teachTaskCollege.do"/>
  </form>
  <script>
    var form = document.actionForm;
     function batchUpdateArrangeInfo(){
       setSearchParams();
       submitId(form,"taskId",true,"?method=arrangeInfoSetting","是否批量设置选定任务的安排信息?");
     }
	
	function query(pageNo,pageSize,orderBy){
	    var form = document.taskListForm;
	    form.action="?method=search";
	    form.target = "_self";
	    transferParams(parent.document.taskForm,form,null,false);
	    goToPage(form,pageNo,pageSize,orderBy);
	}
    function editTeachTask(){
       id = getSelectIds("taskId");
       if(id=="") {alert("<@bean.message key="prompt.task.selector"/>");return;}
       if(isMultiId(id)) {alert("<@bean.message key="common.singleSelectPlease"/>。");return;}
       if(checkConfirm(id)) {alert("<@bean.message key="error.task.modifyUnderConfirm"/>");return;}
       form.action = "teachTaskCollege.do?method=edit&task.id=" + id;
       setSearchParams();
       form.submit();
    }
     function batchUpdateCourseSetting() {
        var ids = getSelectIds("taskId");
        if (ids == null || ids == "") {
            alert("<@bean.message key="prompt.task.selector"/>");
            return;
        }
        if (confirm("是否要更改课程学分？")) {
	        setSearchParams();
	        form.action="?method=batchUpdateCourseSetting";
	        addInput(form, "taskIds", ids, "hidden");
	        form.submit();
        }
     }
	function batchUpdateElectInfoSetting() {
     	var ids = getSelectIds("taskId");
     	if (ids == null || ids == "") {
     		alert("请选择要操作的课程。");
     		return;
     	}
     	form.action = "?method=batchUpdateElectInfoSetting";
     	form.target = "";
     	addInput(form, "taskIds", ids, "hidden");
     	setSearchParams();
     	form.submit();
    }
	function batchUpdateRequirement() {
     	var ids = getSelectIds("taskId");
     	if (ids == null || ids == "") {
     		alert("请选择要操作的课程。");
     		return;
     	}
     	form.action = "?method=batchUpdateRequirementSetting";
     	addInput(form, "taskIds", ids, "hidden");
     	setSearchParams();
     	form.submit();
    }
    function batchEdit(){
      var ids = getSelectIds("taskId");
      if(ids=="") {alert("<@bean.message key="prompt.task.selector"/>");return;}
      var idArray = ids.split(",");
      for(var i=0;i<idArray.length;i++){
          if(checkConfirm(idArray[i])) {alert("选择的教学任务中包含已经确认的，请选择未确认的任务");return;}
      }
      window.open("?method=batchEdit&taskIds="+ids+"&orderBy="+orderByStr);
    }
	function checkConfirm(id){
	    var elem = document.getElementById(id);
	    return elem.value!=0;
	}
	function setSearchParams(){
	    document.actionForm.params.value = queryStr;
	    form.target = "_self";
	}
    function exportTeachPlanPrompt(){
       setSearchParams();
       form.action="teachTaskCollege.do?method=exportSetting";
       form.submit();
    }
	function checkConfirmIdSeq(idSeq){
	   var idArray = idSeq.split(",");
       for(var i=0;i<idArray.length;i++){
          if(checkConfirm(idArray[i])) {alert("选择的教学任务中包含已经确认的，请选择未确认的任务");return false;}
       }
       return true;
	}
    
    function mergeTeachTask(){
       var ids = getSelectIds("taskId");
       if(!isMultiId(ids)){alert("<@bean.message key="common.MultiSelectPlease"/>");return;}
       var IdS = new String(ids);
       if(!checkConfirmIdSeq(ids)) return;
       addInput(form,"taskIds",ids);
       form.action="teachTaskCollege.do?method=mergeSetting";
       setSearchParams();
       form.submit();
    }
    function suggestTime(){
      var id = getSelectIds("taskId");
      if(id=="") {alert("<@bean.message key="prompt.task.selector" />");return;}
      if(isMultiId(id)) {alert("<@bean.message key="common.singleSelectPlease" />。");return;}
      if(checkConfirm(id)) {alert("<@bean.message key="error.task.modifyUnderConfirm"/>");return;}
      window.open("arrangeSuggest.do?method=edit&task.id="+id,'','resizable=1,scrollbars=auto,width=720,height=480,left=200,top=200,status=no');      
    }
    function splitTeachTask(){
       id = getSelectIds("taskId");
       if(id=="") {alert("<@bean.message key="prompt.task.selector" />");return;}
       if(isMultiId(id)) {alert("<@bean.message key="common.singleSelectPlease" />。");return;}
       if(checkConfirm(id)) {alert("<@bean.message key="error.task.modifyUnderConfirm"/>");return;}
       var count = prompt("<@bean.message key="prompt.task.splitNum"/>","3");
       while(count!=null){
          if(!/^\d+$/.test(count)){
            alert("请输入整数(>2)");
            count = prompt("<@bean.message key="prompt.task.splitNum"/>","3");
          }
          else break;
       }
       if(null==count)return;
       form.action = "teachTaskCollege.do?method=splitSetting&task.id=" + id + "&splitNum=" + count;
       setSearchParams();
       form.submit();
    }
     function printAction(method){
         var Ids = getSelectIds("taskId");
         if(""==Ids){alert("请选择一个或多个教学任务");return;}
         window.open("?teachTaskIds="+Ids+"&method="+method);
     }
     function exportStdList(){
         var Ids = getSelectIds("taskId");
         if(""==Ids){alert("请选择一个或多个教学任务");return;}
         form.action="teachTaskCollege.do?method=exportStdList";
         addInput(form,"teachTaskIds",Ids);
         addInput(form,"attrs","task.seqNo,task.course.code,task.course.name,std.code,std.name,std.enrollYear,std.department.name,firstMajor.name,firstAspect.name,courseTake.courseTakeType.name");
         addInput(form,"attrNames","<@msg.message key="attr.taskNo"/>,<@msg.message key="attr.courseNo"/>,<@msg.message key="attr.courseName"/>,<@msg.message key="attr.stdNo"/>,<@msg.message key="attr.personName"/>,入学年份,<@msg.message key="entity.department"/>,<@msg.message key="entity.speciality"/>,方向,修读类别");
         form.submit();
     }
     
     function exportDefault(){
        if(confirm("是否导出查询出的所有任务?")){
	        form.action="teachTaskCollege.do?method=export"+queryStr;
	        addInput(form,"keys",'seqNo,course.code,course.name,teachClass.name,arrangeInfo.teachers,arrangeInfo.activities,requirement.roomConfigType.name,requirement.teachLangType.name,requirement.isGuaPai,teachClass.planStdCount,teachClass.stdCount,arrangeInfo.weeks,arrangeInfo.weekUnits,,arrangeInfo.courseUnits,arrangeInfo.overallUnits,credit');
	        addInput(form,'titles','课程序号,课程代码,课程名称,面向班级,授课教师,上课时间地点,教室设备配置,<@msg.message key="attr.teachLangType"/>,是否挂牌,计划人数,实际人数,周数,周课时,节次,总课时,学分');
	        form.submit();
        }
     }
	function calcPlanStdCountByAdminClass(){
		setSearchParams();
		submitId(form, "taskId", true, "teachTaskCollege.do?method=calcPlanStdCountByAdminClass", "是否确定根据行政班计划人数计算任务的计划人数?");
	}
  </script>
</body> 
<#include "/templates/foot.ftl"/> 