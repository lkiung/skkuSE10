<%@ Page Title="" Language="C#" MasterPageFile="~/has.Master" AutoEventWireup="true" CodeBehind="kakao_test.aspx.cs" Inherits="HomeworkAlertSystem.kakao_test" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
    <title>API Demo - Kakao JavaScript SDK</title>
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<a id="kakao-login-btn"></a>
<a href="http://alpha-developers.kakao.com/logout">로그아웃</a>
<script type='text/javascript'>
  //<![CDATA[
    // Set JavaScript Key of current app.
    Kakao.init('ea4ddb987bbe43ec1dfe93714903f68c');
    // Create Kakao Login button.
    Kakao.Auth.createLoginButton({
      container: '#kakao-login-btn',
      success: function(authObj) {
        // If login succeeds, call API.
        Kakao.API.request({
          url: '/v1/user/me',
          success: function(res) {
            alert(JSON.stringify(res));
          },
          fail: function(error) {
            alert(JSON.stringify(error));
          }
        });
      },
      fail: function(err) {
        alert(JSON.stringify(err));
      }
    });
  //]]>
</script>
</asp:Content>
