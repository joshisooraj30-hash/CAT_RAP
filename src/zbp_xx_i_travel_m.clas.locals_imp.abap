CLASS lhc_Travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Travel RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Travel RESULT result.
    METHODS valCust FOR VALIDATE ON SAVE
      IMPORTING keys FOR Travel~valCust.
    METHODS detCurCode FOR DETERMINE ON SAVE
      IMPORTING keys FOR Travel~detCurCode.
    METHODS dettravelID FOR DETERMINE ON SAVE
      IMPORTING keys FOR Travel~dettravelID.

ENDCLASS.

CLASS lhc_Travel IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD valCust.

*    READ ENTITIES OF zxx_i_travel_m IN LOCAL MODE ENTITY Travel
*    FIELDS ( CustomerId ) WITH CORRESPONDING #( keys )
*    RESULT DATA(it_customer).

*    LOOP AT it_customer INTO DATA(ls_customer).
*      IF ls_customer-CustomerId <> '100000' AND ls_customer-CustomerId <> '100001'.
*            APPEND VALUE #( %tky = ls_customer-%tky ) to failed-travel. """ validations -
*
*        APPEND VALUE #( %tky = keys[ 1 ]-%tky
*                        %msg = new_message_with_text(
*                                 severity = if_abap_behv_message=>severity-error
*                                 text     = 'Customer ID cannot be other than 100000 and 100001'
*                               ) ) TO reported-travel.
*
*      ENDIF.
*    ENDLOOP.

  ENDMETHOD.

  METHOD detCurCode.
*    READ ENTITIES OF zxx_i_travel_m IN LOCAL MODE ENTITY Travel
*    FIELDS ( AgencyID ) WITH CORRESPONDING #( keys )
*    RESULT DATA(it_agency).
*
*    LOOP AT it_agency INTO DATA(ls_agency).
*      IF ls_agency-AgencyId = '70041'.
*        MODIFY ENTITIES OF zxx_i_travel_m IN LOCAL MODE ENTITY travel
*        UPDATE FIELDS ( CurrencyCode ) WITH VALUE #( (  %tky = ls_agency-%tky CurrencyCode = 'EUR' ) ).
*      ELSEIF ls_agency-AgencyId = '70007'.
*        MODIFY ENTITIES OF zxx_i_travel_m IN LOCAL MODE ENTITY travel
*        UPDATE FIELDS ( CurrencyCode ) WITH VALUE #( (  %tky = ls_agency-%tky CurrencyCode = 'USD' ) ).
*      ENDIF.
*    ENDLOOP.
  ENDMETHOD.

  METHOD dettravelID.
    READ ENTITIES OF zxx_i_travel_m IN LOCAL MODE ENTITY Travel
    ALL FIELDS WITH
    CORRESPONDING #( keys )
    RESULT DATA(it_travel).

    DELETE it_travel WHERE TravelId IS NOT INITIAL.
    IF  it_travel is initial.
      SELECT FROM /dmo/travel_m
      FIELDS MAX( travel_id )
      INTO @DATA(lv_max_travelid).

      DATA: lv_index TYPE /dmo/travel_id.
      IF lv_index IS INITIAL.
        lv_index = 1.
      ENDIF.
      LOOP AT it_travel INTO DATA(ls_travel).
        ls_travel-travelid = lv_max_travelid + lv_index.

        MODIFY ENTITIES OF zxx_i_travel_m IN LOCAL MODE
            ENTITY travel
            CREATE FIELDS (  TravelId AgencyId CustomerId )
                  WITH VALUE  #( (
                          %cid = 'etagg'
                          TravelId = Ls_travel-travelid
                          AgencyId = ls_travel-AgencyId
                          CustomerId = ls_travel-CustomerId ) )
                          MAPPED DATA(mapped)
                          FAILED DATA(failed1)
                          REPORTED DATA(reported1).

      ENDLOOP.
    ENDIF.
  ENDMETHOD.

ENDCLASS.
