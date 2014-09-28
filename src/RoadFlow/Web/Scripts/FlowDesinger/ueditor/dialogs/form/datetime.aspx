﻿<%@ Page Language="C#" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script type="text/javascript" src="../internal.js"></script>
    <script type="text/javascript" src="../common.js"></script>
    <%=WebMvc.Common.Tools.IncludeFiles %>
</head>
<body>
<% 
    WebMvc.Common.Tools.CheckLogin();
    Business.Platform.WorkFlowForm workFlowFrom = new Business.Platform.WorkFlowForm(); 
%>
<br />
<table cellpadding="0" cellspacing="1" border="0" width="95%" class="formtable">
    <tr>
        <th style="width:80px;">绑定字段：</th>
        <td><select class="myselect" id="bindfiled" style="width:227px"></select></td>
    </tr>
    <tr>
        <th>默认值：</th>
        <td><select class="myselect" id="defaultvalue" style="width:227px"><%=workFlowFrom.GetDefaultValueSelect("") %></select> </td>
    </tr>
    <tr>
        <th>宽度：</th>
        <td><input type="text" id="width" class="mytext" style="width:150px" /></td>
    </tr>
    <tr>
        <th>选择范围：</th>
        <td>
            <input type="text" id="min" class="mycalendar" style="width:100px;" />
            &nbsp;至&nbsp;<input type="text" id="max" class="mycalendar" style="width:100px;" />
        </td>
    </tr>
    <tr>
        <th>是否选时间：</th>
        <td><input type="checkbox" id="istime" value="1" style="vertical-align:middle;" /><label for="istime" style="vertical-align:middle;">是否允许选择时间</label></td>
    </tr>
</table>
<script type="text/javascript">
    var text = getElement(editor, "flow_datetime", "formdatetimeDialog");
    var attJSON = parent.formattributeJSON;
    var textid = text ? text.id : "";
    $(function ()
    {
        biddingFileds(attJSON, textid, $("#bindfiled"));
        if (text)
        {
            $text = $(text);
            $("#defaultvalue").val($text.attr('defaultvalue'));
            if ($text.attr('width1')) $("#width").val($text.attr('width1'));
            $("#min").val($text.attr('mindate'));
            $("#max").val($text.attr('maxdate'));
            $("#istime").prop('checked', "1" == $text.attr('istime'));
        }
    });
    dialog.onok = function ()
    {
        var bindfiled = $("#bindfiled").val();
        var defaultvalue = $("#defaultvalue").val();
        var id = attJSON.dbconn && attJSON.dbtable && bindfiled ? attJSON.dbtable + '.' + bindfiled : "";
        var width = $("#width").val();
        var istime = $("#istime").prop('checked') ? "1" : "0";
        var min = $("#min").val();
        var max = $("#max").val();
        
        var html = '<input ondblclick="if(editor.ui._dialogs.formdatetimeDialog.iframeUrl.indexOf(\'?\')==-1){editor.ui._dialogs.formdatetimeDialog.iframeUrl=editor.ui._dialogs.formdatetimeDialog.iframeUrl+\'?edit=1\';}editor.ui._dialogs.formdatetimeDialog.open();" title="双击可设置属性" type="text" type1="flow_datetime" id="' + id + '" name="' + id + '" value="日期时间选择" ';
        if (width)
        {
            html += 'style="width:' + width + '" ';
            html += 'width1="' + width + '" ';
        }
        html += 'defaultvalue="' + defaultvalue + '" ';
        if (parseInt(max) > 0)
        {
            html += 'maxdate="' + max + '" ';
        }
        if (parseInt(min) > 0)
        {
            html += 'mindate="' + min + '" ';
        }
        html += 'istime="' + istime + '" ';

        html += '/>';
        if (text)
        {
            $(text).remove();
        }
        editor.execCommand("formdatetime", html);
        dialog.close();
    }
</script>
</body>
</html>