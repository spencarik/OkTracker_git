<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content runat="server" ID="FeaturedContent" ContentPlaceHolderID="FeaturedContent">
    <section class="featured">
        <div class="content-wrapper">
            OkTracker
        </div>
    </section>
</asp:Content>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    Last 20 here<br/>
    <table class="last20">
        <tbody>
            <tr>
                <th>Status</th>
                <th>Category</th>
                <th>Title</th>
                <th>User</th>
                <th>Size</th>
                <th>Creation Date</th>
            </tr>
            <asp:Repeater ID="last20Repeater" runat="server" DataSourceID="OkTracker">
        <ItemTemplate>
            <tr>
                <td title="<%#Eval("status_description")%>"><%# Eval("status_name") %></td>
                <td><%# Eval("category_name") %></td>
                
               
                <td>
                    <% if(!User.Identity.IsAuthenticated)
                       {%>
                    <%# Eval("release_title") %>
                    <% }
                       else
                       {%>
                    <asp:HyperLink ID="topicHyperLink" runat="server"
                         NavigateUrl='<%# "~/Topic.aspx?topic=" + Eval("topic_id") %>'>
                        <%# Eval("release_title") %>
                    </asp:HyperLink>
                      <% } %>
                </td>

                <td><%# Eval("user_name") %></td>
                <td><%# Eval("size") %></td>
                <td><%# Eval("creation_date") %></td>
            </tr>
        </ItemTemplate>
    </asp:Repeater>
    <asp:SqlDataSource ID="OkTracker" runat="server" ConnectionString="<%$ ConnectionStrings:oktrackerConnectionString %>" ProviderName="<%$ ConnectionStrings:oktrackerConnectionString.ProviderName %>" SelectCommand="SELECT [status_id], [status_name], [status_description], [category_id], [category_name], [topic_id], [release_title], [release_id], [user_name], [user_id], [size], [creation_date] FROM [last20added]"></asp:SqlDataSource>
        </tbody>
    </table>
    
</asp:Content>