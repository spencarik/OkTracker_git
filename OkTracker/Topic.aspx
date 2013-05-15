<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Topic.aspx.cs" Inherits="Topic" MasterPageFile="Site.master" Title="Topic" %>

<asp:Content runat="server" ContentPlaceHolderID="FeaturedContent">
    
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <div class="release_info">
        <asp:Repeater ID="releaseInfoRepeater" runat="server" DataSourceID="releaseInfoDataSource">
            <ItemTemplate>
                <table class="fullwidth">
                    <tr>
                        <td>Title: </td>
                        <td><%# Eval("release_title")%><br/></td>
                    </tr>
                    <tr>
                        <td>Category: </td>
                        <td><%# Eval("category_name")%></td>
                    </tr>
                    <tr>
                        <td>Released by: </td>
                        <td><%# Eval("user_name")%></td>
                    </tr>
                    <tr>
                        <td>Date: </td>
                        <td><%# Eval("creation_date")%></td>
                    </tr>
                    <tr>
                        <td>Torrent Downloaded: </td>
                        <td><%# Eval("downloaded")%></td>
                    </tr><tr>
                        <td>Size: </td>
                        <td><%# Eval("size")%></td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            Click <asp:HyperLink ID="downloadTorrent" runat="server" NavigateUrl='<%# "~/FileHandler.ashx?type=torrent&file=" + GetFileBytes(Eval("release_id")) %>'>here</asp:HyperLink> to download
                        </td>
                    </tr>
                </table>
                
            </ItemTemplate>
        </asp:Repeater>
    </div>
    <table class="comment-table">
        <tbody>
    <asp:Repeater ID="commentRepeater" runat="server" DataSourceID="commentDataSource">
        <ItemTemplate>
            <tr>
                <td>
                    <span class="username"><%# Eval("user_name") %> </span> wrote: <br/>
                    <span class="commenttext"><%# Eval("text") %></span> <br/>
                    <span class="date"><%# Eval("creationdate") %></span>
                </td>
            </tr>
        </ItemTemplate>
    </asp:Repeater>   
        </tbody>
    </table>
     <asp:SqlDataSource ID="commentDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:oktrackerConnectionString %>" ProviderName="<%$ ConnectionStrings:oktrackerConnectionString.ProviderName %>" SelectCommand="comments_for_topic" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="p_topic_id" QueryStringField="topic" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="releaseInfoDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:oktrackerConnectionString %>" ProviderName="<%$ ConnectionStrings:oktrackerConnectionString.ProviderName %>" SelectCommand="get_release_info" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="0" Name="p_topic_id" QueryStringField="topic" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>
