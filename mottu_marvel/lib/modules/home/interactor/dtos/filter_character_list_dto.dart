enum FilterCharacterOrderBy {
  nameAsc("name"),
  modifiedAsc("modified");
  // nameDesc("-name"),
  // modifiedDesc("-modified");

  final String value;

  const FilterCharacterOrderBy(this.value);
}

class FilterCharacterListDTO {
  final String? name;
  final String? nameStartsWith;
  final int limit;
  final int offset;
  final FilterCharacterOrderBy orderBy;

  FilterCharacterListDTO({
    this.name,
    this.nameStartsWith,
    this.limit = 20,
    this.offset = 0,
    this.orderBy = FilterCharacterOrderBy.nameAsc,
  });

  @override
  String toString() {
    return "limit=$limit&offset=$offset";
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (name != null) 'name': name,
      if (nameStartsWith != null) 'nameStartsWith': nameStartsWith,
      'limit': limit,
      'offset': offset,
      if (orderBy != FilterCharacterOrderBy.nameAsc) 'orderBy': orderBy.value,
    };
  }
}
