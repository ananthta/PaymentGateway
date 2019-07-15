/* Used to Convert any data type received from backend into appropriate type
 * Has 3 re-usable methods
    * ConvertToDouble(Object)
    * ConvertToInt(Object)
    * ConvertToString(Object
*/
class InconsistentDataHandler {

  static double ConvertToDouble(Object jsonData) {
    double data;
    try {
      data = double.parse(jsonData); // check if jsonData is of type String
      return data;
    } catch (e) { //Json productPrice was not string
      try {
        data = jsonData; //check if jsonData is of type Double
        return data;
      } catch (e) { // Json productPrice was NOT String or Double and must be Integer
        data = (jsonData as int).toDouble(); //convert to double
        return data;
      }
    }
  }

  static int ConvertToInt(Object jsonData) {
    int data;
    try {
      data = int.parse(jsonData); // check if jsonData is of type String
      return data;
    } catch (e) { // jsonData is NOT string
      data = jsonData; //save as integer
      return data;
    }
  }

  static String ConvertToString(Object jsonData) {
    String data;
    try {
      data = jsonData; // Check if jsonData is of type String
      return data;
    } catch (e) { // jsonData is not of type String
      data = jsonData.toString(); //Convert to string
      return data;
    }
  }
}