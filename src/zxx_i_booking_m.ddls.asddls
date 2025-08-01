@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Booking entity Interface view'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZXX_I_BOOKING_M
  as select from /dmo/booking_m
  association to parent ZXX_I_TRAVEL_M    as _travel     on $projection.TravelId = _travel.TravelId
  composition [0..*] of zxx_i_booksuppl_m as _booksuppl
  association to /DMO/I_Customer          as _customer   on $projection.CustomerId = _customer.CustomerID
  association to /DMO/I_Carrier           as _carrier    on $projection.CarrierId = _carrier.AirlineID
  association [1..*] to /DMO/I_Connection        as _connection 
            on $projection.ConnectionId = _connection.ConnectionID
  association to /DMO/I_Booking_Status_VH as _bookingStatus on 
  $projection.BookingStatus = _bookingStatus.BookingStatus
{
  key travel_id     as TravelId,
  key booking_id    as BookingId,
      booking_date  as BookingDate,
      customer_id   as CustomerId,
      carrier_id    as CarrierId,
      connection_id as ConnectionId,
      flight_date   as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price  as FlightPrice,
      currency_code as CurrencyCode,
      booking_status as BookingStatus,
            @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at as LastChangedAt,
      _travel,
      _booksuppl,
      _carrier,
      _connection,
      _customer,
      _bookingStatus
}
