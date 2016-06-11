<%@ Page Title="" Language="C#" MasterPageFile="~/has.Master" AutoEventWireup="true" CodeBehind="home.aspx.cs" Inherits="HomeworkAlertSystem.home" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Repeater ID="RepeaterClasses" runat="server" DataSourceID="SqlDataSourceRepeaterClasses" OnItemDataBound="repeaterClasses_ItemDataBound">
        <HeaderTemplate>
        <table class="repeater">
            <tr class="nohl">
                <td class="rcoltitle">ID</td>
                <td class="rcoltitle"><asp:LinkButton ID="LinkButtonSortClassnumber" CssClass="sort" runat="server" OnClick="LinkButtonSortClassnumber_Click">Class Number</asp:LinkButton></td>
                <td class="rcoltitle">&nbsp;</td>
            </tr>
        </HeaderTemplate>
        <ItemTemplate>
             <tr class="hl">
                <td class="rcolvalue"><%# DataBinder.Eval(Container.DataItem, "id") %>&nbsp;</td>              
                <td class="rcolvalue"><%# DataBinder.Eval(Container.DataItem, "classnumber") %>&nbsp;</td>
                <td class="rcolvalue">
                    <asp:LinkButton ID="LinkButtonEditAlerts1" runat="server" OnClick="LinkButtonEditAlerts_Click" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "id") %>'>
                        <img src="img/alert.png" class="edit" title="Edit Alerts" />
                    </asp:LinkButton>
                    &nbsp;
                    <asp:LinkButton ID="LinkButtonEditStudents1" runat="server" OnClick="LinkButtonEditStudents_Click" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "id") %>'>
                        <img src="img/students.png" class="edit" title="Edit Students" />
                    </asp:LinkButton>
                    &nbsp;
                    <asp:LinkButton ID="LinkButtonEditClass1" runat="server" OnClick="LinkButtonEditClass_Click" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "id") %>'>
                        <img src="img/edit.png" class="edit" title="Edit Class" />
                    </asp:LinkButton>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
        <tr>
            <td colspan="3" class="cali">
                <asp:Label ID="labelNoData" runat="server" Text="No classes found. Add some class to proceed." Visible="false"></asp:Label>
            </td>
        </tr>
        <tr class="rali">
            <td colspan="3"><asp:LinkButton ID="LinkButtonNewClass" runat="server" OnClick="LinkButtonNewClass_Click"><img src="img/create.png" class="new" /></asp:LinkButton></td>
        </tr>
        </table>
        </FooterTemplate>
    </asp:Repeater>
    <asp:SqlDataSource ID="SqlDataSourceRepeaterClasses" runat="server" ConnectionString="<%$ ConnectionStrings:hasConnectionString %>" SelectCommand="SELECT class.id, class.classnumber FROM professor INNER JOIN professorhasclasses ON professor.id = professorhasclasses.profid INNER JOIN class ON professorhasclasses.classid = class.id WHERE (professor.id = @id)"></asp:SqlDataSource>
</asp:Content>

