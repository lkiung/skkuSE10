<%@ Page Title="" Language="C#" MasterPageFile="~/has.Master" AutoEventWireup="true" CodeBehind="class.aspx.cs" Inherits="HomeworkAlertSystem._class" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:Repeater ID="RepeaterClasses" runat="server" DataSourceID="SqlDataSourceRepeaterClasses">
        <HeaderTemplate>
        <table class="repeater">
            <tr class="nohl">
                <td class="rcoltitle">ID</td>
                <td class="rcoltitle"><asp:LinkButton ID="LinkButtonSortClassnumber" CssClass="sort" runat="server" OnClick="LinkButtonSortClassnumber_Click">Class Number</asp:LinkButton></td>
                <td class="rcoltitle">&nbsp;</td>
            </tr>
        </HeaderTemplate>
        <ItemTemplate>
             <tr class="<%# this.GetSelectedClass(Eval("id").ToString()) %>">
                <td class="rcolvalue"><%# DataBinder.Eval(Container.DataItem, "id") %>&nbsp;</td>              
                <td class="rcolvalue"><%# DataBinder.Eval(Container.DataItem, "classnumber") %>&nbsp;</td>
                <td class="rcolvalue">
                    <asp:LinkButton ID="LinkButtonDeleteClass1" runat="server" OnClick="LinkButtonDeleteClass_Click" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "id") %>'>
                        <img src="img/delete.png" class="delete" title="Delete Class" />
                    </asp:LinkButton>
                    &nbsp;
                    <asp:LinkButton ID="LinkButtonEditClass1" runat="server" OnClick="LinkButtonEditClass_Click" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "id") %>'>
                        <img src="img/edit.png" class="edit" title="Edit Class" />
                    </asp:LinkButton>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
        <tr class="rali">
            <td colspan="3"><asp:LinkButton ID="LinkButtonNewClass" runat="server" OnClick="LinkButtonNewClass_Click"><img src="img/create.png" class="new" /></asp:LinkButton></td>
        </tr>
        </table>
        </FooterTemplate>
    </asp:Repeater>
    <asp:SqlDataSource ID="SqlDataSourceRepeaterClasses" runat="server" ConnectionString="<%$ ConnectionStrings:hasConnectionString %>" SelectCommand="SELECT class.id, class.classnumber FROM professor INNER JOIN professorhasclasses ON professor.id = professorhasclasses.profid INNER JOIN class ON professorhasclasses.classid = class.id WHERE (professor.id = @id)"></asp:SqlDataSource>
    <br />
    <br />
    <asp:FormView ID="FormViewClass" runat="server" DataKeyNames="id" DataSourceID="SqlDataSourceClass" OnItemInserted="formViewClass_ItemInserted" OnItemUpdated="formViewClass_ItemUpdated">
        <EditItemTemplate>
            <table class="fw">
                <tr class="fwtitle"><td colspan="2">Edit</td></tr>
                <tr>
                    <td class="fwrowtitle">id:</td>
                    <td class="fwrowitem"><asp:Label ID="idLabel1" runat="server" Text='<%# Eval("id") %>' /></td>
                </tr>
                <tr>
                    <td class="fwrowtitle">classnumber:</td>
                    <td><asp:TextBox ID="classnumberTextBox" runat="server" Text='<%# Bind("classnumber") %>' /></td>
                </tr>
                <tr>
                    <td colspan="2" class="rali">
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />&nbsp;
                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table class="fw">
                <tr class="fwtitle"><td colspan="2">Add</td></tr>
                <tr>
                    <td class="fwrowtitle">classnumber:</td>
                    <td class="fwrowitem"><asp:TextBox ID="classnumberTextBox" runat="server" Text='<%# Bind("classnumber") %>' /></td>
                </tr>
                <tr>
                    <td colspan="2" class="rali">
                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />&nbsp;
                        <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
        <ItemTemplate>
            <table class="fw">
                <tr class="fwtitle"><td colspan="2">View</td></tr>
                <tr>
                    <td class="fwrowtitle">id:</td>
                    <td class="fwrowitem"><asp:Label ID="idLabel1" runat="server" Text='<%# Eval("id") %>' /></td>
                </tr>
                <tr>
                    <td class="fwrowtitle">classnumber:</td>
                    <td class="fwrowitem"><asp:Label ID="classnumberLabel" runat="server" Text='<%# Bind("classnumber") %>' /></td>
                </tr>
            </table>
        </ItemTemplate>
    </asp:FormView>
    
    <asp:SqlDataSource ID="SqlDataSourceClass" runat="server" ConnectionString="<%$ ConnectionStrings:hasConnectionString %>" DeleteCommand="DELETE FROM class WHERE (id = @cid)" InsertCommand="INSERT INTO class(classnumber) VALUES (@classnumber)" SelectCommand="SELECT id, classnumber FROM class WHERE (id = @cid)" UpdateCommand="UPDATE class SET classnumber = @classnumber WHERE (id = @cid)">
        <DeleteParameters>
            <asp:Parameter Name="cid" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="classnumber" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="classnumber" />
        </UpdateParameters>
    </asp:SqlDataSource>
    
</asp:Content>
