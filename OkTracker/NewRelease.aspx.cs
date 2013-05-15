using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

public partial class NewRelease : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void OkButton_Click(object sender, EventArgs e)
    {
        if (!fileUpload.HasFile)
            return;
        try
        {
            using (var conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["oktrackerConnectionString"].ConnectionString))
            {
                conn.Open();
                var command = conn.CreateCommand();
                command.CommandText = "insert_release";
                command.CommandType = CommandType.StoredProcedure;
                //p_user_id, p_title, p_releasestatus_id, p_description, p_image, p_file, p_size
                command.Parameters.Add(new MySqlParameter("p_user_id", MySqlDbType.Int32));
                command.Parameters["p_user_id"].Value = (int) Membership.GetUser(User.Identity.Name).ProviderUserKey;
                command.Parameters.Add(new MySqlParameter("p_title", MySqlDbType.VarChar));
                command.Parameters["p_title"].Value = titleTextBox.Text;
                command.Parameters.Add(new MySqlParameter("p_releasestatus_id", MySqlDbType.Int32));
                command.Parameters["p_releasestatus_id"].Value = 1;
                command.Parameters.Add(new MySqlParameter("p_description", MySqlDbType.VarChar));
                command.Parameters["p_description"].Value = descriptionTextBox.Text;
                command.Parameters.Add(new MySqlParameter("p_image", MySqlDbType.Blob));
                command.Parameters["p_image"].Value = null;
                command.Parameters.Add(new MySqlParameter("p_file", MySqlDbType.Blob));
                command.Parameters["p_file"].Value = fileUpload.FileBytes;
                command.Parameters.Add(new MySqlParameter("p_size", MySqlDbType.Int64));
                command.Parameters["p_size"].Value = Convert.ToInt64(sizeTextBox.Text);
                command.ExecuteNonQuery();
                conn.Close();
            }
        }
        catch (Exception exception)
        {
            Response.Redirect("~/NewRelease.aspx", true);
            throw;
        }
        Response.Redirect("~/Default.aspx");
    }
}