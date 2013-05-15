<%@ WebHandler Language="C#" Class="FileHandler" %>

using System;
using System.Configuration;
using System.IO;
using System.Web;

public class FileHandler : IHttpHandler {
    
    public void ProcessRequest (HttpContext context)
    {
        var filename = context.Request.QueryString["file"];
        var filetype = context.Request.QueryString["type"];
        var fileName = ConfigurationManager.AppSettings["WorkDir"] + filename;
        FileInfo fi = new FileInfo(fileName);
        byte[] stream = new byte[fi.Length];
        using (var fs = new FileStream(fileName, FileMode.OpenOrCreate, FileAccess.Read))
        {
            fs.Read(stream, 0, (int)fi.Length);
            fs.Close();
        }
        switch (filetype)
        {
            case "torrent":
                context.Response.ContentType = "application/x-bittorrent";
                break;
            case "pdf":
                context.Response.ContentType = "application/pdf";
                break;
            case "csv":
                context.Response.ContentType = "text/csv";
                break;
        }
        context.Response.WriteFile(fileName);
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}