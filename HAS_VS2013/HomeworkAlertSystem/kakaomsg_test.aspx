<%@ Page Title="" Language="C#" MasterPageFile="~/has.Master" AutoEventWireup="true" CodeBehind="kakaomsg_test.aspx.cs" Inherits="HomeworkAlertSystem.kakaomsg_test" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width"/>
    <title>KakaoLink Demo(Web Button) - Kakao JavaScript SDK</title>
    <script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
    <style type='text/css'>
      /* <![CDATA[ */
        #file-input-wrapper {
    	    display : none ;
    	    margin-top : 50px ;
        }
      /* ]]> */
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<h3>카카오톡 링크는 카카오톡 앱이 설치되어 있는 모바일 기기에서만 전송 가능합니다.</h3>
<a id="kakao-link-btn" href="javascript:sendLink()">
<img src="http://dn.api1.kage.kakao.co.kr/14/dn/btqa9B90G1b/GESkkYjKCwJdYOkLvIBKZ0/o.jpg"/>
</a>
<script type='text/javascript'>
    //<![CDATA[
    // Set JavaScript Key of current app.
    Kakao.init('ea4ddb987bbe43ec1dfe93714903f68c');
    function sendLink() {
        Kakao.Link.sendTalkLink({
            label: '안녕하세요, 꽃다운 ' + Math.floor(Math.random() * (70) + 15) + '살 개발자입니다.'
        });
    }
    //]]>
</script>
</asp:Content>
