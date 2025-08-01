@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Book Supplement interface view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zxx_i_booksuppl_m
  as select from /dmo/booksuppl_m
  association to parent ZXX_I_BOOKING_M as _booking on  $projection.TravelId  = _booking.TravelId
                                                    and $projection.BookingId = _booking.BookingId
  association to ZXX_I_TRAVEL_M as _travel on $projection.TravelId = _travel.TravelId  // commented
  association to /DMO/I_Supplement as _suppl on $projection.SupplementId = _suppl.SupplementID
  association to /DMO/I_SupplementText as _supplText on $projection.SupplementId = _supplText.SupplementID
                                                     and _supplText.LanguageCode = 'E'
{
  key travel_id             as TravelId,
  key booking_id            as BookingId,
  key booking_supplement_id as BookingSupplementId,
      supplement_id         as SupplementId,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price                 as Price,
      currency_code         as CurrencyCode,
            @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at       as LastChangedAt,
      _booking,
      _suppl,
      _supplText,
      _travel
}
