import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../constants/global_variables.dart';
import '../constants/strings.dart';

class AgentModel<T>{
  final T agentRefId;
  final T location;
  final T firstName;
  final T lastName;
  final T agentId;
  final T rentalsCy;
  final T wfiGtlRentals;
  final T wfiGtlRevenues;
  final T penetrationRate;

  AgentModel(this.agentRefId, this.location, this.firstName, this.lastName, this.agentId, this.rentalsCy, this.wfiGtlRentals, this.wfiGtlRevenues, this.penetrationRate);

  String getAgentRefIdAsString(){
    return agentRefId.toString();
  }

  String getLocationAsString(){
    return location.toString();
  }

  String getFirstNameAsString(){
    return firstName.toString();
  }

  String getLastNameAsString(){
    return lastName.toString();
  }

  String getAgentIdAsString(){
    return agentId.toString();
  }

  String getRentalsCyAsString(){
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    return myFormat.format(rentalsCy).toString();
  }

  int getRentalsCyAsInt(){
    return int.parse(rentalsCy.toString());
  }

  String getWfiGtlRentalsAsString(){
    NumberFormat myFormat = NumberFormat.decimalPattern('en_us');
    return myFormat.format(wfiGtlRentals).toString();
  }

  int getWfiGtlRentalsAsInt(){
    return int.parse(wfiGtlRentals.toString()) ;
  }

  String getWfiGtlRevenuesAsString(){
    return  formatCurrency.format(wfiGtlRevenues);
  }

  double getWfiGtlRevenuesAsDouble(){
    return  double.parse(wfiGtlRevenues.toString());
  }

  String getPenetrationRateAsString(){
    return getPenetrationRateAsDouble().toStringAsFixed(2) + "%";
  }

  double getPenetrationRateAsDouble(){
    return double.parse(penetrationRate.toString());
  }
  String getFullName(){
    return getFirstNameAsString() + " " + getLastNameAsString();
  }

  @override
  String toString(){
    return '[' + getLocationAsString() + "," + getFirstNameAsString() + " " + getLastNameAsString() + "," + getAgentIdAsString() + "," + getRentalsCyAsString().toString() + "," + getRentalsCyAsString().toString() + "," + getWfiGtlRevenuesAsString().toString() + ']';
  }

  T getSort(dataName){
    T sortBy = '' as T;

    if (dataName == 'location')
    {
      sortBy = location;
    }
    if (dataName == 'agent_name')
    {
      sortBy = (getFirstNameAsString() + " " + getLastNameAsString()) as T;
    }
    if (dataName == 'agent_id')
    {
      sortBy = agentId;
    }
    if (dataName == 'rentals_cy')
    {
      sortBy = rentalsCy;
    }
    if (dataName == 'wfi_gtl_rentals')
    {
      sortBy = wfiGtlRentals ;
    }
    if (dataName == 'wfi_gtl_revenues')
    {
      sortBy = double.parse(getWfiGtlRevenuesAsDouble().toStringAsFixed(2))  as T;
    }
    if (dataName == 'penetration_rate')
    {
      sortBy = double.parse(getPenetrationRateAsDouble().toStringAsFixed(2))  as T;
    }
    return sortBy;
  }

  String getFilter(dataName){
    String sortBy = '';

    if (dataName == locationDoc)
    {
      sortBy = getLocationAsString();
    }
    if (dataName == agentNameDoc)
    {
      sortBy = (getFirstNameAsString() + " " + getLastNameAsString());
    }
    if (dataName == agentIdDoc)
    {
      sortBy = getAgentIdAsString();
    }
    if (dataName == rentalsCyDoc)
    {
      sortBy = getRentalsCyAsString();
    }
    if (dataName == wfiGtlRentalsDoc)
    {
      sortBy = getWfiGtlRentalsAsString() ;
    }
    if (dataName == wfiGtlRevenuesDoc)
    {
      sortBy = getWfiGtlRevenuesAsString();
    }
    if (dataName == penetrationRateDoc)
    {
      sortBy = getPenetrationRateAsString();
    }
    return sortBy;
  }

  ///This method adds a new agent to the database and UI array
  Future<void> add()async {
    CollectionReference agents  = FirebaseFirestore.instance.collection('agents');

    var agentObj = AgentModel(
      getAgentRefIdAsString(),
      getLocationAsString(),
      getFirstNameAsString(),
      getLastNameAsString(),
      getAgentIdAsString(),
      getRentalsCyAsInt(),
      getWfiGtlRentalsAsInt(),
      getWfiGtlRevenuesAsDouble(),
      getPenetrationRateAsDouble()
    );

    //add to firebase
     agents
        .add({
      'location': getLocationAsString(),
      'fname': getFirstNameAsString(),
      'lname': getLastNameAsString(),
      'agent_id': getAgentIdAsString(),
      'rentals_cy': getRentalsCyAsInt(),
      'wfi_gtl_rentals': getWfiGtlRentalsAsInt(),
      'wfi_gtl_revenues': getWfiGtlRevenuesAsDouble(),
      'penetration_rate': getPenetrationRateAsDouble(),
    })
        .then((value) => print("Agent Added"))
        .catchError((error) => print("Failed to add user: $error"));

    //add to array
    allAgents.insert(0, agentObj);
  }

  ///This method deletes the selected agent from firebase
  ///
  /// Uses the id of the document to delete the specific agent
  /// - then prints that the specific id has been deleted
  /// - will reflect in the web app
  Future <void> deleteAgent(String agentRefId) async{
    final _db = FirebaseFirestore.instance; //initialize the firestore database
    _db.collection("agents")
        .doc(agentRefId)
        .delete();

    print("Doc Ref: " + agentRefId + " Has been deleted");

    //update array so it reflects database: this way we don't have to read the database again for this session
    for (int i = 0; i < allAgents.length; i++) {
      if (allAgents[i].getAgentRefIdAsString() == agentRefId){
        allAgents.removeAt(i);
      }
    }
  }


  /// This method will update the agent document in firebase
  ///
  /// Uses the id of the document to make changes
  /// - then prints that the specific id has been updated
  /// - will reflect in the web app
  Future <void> updateAgent(String agentRefId) async {
    final _db = FirebaseFirestore.instance; //initialize the firestore database
    var updateColumn = _db.collection("agents").doc(agentRefId);
    updateColumn.update({'location': getLocationAsString()});
    updateColumn.update({'fname': getFirstNameAsString()});
    updateColumn.update({'lname': getLastNameAsString()});
    updateColumn.update({'agent_id': getAgentIdAsString()});
    updateColumn.update({'rentals_cy': getRentalsCyAsInt()});
    updateColumn.update({'wfi_gtl_rentals': getWfiGtlRentalsAsInt()});
    updateColumn.update({'wfi_gtl_revenues': getWfiGtlRevenuesAsDouble()});
    updateColumn.update({'penetration_rate': getPenetrationRateAsDouble()});

    //update array so it reflects database: this way we don't have to read the database again for this session
    for (int i = 0; i < allAgents.length; i++){
      if (allAgents[i].getAgentRefIdAsString() == agentRefId){
        allAgents[i] = AgentModel (agentRefId, getLocationAsString(), getFirstNameAsString(), getLastNameAsString(), getAgentIdAsString(), getRentalsCyAsInt(), getWfiGtlRentalsAsInt(), getWfiGtlRevenuesAsDouble(), getPenetrationRateAsDouble());
      }
    }
  }
}

