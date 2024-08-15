import org.basex.api.client.ClientSession;

public class BaseX {
    public static void main(String[] args) {

        // Abrir y poner en el cmd: basexserver -c PASSWORD y poner una contraseña que es la que se pondra como String password (línea 11)
        
        String serverAddress = "x";
        int serverPort = x;
        String username = "x";
        String password = "x";

        try {
            try (ClientSession session = new ClientSession(serverAddress, serverPort, username, password)) {
               
                String databaseName = "libros";
                session.execute("OPEN " + databaseName);

                
                String query = "for $doc in collection('"+databaseName+"') return $doc";
                String result = session.execute("XQUERY " + query);
                System.out.println("Query result:\n" + result);

                session.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}