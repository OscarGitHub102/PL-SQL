import com.mongodb.MongoClient;
import com.mongodb.MongoClientURI;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.mongodb.client.MongoDatabase;
import org.bson.Document;

public class MongoDB {

    public static void main(String[] args) {
        
        // Antes de comprobar que funciona habría que crearse un usuarioConexión a MongoDB
        //db.createUser({ user: "admin", pwd: "admin", roles: [] }) 
        
        MongoClientURI uri = new MongoClientURI("x");
        
        try (MongoClient mongoClient = new MongoClient(uri)) {

            MongoDatabase database = mongoClient.getDatabase("x");
            MongoCollection<Document> collection = database.getCollection("x");

            MongoCursor<Document> cursor = collection.find().iterator();
            while (cursor.hasNext())
            {
                Document document = cursor.next();
                System.out.println(document.toJson());
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
