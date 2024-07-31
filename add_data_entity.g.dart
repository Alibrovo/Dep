import &#39;package:cloud_firestore/cloud_firestore.dart&#39;;
import &#39;package:json_annotation/json_annotation.dart&#39;;
part &#39;add_data_entity.g.dart&#39;;

@JsonSerializable()
class AddEntity {
String? taskname;
String? image;
String? addId;
String? userID;
bool isCompleted;
DateTime? dateTime;

AddEntity(
{this.dateTime,
this.taskname,
this.image,
this.addId,
this.isCompleted = false,
this.userID});

// From JSON
factory AddEntity.fromJson(Map&lt;String, dynamic&gt; json) =&gt;
_$AddEntityFromJson(json);

// To JSON
Map&lt;String, dynamic&gt; toJson() =&gt; _$AddEntityToJson(this);

static CollectionReference&lt;AddEntity&gt; collection() {
return FirebaseFirestore.instance.collection(&quot;AddEntity&quot;).withConverter(
fromFirestore: (snapshot, _) =&gt; AddEntity.fromJson(snapshot.data()!),
toFirestore: (user, _) =&gt; user.toJson());
}

static DocumentReference&lt;AddEntity&gt; doc({required String addId}) {
return FirebaseFirestore.instance.doc(&quot;AddEntity/$addId&quot;).withConverter(
fromFirestore: (snapshot, _) =&gt; AddEntity.fromJson(snapshot.data()!),
toFirestore: (user, _) =&gt; user.toJson());
}
}