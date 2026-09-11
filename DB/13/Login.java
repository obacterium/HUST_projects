import java.sql.*;
import java.util.Scanner;

public class Login {
    public static void main(String[] args) {
        Connection connection = null;
        //申明下文中的resultSet, statement
        Statement statement = null;
        ResultSet resultSet = null;


        Scanner input = new Scanner(System.in);

        System.out.print("请输入用户名：");
        String loginName = input.nextLine();
        System.out.print("请输入密码：");
        String loginPass = input.nextLine();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String userName = "root";
            String passWord = "123123";
            String url = "jdbc:mysql://127.0.0.1:3306/finance?useUnicode=true&characterEncoding=UTF8&useSSL=false&serverTimezone=UTC";
            connection = DriverManager.getConnection(url, userName, passWord);
            // 补充实现代码:
            statement = connection.createStatement();
            // 构建SQL查询：匹配邮箱和密码
            String sql = "SELECT c_name FROM client WHERE c_mail = '" + loginName + "' AND c_password = '" + loginPass + "';";
            // 执行查询
            resultSet = statement.executeQuery(sql);
            // 判断结果集是否有数据
            if (resultSet.next()) {
                System.out.println("登录成功。");
            } else {
                System.out.println("用户名或密码错误！");
            }

         } catch (ClassNotFoundException e) {
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
