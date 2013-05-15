<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NewRelease.aspx.cs" Inherits="NewRelease" MasterPageFile="Site.master" Title="New release"%>

<asp:Content runat="server" ContentPlaceHolderID="FeaturedContent">
    
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <table>
        <tbody>
            <tr>
                <td>
                    <asp:Label ID="Label1" runat="server">Title: </asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="titleTextBox" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label2" runat="server">Description: </asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="descriptionTextBox" runat="server"></asp:TextBox>   
                </td>
            </tr>
                <tr>
                <td>
                    <asp:Label ID="Label4" runat="server">Size(bytes) : </asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="sizeTextBox" runat="server"></asp:TextBox>  
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label3" runat="server">Torrent File: </asp:Label>
                </td>
                <td>
                    <asp:FileUpload ID="fileUpload" runat="server" />
                <td/>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Button ID="okButton" runat="server" Text="Ok" OnClick="OkButton_Click"/>
                </td>
            </tr>
        </tbody>
    </table>
    
</asp:Content>
