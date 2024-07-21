using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProjectABCD
{
    public partial class JqueryWithDatatable : System.Web.UI.Page
    {
        static SqlConnection con = new SqlConnection("data source=DESKTOP-CJ73HQ6;initial catalog=db_07072024;Integrated Security=true");
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static void Save(string Name, int Age, string City)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SP_Insert", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Name", Name);
                cmd.Parameters.AddWithValue("@Age", Age);
                cmd.Parameters.AddWithValue("@City", City);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                // Handle exception as per your application's error handling strategy
                throw ex;
            }
            finally
            {
                con.Close();
            }
        }

        [WebMethod]
        public static void Update(int Id, string Name, int Age, string City)
        {
            try
            {
                con.Open();
                SqlCommand cmd = new SqlCommand("SP_Update", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Id", Id);
                cmd.Parameters.AddWithValue("@Name", Name);
                cmd.Parameters.AddWithValue("@Age", Age);
                cmd.Parameters.AddWithValue("@City", City);
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                // Handle exception as per your application's error handling strategy
                throw ex;
            }
            finally
            {
                con.Close();
            }
        }

        [WebMethod]
        public static DataTable GetDataTableData()
        {
            DataTable dt = new DataTable();
            try
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT Id, Name, Age, City FROM jqInsert", con);
                da.Fill(dt);
            }
            catch (Exception ex)
            {
                // Handle exception as per your application's error handling strategy
                throw ex;
            }
            finally
            {
                con.Close();
            }
            return dt;
            //string json = DataTableToJSON(dt);
            //return json;
        }

        //private static string DataTableToJSON(DataTable dt)
        //{
        //    string JSONString = string.Empty;
        //    JSONString = Newtonsoft.Json.JsonConvert.SerializeObject(dt);
        //    return JSONString;
        //}
    }
}
