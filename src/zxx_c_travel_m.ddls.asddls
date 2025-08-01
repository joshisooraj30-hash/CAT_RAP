@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PROJECTION VIEW ON TRAVEL'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZXX_C_TRAVEL_M
  provider contract transactional_query
  as projection on ZXX_I_TRAVEL_M
{
//  @ObjectModel.text.element: [ 'Description' ]
  key TravelId,
      @Consumption.valueHelpDefinition: [{ entity: {
      name : '/DMO/I_Agency' , element: 'AgencyID' }}]
      AgencyId,
//      _agency.Name,
      CustomerId,
      BeginDate,
      EndDate,
            @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee,
            @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,
      CurrencyCode,
      Description,
      OverallStatus,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LastChangedAt,
      /* Associations */
      _agency,
      _booking : redirected to composition child zxx_c_booking_m,
      _customer,
      _overallstatus
}
