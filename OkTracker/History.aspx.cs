using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using MigraDoc.DocumentObjectModel.Tables;
using PdfSharp;
using MigraDoc.Rendering;
using MigraDoc.DocumentObjectModel;
using MySql.Data.MySqlClient;

public partial class History : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void HistoryToPdf(object sender, EventArgs e)
    {
        var history = historyRepeater.DataSource;
        var source = oktracker.DataItemContainer;
        Document document = CreateDocument();
        var renderer = new PdfDocumentRenderer(true, PdfSharp.Pdf.PdfFontEmbedding.Always) {Document = document};
        renderer.RenderDocument();
        string filename = "HistoryReport_" + (int)HttpContext.Current.Session["uid"] + ".pdf";
        renderer.PdfDocument.Save( ConfigurationManager.AppSettings["WorkDir"] + filename);
        Response.Redirect("~/FileHandler.ashx?type=pdf&file="+filename);
    }

    public static Document CreateDocument()
    {
        // Create a new MigraDoc document
        var document = new Document
                           {
                               Info =
                                   {
                                       Title = "Hello, MigraDoc",
                                       Subject = "Demonstrates an excerpt of the capabilities of MigraDoc.",
                                       Author = "Stefan Lange"
                                   }
                           };

        DefineStyles(document);
        DefineCover(document);
        DefineTables(document);
        return document;
    }

    private static void DefineStyles(Document document)
    {
        // Get the predefined style Normal.
        var style = document.Styles["Normal"];
        // Because all styles are derived from Normal, the next line changes the
        // font of the whole document. Or, more exactly, it changes the font of
        // all styles and paragraphs that do not redefine the font.
        style.Font.Name = "Times New Roman";
        // Heading1 to Heading9 are predefined styles with an outline level. An outline level
        // other than OutlineLevel.BodyText automatically creates the outline (or bookmarks)
        // in PDF.
        style = document.Styles["Heading1"];
        style.Font.Name = "Tahoma";
        style.Font.Size = 14;
        style.Font.Bold = true;
        style.Font.Color = Colors.DarkBlue;
        style.ParagraphFormat.PageBreakBefore = true;
        style.ParagraphFormat.SpaceAfter = 6;

        style = document.Styles["Heading2"];
        style.Font.Size = 12;
        style.Font.Bold = true;
        style.ParagraphFormat.PageBreakBefore = false;
        style.ParagraphFormat.SpaceBefore = 6;
        style.ParagraphFormat.SpaceAfter = 6;

        style = document.Styles["Heading3"];
        style.Font.Size = 10;
        style.Font.Bold = true;
        style.Font.Italic = true;
        style.ParagraphFormat.SpaceBefore = 6;
        style.ParagraphFormat.SpaceAfter = 3;

        style = document.Styles[StyleNames.Header];
        style.ParagraphFormat.AddTabStop("16cm", TabAlignment.Right);
        style = document.Styles[StyleNames.Footer];
        style.ParagraphFormat.AddTabStop("8cm", TabAlignment.Center);

        // Create a new style called TextBox based on style Normal
        style = document.Styles.AddStyle("TextBox", "Normal");
        style.ParagraphFormat.Alignment = ParagraphAlignment.Justify;
        style.ParagraphFormat.Borders.Width = 2.5;
        style.ParagraphFormat.Borders.Distance = "3pt";
        style.ParagraphFormat.Shading.Color = Colors.SkyBlue;

        // Create a new style called TOC based on style Normal
        style = document.Styles.AddStyle("TOC", "Normal");
        style.ParagraphFormat.AddTabStop("16cm", TabAlignment.Right, TabLeader.Dots);
    }
    private static void DefineCover(Document document)
    {
        Section section = document.AddSection();

        Paragraph paragraph = section.AddParagraph();
        paragraph.Format.SpaceAfter = "3cm";

        //Image image = section.AddImage("../../images/Logo landscape.png");
        //image.Width = "10cm";

        paragraph = section.AddParagraph("Report of downloaded history");
        paragraph.Format.Font.Size = 16;
        paragraph.Format.Font.Color = Colors.DarkRed;
        paragraph.Format.SpaceBefore = "8cm";
        paragraph.Format.SpaceAfter = "3cm";

        paragraph = section.AddParagraph("Rendering date: ");
        paragraph.AddDateField();
    }

    public static void DefineTables(Document document)
    {
        Paragraph paragraph = document.LastSection.AddParagraph("Download History", "Heading1");
        paragraph.AddBookmark("Tables");

        DemonstrateSimpleTable(document);
        //DemonstrateAlignment(document);
        //DemonstrateCellMerge(document);
    }

    public static void DemonstrateSimpleTable(Document document)
    {
        var table = new Table();
        table.Borders.Width = 0.25;
        
        Column column = table.AddColumn(Unit.FromCentimeter(2));
        column.Format.Alignment = ParagraphAlignment.Center;

        table.AddColumn(Unit.FromCentimeter(2));
        table.AddColumn(Unit.FromCentimeter(4)); 
        table.AddColumn(Unit.FromCentimeter(4)); 
        table.AddColumn(Unit.FromCentimeter(2));
        table.AddColumn(Unit.FromCentimeter(2));
        table.AddColumn(Unit.FromCentimeter(2));

        Row row = table.AddRow();
        row.Shading.Color = Colors.PaleGoldenrod;
        Cell cell = row.Cells[0];
        cell.AddParagraph("Status");
        cell = row.Cells[1];
        cell.AddParagraph("Category");
        cell = row.Cells[2];
        cell.AddParagraph("Title");
        cell = row.Cells[3];
        cell.AddParagraph("Description");
        cell = row.Cells[4];
        cell.AddParagraph("Creator Name");
        cell = row.Cells[5];
        cell.AddParagraph("Size");
        cell = row.Cells[6];
        cell.AddParagraph("Download Date");
        var rowCount = 0;
        try
        {
            using (var conn = new MySqlConnection(ConfigurationManager.ConnectionStrings["oktrackerConnectionString"].ConnectionString))
            {
                conn.Open();
                var command = conn.CreateCommand();
                command.CommandType = CommandType.StoredProcedure;
                command.CommandText = "history_of_user";
                command.Parameters.Add(new MySqlParameter("p_user_id", MySqlDbType.Int32));
                command.Parameters["p_user_id"].Value = (int) HttpContext.Current.Session["uid"];
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        row = table.AddRow();
                        cell = row.Cells[0];
                        cell.AddParagraph(reader.GetString("status_name"));
                        cell = row.Cells[1];
                        cell.AddParagraph(reader.GetString("category_name"));
                        cell = row.Cells[2];
                        cell.AddParagraph(reader.GetString("release_title"));
                        cell = row.Cells[3];
                        cell.AddParagraph(reader.GetString("release_description"));
                        cell = row.Cells[4];
                        cell.AddParagraph(reader.GetString("user_name"));
                        cell = row.Cells[5];
                        cell.AddParagraph(reader.GetInt64("size").ToString());
                        cell = row.Cells[6];
                        cell.AddParagraph(reader.GetDateTime("download_date").ToString());
                        rowCount++;
                    }
                }
                conn.Close();
            }
        }
        catch (Exception exception)
        {
        }
        table.SetEdge(0, 0, 7, rowCount, Edge.Box, BorderStyle.Single, 1.5, Colors.Black);

        document.LastSection.Add(table);
    }
}