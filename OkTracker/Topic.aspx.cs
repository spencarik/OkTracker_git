using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Security.AccessControl;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Topic : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected string GetFileBytes(object releaseId)
    {
        var name = "release_" + releaseId + ".torrent";
        var filename = ConfigurationManager.AppSettings["WorkDir"] + name;
        if (File.Exists(filename))
            return name;
        FileInfo fi = new FileInfo("C:\\Users\\Kirill\\Downloads\\[rutracker.org].t4437979.torrent");
        byte[] buffer = new byte[fi.Length];
        using (var fs = new FileStream("C:\\Users\\Kirill\\Downloads\\[rutracker.org].t4437979.torrent", FileMode.Open, FileAccess.ReadWrite))
        {
            fs.Read(buffer, 0, (int)fi.Length);
            fs.Close();
        }
        using (var fs = new FileStream(filename, FileMode.OpenOrCreate, FileAccess.Write))
        {
            fs.Write(buffer, 0, (int)fi.Length);
            fs.Close();
        }
        return name;
    }
}