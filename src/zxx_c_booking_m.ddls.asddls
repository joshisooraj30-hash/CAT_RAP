@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PROJECTION VIEW ON BOOKING'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity zxx_c_booking_m  
as projection on ZXX_I_BOOKING_M
{
    key TravelId,
    key BookingId,
    BookingDate,
    CustomerId,
    CarrierId,
    ConnectionId,
    FlightDate,
    @Semantics.amount.currencyCode: 'CurrencyCode'
    FlightPrice,
    CurrencyCode,
    BookingStatus,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    LastChangedAt,
    /* Associations */
    _bookingStatus,
    _booksuppl : redirected to composition child zxx_c_booksuppl_m,
    _carrier,
    _connection,
    _customer,
    _travel : redirected to parent ZXX_C_TRAVEL_M
}
