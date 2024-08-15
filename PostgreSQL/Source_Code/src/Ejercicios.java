import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class Ejercicios {

    private static final String URL = "x";
    private static final String USUARIO = "x";
    private static final String CONTRASENA = "x";

    public static void main(String[] args) {
        Connection conexion = null;

        try {
            Class.forName("org.postgresql.Driver");
            conexion = DriverManager.getConnection(URL, USUARIO, CONTRASENA);
            Scanner scanner = new Scanner(System.in);
            boolean salir = false;

            while (!salir) {
                System.out.println("Introduzca una opción: ");
                System.out.println("c. Para los departamentos 111 y 112 hallar la media aritmética de los años de servicio de sus empleados en el día de hoy.");
                System.out.println("e. Obtener los nombres y salarios de los empleados cuyo salario coincide con la comisión de algún otro o la suya propia. Ordenarlos alfabéticamente.");
                System.out.println("f. Para los departamentos cuyo director lo sea en funciones, hallar el número de empleados y la suma de sus salarios, comisiones y número de hijos.");
                System.out.println("g. Para los departamentos cuyo presupuesto anual supera los 100.00 €, hallar cuántos empleados hay en promedio por cada extensión telefónica.");
                System.out.println("j. Como consecuencia del convenio, se aumenta el sueldo a todos los empleados en un 5.33% y la comisión en un 6.19% a todos los vendedores.");
                System.out.println("k. Crear un programa que muestre los empleados de la tabla TEMPLE que trabajan en un departamento introducido por teclado.");
                System.out.println("l. Realizar un programa que muestre los códigos de los empleados y cuente aquellos cuya comisión es nula.");
                System.out.println("m. Escribir un bloque PL que reciba una cadena y visualice el apellido y el número de empleado de todos los empleados cuyo apellido contenga la cadena especificada. Al finalizar se visualizará el número de empleados mostrados.");
                System.out.println("s. Salir");

                String opcion = scanner.nextLine();

                switch (opcion) {
                    case "c":
                        consultaC(conexion);
                        break;
                    case "e":
                        consultaE(conexion);
                        break;
                    case "f":
                        consultaF(conexion);
                        break;
                    case "g":
                        consultaG(conexion);
                        break;
                    case "j":
                        consultaJ(conexion);
                        break;
                    case "k":
                        consultaK(conexion, scanner);
                        break;
                    case "l":
                        consultaL(conexion);
                        break;
                    case "m":
                        consultaM(conexion, scanner);
                        break;
                    case "s":
                        salir = true;
                        break;
                    default:
                        System.out.println("Opción inválida");
                        break;
                }
            }

        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        } finally {
            if (conexion != null) {
                try {
                    conexion.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private static void consultaC(Connection conexion) throws SQLException
    {
        String consultaSQL = "SELECT NUMDE, trunc(AVG(EXTRACT(YEAR FROM AGE(NOW(), FECIN))),2) AS \"media de años de servicio\" " + "FROM TEMPLE WHERE NUMDE IN (111, 112) GROUP BY NUMDE;";

        try (PreparedStatement statement = conexion.prepareStatement(consultaSQL)) {
            try (ResultSet resultSet = statement.executeQuery()) {
                
                while (resultSet.next())
                {
                    int numde = resultSet.getInt("NUMDE");
                    double mediaAniosServicio = resultSet.getDouble("media de años de servicio");
                    System.out.println("NUMDE: " + numde + ", Media de años de servicio: " + mediaAniosServicio);
                }
            }
        }
    }

    private static void consultaE(Connection conexion) throws SQLException
    {
        String consultaSQL = "SELECT NOMEM, SALAR FROM TEMPLE WHERE SALAR = ANY (SELECT SALAR " + "FROM TEMPLE WHERE COMIS IS NOT NULL) ORDER BY NOMEM;";

        try (PreparedStatement statement = conexion.prepareStatement(consultaSQL)) {
            try (ResultSet resultSet = statement.executeQuery()) {
                
                while (resultSet.next())
                {
                    String nomem = resultSet.getString("NOMEM");
                    double salar = resultSet.getDouble("SALAR");
                    System.out.println("NOMBRE: " + nomem + ", Salario: " + salar);
                }
            }
        }
    }

    private static void consultaF(Connection conexion) throws SQLException
    {
        String consultaSQL = "SELECT TDEPTO.NUMDE, COUNT(TEMPLE.NUMEM) AS \"TOTAL EMPLEADOS\", " + "SUM(TEMPLE.SALAR) AS \"TOTAL SALARIOS\", " + "SUM(TEMPLE.COMIS) AS \"TOTAL COMISIONES\", " + "SUM(TEMPLE.NUMHI) AS \"TOTAL HIJOS\" " + "FROM TDEPTO, TEMPLE " + "WHERE TDEPTO.NUMDE = TEMPLE.NUMDE and TDEPTO.TIDIR = 'F' " + "GROUP BY TDEPTO.NUMDE;";

        try (PreparedStatement statement = conexion.prepareStatement(consultaSQL)) {
            try (ResultSet resultSet = statement.executeQuery()) {
                
                while (resultSet.next())
                {
                    int numde = resultSet.getInt("NUMDE");
                    int totalEmpleados = resultSet.getInt("TOTAL EMPLEADOS");
                    double totalSalarios = resultSet.getDouble("TOTAL SALARIOS");
                    double totalComisiones = resultSet.getDouble("TOTAL COMISIONES");
                    int totalHijos = resultSet.getInt("TOTAL HIJOS");
                    System.out.println("NUMDE: " + numde + ", Total empleados: " + totalEmpleados + ", Total salarios: " + totalSalarios + ", Total comisiones: " + totalComisiones + ", Total hijos: " + totalHijos);
                }
            }
        }
    }

    private static void consultaG(Connection conexion) throws SQLException
    {
        String consultaSQL = "SELECT TEMPLE.EXTEL, COUNT(TEMPLE.NUMEM) AS \"TOTAL EMPLEADOS POR " + "LINEA TELEFONICA\" " + "FROM TDEPTO, TEMPLE " + "WHERE TDEPTO.NUMDE = TEMPLE.NUMDE AND TDEPTO.PRESU > 100.00 " + "GROUP BY TDEPTO.NUMDE, TEMPLE.EXTEL;";

        try (PreparedStatement statement = conexion.prepareStatement(consultaSQL)) {
            try (ResultSet resultSet = statement.executeQuery()) {
                
                while (resultSet.next())
                {
                    String extel = resultSet.getString("EXTEL");
                    int totalEmpleadosPorLinea = resultSet.getInt("EMPLEADOS POR LÍNEA TELEFÓNICA");
                    System.out.println("Extensión telefónica: " + extel + ", Total empleados por línea telefónica: " + totalEmpleadosPorLinea);
                }
            }
        }
    }

    private static void consultaJ(Connection conexion) throws SQLException
    {
        String consultaSQL = "UPDATE TEMPLE " + "SET SALAR = SALAR * 1.0533, COMIS = COMIS * 1.0619 " + "WHERE COMIS IS NOT NULL;";

        try (PreparedStatement statement = conexion.prepareStatement(consultaSQL)) {
            int filasAfectadas = statement.executeUpdate();
            System.out.println("Se han actualizado " + filasAfectadas + " empleados.");
        }
    }

    private static void consultaK(Connection conexion, Scanner scanner) throws SQLException
    {
        System.out.println("Introduce el número de departamento: ");
        int numde = scanner.nextInt();

        String consultaSQL = "SELECT * FROM mostrarEmpleadosDepartamento(?)";

        try (PreparedStatement statement = conexion.prepareStatement(consultaSQL)) {
            statement.setInt(1, numde);

            try (ResultSet resultSet = statement.executeQuery()) {
                
                while (resultSet.next())
                {
                    int numem = resultSet.getInt("NUMEM");
                    String nomem = resultSet.getString("NOMEM");
                    System.out.println("NUMEM: " + numem + ", NOMBRE: " + nomem);
                }
            }
        }
        scanner.nextLine();  
    }

    private static void consultaL(Connection conexion) throws SQLException
    {
        String consultaSQL = "SELECT NUMEM FROM TEMPLE WHERE COMIS IS NULL;";

        try (PreparedStatement statement = conexion.prepareStatement(consultaSQL)) {
            try (ResultSet resultSet = statement.executeQuery()) {
                int contador = 0;
                
                while (resultSet.next())
                {
                    int numem = resultSet.getInt("NUMEM");
                    System.out.println("Código de empleado con comisión nula: " + numem);
                    contador++;
                }
                System.out.println("Total de empleados con comisión nula: " + contador);
            }
        }
    }

    private static void consultaM(Connection conexion, Scanner scanner) throws SQLException
    {
        System.out.println("Introduzca una cadena para buscar en apellidos: ");
        String cadenaBusqueda = scanner.nextLine();

        String consultaSQL = "SELECT NUMEM, NOMEM FROM TEMPLE WHERE NOMEM LIKE ?;";

        try (PreparedStatement statement = conexion.prepareStatement(consultaSQL)) {
            statement.setString(1, "%" + cadenaBusqueda + "%");

            try (ResultSet resultSet = statement.executeQuery()) {
                int contador = 0;
                
                while (resultSet.next())
                {
                    int numem = resultSet.getInt("NUMEM");
                    String apellido = resultSet.getString("NOMEM");
                    System.out.println("NUMEM: " + numem + ", Apellido: " + apellido);
                    contador++;
                }
                System.out.println("Total de empleados mostrados: " + contador);
            }
        }
    }
}
