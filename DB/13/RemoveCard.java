import java.sql.*;
import java.util.Scanner;

public class RemoveCard {
    static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://127.0.0.1:3306/finance?allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF8&useSSL=false&serverTimezone=UTC";
    static final String USER = "root";
    static final String PASS = "123123";
    /**
     * 删除bank_card表中数据
     *
     * @param connection 数据库连接对象
     * @param b_c_id 客户编号
     * @param c_number 银行卡号
     */
    public static int removeBankCard(Connection connection,
                                 int b_c_id, String b_number) {
        // 预编译SQL删除语句，通过客户编号和银行卡号精确定位
        String sql = "DELETE FROM bank_card WHERE b_c_id = ? AND b_number = ?";
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            // 绑定参数：客户编号和银行卡号
            pstmt.setInt(1, b_c_id);       // 所属客户编号
            pstmt.setString(2, b_number);   // 银行卡号
            // 执行删除并返回受影响行数
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            return 0; // 删除失败时返回0
        }
    }

    // 不要修改main() 
    public static void main(String[] args) throws Exception {

        Scanner sc = new Scanner(System.in);
        Class.forName(JDBC_DRIVER);

        Connection connection = DriverManager.getConnection(DB_URL, USER, PASS);

        while(sc.hasNext())
        {
            String input = sc.nextLine();
            if(input.equals(""))
                break;

            String[]commands = input.split(" ");
            if(commands.length ==0)
                break;
            int id = Integer.parseInt(commands[0]);
            String carNumber = commands[1];
            
            int n = removeBankCard(connection, id, carNumber);
            if (n > 0) {
               System.out.println("已销卡数：" + n);
            } else {
               System.out.println("销户失败，请检查客户编号或银行卡号！" );
            }
        }
    }

}
