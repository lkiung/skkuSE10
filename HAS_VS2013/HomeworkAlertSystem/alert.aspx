<%@ Page Title="" Language="C#" MasterPageFile="~/has.Master" AutoEventWireup="true" CodeBehind="alert.aspx.cs" Inherits="HomeworkAlertSystem.alert" %>
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
    <asp:Label ID="labelUpdateCancel" runat="server" Text="Editing <b>sent</b> alerts is forbidden! Please create a new alert.<br />" ForeColor="Red" Font-Bold="true" Visible="false"></asp:Label>
    <asp:FormView ID="FormViewAlert" runat="server" DataKeyNames="id" DataSourceID="SqlDataSourceFormViewAlert" OnItemInserting="FormViewAlert_ItemInserting" OnItemInserted="FormViewAlert_ItemInserted" OnItemUpdating="FormViewAlert_ItemUpdating" OnItemUpdated="FormViewAlert_ItemUpdated">
        <EditItemTemplate>
            <table class="fw">
                <tr class="fwtitle"><td colspan="2">Edit Alert</td></tr>
                <tr>
                    <td class="fwrowtitle">id:</td>
                    <td class="fwrowitem"><asp:Label ID="idLabel1" runat="server" Text='<%# Eval("id") %>' /></td>
                </tr>
                <tr>
                    <td class="fwrowtitle">Subject:</td>
                    <td><asp:TextBox ID="subjectTextBox" runat="server" Text='<%# Bind("subject") %>' /></td>
                </tr>
                <tr>
                    <td class="fwrowtitle">Message:</td>
                    <td><asp:TextBox ID="messageTextBox" runat="server" Text='<%# Bind("message") %>' /></td>
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
                <tr class="fwtitle"><td colspan="2">Add Alert</td></tr>
                <tr>
                    <td class="fwrowtitle">Subject:</td>
                    <td class="fwrowitem"><asp:TextBox ID="subjectTextBox" runat="server" Text='<%# Bind("subject") %>' /></td>
                </tr>
                <tr>
                    <td class="fwrowtitle">Message:</td>
                    <td class="fwrowitem"><asp:TextBox ID="messageTextBox" runat="server" Text='<%# Bind("message") %>' /></td>
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
            Item Template Placeholder
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="SqlDataSourceFormViewAlert" runat="server" ConnectionString="<%$ ConnectionStrings:hasConnectionString %>" InsertCommand="INSERT INTO alert(profid, classid, subject, message, added) VALUES (@profid, @classid, @subject, @message, @added)" SelectCommand="SELECT * FROM alert WHERE id=@aid" UpdateCommand="UPDATE alert SET subject = @subject, message = @message WHERE (id = @aid)">
        <InsertParameters>
            <asp:Parameter Name="profid" />
            <asp:Parameter Name="classid" />
            <asp:Parameter Name="subject" />
            <asp:Parameter Name="message" />
            <asp:Parameter Name="added" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="subject" />
            <asp:Parameter Name="message" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>
