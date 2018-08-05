<@table.table   width="100%" id="listTable" sortable="true">
	<@table.thead>
      <@table.selectAllTd id="studyProductId"/>
      <@table.sortTd  name="attr.stdNo" id="studyProduct.student.code"/>
      <@table.sortTd  name="attr.personName" id="studyProduct.student.name"/>
      <@table.sortTd  text="项目名称" id="studyProduct.name"/>
      <@table.sortTd  text="立项单位" id="studyProduct.company"/>
      <@table.sortTd  text="项目类别" id="studyProduct.projectType.name"/>
      <@table.sortTd  text="是否通过审核" id="studyProduct.isPassCheck"/>
      <@table.td text="是否获奖"/>
    </@>
    <@table.tbody datas=studyProducts;studyProduct>
      <@table.selectTd id="studyProductId" value=studyProduct.id/>
        <td>${studyProduct.student.code}</td>
  		<td><A href="#" onclick="info(${studyProduct.id})"><@i18nName (studyProduct.student)?if_exists/></A></td>
  		<td>${studyProduct.name?if_exists}</td>
  		<td>${studyProduct.company?if_exists}</td>
  		<td>${studyProduct.projectType?if_exists.name?if_exists}</td>
  		<td>${studyProduct.isPassCheck?string("通过审核", "未通过")}</td>
  		<td>${studyProduct.isAwarded?string("是","否")}</td>
      </@>
    </@>