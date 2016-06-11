<%@ Page Title="" Language="C#" MasterPageFile="~/has.Master" AutoEventWireup="true" CodeBehind="students.aspx.cs" Inherits="HomeworkAlertSystem.students" %>
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
    <asp:Repeater ID="RepeaterStudents" runat="server" DataSourceID="SqlDataSourceRepeaterStudents" OnItemDataBound="repeaterStudents_ItemDataBound">
        <HeaderTemplate>
        <table class="repeater">
            <tr class="nohl">
                <td class="rcoltitle">ID</td>
                <td class="rcoltitle"><asp:LinkButton ID="LinkButtonSortStudentNumber" CssClass="sort" runat="server" OnClick="LinkButtonSortStudentNumber_Click">Student Number</asp:LinkButton></td>
                <td class="rcoltitle"><asp:LinkButton ID="LinkButtonSortStudentName" CssClass="sort" runat="server" OnClick="LinkButtonSortStudentName_Click">Student Name</asp:LinkButton></td>
                <td class="rcoltitle"><asp:LinkButton ID="LinkButtonSortStudentPhone" CssClass="sort" runat="server" OnClick="LinkButtonSortStudentPhone_Click">Student Phone</asp:LinkButton></td>
                <td class="rcoltitle"><asp:LinkButton ID="LinkButtonSortStudentEmail" CssClass="sort" runat="server" OnClick="LinkButtonSortStudentEmail_Click">Student Email</asp:LinkButton></td>
                <td class="rcoltitle">&nbsp;</td>
            </tr>
        </HeaderTemplate>
        <ItemTemplate>
             <tr class="hl">
                <td class="rcolvalue"><%# DataBinder.Eval(Container.DataItem, "id") %>&nbsp;</td>              
                <td class="rcolvalue"><%# DataBinder.Eval(Container.DataItem, "number") %>&nbsp;</td>
                <td class="rcolvalue"><%# DataBinder.Eval(Container.DataItem, "name") %>&nbsp;</td>
                <td class="rcolvalue"><%# DataBinder.Eval(Container.DataItem, "phone") %>&nbsp;</td>
                <td class="rcolvalue"><%# DataBinder.Eval(Container.DataItem, "email") %>&nbsp;</td>
                <td class="rcolvalue">
                    &nbsp;
                    <asp:LinkButton ID="LinkButtonEditStudents1" runat="server" OnClick="LinkButtonEditStudent_Click" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "id") %>'>
                        <img src="img/student.png" class="edit" title="Edit Student" />
                    </asp:LinkButton>
                    &nbsp;
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
        <tr>
            <td colspan="6" class="cali">
                <asp:Label ID="labelNoData" runat="server" Text="<br />No students found. Add some students to proceed.<br />" Visible="false"></asp:Label>
            </td>
        </tr>
        <tr class="rali">
            <td colspan="6"><asp:LinkButton ID="LinkButtonNewStudent" runat="server" OnClick="LinkButtonNewStudent_Click"><img src="img/create.png" class="new" /></asp:LinkButton></td>
        </tr>
        </table>
        </FooterTemplate>
    </asp:Repeater>
    <asp:SqlDataSource ID="SqlDataSourceRepeaterStudents" runat="server" ConnectionString="<%$ ConnectionStrings:hasConnectionString %>" SelectCommand="SELECT student.id, student.number, student.name, student.phone, student.email, classhasstudents.classid FROM student INNER JOIN classhasstudents ON student.id = classhasstudents.studentid INNER JOIN class ON classhasstudents.classid = class.id INNER JOIN professorhasclasses ON class.id = professorhasclasses.classid INNER JOIN professor ON professorhasclasses.profid = professor.id WHERE (class.id = @cid) AND (professor.id = @pid)">
    </asp:SqlDataSource>
    <br />
    <br />
    <asp:FormView ID="FormViewStudents" runat="server" DataKeyNames="id" DataSourceID="SqlDataSourceFormViewStudents" OnItemInserted="formViewStudents_ItemInserted" OnItemUpdated="formViewStudents_ItemUpdated">
        <EditItemTemplate>
            <table class="fw">
                <tr class="fwtitle"><td colspan="2">Edit</td></tr>
                <tr>
                    <td class="fwrowtitle">id:</td>
                    <td class="fwrowitem"><asp:Label ID="idLabel1" runat="server" Text='<%# Eval("id") %>' /></td>
                </tr>
                <tr>
                    <td class="fwrowtitle">Student number:</td>
                    <td><asp:TextBox ID="numberTextBox" runat="server" Text='<%# Bind("number") %>' /></td>
                </tr>
                <tr>
                    <td class="fwrowtitle">Student name:</td>
                    <td><asp:TextBox ID="nameTextBox" runat="server" Text='<%# Bind("name") %>' /></td>
                </tr>
                <tr>
                    <td class="fwrowtitle">Student phone:</td>
                    <td><asp:TextBox ID="phoneTextBox" runat="server" Text='<%# Bind("phone") %>' /></td>
                </tr>
                <tr>
                    <td class="fwrowtitle">Student email:</td>
                    <td><asp:TextBox ID="emailTextBox" runat="server" Text='<%# Bind("email") %>' /></td>
                </tr>
                <tr>
                    <td colspan="2" class="rali">
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                        &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </td>
                </tr>
            </table>
        </EditItemTemplate>
        <InsertItemTemplate>
            <table class="fw">
                <tr class="fwtitle"><td colspan="2">Add</td></tr>
                <tr>
                    <td class="fwrowtitle">Student number:</td>
                    <td><asp:TextBox ID="numberTextBox" runat="server" Text='<%# Bind("number") %>' /></td>
                </tr>
                <tr>
                    <td class="fwrowtitle">Student name:</td>
                    <td><asp:TextBox ID="nameTextBox" runat="server" Text='<%# Bind("name") %>' /></td>
                </tr>
                <tr>
                    <td class="fwrowtitle">Student phone:</td>
                    <td><asp:TextBox ID="phoneTextBox" runat="server" Text='<%# Bind("phone") %>' /></td>
                </tr>
                <tr>
                    <td class="fwrowtitle">Student email:</td>
                    <td><asp:TextBox ID="emailTextBox" runat="server" Text='<%# Bind("email") %>' /></td>
                </tr>
                <tr>
                    <td colspan="2" class="rali">
                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                        &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                    </td>
                </tr>
            </table>
        </InsertItemTemplate>
        <ItemTemplate>
            ItemTemplate placeholder
        </ItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="SqlDataSourceFormViewStudents" runat="server" ConnectionString="<%$ ConnectionStrings:hasConnectionString %>" DeleteCommand="DELETE FROM student WHERE (id = @sid)" InsertCommand="INSERT INTO student(number, name, phone, email) VALUES (@number, @name, @phone, @email)" SelectCommand="SELECT id, number, name, phone, email FROM student WHERE (id = @sid)" UpdateCommand="UPDATE student SET number = @number, name = @name, phone = @phone, email = @email WHERE (id = @sid)">
        <DeleteParameters>
            <asp:Parameter Name="sid" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="number" />
            <asp:Parameter Name="name" />
            <asp:Parameter Name="phone" />
            <asp:Parameter Name="email" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="number" />
            <asp:Parameter Name="name" />
            <asp:Parameter Name="phone" />
            <asp:Parameter Name="email" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <br />
    <br />
    <br />
    <br />
</asp:Content>
