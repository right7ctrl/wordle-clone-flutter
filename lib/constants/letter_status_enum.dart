///Klavyede önceden kullanılmış harflerin; keyword içerisindeki durumlarını belirtir

/// [not_in_keyword] = Harf, keyword içerisinde bulunmuyor
/// bu durumda klavyede bu harfin arkaplanının gri renkte olmasını bekliyoruz

/// [in_keyword] = Harf, keyword içerisinde bulunuyor,
/// bu durumda klavyede bu harfin arkaplanının yeşil renkte olmasını bekliyoruz

/// [not_in_correct_index] = Harf, keyword içerisinde bulunuyor ama farklı yerde,
/// bu durumda klavyede bu harfin arkaplanının aynı renkte kalmasını bekliyoruz.
enum LetterStatus {
  not_in_keyword,
  not_in_correct_index,
  in_keyword,
}
