<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="HomeworkAlertSystem.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>성균관대학교 - SKKU - Homework Alert System (HAS)</title>
    <link rel="stylesheet" type="text/css" href="/css/has.css" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="cbox">
        <div class="lbox">
            <p>
                <asp:Label ID="LabelId" runat="server" Text="Login / 아이디"></asp:Label>
                <asp:TextBox ID="TextBoxId" runat="server" CssClass="frali" Width="250"></asp:TextBox>
            </p>
            <p>
                <asp:Label ID="LabelPw" runat="server" Text="Password / 비밀번호 입력"></asp:Label>
                <asp:TextBox ID="TextBoxPw" runat="server" CssClass="frali" Width="250" TextMode="Password"></asp:TextBox>
            </p>
            <p>
                <asp:Button ID="ButtonLogin" runat="server" Text="Login / 로그인" CssClass="frali" OnClick="ButtonLogin_Click" />
            </p>
        </div>
    </div>
    </form>
</body>
</html>
