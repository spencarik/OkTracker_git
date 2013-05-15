<%@ Page Language="C#" AutoEventWireup="true" CodeFile="History.aspx.cs" Inherits="History" MasterPageFile="Site.master" Title="Download History"%>

<asp:Content runat="server" ContentPlaceHolderID="FeaturedContent">
    <asp:LinkButton runat="server" PostBackUrl="#" OnClick="HistoryToPdf" Text="To PDF..."/>
</asp:Content>
<asp:Content runat="server" ContentPlaceHolderID="MainContent">
        
    <table class="history">
            <tbody>
                <tr>
                    <th>Status</th>
                    <th>Category</th>
                    <th>Title</th>
                    <th>User</th>
                    <th>Size</th>
                    <th>Creation Date</th>
                </tr>
                <asp:Repeater ID="historyRepeater" runat="server" DataSourceID="oktracker">
            <ItemTemplate>
               <%-- u.`name` as 'user_name',
		r.status_id,
		r.status_name,
		r.status_description,
		r.category_id,
		r.category_name,
		r.topic_id,
		r.release_title,
		r.release_id,
		r.release_file,
		r.user_name as 'creator_user_name',
		r.user_id,
		r.size,
		r.creation_date--%>
                <tr>
                    <td title="<%#Eval("status_description")%>"><%# Eval("status_name") %></td>
                    <td><%# Eval("category_name") %></td>
                    <td>
                        <asp:HyperLink ID="topicHyperLink" runat="server"
                             NavigateUrl='<%# "~/Topic.aspx?topic=" + Eval("topic_id") %>'>
                            <%# Eval("release_title") %>
                        </asp:HyperLink>
                    </td>
                    <td><%# Eval("user_name") %></td>
                    <td><%# Eval("size") %></td>
                    <td><%# Eval("download_date") %></td>
                </tr>
                <tr>
                    <td colspan="6">
                        <%# Eval("release_description") %>
                    </td>
                </tr>
            </ItemTemplate>
        </asp:Repeater>
    </table>
    <asp:SqlDataSource ID="oktracker" runat="server" ConnectionString="<%$ ConnectionStrings:oktrackerConnectionString %>" ProviderName="<%$ ConnectionStrings:oktrackerConnectionString.ProviderName %>" SelectCommand="history_of_user" SelectCommandType="StoredProcedure">
        <SelectParameters>
            <asp:SessionParameter DefaultValue="0" Name="p_user_id" SessionField="uid" Type="Int32"/>
        </SelectParameters>
    </asp:SqlDataSource>
    
</asp:Content>