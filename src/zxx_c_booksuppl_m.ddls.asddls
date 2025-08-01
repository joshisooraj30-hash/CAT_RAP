@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PROJECTION VIEW ON BOOKING SUPPLEMENT'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zxx_c_booksuppl_m 
as projection on zxx_i_booksuppl_m
{
    key TravelId,
    key BookingId,
    key BookingSupplementId,
    SupplementId,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    Price,
    CurrencyCode,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    LastChangedAt,
    /* Associations */
    _booking : redirected to parent zxx_c_booking_m,
    _suppl,
    _supplText,
    _travel : redirected to ZXX_C_TRAVEL_M
}
