// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    this.limit = 15,
    required this.offset,
    this.orderBy = FilterCharacterOrderBy.nameAsc,
  });

  @override
  String toString() {
    final queryString = toMap().entries.map((entry) {
      return '${entry.key}=${Uri.encodeComponent(entry.value)}';
    }).join('&');

    return queryString;
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (name != null) 'name': name,
      if (nameStartsWith != null) 'nameStartsWith': nameStartsWith,
      'limit': limit.toString(),
      'offset': offset.toString(),
      if (orderBy != FilterCharacterOrderBy.nameAsc) 'orderBy': orderBy.value,
    };
  }

  FilterCharacterListDTO copyWith({
    String? name,
    String? nameStartsWith,
    int? limit,
    int? offset,
    FilterCharacterOrderBy? orderBy,
  }) {
    return FilterCharacterListDTO(
      name: name ?? this.name,
      nameStartsWith: nameStartsWith ?? this.nameStartsWith,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
      orderBy: orderBy ?? this.orderBy,
    );
  }
}
