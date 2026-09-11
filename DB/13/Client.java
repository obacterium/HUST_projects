/* 请在适当的位置补充代码，完成指定的任务 
   提示：
      try {


      } catch
    之间补充代码  
*/
import java.sql.*;

public class Client {
    public static void main(String[] args) {
        Connection connection = null;
        Statement statement = null;
        ResultSet resultSet = null;

        try {
 
            // 加载MySQL JDBC驱动
            Class.forName("com.mysql.cj.jdbc.Driver");
            // 建立数据库连接（finance数据库，UTF8编码）
            connection = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/finance?useUnicode=true&characterEncoding=UTF8&useSSL=false&serverTimezone=UTC", 
            "root", "123123"
            );
            // 创建Statement对象执行SQL
            statement = connection.createStatement();
            // 执行查询：筛选邮箱不为空的客户
            resultSet = statement.executeQuery(
                "SELECT c_name,c_mail,c_phone FROM client WHERE c_mail IS NOT NULL;"
            );
            // 打印表头（制表符分隔）
            System.out.printf("%s\t%s\t\t\t\t%s\n", "姓名", "邮箱", "电话");
            // 遍历结果集并打印每行数据
            while (resultSet.next()) {
                System.out.printf("%3s\t%s\t\t%s\n", 
                    resultSet.getString("c_name"), 
                    resultSet.getString("c_mail"), 
                    resultSet.getString("c_phone")
                );
            }
 
         } catch (ClassNotFoundException e) {
            System.out.println("Sorry,can`t find the JDBC Driver!"); 
            e.printStackTrace();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
        } finally {
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }

                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException throwables) {
                throwables.printStackTrace();
            }
        }
    }
}
