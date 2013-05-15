using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

public partial class App_Admin_Admin : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }

    protected void importData_Click(object sender, EventArgs e)
    {
        if (!dataFileUpload.HasFile)
            return;
        var shortFileName = Guid.NewGuid() + ".csv";
        var filename = ConfigurationManager.AppSettings["WorkDir"] + shortFileName;
        if (File.Exists(filename))
            File.Delete(filename);
        dataFileUpload.SaveAs(filename);
        var fileInfo = new FileInfo(filename);
        try
        {
            using (
                var conn =
                    new MySqlConnection(
                        ConfigurationManager.ConnectionStrings["oktrackerConnectionString"].ConnectionString))
            {
                conn.Open();
                var command = conn.CreateCommand();
                command.CommandText = "LOAD DATA INFILE '" + fileInfo.FullName.Replace('\\', '/') +
                                      "' INTO TABLE `release`" +
                                      " columns TERMINATED BY ',' OPTIONALLY ENCLOSED BY '" + '"' +
                                      "'LINES TERMINATED BY '\n'" +
                                      " (user_id,title,releasestatus_id,description,`size`)";
                command.ExecuteNonQuery();
                conn.Close();
                fileInfo.Delete();
                Response.Redirect("~/Default.aspx", true);
            }
        }
        catch (Exception exception)
        {
        }
    }

    protected void exportData_Click(object sender, EventArgs e)
    {
        var shortFileName = Guid.NewGuid() + ".csv";
        var filename = ConfigurationManager.AppSettings["WorkDir"] + shortFileName;
        var fileInfo = new FileInfo(filename);
        if (fileInfo.Exists)
        {
            fileInfo.Delete();
        }
        try
        {
            using (
                var conn =
                    new MySqlConnection(
                        ConfigurationManager.ConnectionStrings["oktrackerConnectionString"].ConnectionString))
            {
                conn.Open();
                var command = conn.CreateCommand();
                command.CommandText =
                    "select user_id,title,releasestatus_id,description,`size` from `release` into outfile '" + fileInfo.FullName.Replace('\\', '/') +
                    "' columns TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n'";
                command.ExecuteNonQuery();
                conn.Close();
            }
            Response.Redirect("~/FileHandler.ashx?type=cvs&file=" + shortFileName);
        }
        catch (Exception exception)
        {
        }
    }
}