<%@ Page Title="" Language="C#" MasterPageFile="~/has.Master" AutoEventWireup="true" CodeBehind="sendalert.aspx.cs" Inherits="HomeworkAlertSystem.sendalert" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <script type="text/javascript">
            function wait(ms)
            {
                setTimeout(reload, ms)
            }

            function reload()
            {
                location.reload();
            }
        </script>
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
    <div class="cali"><asp:ImageButton ID="imageButtonSend" CssClass="alerting" runat="server" ImageUrl="~/img/send.png" OnClick="imageButtonSend_Click" /></div>
    <br />
    <asp:Repeater ID="RepeaterStudents" runat="server">
        <HeaderTemplate>
        <table class="repeater">
            <tr class="nohl">
                <td class="rcoltitle">ID</td>
                <td class="rcoltitle"><asp:LinkButton ID="LinkButtonSortStudentNumber" CssClass="sort" runat="server" OnClick="LinkButtonSortStudentNumber_Click">Student Number</asp:LinkButton></td>
                <td class="rcoltitle"><asp:LinkButton ID="LinkButtonSortStudentName" CssClass="sort" runat="server" OnClick="LinkButtonSortStudentName_Click">Student Name</asp:LinkButton></td>
                <td class="rcoltitle"><asp:LinkButton ID="LinkButtonSortStudentPhone" CssClass="sort" runat="server" OnClick="LinkButtonSortStudentPhone_Click">Student Phone</asp:LinkButton></td>
                <td class="rcoltitle"><asp:LinkButton ID="LinkButtonSortStudentEmail" CssClass="sort" runat="server" OnClick="LinkButtonSortStudentEmail_Click">Student Email</asp:LinkButton></td>
                <td class="rcoltitle cali">Status</td>
            </tr>
        </HeaderTemplate>
        <ItemTemplate>
             <tr class="hl">
                <td class="rcolvalue"><asp:Label ID="LabelStudentId" runat="server" Text='<%# Eval("id") %>'></asp:Label>&nbsp;</td>              
                <td class="rcolvalue"><%# DataBinder.Eval(Container.DataItem, "number") %>&nbsp;</td>
                <td class="rcolvalue"><%# DataBinder.Eval(Container.DataItem, "name") %>&nbsp;</td>
                <td class="rcolvalue"><%# DataBinder.Eval(Container.DataItem, "phone") %>&nbsp;</td>
                <td class="rcolvalue"><%# DataBinder.Eval(Container.DataItem, "email") %>&nbsp;</td>
                <td class="rcolvalue cali"><asp:Image ID="ImageStatus" CssClass="status" runat="server" ImageUrl="~/img/wait.png" />&nbsp;</td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
        </table>
        </FooterTemplate>
    </asp:Repeater>
</asp:Content>
