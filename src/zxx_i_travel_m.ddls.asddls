@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel entity Interface view'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZXX_I_TRAVEL_M
  as select from /dmo/travel_m
  composition [0..*] of ZXX_I_BOOKING_M   as _booking
  association to /DMO/I_Agency            as _agency        on $projection.AgencyId = _agency.AgencyID
  association to /DMO/I_Customer          as _customer      on $projection.CustomerId = _customer.CustomerID
  association to /DMO/I_Overall_Status_VH as _overallstatus on $projection.OverallStatus = _overallstatus.OverallStatus
{
  key travel_id       as TravelId,
      agency_id       as AgencyId,
      customer_id     as CustomerId,
      begin_date      as BeginDate,
      end_date        as EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      booking_fee     as BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      total_price     as TotalPrice,
      currency_code   as CurrencyCode,
      description     as Description,
      overall_status  as OverallStatus,
      created_by      as CreatedBy,
      created_at      as CreatedAt,
      last_changed_by as LastChangedBy,
            @Semantics.systemDateTime.localInstanceLastChangedAt: true
      last_changed_at as LastChangedAt,
      _booking,
      _agency,
      _customer,
      _overallstatus
}
