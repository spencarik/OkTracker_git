<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Admin.aspx.cs" Inherits="App_Admin_Admin" MasterPageFile="../Site.master" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    Edit data on your PC and upload it into database<br/>
    <asp:FileUpload ID="dataFileUpload" runat="server" />
    <asp:Button ID="uploadData" runat="server" Text="Import data" OnClick="importData_Click" /><br/>
    Store data on your PC and edit it<br/>
    <asp:Button ID="downloadData" runat="server" Text="Export data" OnClick="exportData_Click" /><br/>
</asp:Content>
