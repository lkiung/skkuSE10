<%@ Page Title="" Language="C#" MasterPageFile="~/has.Master" AutoEventWireup="true" CodeBehind="alerts.aspx.cs" Inherits="HomeworkAlertSystem.alerts" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table class="repeater">
        <tr class="titledisplay">
            <td class="rcoltitle">ID</td>
            <td class="rcoltitle">Class Number</td>
        </tr>
        <tr>
            <td class="rcolvalue"><asp:Label ID="labelClassId" runat="server"></asp:Label>&nbsp;</td>              
            <td class="rcolvalue"><asp:Label ID="labelClassnumber" runat="server"></asp:Label>&nbsp;</td>
        </tr>
    </table>
    <br />
    <br />
    <br />
    <div class="rtitle">Alerts</div>
    <br />
    <br />
    <asp:Repeater ID="RepeaterAlerts" runat="server" DataSourceID="SqlDataSourceRepeaterAlerts" OnItemDataBound="repeaterAlerts_ItemDataBound">
        <HeaderTemplate>
        <table class="repeater">
            <tr class="titledisplay">
                <td class="rcoltitle">ID</td>
                <td class="rcoltitle">Subject</td>
                <td class="rcoltitle">Message</td>
                <td class="rcoltitle">Added</td>
                <td class="rcoltitle">Alert Sent</td>
                <td class="rcoltitle">&nbsp;</td>
            </tr>
        </HeaderTemplate>
        <ItemTemplate>
             <tr>
                <td class="rcolvalue"><%# DataBinder.Eval(Container.DataItem, "id") %>&nbsp;</td>              
                <td class="rcolvalue"><%# DataBinder.Eval(Container.DataItem, "subject") %>&nbsp;</td>
                <td class="rcolvalue"><%# DataBinder.Eval(Container.DataItem, "message") %>&nbsp;</td>
                <td class="rcolvalue"><%# DataBinder.Eval(Container.DataItem, "added") %>&nbsp;</td>
                <td class="rcolvalue sent"><asp:Label ID="LabelAlertSent" runat="server" Text='<%# Eval("alertsent") %>'></asp:Label></td>
                <td class="rcolvalue">
                    <asp:LinkButton ID="LinkButtonSendAlert" runat="server" OnClick="LinkButtonSendAlert_Click" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "id") %>'>
                        <img src="img/send.png" class="send" title="Send Alert" />
                    </asp:LinkButton>
                    <asp:LinkButton ID="LinkButtonEditAlert" runat="server" OnClick="LinkButtonEditAlert_Click" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "id") %>'>
                        <img src="img/edit.png" class="edit" title="Edit Alert" />
                    </asp:LinkButton>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            <tr>
                <td colspan="6" class="cali">
                    <asp:Label ID="labelNoData" runat="server" Text="<br />No alerts for this class found.<br />" Visible="false"></asp:Label>
                </td>
            </tr>
            <tr class="rali">
                <td colspan="6"><asp:LinkButton ID="LinkButtonNewAlert" runat="server" OnClick="LinkButtonNewAlert_Click"><img src="img/create.png" class="new" /></asp:LinkButton></td>
            </tr>
        </table>
        </FooterTemplate>
    </asp:Repeater>
    <asp:SqlDataSource ID="SqlDataSourceRepeaterAlerts" runat="server" ConnectionString="<%$ ConnectionStrings:hasConnectionString %>" SelectCommand="SELECT id, classid, profid, subject, message, added, alertsent, resent FROM alert WHERE (classid = @cid) AND (profid = @pid)">
    </asp:SqlDataSource>
</asp:Content>
