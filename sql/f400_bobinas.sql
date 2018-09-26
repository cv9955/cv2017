prompt --application/set_environment/8859258967720850
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- ORACLE Application Express (APEX) export file
--
-- You should run the script connected to SQL*Plus as the Oracle user
-- APEX_180100 or as the owner (parsing schema) of the application.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_api.import_begin (
 p_version_yyyy_mm_dd=>'2018.04.04'
,p_release=>'18.1.0.00.45'
,p_default_workspace_id=>4778624277915672
,p_default_application_id=>400
,p_default_owner=>'VIC'
);
end;
/
 
prompt APPLICATION 400 - Victoria Corrugados S.A.
--
-- Application Export:
--   Application:     400
--   Name:            Victoria Corrugados S.A.
--   Date and Time:   21:17 Wednesday September 19, 2018
--   Exported By:     CESAR
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     BREADCRUMB ENTRY:  Breadcrumb: BOBINAS (300)
--     PAGE: 310. BOBINAS COMPRAS
--     PAGE: 311. Bobinas w1
--     PAGE: 312. Bobinas w2
--     PAGE: 313. Bobinas w3
--     PAGE: 314. BOBINAS INGRESO
--     PAGE: 315. PRINT_PLANILLA
--     PAGE: 316. PRINT_ETIQUETA
--     PAGE: 330. RESUMEN STOCK
--     PAGE: 300. BOBINAS
--     PAGE: 301. STOCK X FORMATO
--     PAGE: 302. DETALLE BOBINA
--     PAGE: 303. BOBINAS CORRUGADO
--   Manifest End
--   Version:         18.1.0.00.45
--   Instance ID:     211642672295911
--

-- C O M P O N E N T    E X P O R T
begin
  wwv_flow_api.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/navigation/breadcrumbentry/8859258967720850
begin
wwv_flow_api.create_menu_option(
 p_id=>wwv_flow_api.id(8859258967720850)
,p_menu_id=>wwv_flow_api.id(3152262276915400)
,p_parent_id=>0
,p_option_sequence=>10
,p_short_name=>'BOBINAS'
,p_link=>'f?p=&APP_ID.:300:&SESSION.::&DEBUG.:::'
,p_page_id=>300
);
end;
/
prompt --application/pages/delete_00310
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>310);
end;
/
prompt --application/pages/page_00310
begin
wwv_flow_api.create_page(
 p_id=>310
,p_user_interface_id=>wwv_flow_api.id(3150912767915327)
,p_name=>'BOBINAS COMPRAS'
,p_alias=>'BOB_BUY'
,p_step_title=>'BOBINAS COMPRAS'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title=>'BOBINAS COMPRAS'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(5973192580485747)
,p_step_template=>wwv_flow_api.id(12583897249064454)
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'CESAR'
,p_last_upd_yyyymmddhh24miss=>'20180918100216'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10655050394738202)
,p_plug_name=>'PROVEEDOR'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(3117357289915216)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'BOB_PROV.PROV AS LABEL,',
'SUM(BOB.PESO) as valor',
'from BOB_ORDEN , BOB , BOB_TIPO , BOB_PROV',
'WHERE EXTRACT(YEAR FROM FECHA) = EXTRACT(YEAR FROM SYSDATE)',
'AND BOB.ORDEN_INGRESO = BOB_ORDEN.ID',
'AND BOB.TIPO = BOB_TIPO.ID',
'AND BOB_PROV.ID = BOB_ORDEN.PROV',
'GROUP BY BOB_PROV.PROV',
'',
'',
'ORDER BY 1'))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(7872245855270535)
,p_region_id=>wwv_flow_api.id(10655050394738202)
,p_chart_type=>'pie'
,p_animation_on_display=>'none'
,p_animation_on_data_change=>'none'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_value_format_scaling=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>false
,p_show_value=>true
,p_show_label=>false
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_pie_other_threshold=>0
,p_pie_selection_effect=>'highlight'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(7872753167270538)
,p_chart_id=>wwv_flow_api.id(7872245855270535)
,p_seq=>10
,p_name=>'New'
,p_location=>'REGION_SOURCE'
,p_items_value_column_name=>'VALOR'
,p_items_label_column_name=>'LABEL'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10655909565738210)
,p_plug_name=>'TIPO DE PAPEL'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(3117357289915216)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'BOB_TIPO.TIPO_PAPEL AS LABEL,',
'SUM(BOB.PESO) as valor',
'from BOB_ORDEN , BOB , BOB_TIPO , BOB_PROV',
'WHERE EXTRACT(YEAR FROM FECHA) = EXTRACT(YEAR FROM SYSDATE)',
'AND BOB.ORDEN_INGRESO = BOB_ORDEN.ID',
'AND BOB.TIPO = BOB_TIPO.ID',
'AND BOB_PROV.ID = BOB_ORDEN.PROV',
'GROUP BY BOB_TIPO.TIPO_PAPEL',
'',
''))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(7875074406270544)
,p_region_id=>wwv_flow_api.id(10655909565738210)
,p_chart_type=>'pie'
,p_animation_on_display=>'none'
,p_animation_on_data_change=>'none'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_value_format_scaling=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>false
,p_show_value=>true
,p_show_label=>false
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_pie_other_threshold=>0
,p_pie_selection_effect=>'highlight'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(7875505515270545)
,p_chart_id=>wwv_flow_api.id(7875074406270544)
,p_seq=>10
,p_name=>'New'
,p_location=>'REGION_SOURCE'
,p_items_value_column_name=>'VALOR'
,p_items_label_column_name=>'LABEL'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10656817065738219)
,p_plug_name=>'FORMATO'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(3117357289915216)
,p_plug_display_sequence=>50
,p_plug_new_grid_row=>false
,p_plug_new_grid_column=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'BOB.FORMATO AS LABEL,',
'SUM(BOB.PESO) as valor',
'from BOB_ORDEN , BOB , BOB_TIPO , BOB_PROV',
'WHERE EXTRACT(YEAR FROM FECHA) = EXTRACT(YEAR FROM SYSDATE)',
'AND BOB.ORDEN_INGRESO = BOB_ORDEN.ID',
'AND BOB.TIPO = BOB_TIPO.ID',
'AND BOB_PROV.ID = BOB_ORDEN.PROV',
'GROUP BY BOB.FORMATO',
'',
'',
'ORDER BY 1'))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_num_rows=>15
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(7873693216270542)
,p_region_id=>wwv_flow_api.id(10656817065738219)
,p_chart_type=>'pie'
,p_animation_on_display=>'none'
,p_animation_on_data_change=>'none'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'none'
,p_hover_behavior=>'none'
,p_value_format_scaling=>'auto'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>false
,p_show_value=>true
,p_show_label=>false
,p_legend_rendered=>'on'
,p_legend_position=>'auto'
,p_pie_other_threshold=>0
,p_pie_selection_effect=>'highlight'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(7874173218270543)
,p_chart_id=>wwv_flow_api.id(7873693216270542)
,p_seq=>10
,p_name=>'New'
,p_location=>'REGION_SOURCE'
,p_items_value_column_name=>'VALOR'
,p_items_label_column_name=>'LABEL'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(13019910451693317)
,p_plug_name=>'ULTIMOS INGRESOS'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(3116822328915215)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT S.ORDEN,O.FECHA,O.PROV,O.REMITO,S.BOBINAS,S.KILOS ',
'FROM (SELECT ORDEN_INGRESO ORDEN,COUNT(ID) BOBINAS, SUM(PESO) KILOS ',
'	FROM BOB ',
'	GROUP BY ORDEN_INGRESO) S,BOB_ORDEN O ',
'	WHERE S.ORDEN = O.ID',
''))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>8.5
,p_prn_height=>11
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(4802395895338441)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'C'
,p_show_notify=>'Y'
,p_download_formats=>'CSV:HTML:EMAIL:XLS:PDF:RTF'
,p_detail_link=>'f?p=&APP_ID.:314:&SESSION.::&DEBUG.:RP,314:P314_ORDEN:#ORDEN#'
,p_detail_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-view.png" class="apex-edit-view" alt="">'
,p_owner=>'CESAR'
,p_internal_uid=>4802395895338441
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4802614744338444)
,p_db_column_name=>'FECHA'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Fecha'
,p_column_type=>'DATE'
,p_column_alignment=>'CENTER'
,p_tz_dependent=>'N'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4803084251338448)
,p_db_column_name=>'PROV'
,p_display_order=>40
,p_column_identifier=>'G'
,p_column_label=>'Prov'
,p_column_type=>'NUMBER'
,p_display_text_as=>'LOV_ESCAPE_SC'
,p_column_alignment=>'RIGHT'
,p_rpt_named_lov=>wwv_flow_api.id(6063612945635258)
,p_rpt_show_filter_lov=>'1'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(4803143162338449)
,p_db_column_name=>'REMITO'
,p_display_order=>50
,p_column_identifier=>'H'
,p_column_label=>'Remito'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(7992452670702002)
,p_db_column_name=>'ORDEN'
,p_display_order=>60
,p_column_identifier=>'K'
,p_column_label=>'Orden'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(7992527355702003)
,p_db_column_name=>'BOBINAS'
,p_display_order=>70
,p_column_identifier=>'L'
,p_column_label=>'Bobinas'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(7992697375702004)
,p_db_column_name=>'KILOS'
,p_display_order=>80
,p_column_identifier=>'M'
,p_column_label=>'Kilos'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(7991722464692451)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'79918'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ORDEN:FECHA:PROV:REMITO::BOBINAS:KILOS'
,p_sort_column_1=>'ORDEN'
,p_sort_direction_1=>'DESC NULLS LAST'
,p_sort_column_2=>'0'
,p_sort_direction_2=>'ASC'
,p_sort_column_3=>'0'
,p_sort_direction_3=>'ASC'
,p_sort_column_4=>'0'
,p_sort_direction_4=>'ASC'
,p_sort_column_5=>'0'
,p_sort_direction_5=>'ASC'
,p_sort_column_6=>'0'
,p_sort_direction_6=>'ASC'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(7871513426270532)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(13019910451693317)
,p_button_name=>'NUEVA'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--success'
,p_button_template_id=>wwv_flow_api.id(3140004793915261)
,p_button_image_alt=>'Nueva'
,p_button_position=>'RIGHT_OF_IR_SEARCH_BAR'
,p_button_redirect_url=>'f?p=&APP_ID.:311:&SESSION.::&DEBUG.:RP,311,312,313::'
,p_icon_css_classes=>'fa-truck'
);
end;
/
prompt --application/pages/delete_00311
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>311);
end;
/
prompt --application/pages/page_00311
begin
wwv_flow_api.create_page(
 p_id=>311
,p_user_interface_id=>wwv_flow_api.id(3150912767915327)
,p_name=>'Bobinas w1'
,p_alias=>'BOB_W1'
,p_page_mode=>'MODAL'
,p_step_title=>'Ingreso de Papel'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title=>'Bobinas w1'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(5973192580485747)
,p_inline_css=>'#BREADZERO{ DISPLAY: none;}'
,p_step_template=>wwv_flow_api.id(3105040668915190)
,p_page_template_options=>'#DEFAULT#'
,p_dialog_height=>'400'
,p_last_updated_by=>'CESAR'
,p_last_upd_yyyymmddhh24miss=>'20180915142135'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10095258800268185)
,p_plug_name=>'Wizard Progress'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(3107368288915203)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_list_id=>wwv_flow_api.id(7884033555289063)
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(3138982574915255)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10095392225268185)
,p_plug_name=>'Proveedor'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(3107368288915203)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10095466260268185)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(3107709176915203)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(7879476541289016)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(10095466260268185)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(3140172613915263)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(7879071015289016)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(10095466260268185)
,p_button_name=>'NEXT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(3140270662915263)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Next'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_icon_css_classes=>'fa-chevron-right'
,p_grid_new_grid=>false
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(7883132110289024)
,p_branch_name=>'Go To w2'
,p_branch_action=>'f?p=&APP_ID.:312:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(7879071015289016)
,p_branch_sequence=>20
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7880114287289017)
,p_name=>'P311_PROVEEDOR'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(10095392225268185)
,p_prompt=>'Proveedor'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PROV_PAPEL_ACTIVO'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select PROV as d,',
'       ID as r',
'  from BOB_PROV',
'  where activo = ''S''',
' order by 1'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'nuevo...'
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(3139618903915258)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--xlarge'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7880465302289019)
,p_name=>'P311_FECHA'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(10095392225268185)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SYSDATE',
''))
,p_item_default_type=>'PLSQL_EXPRESSION'
,p_prompt=>'Fecha'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>10
,p_field_template=>wwv_flow_api.id(3139618903915258)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--xlarge'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7880835991289020)
,p_name=>'P311_REMITO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(10095392225268185)
,p_prompt=>'Remito'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>10
,p_cMaxlength=>10
,p_field_template=>wwv_flow_api.id(3139618903915258)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--xlarge'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7882187386289023)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(7879476541289016)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7882663097289023)
,p_event_id=>wwv_flow_api.id(7882187386289023)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7881247522289021)
,p_name=>'New'
,p_event_sequence=>20
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7881776027289022)
,p_event_id=>wwv_flow_api.id(7881247522289021)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(',
'        p_collection_name => ''W1'');'))
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
end;
/
prompt --application/pages/delete_00312
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>312);
end;
/
prompt --application/pages/page_00312
begin
wwv_flow_api.create_page(
 p_id=>312
,p_user_interface_id=>wwv_flow_api.id(3150912767915327)
,p_name=>'Bobinas w2'
,p_alias=>'BOB_W2'
,p_page_mode=>'MODAL'
,p_step_title=>'Ingreso de Papel'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title=>'Bobinas w2'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(5973192580485747)
,p_inline_css=>'#BREADZERO{ DISPLAY: none;}'
,p_step_template=>wwv_flow_api.id(3105040668915190)
,p_page_template_options=>'#DEFAULT#'
,p_dialog_height=>'400'
,p_last_updated_by=>'CESAR'
,p_last_upd_yyyymmddhh24miss=>'20180915143329'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12783147114580445)
,p_plug_name=>'Wizard Progress'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(3107368288915203)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(3138982574915255)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12783201584580445)
,p_plug_name=>'Remito'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(3107368288915203)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12704872354199790)
,p_plug_name=>'ENTRY'
,p_parent_plug_id=>wwv_flow_api.id(12783201584580445)
,p_region_template_options=>'#DEFAULT#:t-Region--noPadding:t-Region--removeHeader:t-Region--noBorder:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(3117357289915216)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(12704886054199791)
,p_name=>'LISTA'
,p_parent_plug_id=>wwv_flow_api.id(12783201584580445)
,p_template=>wwv_flow_api.id(3107368288915203)
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'SEQ_ID,',
'N001 AS TIPO_ID,',
'N002 AS FORMATO,',
'N003 AS GRAMAJE,',
'N004 AS CANT',
' FROM APEX_COLLECTIONS',
'WHERE COLLECTION_NAME = ''W1'''))
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(3127301024915232)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7893601580298448)
,p_query_column_id=>1
,p_column_alias=>'SEQ_ID'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7892063266298444)
,p_query_column_id=>2
,p_column_alias=>'TIPO_ID'
,p_column_display_sequence=>2
,p_column_heading=>'Tipo'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7892410792298447)
,p_query_column_id=>3
,p_column_alias=>'FORMATO'
,p_column_display_sequence=>3
,p_column_heading=>'Formato'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7892886288298447)
,p_query_column_id=>4
,p_column_alias=>'GRAMAJE'
,p_column_display_sequence=>4
,p_column_heading=>'Gramaje'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7893286551298448)
,p_query_column_id=>5
,p_column_alias=>'CANT'
,p_column_display_sequence=>1
,p_column_heading=>'Cant'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(12783322782580445)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(3107709176915203)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(7891005062298442)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(12783322782580445)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(3140172613915263)
,p_button_image_alt=>'Cancel'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(7894371188298450)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(12704872354199790)
,p_button_name=>'ADD'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(3140004793915261)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Agregar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-cart-arrow-down'
,p_button_cattributes=>'STYLE="margin-top:10px;"'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(7890602782298441)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(12783322782580445)
,p_button_name=>'BORRAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(3140172613915263)
,p_button_image_alt=>'Borrar'
,p_button_position=>'REGION_TEMPLATE_DELETE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(7890230751298441)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(12783322782580445)
,p_button_name=>'NEXT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(3140270662915263)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Siguiente'
,p_button_position=>'REGION_TEMPLATE_NEXT'
,p_icon_css_classes=>'fa-chevron-right'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(7889844377298440)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(12783322782580445)
,p_button_name=>'PREVIOUS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(3140004793915261)
,p_button_image_alt=>'Previous'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_execute_validations=>'N'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(7902391658298465)
,p_branch_name=>'Go To w3'
,p_branch_action=>'f?p=&APP_ID.:313:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(7890230751298441)
,p_branch_sequence=>20
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(7901963693298464)
,p_branch_name=>'Back to w1'
,p_branch_action=>'f?p=&APP_ID.:311:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'BEFORE_VALIDATION'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(7889844377298440)
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7894708091298450)
,p_name=>'P312_TIPO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(12704872354199790)
,p_prompt=>'TipoPapel'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_TIPO_PAPEL'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select TIPO_PAPEL as d,',
'       ID as r',
'  from BOB_TIPO',
' order by 1'))
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7895110227298452)
,p_name=>'P312_GRAMAJE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(12704872354199790)
,p_prompt=>'Gramaje'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>10
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7895585969298453)
,p_name=>'P312_FORMATO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(12704872354199790)
,p_prompt=>'Formato'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>10
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7895908138298453)
,p_name=>'P312_CANTIDAD'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(12704872354199790)
,p_prompt=>'Cantidad'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>10
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7899533957298461)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(7891005062298442)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7900027052298462)
,p_event_id=>wwv_flow_api.id(7899533957298461)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7898107229298460)
,p_name=>'New'
,p_event_sequence=>30
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(12704886054199791)
,p_bind_type=>'bind'
,p_bind_event_type=>'custom'
,p_bind_event_type_custom=>'BItEvent'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7899181965298461)
,p_event_id=>wwv_flow_api.id(7898107229298460)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'APEX_COLLECTION.DELETE_MEMBER (''W1'',''1'');',
''))
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7898632071298460)
,p_event_id=>wwv_flow_api.id(7898107229298460)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(12704886054199791)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7896731504298456)
,p_name=>'AddItem'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(7894371188298450)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7897293116298458)
,p_event_id=>wwv_flow_api.id(7896731504298456)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'apex_collection.add_member(',
'p_collection_name => ''w1'',',
'p_n001 => :P312_TIPO,',
'p_n002 => :p312_formato,',
'p_n003 => :p312_gramaje,',
'p_n004 => :p312_cantidad);',
'   '))
,p_attribute_02=>'P312_TIPO,P312_FORMATO,P312_GRAMAJE,P312_CANTIDAD'
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7897705090298459)
,p_event_id=>wwv_flow_api.id(7896731504298456)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(12704886054199791)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7900419517298462)
,p_name=>'New_1'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(7890602782298441)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7900900538298463)
,p_event_id=>wwv_flow_api.id(7900419517298462)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(',
'        p_collection_name => ''W1'');'))
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7901480250298463)
,p_event_id=>wwv_flow_api.id(7900419517298462)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(12704886054199791)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(7896341872298454)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'New'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    v_id number;',
'    ',
'    CURSOR CX IS',
'    SELECT n001 as tipo,n002 as formato,n003 as gramaje ,n004 as cant ',
'		from apex_collections where collection_name = ''W1'';',
'    ',
'    item cx%ROWTYPE;',
'    ',
'    ',
'BEGIN',
'',
'    APEX_COLLECTION.CREATE_OR_TRUNCATE_COLLECTION(',
'        p_collection_name => ''w2'');',
'   ',
'',
'    select max(id) into v_id from bob;',
'',
'    OPEN CX;',
'    ',
'    LOOP',
'        FETCH CX into item;',
'        EXIT WHEN CX%NOTFOUND;',
'',
'        FOR counter IN 1..item.cant LOOP',
'        ',
'        v_id := v_id + 1;',
'        APEX_COLLECTION.ADD_MEMBER( ',
'           p_collection_name => ''w2'',',
'           p_n001 => v_id,',
'           p_n002 => item.tipo,',
'           p_n003 => item.formato,',
'           p_n004 => item.gramaje',
'        );',
'        ',
'        END LOOP;',
'',
'   END LOOP;',
'   CLOSE CX;',
'end;'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/delete_00313
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>313);
end;
/
prompt --application/pages/page_00313
begin
wwv_flow_api.create_page(
 p_id=>313
,p_user_interface_id=>wwv_flow_api.id(3150912767915327)
,p_name=>'Bobinas w3'
,p_alias=>'BOB_W3'
,p_page_mode=>'MODAL'
,p_step_title=>'Ingreso de Papel'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title=>'Bobinas w3'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(5973192580485747)
,p_inline_css=>'#BREADZERO{ DISPLAY: none;}'
,p_step_template=>wwv_flow_api.id(3105040668915190)
,p_page_template_options=>'#DEFAULT#'
,p_dialog_height=>'400'
,p_last_updated_by=>'CESAR'
,p_last_upd_yyyymmddhh24miss=>'20180915143844'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10147221824288858)
,p_plug_name=>'Wizard Progress'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(3107368288915203)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_plug_source_type=>'NATIVE_LIST'
,p_list_template_id=>wwv_flow_api.id(3138982574915255)
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10147229718288858)
,p_plug_name=>'wEtiquetas'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(3116822328915215)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>'select n001 as id,n002 as tipo,n003 as formato,n004 as gramaje from apex_collections where collection_name = ''W2'''
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(14406472701330470)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_show_search_bar=>'N'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_owner=>'CESAR'
,p_internal_uid=>14406472701330470
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(7911544008309662)
,p_db_column_name=>'ID'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(7911996590309668)
,p_db_column_name=>'TIPO'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Tipo'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(7912383528309668)
,p_db_column_name=>'FORMATO'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Formato'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(7912794253309669)
,p_db_column_name=>'GRAMAJE'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Gramaje'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(15665091813355027)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'79131'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'ID:TIPO:FORMATO:GRAMAJE'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10147370707288858)
,p_plug_name=>'Buttons'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(3107709176915203)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_03'
,p_attribute_01=>'N'
,p_attribute_02=>'TEXT'
,p_attribute_03=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(7909644958309647)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(10147370707288858)
,p_button_name=>'CANCEL'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(3140172613915263)
,p_button_image_alt=>'Cancelar'
,p_button_position=>'REGION_TEMPLATE_CLOSE'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(7910807282309648)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(10147370707288858)
,p_button_name=>'FINISH'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(3140172613915263)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Terminar'
,p_button_position=>'REGION_TEMPLATE_NEXT'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(7910082645309648)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(10147370707288858)
,p_button_name=>'PREVIOUS'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(3140004793915261)
,p_button_image_alt=>'Anterior'
,p_button_position=>'REGION_TEMPLATE_PREVIOUS'
,p_button_execute_validations=>'N'
,p_icon_css_classes=>'fa-chevron-left'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(7916249567309683)
,p_branch_name=>'Back to w2'
,p_branch_action=>'f?p=&APP_ID.:312:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(7910082645309648)
,p_branch_sequence=>10
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(7916620436309684)
,p_branch_name=>'finish'
,p_branch_action=>'f?p=&APP_ID.:314:&SESSION.::&DEBUG.:RP,314:P314_ORDEN:&P313_ORDEN.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(7910807282309648)
,p_branch_sequence=>10
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(4802210129338440)
,p_name=>'P313_ORDEN'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(10147229718288858)
,p_display_as=>'NATIVE_HIDDEN'
,p_warn_on_unsaved_changes=>'I'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7914390642309681)
,p_name=>'Cancel Dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(7909644958309647)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7914856539309682)
,p_event_id=>wwv_flow_api.id(7914390642309681)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CANCEL'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(7913977087309680)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'GENERAR_BOBINAS'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'	V_ORDEN NUMBER;',
'',
'	CURSOR CX IS',
'		SELECT n001 tipo,n002 formato,n003 gramaje ,n004 cant ',
'			from apex_collections ',
'			where collection_name = ''W1'';',
'	item cx%ROWTYPE;',
'',
'BEGIN',
'	INSERT INTO BOB_ORDEN (PROV,REMITO,FECHA)',
'		VALUES (:P311_PROVEEDOR,:P311_REMITO,:P311_FECHA)',
'		RETURNING ID into V_ORDEN;',
'',
'	OPEN CX;',
'	LOOP FETCH CX into item;',
'		EXIT WHEN CX%NOTFOUND;',
'',
'		FOR I IN 1..item.cant LOOP',
'			INSERT INTO BOB(TIPO,FORMATO,GRAMAJE,ORDEN_INGRESO)',
'				VALUES(item.tipo,item.formato,item.gramaje,V_ORDEN);',
'		END LOOP;	 ',
'	END LOOP;',
'	CLOSE CX;',
'    :P313_ORDEN := V_ORDEN;',
'END;   ',
''))
,p_process_error_message=>'error en cargar'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(7910807282309648)
,p_process_success_message=>'BOBINAS CARGADAS OK!'
);
end;
/
prompt --application/pages/delete_00314
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>314);
end;
/
prompt --application/pages/page_00314
begin
wwv_flow_api.create_page(
 p_id=>314
,p_user_interface_id=>wwv_flow_api.id(3150912767915327)
,p_name=>'BOBINAS INGRESO'
,p_alias=>'BOB_ORDEN_X'
,p_step_title=>'BOBINAS INGRESO'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title=>'BOBINAS INGRESO'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(5973192580485747)
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'CESAR'
,p_last_upd_yyyymmddhh24miss=>'20180915144439'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10717682021309548)
,p_plug_name=>'Orden de Ingreso &P314_ORDEN.'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(3117357289915216)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10795624919226449)
,p_plug_name=>'COMPRAS_ORDEN'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--textContent:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(3117357289915216)
,p_plug_display_sequence=>20
,p_plug_display_point=>'BODY_3'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ID,',
'       TIPO,',
'       FORMATO,',
'       GRAMAJE,',
'       PESO,',
'       DIAMETRO,',
'       PSTOCK,',
'       ESTADO,',
'       ORDEN_INGRESO',
'  from BOB',
'where ORDEN_INGRESO = :P314_ORDEN',
''))
,p_plug_source_type=>'NATIVE_IG'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(10718248235309554)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(10718375067309555)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(10796831817226454)
,p_name=>'ROWID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ROWID'
,p_data_type=>'ROWID'
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_pivot=>false
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(10797492170226459)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Id'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>40
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(10798067765226460)
,p_name=>'TIPO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TIPO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Tipo'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>50
,p_value_alignment=>'RIGHT'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(10798629262226461)
,p_name=>'FORMATO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FORMATO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Formato'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>60
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(10799253975226462)
,p_name=>'GRAMAJE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'GRAMAJE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Gramaje'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>70
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(10799893227226463)
,p_name=>'PESO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PESO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Peso'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>80
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(10800497178226464)
,p_name=>'DIAMETRO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DIAMETRO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Diametro'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>90
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'right'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(10801038972226465)
,p_name=>'PSTOCK'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PSTOCK'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_PCT_GRAPH'
,p_heading=>'Pstock'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>100
,p_value_alignment=>'RIGHT'
,p_attribute_01=>'Y'
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(10801701438226466)
,p_name=>'ESTADO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ESTADO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Estado'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>110
,p_value_alignment=>'RIGHT'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_api.create_region_column(
 p_id=>wwv_flow_api.id(10802260661226466)
,p_name=>'ORDEN_INGRESO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ORDEN_INGRESO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>120
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_pivot=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_api.create_interactive_grid(
 p_id=>wwv_flow_api.id(10796182183226450)
,p_internal_uid=>10796182183226450
,p_is_editable=>true
,p_edit_operations=>'u'
,p_lost_update_check_type=>'VALUES'
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_show_nulls_as=>'-'
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>false
,p_show_toolbar=>true
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_download=>false
,p_download_formats=>null
,p_fixed_header=>'NONE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_api.create_ig_report(
 p_id=>wwv_flow_api.id(10796576706226451)
,p_interactive_grid_id=>wwv_flow_api.id(10796182183226450)
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_api.create_ig_report_view(
 p_id=>wwv_flow_api.id(10796616741226451)
,p_report_id=>wwv_flow_api.id(10796576706226451)
,p_view_type=>'GRID'
,p_stretch_columns=>false
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(10797243463226457)
,p_view_id=>wwv_flow_api.id(10796616741226451)
,p_display_seq=>1
,p_column_id=>wwv_flow_api.id(10796831817226454)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(10797900301226460)
,p_view_id=>wwv_flow_api.id(10796616741226451)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(10797492170226459)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>93
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(10798417632226461)
,p_view_id=>wwv_flow_api.id(10796616741226451)
,p_display_seq=>3
,p_column_id=>wwv_flow_api.id(10798067765226460)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>108
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(10799063678226462)
,p_view_id=>wwv_flow_api.id(10796616741226451)
,p_display_seq=>4
,p_column_id=>wwv_flow_api.id(10798629262226461)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>107
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(10799616994226463)
,p_view_id=>wwv_flow_api.id(10796616741226451)
,p_display_seq=>5
,p_column_id=>wwv_flow_api.id(10799253975226462)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>110
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(10800241805226464)
,p_view_id=>wwv_flow_api.id(10796616741226451)
,p_display_seq=>6
,p_column_id=>wwv_flow_api.id(10799893227226463)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>101
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(10800880273226465)
,p_view_id=>wwv_flow_api.id(10796616741226451)
,p_display_seq=>7
,p_column_id=>wwv_flow_api.id(10800497178226464)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>102
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(10801478628226465)
,p_view_id=>wwv_flow_api.id(10796616741226451)
,p_display_seq=>8
,p_column_id=>wwv_flow_api.id(10801038972226465)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>163
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(10802009085226466)
,p_view_id=>wwv_flow_api.id(10796616741226451)
,p_display_seq=>9
,p_column_id=>wwv_flow_api.id(10801701438226466)
,p_is_visible=>false
,p_is_frozen=>false
,p_width=>111
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(10802629390226467)
,p_view_id=>wwv_flow_api.id(10796616741226451)
,p_display_seq=>10
,p_column_id=>wwv_flow_api.id(10802260661226466)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_ig_report_column(
 p_id=>wwv_flow_api.id(10809156586320806)
,p_view_id=>wwv_flow_api.id(10796616741226451)
,p_display_seq=>0
,p_column_id=>wwv_flow_api.id(10718248235309554)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(7934674050841872)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(10717682021309548)
,p_button_name=>'ELIMINAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--iconLeft:t-Button--pillStart'
,p_button_template_id=>wwv_flow_api.id(3140270662915263)
,p_button_image_alt=>'Eliminar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_condition=>'SELECT 1 FROM BOB_USO WHERE BOBINA IN(SELECT ID FROM BOB WHERE ORDEN_INGRESO = :P314_ORDEN)'
,p_button_condition_type=>'NOT_EXISTS'
,p_icon_css_classes=>'fa-times-circle'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(7935087442841873)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(10717682021309548)
,p_button_name=>'GUARDAR'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--iconRight:t-Button--pillEnd:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(3140270662915263)
,p_button_image_alt=>'Guardar'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_icon_css_classes=>'fa-floppy-o'
,p_database_action=>'UPDATE'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(7934221002841872)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(10717682021309548)
,p_button_name=>'PLANILLA'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconRight:t-Button--pillStart'
,p_button_template_id=>wwv_flow_api.id(3140270662915263)
,p_button_image_alt=>'Planilla'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:315:&SESSION.::&DEBUG.:315,RIR:P315_ID:&P314_ORDEN.'
,p_icon_css_classes=>'fa-print'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(7933826273841870)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(10717682021309548)
,p_button_name=>'ETIQUETAS'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--primary:t-Button--iconRight:t-Button--pillEnd'
,p_button_template_id=>wwv_flow_api.id(3140270662915263)
,p_button_image_alt=>'Etiquetas'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:316:&SESSION.::&DEBUG.:316,RIR:P316_ID:&P314_ORDEN.'
,p_icon_css_classes=>'fa-print'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(7937930087841879)
,p_branch_name=>'Back to Page 310'
,p_branch_action=>'f?p=&APP_ID.:310:&SESSION.::&DEBUG.:RP,310::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_api.id(7934674050841872)
,p_branch_sequence=>20
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7935412928841874)
,p_name=>'P314_ORDEN'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(10717682021309548)
,p_use_cache_before_default=>'NO'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7935862578841876)
,p_name=>'P314_PROV'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(10717682021309548)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Provedor'
,p_source=>'PROV'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PROV_PAPEL_HISTORICO'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select PROV as d,',
'       ID as r',
'  from BOB_PROV',
' order by 1'))
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(3139618903915258)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7936287820841876)
,p_name=>'P314_REMITO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(10717682021309548)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Remito'
,p_source=>'REMITO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>10
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(3139618903915258)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7936675820841878)
,p_name=>'P314_FECHA'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(10717682021309548)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Fecha'
,p_source=>'FECHA'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>10
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_grid_label_column_span=>1
,p_field_template=>wwv_flow_api.id(3139618903915258)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(7933166485841860)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(10795624919226449)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'COMPRAS_ORDEN - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(7937466164841879)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'New_1'
,p_process_sql_clob=>'DELETE BOB_ORDEN WHERE ID = :P314_ORDEN;'
,p_process_error_message=>'No se Puede Borrar'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(7934674050841872)
,p_process_success_message=>'Orden de Compra Eliminada'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(7937009915841878)
,p_process_sequence=>10
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'New'
,p_attribute_02=>'BOB_ORDEN'
,p_attribute_03=>'P314_ORDEN'
,p_attribute_04=>'ID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/delete_00315
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>315);
end;
/
prompt --application/pages/page_00315
begin
wwv_flow_api.create_page(
 p_id=>315
,p_user_interface_id=>wwv_flow_api.id(3150912767915327)
,p_name=>'PRINT_PLANILLA'
,p_alias=>'BOB_PRINT_PLANILLA'
,p_step_title=>'PRINT_PLANILLA'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title=>'PRINT_PLANILLA'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(5973192580485747)
,p_step_template=>wwv_flow_api.id(7955757788955595)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_browser_cache=>'N'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'CESAR'
,p_last_upd_yyyymmddhh24miss=>'20180915145447'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10870315874572200)
,p_plug_name=>'&P315_ID.'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(3117357289915216)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>'BOB_PRINT.planilla(:P315_ID);'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7947670580906400)
,p_name=>'P315_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(10870315874572200)
,p_use_cache_before_default=>'NO'
,p_source=>'0'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
end;
/
prompt --application/pages/delete_00316
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>316);
end;
/
prompt --application/pages/page_00316
begin
wwv_flow_api.create_page(
 p_id=>316
,p_user_interface_id=>wwv_flow_api.id(3150912767915327)
,p_name=>'PRINT_ETIQUETA'
,p_alias=>'BOB_PRINT_ETIQ'
,p_step_title=>'PRINT_ETIQUETA'
,p_reload_on_submit=>'A'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title=>'PRINT_ETIQUETA'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(5973192580485747)
,p_step_template=>wwv_flow_api.id(7955471688955550)
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_browser_cache=>'N'
,p_help_text=>'No help is available for this page.'
,p_last_updated_by=>'CESAR'
,p_last_upd_yyyymmddhh24miss=>'20180915145436'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(13882858641913753)
,p_plug_name=>'&P316_ID.'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(3107368288915203)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_source=>'BOB_PRINT.ETIQUETAS(:P316_ID);'
,p_plug_source_type=>'NATIVE_PLSQL'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7950505911915456)
,p_name=>'P316_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(13882858641913753)
,p_use_cache_before_default=>'NO'
,p_source=>'0'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
end;
/
prompt --application/pages/delete_00330
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>330);
end;
/
prompt --application/pages/page_00330
begin
wwv_flow_api.create_page(
 p_id=>330
,p_user_interface_id=>wwv_flow_api.id(3150912767915327)
,p_name=>'RESUMEN STOCK'
,p_step_title=>'RESUMEN STOCK'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title=>'RESUMEN STOCK'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(5973192580485747)
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'CESAR'
,p_last_upd_yyyymmddhh24miss=>'20180915164800'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(9880541175277211)
,p_plug_name=>'STOCK'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(3117357289915216)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'    ROUND(sum(PESO * PSTOCK) / 100) as valor,',
'    ''KILOS'' as label from BOB ',
'    WHERE ESTADO between 0 and 2 ',
'UNION ',
'select ',
'    COUNT(ID) as valor,',
'    ''BOBINAS ENTERAS'' as label ',
'    from BOB WHERE ESTADO = 1 ',
'UNION ',
'select ',
'    COUNT(ID) as valor,',
'    ''BOBINAS USADAS'' as label ',
'    from BOB WHERE ESTADO = 2 ',
'ORDER BY 1 DESC'))
,p_plug_source_type=>'PLUGIN_COM.ORACLE.APEX.BADGE_LIST'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'LABEL'
,p_attribute_02=>'VALOR'
,p_attribute_04=>'f?p=&APP_ID.:10:&SESSION.::&DEBUG.:RP::'
,p_attribute_05=>'0'
,p_attribute_07=>'BOX'
,p_attribute_08=>'Y'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(9880586398277212)
,p_plug_name=>'COMPRAS &P1_YEAR.'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(3117357289915216)
,p_plug_display_sequence=>30
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1,TO_CHAR(COUNT(ID)) as valor,''ENTREGAS RECIBIDAS'' as label from BOB_ORDEN ',
'WHERE EXTRACT(YEAR FROM FECHA) = EXTRACT(YEAR FROM SYSDATE)',
'',
'UNION ',
'',
'select 3,',
'TO_CHAR(sum(B.PESO),''999G999G990'') as valor,',
'''COMPRAS '' || EXTRACT(YEAR FROM SYSDATE) as label from BOB B,BOB_ORDEN O ',
'WHERE B.ORDEN_INGRESO = O.ID',
'AND EXTRACT(YEAR FROM O.FECHA) = EXTRACT(YEAR FROM SYSDATE)',
'',
'',
'ORDER BY 1'))
,p_plug_source_type=>'PLUGIN_COM.ORACLE.APEX.BADGE_LIST'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'LABEL'
,p_attribute_02=>'VALOR'
,p_attribute_04=>'f?p=&APP_ID.:12:&SESSION.::&DEBUG.:RP::'
,p_attribute_05=>'0'
,p_attribute_07=>'BOX'
,p_attribute_08=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(10506592288826626)
,p_plug_name=>'CORRUGADO &P1_YEAR.'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_escape_on_http_output=>'Y'
,p_plug_template=>wwv_flow_api.id(3117357289915216)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1, TO_CHAR(COUNT(DISTINCT FECHA)) as valor,''DIAS CORRUGADOS'' as label from BOB_USO  U',
'WHERE  EXTRACT(YEAR FROM FECHA) = EXTRACT(YEAR FROM SYSDATE)',
'/*',
'UNION ',
'',
'select 2,ROUND(sum(B.PESO * U.USO / U.REND /B.GRAMAJE/B.FORMATO * 1000 / 3 )) as valor,''METROS LINEALES'' as label from BOB B,BOB_USO U ',
'WHERE B.ID = U.BOBINA',
'AND  EXTRACT(YEAR FROM FECHA) = EXTRACT(YEAR FROM SYSDATE)',
'',
'UNION ',
'',
'select 3, ROUND(sum(B.PESO * U.USO /U.REND /B.GRAMAJE * 10 / 3)) as valor,''METROS CUADRADOS'' as label from BOB B,BOB_USO U ',
'WHERE B.ID = U.BOBINA',
'AND  EXTRACT(YEAR FROM FECHA) = EXTRACT(YEAR FROM SYSDATE)',
'*/',
'UNION ',
'',
'select 4, TO_CHAR(sum(B.PESO * U.USO / 100),''999G999G990'') as valor,''KILOS'' as label from BOB B,BOB_USO U ',
'WHERE B.ID = U.BOBINA',
'AND  EXTRACT(YEAR FROM FECHA) = EXTRACT(YEAR FROM SYSDATE)',
'',
'ORDER BY 1',
'',
' ',
'',
'',
'',
''))
,p_plug_source_type=>'PLUGIN_COM.ORACLE.APEX.BADGE_LIST'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'LABEL'
,p_attribute_02=>'VALOR'
,p_attribute_04=>'f?p=&APP_ID.:12:&SESSION.::&DEBUG.:RP::'
,p_attribute_05=>'0'
,p_attribute_07=>'BOX'
,p_attribute_08=>'N'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(11515954927414914)
,p_plug_name=>'Monetizado'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(3116822328915215)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ID ,KEY ,TIPO_PAPEL ,',
'    BOB_PKG.PRECIOPAPEL(ID) PRECIO, ',
'    BOB_PKG.STOCK(ID) KILOS ',
'    FROM BOB_TIPO;'))
,p_plug_source_type=>'NATIVE_IR'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
);
wwv_flow_api.create_worksheet(
 p_id=>wwv_flow_api.id(11516324829414917)
,p_max_row_count=>'1000000'
,p_show_nulls_as=>'-'
,p_show_search_bar=>'N'
,p_report_list_mode=>'TABS'
,p_show_detail_link=>'N'
,p_owner=>'CESAR'
,p_internal_uid=>11516324829414917
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(7968819693013856)
,p_db_column_name=>'TIPO_PAPEL'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Tipo Papel'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(7969209447013858)
,p_db_column_name=>'PRECIO'
,p_display_order=>30
,p_column_identifier=>'D'
,p_column_label=>'Precio'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'FML999G999G999G999G990D00'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(7969603753013859)
,p_db_column_name=>'ID'
,p_display_order=>40
,p_column_identifier=>'F'
,p_column_label=>'Id'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(7970069523013859)
,p_db_column_name=>'KEY'
,p_display_order=>50
,p_column_identifier=>'G'
,p_column_label=>'Key'
,p_column_type=>'STRING'
);
wwv_flow_api.create_worksheet_column(
 p_id=>wwv_flow_api.id(7970481573013860)
,p_db_column_name=>'KILOS'
,p_display_order=>60
,p_column_identifier=>'H'
,p_column_label=>'Kilos'
,p_column_type=>'NUMBER'
,p_column_alignment=>'RIGHT'
,p_format_mask=>'999G999G999G999G999G999G990'
);
wwv_flow_api.create_worksheet_rpt(
 p_id=>wwv_flow_api.id(14310270810649810)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'79708'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'KEY:TIPO_PAPEL:PRECIO:KILOS:APXWS_CC_001:'
,p_sum_columns_on_break=>'VALOR:APXWS_CC_001:KILOS'
);
wwv_flow_api.create_worksheet_computation(
 p_id=>wwv_flow_api.id(7971245210013863)
,p_report_id=>wwv_flow_api.id(14310270810649810)
,p_db_column_name=>'APXWS_CC_001'
,p_column_identifier=>'C01'
,p_computation_expr=>'H * D'
,p_format_mask=>'FML999G999G999G999G990'
,p_column_type=>'NUMBER'
,p_column_label=>'VALOR'
,p_report_label=>'VALOR'
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(7972675540013866)
,p_branch_action=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.:RP,1,2:P2_ID:&P1_SEARCH.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_api.create_page_branch(
 p_id=>wwv_flow_api.id(7973011393013867)
,p_branch_action=>'f?p=&APP_ID.:2:&SESSION.::&DEBUG.:RP:P2_ID:&P1_SEARCH.&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>20
);
end;
/
prompt --application/pages/delete_00300
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>300);
end;
/
prompt --application/pages/page_00300
begin
wwv_flow_api.create_page(
 p_id=>300
,p_user_interface_id=>wwv_flow_api.id(3150912767915327)
,p_name=>'BOBINAS'
,p_step_title=>'BOBINAS'
,p_step_sub_title=>'STOCK_PAPEL'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(5973192580485747)
,p_step_template=>wwv_flow_api.id(3104264969915190)
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'CESAR'
,p_last_upd_yyyymmddhh24miss=>'20180919205657'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(2996567774730273)
,p_plug_name=>'Stock de Bobinas'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(3117357289915216)
,p_plug_display_sequence=>10
,p_plug_display_point=>'BODY'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT T.ID AS TIPO, T.TIPO_PAPEL, B.FORMATO ,  B.KILOS ',
'  FROM  ( ',
'    SELECT FORMATO , TIPO , SUM(PESO * PSTOCK / 100) AS KILOS ',
'      FROM BOB  ',
'      WHERE ESTADO IN (1,2)',
'      GROUP BY FORMATO,TIPO',
'      ORDER BY FORMATO,TIPO) B, BOB_TIPO T',
'  WHERE B.TIPO = T.ID'))
,p_plug_source_type=>'NATIVE_JET_CHART'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
);
wwv_flow_api.create_jet_chart(
 p_id=>wwv_flow_api.id(2996986451730275)
,p_region_id=>wwv_flow_api.id(2996567774730273)
,p_chart_type=>'bar'
,p_height=>'600'
,p_animation_on_display=>'auto'
,p_animation_on_data_change=>'auto'
,p_orientation=>'vertical'
,p_data_cursor=>'auto'
,p_data_cursor_behavior=>'auto'
,p_hide_and_show_behavior=>'withRescale'
,p_hover_behavior=>'dim'
,p_stack=>'on'
,p_sorting=>'label-asc'
,p_fill_multi_series_gaps=>true
,p_zoom_and_scroll=>'off'
,p_tooltip_rendered=>'Y'
,p_show_series_name=>true
,p_show_group_name=>true
,p_show_value=>true
,p_show_label=>true
,p_legend_rendered=>'on'
,p_legend_position=>'top'
);
wwv_flow_api.create_jet_chart_series(
 p_id=>wwv_flow_api.id(2998698605730283)
,p_chart_id=>wwv_flow_api.id(2996986451730275)
,p_seq=>10
,p_name=>'Series 1'
,p_location=>'REGION_SOURCE'
,p_series_name_column_name=>'TIPO_PAPEL'
,p_items_value_column_name=>'KILOS'
,p_group_name_column_name=>'FORMATO'
,p_items_label_column_name=>'FORMATO'
,p_assigned_to_y2=>'off'
,p_items_label_rendered=>true
,p_items_label_position=>'auto'
,p_link_target=>'f?p=&APP_ID.:301:&SESSION.::&DEBUG.:RP:P301_FORMATO,P301_TIPO:&FORMATO.,&TIPO.'
,p_link_target_type=>'REDIRECT_PAGE'
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(2997413183730279)
,p_chart_id=>wwv_flow_api.id(2996986451730275)
,p_axis=>'x'
,p_is_rendered=>'on'
,p_baseline_scaling=>'zero'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>true
,p_zoom_order_weeks=>true
,p_zoom_order_months=>true
,p_zoom_order_quarters=>true
,p_zoom_order_years=>false
);
wwv_flow_api.create_jet_chart_axis(
 p_id=>wwv_flow_api.id(2998058320730282)
,p_chart_id=>wwv_flow_api.id(2996986451730275)
,p_axis=>'y'
,p_is_rendered=>'on'
,p_baseline_scaling=>'zero'
,p_position=>'auto'
,p_major_tick_rendered=>'auto'
,p_minor_tick_rendered=>'auto'
,p_tick_label_rendered=>'on'
,p_zoom_order_seconds=>false
,p_zoom_order_minutes=>false
,p_zoom_order_hours=>false
,p_zoom_order_days=>true
,p_zoom_order_weeks=>true
,p_zoom_order_months=>true
,p_zoom_order_quarters=>false
,p_zoom_order_years=>false
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4802081063338438)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(2996567774730273)
,p_button_name=>'INGRESO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--pillStart'
,p_button_template_id=>wwv_flow_api.id(3140172613915263)
,p_button_image_alt=>'Ingreso'
,p_button_position=>'REGION_TEMPLATE_COPY'
,p_button_redirect_url=>'f?p=&APP_ID.:310:&SESSION.::&DEBUG.:RP::'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4802131911338439)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(2996567774730273)
,p_button_name=>'ADD'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--success:t-Button--pillEnd:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(3140004793915261)
,p_button_image_alt=>'Add'
,p_button_position=>'REGION_TEMPLATE_COPY'
,p_icon_css_classes=>'fa-truck'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(4801922392338437)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(2996567774730273)
,p_button_name=>'CORRUGADO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(3140270662915263)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Corrugado'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:303:&SESSION.::&DEBUG.:RP::'
,p_icon_css_classes=>'fa-gears'
);
end;
/
prompt --application/pages/delete_00301
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>301);
end;
/
prompt --application/pages/page_00301
begin
wwv_flow_api.create_page(
 p_id=>301
,p_user_interface_id=>wwv_flow_api.id(3150912767915327)
,p_name=>'STOCK X FORMATO'
,p_page_mode=>'MODAL'
,p_step_title=>'STOCK X FORMATO'
,p_step_sub_title=>'STOCK X FORMATO'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(5973192580485747)
,p_inline_css=>'#BREADZERO { DISPLAY : NONE ; }'
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'CESAR'
,p_last_upd_yyyymmddhh24miss=>'20180831080201'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(5585965298972144)
,p_name=>'REPORT 1'
,p_template=>wwv_flow_api.id(3107368288915203)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ID,',
'       TIPO,',
'       FORMATO,',
'       GRAMAJE,',
'       PESO,',
'       BOB_PKG.DIAMETROACTUAL(ID) AS DIAMETRO,',
'       PSTOCK,',
'       ROUND(PSTOCK * PESO /FORMATO / GRAMAJE * 1000) AS METROS ',
'  from BOB',
'WHERE ESTADO IN (1,2) ',
'AND FORMATO = :P301_FORMATO',
'AND TIPO = :P301_TIPO'))
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(3127301024915232)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_no_data_found=>'No data found.'
,p_query_num_rows_type=>'NEXT_PREVIOUS_LINKS'
,p_query_row_count_max=>500
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'Y'
,p_prn_format=>'PDF'
,p_prn_output_link_text=>'Print'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_document_header=>'APEX'
,p_prn_units=>'MILLIMETERS'
,p_prn_paper_size=>'A4'
,p_prn_width_units=>'PERCENTAGE'
,p_prn_width=>210
,p_prn_height=>297
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#9bafde'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'normal'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#efefef'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(3004984686766065)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>1
,p_column_heading=>'Id'
,p_use_as_row_header=>'Y'
,p_default_sort_column_sequence=>1
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(3002123828766057)
,p_query_column_id=>2
,p_column_alias=>'TIPO'
,p_column_display_sequence=>2
,p_column_heading=>'Tipo'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_display_as=>'TEXT_FROM_LOV'
,p_named_lov=>wwv_flow_api.id(3682774705105897)
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(3002540737766061)
,p_query_column_id=>3
,p_column_alias=>'FORMATO'
,p_column_display_sequence=>3
,p_column_heading=>'Formato'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(3002920854766062)
,p_query_column_id=>4
,p_column_alias=>'GRAMAJE'
,p_column_display_sequence=>4
,p_column_heading=>'Gramaje'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(3003338225766063)
,p_query_column_id=>5
,p_column_alias=>'PESO'
,p_column_display_sequence=>5
,p_column_heading=>'Peso'
,p_use_as_row_header=>'N'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(3003769540766063)
,p_query_column_id=>6
,p_column_alias=>'DIAMETRO'
,p_column_display_sequence=>6
,p_column_heading=>'Diametro'
,p_use_as_row_header=>'N'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(3004117312766064)
,p_query_column_id=>7
,p_column_alias=>'PSTOCK'
,p_column_display_sequence=>8
,p_column_heading=>'Pstock'
,p_column_format=>'PCT_GRAPH:::'
,p_heading_alignment=>'LEFT'
,p_disable_sort_column=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(3004556260766064)
,p_query_column_id=>8
,p_column_alias=>'METROS'
,p_column_display_sequence=>7
,p_column_heading=>'Metros'
,p_use_as_row_header=>'N'
,p_column_alignment=>'RIGHT'
,p_disable_sort_column=>'N'
,p_sum_column=>'Y'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3005330488766072)
,p_name=>'P301_TIPO'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(5585965298972144)
,p_prompt=>'PAPEL'
,p_source=>'1'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_TIPO_PAPEL'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select TIPO_PAPEL as d,',
'       ID as r',
'  from BOB_TIPO',
' order by 1'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(3139618903915258)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--xlarge'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(3005796417766089)
,p_name=>'P301_FORMATO'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(5585965298972144)
,p_prompt=>'FORMATO'
,p_source=>'110'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(3139618903915258)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--xlarge'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
end;
/
prompt --application/pages/delete_00302
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>302);
end;
/
prompt --application/pages/page_00302
begin
wwv_flow_api.create_page(
 p_id=>302
,p_user_interface_id=>wwv_flow_api.id(3150912767915327)
,p_name=>'DETALLE BOBINA'
,p_page_mode=>'MODAL'
,p_step_title=>'DETALLE BOBINA'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title=>'DETALLE BOBINA'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(5973192580485747)
,p_inline_css=>'#BREADZERO{ DISPLAY: none;}'
,p_page_template_options=>'#DEFAULT#'
,p_dialog_width=>'800'
,p_last_updated_by=>'CESAR'
,p_last_upd_yyyymmddhh24miss=>'20180915114313'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(8743193774941105)
,p_plug_name=>'BOBINA Nro &P2_ID.'
,p_region_template_options=>'#DEFAULT#:t-Region--removeHeader:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(3117357289915216)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(8868196057307971)
,p_plug_name=>'New'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(3107709176915203)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'REGION_POSITION_03'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(11052076267697452)
,p_name=>'ORDEN &P2_ID.'
,p_template=>wwv_flow_api.id(3107368288915203)
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_new_grid_row=>false
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select BOB_USO.ID, FECHA, LUGAR, ORDEN,',
'       INICIO || ''->'' || FIN AS DIAMETRO ,',
'       ROUND (USO * PESO / 100) AS KILOS ,',
'       ROUND (USO * PESO / FORMATO / GRAMAJE * 1000) AS METROS',
'  from BOB_USO,BOB',
'WHERE',
'    BOB_USO.BOBINA = BOB.ID',
'AND BOBINA= :P302_ID'))
,p_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select 1 from BOB_USO',
'WHERE BOBINA= :P302_ID'))
,p_display_condition_type=>'EXISTS'
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(3127301024915232)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_num_rows_type=>'ROW_RANGES_IN_SELECT_LIST'
,p_pagination_display_position=>'BOTTOM_RIGHT'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(6322558374495265)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>1
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(6322820767495270)
,p_query_column_id=>2
,p_column_alias=>'FECHA'
,p_column_display_sequence=>2
,p_column_heading=>'Fecha'
,p_use_as_row_header=>'N'
,p_column_link=>'f?p=&APP_ID.:59:&SESSION.::&DEBUG.:RP,59:P59_FECHA:#FECHA#'
,p_column_linktext=>'#FECHA#'
,p_column_alignment=>'CENTER'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(6323280488495271)
,p_query_column_id=>3
,p_column_alias=>'LUGAR'
,p_column_display_sequence=>3
,p_column_heading=>'Lugar'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_display_as=>'TEXT_FROM_LOV'
,p_named_lov=>wwv_flow_api.id(5366938846123855)
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(6323623367495271)
,p_query_column_id=>4
,p_column_alias=>'ORDEN'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(6324019600495272)
,p_query_column_id=>5
,p_column_alias=>'DIAMETRO'
,p_column_display_sequence=>5
,p_column_heading=>'Diametro'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(6324471416495273)
,p_query_column_id=>6
,p_column_alias=>'KILOS'
,p_column_display_sequence=>6
,p_column_heading=>'Kilos'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(6324809796495273)
,p_query_column_id=>7
,p_column_alias=>'METROS'
,p_column_display_sequence=>7
,p_column_heading=>'Metros'
,p_use_as_row_header=>'N'
,p_disable_sort_column=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(6326324390495310)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(8868196057307971)
,p_button_name=>'GUARDAR'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(3140172613915263)
,p_button_image_alt=>'Guardar'
,p_button_position=>'REGION_TEMPLATE_CREATE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>':P302_ESTADO IN (0,1)'
,p_button_condition_type=>'PLSQL_EXPRESSION'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6325202795495279)
,p_name=>'P302_NEW'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(11052076267697452)
,p_use_cache_before_default=>'NO'
,p_source=>'BOB_PRINT.QR(:P302_ID)'
,p_source_type=>'FUNCTION'
,p_display_as=>'PLUGIN_COM.JANNAVRATIL.APEX.QR.ITEM'
,p_field_template=>wwv_flow_api.id(3139618903915258)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'200'
,p_attribute_02=>'#000000'
,p_attribute_03=>'#FFFFFF'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6327018338495319)
,p_name=>'P302_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(8743193774941105)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6327470895495320)
,p_name=>'P302_PROV'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(8743193774941105)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Provedor'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT BOB_PROV.PROV FROM BOB_PROV,BOB_ORDEN',
'WHERE BOB_ORDEN.PROV = BOB_PROV.ID',
'AND BOB_ORDEN.ID = :P302_ORDEN'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6327807490495322)
,p_name=>'P302_ORDEN'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(8743193774941105)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Orden Ingreso'
,p_source=>'ORDEN_INGRESO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6328274431495323)
,p_name=>'P302_TIPO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(8743193774941105)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo'
,p_source=>'TIPO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_TIPO_PAPEL'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select TIPO_PAPEL as d,',
'       ID as r',
'  from BOB_TIPO',
' order by 1'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_read_only_when=>':P302_ESTADO IN ( -1,2,3) '
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6328689118495326)
,p_name=>'P302_FORMATO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(8743193774941105)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Formato'
,p_source=>'FORMATO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when=>':P302_ESTADO IN ( -1,2,3) '
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6329039555495327)
,p_name=>'P302_GRAMAJE'
,p_is_required=>true
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(8743193774941105)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Gramaje'
,p_source=>'GRAMAJE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when=>':P302_ESTADO IN ( -1,2,3) '
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6329441060495327)
,p_name=>'P302_PESO'
,p_is_required=>true
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(8743193774941105)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Peso'
,p_source=>'PESO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when=>':P302_ESTADO IN ( -1,2,3) '
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6329848939495332)
,p_name=>'P302_ESTADO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(8743193774941105)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Estado'
,p_source=>'ESTADO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_ESTADO_BOBINA'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ESTADO as d,',
'       ID as r',
'  from BOB_ESTADO',
' order by 1'))
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6330287259495333)
,p_name=>'P302_PSTOCK'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(8743193774941105)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Stock'
,p_source=>'PSTOCK'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_PCT_GRAPH'
,p_begin_on_new_line=>'N'
,p_display_when=>'P302_ESTADO'
,p_display_when2=>'2'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6330660235495334)
,p_name=>'P302_DIAMETRO'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(8743193774941105)
,p_prompt=>'Diametro'
,p_source=>'BOB_PKG.DIAMETROACTUAL(:P302_ID)'
,p_source_type=>'FUNCTION'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_read_only_when=>':P302_ESTADO IN ( -1,2,3) '
,p_read_only_when_type=>'PLSQL_EXPRESSION'
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6331032579495335)
,p_name=>'P302_METROS'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_api.id(8743193774941105)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Metros'
,p_source=>'BOB_PKG.METROSACTUAL(:P302_ID)'
,p_source_type=>'FUNCTION'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_display_when=>'P302_ESTADO'
,p_display_when2=>'2'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(6499462548020842)
,p_name=>'P302_FECHA'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(8743193774941105)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Fecha'
,p_source=>'select fecha from bob_orden where id = :P302_ORDEN'
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(6331709301495396)
,p_name=>'New'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_api.id(6326324390495310)
,p_bind_type=>'bind'
,p_bind_event_type=>'click'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6332224428495404)
,p_event_id=>wwv_flow_api.id(6331709301495396)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'UPDATE BOB',
'SET ',
'TIPO = :P302_TIPO,',
'FORMATO = :P302_FORMATO,',
'GRAMAJE = :P302_GRAMAJE,',
'PESO = :P302_PESO,',
'DIAMETRO = :P302_DIAMETRO',
'WHERE ID = :P302_ID;',
''))
,p_attribute_02=>'P302_FORMATO,P302_GRAMAJE,P302_PESO,P302_DIAMETRO,P302_TIPO'
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(6332773022495405)
,p_event_id=>wwv_flow_api.id(6331709301495396)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(6331448366495390)
,p_process_sequence=>10
,p_process_point=>'AFTER_HEADER'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'New'
,p_attribute_02=>'BOB'
,p_attribute_03=>'P302_ID'
,p_attribute_04=>'ID'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(6325622377495296)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_api.id(11052076267697452)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'ORDEN &P302_ORDEN. - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
);
end;
/
prompt --application/pages/delete_00303
begin
wwv_flow_api.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>303);
end;
/
prompt --application/pages/page_00303
begin
wwv_flow_api.create_page(
 p_id=>303
,p_user_interface_id=>wwv_flow_api.id(3150912767915327)
,p_name=>'BOBINAS CORRUGADO'
,p_step_title=>'BOBINAS CORRUGADO'
,p_warn_on_unsaved_changes=>'N'
,p_step_sub_title=>'BOBINAS CORRUGADO'
,p_step_sub_title_type=>'TEXT_WITH_SUBSTITUTIONS'
,p_autocomplete_on_off=>'OFF'
,p_group_id=>wwv_flow_api.id(5973192580485747)
,p_javascript_file_urls=>'#APP_IMAGES#bobinas_corrugado.js'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#mycanvas{',
'			border:1px solid #d9d9d9;',
'	position:fixed; ',
'	width: 100%;',
'	height:360px;',
'}',
''))
,p_step_template=>wwv_flow_api.id(12583897249064454)
,p_page_template_options=>'#DEFAULT#'
,p_last_updated_by=>'CESAR'
,p_last_upd_yyyymmddhh24miss=>'20180919092348'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(9706041660842063)
,p_plug_name=>'COL_1'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(3107368288915203)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18741245423976629)
,p_plug_name=>'Bobina Nro &P303_BOBINA.'
,p_parent_plug_id=>wwv_flow_api.id(9706041660842063)
,p_icon_css_classes=>'fa-info'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_api.id(3117357289915216)
,p_plug_display_sequence=>40
,p_plug_new_grid_row=>false
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_plug_read_only_when_type=>'ALWAYS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(18898170211738238)
,p_plug_name=>'canvas'
,p_parent_plug_id=>wwv_flow_api.id(9706041660842063)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(3107368288915203)
,p_plug_display_sequence=>50
,p_plug_display_point=>'BODY'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<canvas id="mycanvas"></canvas>',
''))
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(19900435080367830)
,p_plug_name=>'BAJA'
,p_parent_plug_id=>wwv_flow_api.id(9706041660842063)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody:t-Form--large:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_api.id(3117357289915216)
,p_plug_display_sequence=>20
,p_plug_grid_column_span=>6
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_page_plug(
 p_id=>wwv_flow_api.id(24174935225797050)
,p_plug_name=>'col-3'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_api.id(3107368288915203)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_new_grid_row=>false
,p_plug_display_column=>9
,p_plug_display_point=>'BODY'
,p_plug_query_options=>'DERIVED_REPORT_COLUMNS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(16304039289900840)
,p_name=>'C - LINNER'
,p_region_name=>'TABLE_C'
,p_parent_plug_id=>wwv_flow_api.id(24174935225797050)
,p_template=>wwv_flow_api.id(3112071309915208)
,p_display_sequence=>40
,p_region_template_options=>'#DEFAULT#:js-useLocalStorage:is-collapsed:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'BOB_USO.ID,',
'BOB_USO.ORDEN,',
'BOB_USO.BOBINA,',
'BOB.TIPO,',
'BOB.FORMATO,',
'BOB.GRAMAJE,',
'TO_CHAR(INICIO,''9000'') || '' ->'' || TO_CHAR(FIN,''9000'') AS DIAMETRO,',
'ROUND(BOB.PESO/BOB.FORMATO/BOB.GRAMAJE*USO*1000/REND,0) AS METROS,',
'''<a href=javascript:$s("P303_ID_TO_DELETE",''||BOB_USO.ID||'') class="fa fa-trash" ></a>'' delete_link,',
'''<a href=javascript:$s("P303_ID_A_SUBIR",''||BOB_USO.ID||'') class="fa fa-arrow-up" ></a>'' ||',
'''<a href=javascript:$s("P303_ID_A_BAJAR",''||BOB_USO.ID||'') class="fa fa-arrow-down" ></a>''',
'as link',
'FROM BOB_USO,BOB ',
'WHERE FECHA = :P303_FECHA AND LUGAR = 3',
'AND BOB_USO.BOBINA = BOB.ID',
'ORDER BY ORDEN'))
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(3127301024915232)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7831251222105011)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>8
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7830047131105009)
,p_query_column_id=>2
,p_column_alias=>'ORDEN'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7828482166105007)
,p_query_column_id=>3
,p_column_alias=>'BOBINA'
,p_column_display_sequence=>1
,p_column_heading=>'Nro'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7828826388105007)
,p_query_column_id=>4
,p_column_alias=>'TIPO'
,p_column_display_sequence=>2
,p_column_heading=>'T'
,p_use_as_row_header=>'N'
,p_display_as=>'TEXT_FROM_LOV'
,p_named_lov=>wwv_flow_api.id(5365177573123850)
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7829210593105008)
,p_query_column_id=>5
,p_column_alias=>'FORMATO'
,p_column_display_sequence=>3
,p_column_heading=>'For'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7829693115105009)
,p_query_column_id=>6
,p_column_alias=>'GRAMAJE'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7830855235105010)
,p_query_column_id=>7
,p_column_alias=>'DIAMETRO'
,p_column_display_sequence=>7
,p_column_heading=>'Diametro'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7830498875105010)
,p_query_column_id=>8
,p_column_alias=>'METROS'
,p_column_display_sequence=>6
,p_column_heading=>'Metros'
,p_use_as_row_header=>'N'
,p_column_format=>'999990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7831661561105011)
,p_query_column_id=>9
,p_column_alias=>'DELETE_LINK'
,p_column_display_sequence=>10
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7832014823105012)
,p_query_column_id=>10
,p_column_alias=>'LINK'
,p_column_display_sequence=>9
,p_column_heading=>'Link'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(16305267994900852)
,p_name=>'B - ONDA'
,p_region_name=>'TABLE_B'
,p_parent_plug_id=>wwv_flow_api.id(24174935225797050)
,p_template=>wwv_flow_api.id(3112071309915208)
,p_display_sequence=>30
,p_region_template_options=>'#DEFAULT#:js-useLocalStorage:is-collapsed:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'BOB_USO.ID,',
'BOB_USO.ORDEN,',
'BOB_USO.BOBINA,',
'BOB.TIPO,',
'BOB.FORMATO,',
'BOB.GRAMAJE,',
'TO_CHAR(INICIO,''9000'') || '' ->'' || TO_CHAR(FIN,''9000'') AS DIAMETRO,',
'ROUND(BOB.PESO/BOB.FORMATO/BOB.GRAMAJE*USO*1000/REND,0) AS METROS,',
'''<a href=javascript:$s("P303_ID_TO_DELETE",''||BOB_USO.ID||'') class="fa fa-trash" ></a>'' delete_link,',
'''<a href=javascript:$s("P303_ID_A_SUBIR",''||BOB_USO.ID||'') class="fa fa-arrow-up" ></a>'' ||',
'''<a href=javascript:$s("P303_ID_A_BAJAR",''||BOB_USO.ID||'') class="fa fa-arrow-down" ></a>''',
'as link',
'FROM BOB_USO,BOB ',
'WHERE FECHA = :P303_FECHA AND LUGAR = 2',
'AND BOB_USO.BOBINA = BOB.ID',
'ORDER BY ORDEN'))
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(3127301024915232)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7827338013105005)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>8
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7826155268105003)
,p_query_column_id=>2
,p_column_alias=>'ORDEN'
,p_column_display_sequence=>5
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7824588843105001)
,p_query_column_id=>3
,p_column_alias=>'BOBINA'
,p_column_display_sequence=>1
,p_column_heading=>'Nro'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7824900872105001)
,p_query_column_id=>4
,p_column_alias=>'TIPO'
,p_column_display_sequence=>2
,p_column_heading=>'T'
,p_use_as_row_header=>'N'
,p_display_as=>'TEXT_FROM_LOV'
,p_named_lov=>wwv_flow_api.id(5365177573123850)
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7825319609105002)
,p_query_column_id=>5
,p_column_alias=>'FORMATO'
,p_column_display_sequence=>3
,p_column_heading=>'For'
,p_use_as_row_header=>'N'
,p_column_alignment=>'CENTER'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7825766389105002)
,p_query_column_id=>6
,p_column_alias=>'GRAMAJE'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7826967864105004)
,p_query_column_id=>7
,p_column_alias=>'DIAMETRO'
,p_column_display_sequence=>7
,p_column_heading=>'Diametro'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7826576316105004)
,p_query_column_id=>8
,p_column_alias=>'METROS'
,p_column_display_sequence=>6
,p_column_heading=>'Metros'
,p_use_as_row_header=>'N'
,p_column_format=>'999990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7827762075105005)
,p_query_column_id=>9
,p_column_alias=>'DELETE_LINK'
,p_column_display_sequence=>10
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7824110381105000)
,p_query_column_id=>10
,p_column_alias=>'LINK'
,p_column_display_sequence=>9
,p_column_heading=>'Link'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(18741328400976630)
,p_name=>'CORRUGADO'
,p_region_name=>'CORRUGADO'
,p_parent_plug_id=>wwv_flow_api.id(24174935225797050)
,p_template=>wwv_flow_api.id(3112071309915208)
,p_display_sequence=>10
,p_region_template_options=>'#DEFAULT#:js-useLocalStorage:is-expanded:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT D.ID,D.ID_CORR,D.FORMATO,D.ORDEN,D.CALIDAD,PROD_PKG.MetrosCorrugado(D.ID) AS METROS , ',
'''<a href=javascript:$s("P303_ORDEN_A_BORRAR",''||D.ID||'') class="fa fa-trash" ></a>'' as BORRAR,',
'''<a href=javascript:$s("P303_ORDEN_A_SUBIR",''||D.ID||'') class="fa fa-arrow-up" ></a>'' ||',
'''<a href=javascript:$s("P303_ORDEN_A_BAJAR",''||D.ID||'') class="fa fa-arrow-down" ></a>''',
'as link',
'FROM CABS_CORR_D D',
'WHERE FECHA = :P303_FECHA',
'ORDER BY ORDEN;'))
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(3127301024915232)
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_query_num_rows_item=>'P303_ROWS'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7817120817104977)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>8
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7818717080104979)
,p_query_column_id=>2
,p_column_alias=>'ID_CORR'
,p_column_display_sequence=>1
,p_column_heading=>'Id corr'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7818369272104979)
,p_query_column_id=>3
,p_column_alias=>'FORMATO'
,p_column_display_sequence=>3
,p_column_heading=>'Formato'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7817975532104978)
,p_query_column_id=>4
,p_column_alias=>'ORDEN'
,p_column_display_sequence=>2
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7817563051104978)
,p_query_column_id=>5
,p_column_alias=>'CALIDAD'
,p_column_display_sequence=>5
,p_column_heading=>'Calidad'
,p_use_as_row_header=>'N'
,p_display_as=>'TEXT_FROM_LOV'
,p_named_lov=>wwv_flow_api.id(3684518334234034)
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7816722545104977)
,p_query_column_id=>6
,p_column_alias=>'METROS'
,p_column_display_sequence=>4
,p_column_heading=>'Metros'
,p_use_as_row_header=>'N'
,p_column_format=>'999990'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7816315981104976)
,p_query_column_id=>7
,p_column_alias=>'BORRAR'
,p_column_display_sequence=>7
,p_column_heading=>'Borrar'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7815999715104972)
,p_query_column_id=>8
,p_column_alias=>'LINK'
,p_column_display_sequence=>6
,p_column_heading=>'Link'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_region(
 p_id=>wwv_flow_api.id(19901970553367845)
,p_name=>'A - INTERIOR'
,p_region_name=>'TABLE_A'
,p_parent_plug_id=>wwv_flow_api.id(24174935225797050)
,p_template=>wwv_flow_api.id(3112071309915208)
,p_display_sequence=>20
,p_region_template_options=>'#DEFAULT#:js-useLocalStorage:is-collapsed:t-Region--scrollBody'
,p_component_template_options=>'#DEFAULT#:t-Report--altRowsDefault:t-Report--rowHighlight'
,p_display_point=>'BODY'
,p_source_type=>'NATIVE_SQL_REPORT'
,p_query_type=>'SQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'BOB_USO.ID,',
'BOB_USO.ORDEN,',
'BOB_USO.BOBINA,',
'BOB.TIPO,',
'BOB.FORMATO,',
'BOB.GRAMAJE,',
'TO_CHAR(INICIO,''9000'') || '' ->'' || TO_CHAR(FIN,''9000'') AS DIAMETRO,',
'ROUND(BOB.PESO/BOB.FORMATO/BOB.GRAMAJE*USO*1000/REND,0) AS METROS,',
'''<a href=javascript:$s("P303_ID_TO_DELETE",''||BOB_USO.ID||'') class="fa fa-trash" ></a>'' delete_link,',
'''<a href=javascript:$s("P303_ID_A_SUBIR",''||BOB_USO.ID||'') class="fa fa-arrow-up" ></a>'' ||',
'''<a href=javascript:$s("P303_ID_A_BAJAR",''||BOB_USO.ID||'') class="fa fa-arrow-down" ></a>''',
'as link',
'FROM BOB_USO,BOB ',
'WHERE FECHA = :P303_FECHA AND LUGAR = 1',
'AND BOB_USO.BOBINA = BOB.ID',
'ORDER BY ORDEN'))
,p_ajax_enabled=>'Y'
,p_query_row_template=>wwv_flow_api.id(3127301024915232)
,p_query_num_rows=>15
,p_query_options=>'DERIVED_REPORT_COLUMNS'
,p_query_show_nulls_as=>'-'
,p_csv_output=>'N'
,p_prn_output=>'N'
,p_sort_null=>'L'
,p_plug_query_strip_html=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7822266145104995)
,p_query_column_id=>1
,p_column_alias=>'ID'
,p_column_display_sequence=>8
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7820642542104987)
,p_query_column_id=>2
,p_column_alias=>'ORDEN'
,p_column_display_sequence=>6
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7819839647104982)
,p_query_column_id=>3
,p_column_alias=>'BOBINA'
,p_column_display_sequence=>1
,p_column_heading=>'Nro'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7823092496104996)
,p_query_column_id=>4
,p_column_alias=>'TIPO'
,p_column_display_sequence=>2
,p_column_heading=>'T'
,p_use_as_row_header=>'N'
,p_display_as=>'TEXT_FROM_LOV'
,p_named_lov=>wwv_flow_api.id(5365177573123850)
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7823498373104997)
,p_query_column_id=>5
,p_column_alias=>'FORMATO'
,p_column_display_sequence=>3
,p_column_heading=>'For'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7820203012104983)
,p_query_column_id=>6
,p_column_alias=>'GRAMAJE'
,p_column_display_sequence=>4
,p_hidden_column=>'Y'
,p_derived_column=>'N'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7821405768104989)
,p_query_column_id=>7
,p_column_alias=>'DIAMETRO'
,p_column_display_sequence=>7
,p_column_heading=>'Diametro'
,p_use_as_row_header=>'N'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7821040449104988)
,p_query_column_id=>8
,p_column_alias=>'METROS'
,p_column_display_sequence=>5
,p_column_heading=>'Metros'
,p_use_as_row_header=>'N'
,p_column_format=>'999990'
,p_column_alignment=>'RIGHT'
,p_heading_alignment=>'LEFT'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7821851215104990)
,p_query_column_id=>9
,p_column_alias=>'DELETE_LINK'
,p_column_display_sequence=>10
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_report_columns(
 p_id=>wwv_flow_api.id(7822699837104996)
,p_query_column_id=>10
,p_column_alias=>'LINK'
,p_column_display_sequence=>9
,p_column_heading=>'Mover'
,p_use_as_row_header=>'N'
,p_display_as=>'WITHOUT_MODIFICATION'
,p_derived_column=>'N'
,p_include_in_export=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(7811356762104956)
,p_button_sequence=>150
,p_button_plug_id=>wwv_flow_api.id(19900435080367830)
,p_button_name=>'SUBMIT'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(3140004793915261)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Submit'
,p_button_position=>'BODY'
,p_button_condition=>'P303_PSTOCK'
,p_button_condition_type=>'ITEM_NOT_NULL_OR_ZERO'
,p_icon_css_classes=>'fa-database-arrow-down'
,p_button_cattributes=>'STYLE="postion:relative; top:20px;"'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(7810970954104955)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_api.id(19900435080367830)
,p_button_name=>'BOBINA_LOAD'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--gapRight'
,p_button_template_id=>wwv_flow_api.id(3140004793915261)
,p_button_image_alt=>'Refresh'
,p_button_position=>'REGION_TEMPLATE_COPY'
,p_icon_css_classes=>'fa-repeat'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(7806277960104941)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(18741245423976629)
,p_button_name=>'Detalle'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(3140172613915263)
,p_button_image_alt=>'Detalle'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:302:&SESSION.::&DEBUG.:RP,302:P302_ID:&P303_BOBINA.'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(8680432027728934)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_api.id(18741328400976630)
,p_button_name=>'CORRUGADO_DIARIO'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--warning:t-Button--iconRight'
,p_button_template_id=>wwv_flow_api.id(3140270662915263)
,p_button_image_alt=>'Corrugado Diario'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:13:&SESSION.::&DEBUG.:RP,13:P13_FECHA:&P303_FECHA.'
,p_icon_css_classes=>'fa-gears'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(7811768983104957)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_api.id(19900435080367830)
,p_button_name=>'PREV_DAY'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(3140004793915261)
,p_button_image_alt=>'Prev day'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:303:&SESSION.::&DEBUG.:RP:P303_FECHA:&P303_PREV_DAY.'
,p_icon_css_classes=>'fa-angle-double-left'
);
wwv_flow_api.create_page_button(
 p_id=>wwv_flow_api.id(7812174644104957)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_api.id(19900435080367830)
,p_button_name=>'NEXT_DAY'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_api.id(3140004793915261)
,p_button_image_alt=>'next day'
,p_button_position=>'REGION_TEMPLATE_EDIT'
,p_button_redirect_url=>'f?p=&APP_ID.:303:&SESSION.::&DEBUG.:RP:P303_FECHA:&P303_NEXT_DAY.'
,p_icon_css_classes=>'fa-angle-double-right'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7803535447104924)
,p_name=>'P303_ID_TO_DELETE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(18898170211738238)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7803933537104936)
,p_name=>'P303_ID_A_SUBIR'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(18898170211738238)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7804330047104937)
,p_name=>'P303_ID_A_BAJAR'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(18898170211738238)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7804709885104937)
,p_name=>'P303_ORDEN_A_SUBIR'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(18898170211738238)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7805113203104938)
,p_name=>'P303_ORDEN_A_BAJAR'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(18898170211738238)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7805506780104938)
,p_name=>'P303_ORDEN_A_BORRAR'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(18898170211738238)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7806660673104946)
,p_name=>'P303_PROVEEDOR'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(18741245423976629)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Proveedor'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT PROV FROM BOB_ORDEN',
'WHERE ID = :P303_ORDEN'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_PROV_PAPEL_HISTORICO'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select PROV as d,',
'       ID as r',
'  from BOB_PROV',
' order by 1'))
,p_cHeight=>1
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7807069295104948)
,p_name=>'P303_ORDEN'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_api.id(18741245423976629)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Orden'
,p_source=>'ORDEN_INGRESO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7807444405104949)
,p_name=>'P303_TIPO'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_api.id(18741245423976629)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Tipo'
,p_source=>'TIPO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_TIPO_PAPEL'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select TIPO_PAPEL as d,',
'       ID as r',
'  from BOB_TIPO',
' order by 1'))
,p_cHeight=>1
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7807888601104949)
,p_name=>'P303_FORMATO'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_api.id(18741245423976629)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Formato'
,p_source=>'FORMATO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7808265647104951)
,p_name=>'P303_GRAMAJE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(18741245423976629)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Gramaje'
,p_source=>'GRAMAJE'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7808678800104952)
,p_name=>'P303_PESO'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_api.id(18741245423976629)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Kilos'
,p_source=>'PESO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7809028556104952)
,p_name=>'P303_PSTOCK'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(18741245423976629)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Existencia'
,p_source=>'PSTOCK'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_PCT_GRAPH'
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7809417648104953)
,p_name=>'P303_DIAM_ACTUAL'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_api.id(18741245423976629)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Diametro'
,p_source=>'bob_pkg.diametroactual(:P303_BOBINA)'
,p_source_type=>'FUNCTION'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(3139618903915258)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7809811076104953)
,p_name=>'P303_METROS_ACTUAL'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_api.id(18741245423976629)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Metros'
,p_source=>'bob_pkg.METROSactual(:P303_BOBINA)'
,p_source_type=>'FUNCTION'
,p_display_as=>'NATIVE_DISPLAY_ONLY'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_api.id(3139618903915258)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'VALUE'
,p_attribute_04=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7810255149104954)
,p_name=>'P303_ESTADO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(18741245423976629)
,p_use_cache_before_default=>'NO'
,p_source=>'ESTADO'
,p_source_type=>'DB_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7812585547104958)
,p_name=>'P303_FECHA'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(19900435080367830)
,p_prompt=>'Fecha'
,p_source=>'SYSDATE()'
,p_source_type=>'FUNCTION'
,p_display_as=>'NATIVE_DATE_PICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_04=>'button'
,p_attribute_05=>'N'
,p_attribute_07=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7812931244104958)
,p_name=>'P303_LUGAR'
,p_is_required=>true
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_api.id(19900435080367830)
,p_item_default=>'1'
,p_prompt=>'Lugar'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_named_lov=>'LOV_LUGAR_CORRUGADO'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select KEY as d,',
'       ID as r',
'  from BOB_LUGAR',
' order by 1'))
,p_begin_on_new_line=>'N'
,p_grid_label_column_span=>0
,p_field_template=>wwv_flow_api.id(3139537902915257)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--xlarge:t-Form-fieldContainer--radioButtonGroup'
,p_warn_on_unsaved_changes=>'I'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'3'
,p_attribute_02=>'NONE'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7813352251104959)
,p_name=>'P303_BOBINA'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_api.id(19900435080367830)
,p_prompt=>'Bobina'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_colspan=>4
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'center'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7813778984104960)
,p_name=>'P303_INICIO'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_api.id(19900435080367830)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Inicio'
,p_source=>'NVL(BOB_PKG.DIAMETROACTUAL(:P303_BOBINA),0)'
,p_source_type=>'FUNCTION'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_display_when=>'P303_BOBINA'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_read_only_when=>'P303_PSTOCK'
,p_read_only_when2=>'100'
,p_read_only_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'center'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7814116747104960)
,p_name=>'P303_FIN'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_api.id(19900435080367830)
,p_use_cache_before_default=>'NO'
,p_prompt=>'Final'
,p_source=>'0'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_read_only_when=>'P303_PSTOCK'
,p_read_only_when_type=>'ITEM_IS_NULL_OR_ZERO'
,p_field_template=>wwv_flow_api.id(5489110000467812)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_03=>'center'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7814513258104960)
,p_name=>'P303_PREV_DAY'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_api.id(19900435080367830)
,p_source=>'SELECT MAX(FECHA) FROM CABS_CORR_D WHERE FECHA < :P303_FECHA'
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7814949038104961)
,p_name=>'P303_NEXT_DAY'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_api.id(19900435080367830)
,p_source=>'SELECT MIN(FECHA) FROM CABS_CORR_D WHERE FECHA > :P303_FECHA'
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_display_when=>'P303_FECHA'
,p_display_when_type=>'ITEM_IS_NOT_NULL'
,p_attribute_01=>'Y'
);
end;
/
begin
wwv_flow_api.create_page_item(
 p_id=>wwv_flow_api.id(7819102417104980)
,p_name=>'P303_ROWS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_api.id(18741328400976630)
,p_source=>'30'
,p_source_type=>'STATIC'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7835403387105061)
,p_name=>'FECHA_CHANGE'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P303_FECHA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7835959302105061)
,p_event_id=>wwv_flow_api.id(7835403387105061)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'FECHA'
,p_attribute_02=>'Y'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7834581627105060)
,p_name=>'Load_bobina'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P303_BOBINA'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7835071028105060)
,p_event_id=>wwv_flow_api.id(7834581627105060)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_01=>'BOBINA_LOAD'
,p_attribute_02=>'Y'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7850210306105076)
,p_name=>'USO_A_BORRAR'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P303_ID_TO_DELETE'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7850704650105076)
,p_event_id=>wwv_flow_api.id(7850210306105076)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DELETE FROM BOB_USO WHERE ID = :P303_ID_TO_DELETE;',
''))
,p_attribute_02=>'P303_ID_TO_DELETE'
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7851249466105077)
,p_event_id=>wwv_flow_api.id(7850210306105076)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(19901970553367845)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7851716614105077)
,p_event_id=>wwv_flow_api.id(7850210306105076)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(16305267994900852)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7852223925105078)
,p_event_id=>wwv_flow_api.id(7850210306105076)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(16304039289900840)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7847854018105074)
,p_name=>'USO_A_SUBIR'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P303_ID_A_SUBIR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7848378578105074)
,p_event_id=>wwv_flow_api.id(7847854018105074)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'BOB_PKG.SUBIRORDENUSO(:P303_ID_A_SUBIR);'
,p_attribute_02=>'P303_ID_A_SUBIR'
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7848893959105075)
,p_event_id=>wwv_flow_api.id(7847854018105074)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(19901970553367845)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7849865366105076)
,p_event_id=>wwv_flow_api.id(7847854018105074)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(16305267994900852)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7849381610105075)
,p_event_id=>wwv_flow_api.id(7847854018105074)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(16304039289900840)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7845421487105071)
,p_name=>'USO_A_BAJAR'
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P303_ID_A_BAJAR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7845910160105072)
,p_event_id=>wwv_flow_api.id(7845421487105071)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'BOB_PKG.BAJARORDENUSO(:P303_ID_A_BAJAR);'
,p_attribute_02=>'P303_ID_A_BAJAR'
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7846478356105072)
,p_event_id=>wwv_flow_api.id(7845421487105071)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(19901970553367845)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7846940337105073)
,p_event_id=>wwv_flow_api.id(7845421487105071)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(16305267994900852)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7847459568105073)
,p_event_id=>wwv_flow_api.id(7845421487105071)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(16304039289900840)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7837745956105064)
,p_name=>'ORDEN_A_SUBIR'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P303_ORDEN_A_SUBIR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7838217201105064)
,p_event_id=>wwv_flow_api.id(7837745956105064)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    vFecha date;',
'    vOrden number;',
'    vCambio number;',
'BEGIN',
'    SELECT FECHA,ORDEN ',
'    INTO vFecha,vOrden',
'    FROM CABS_CORR_D',
'    WHERE ID = :P303_ORDEN_A_SUBIR;',
'    ',
'    if vOrden > 0 then',
'    ',
'    SELECT ID',
'    INTO vCambio',
'    FROM CABS_CORR_D',
'    WHERE FECHA = vFecha',
'    AND ORDEN = vOrden -1;',
'    ',
'    ',
'    UPDATE CABS_CORR_D',
'    SET ORDEN = -1',
'    WHERE ID = :P303_ORDEN_A_SUBIR;',
'    ',
'    UPDATE CABS_CORR_D',
'    SET ORDEN = vOrden',
'    WHERE ID = vCambio; ',
'    ',
'    UPDATE CABS_CORR_D',
'    SET ORDEN = vOrden -1',
'    WHERE ID = :P303_ORDEN_A_SUBIR;  ',
'    ',
'    End if;',
'    ',
'    ',
'END;'))
,p_attribute_02=>'P303_ORDEN_A_SUBIR'
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7838772093105065)
,p_event_id=>wwv_flow_api.id(7837745956105064)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(18741328400976630)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7836300903105062)
,p_name=>'ORDEN_A_BAJAR'
,p_event_sequence=>90
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P303_ORDEN_A_BAJAR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7836856110105063)
,p_event_id=>wwv_flow_api.id(7836300903105062)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    vFecha date;',
'    vOrden number;',
'    vCambio number;',
'BEGIN',
'    SELECT FECHA,ORDEN ',
'    INTO vFecha,vOrden',
'    FROM CABS_CORR_D',
'    WHERE ID = :P303_ORDEN_A_BAJAR;',
'    ',
'    ',
'    SELECT ID',
'    INTO vCambio',
'    FROM CABS_CORR_D',
'    WHERE FECHA = vFecha',
'    AND ORDEN = vOrden + 1;',
'    ',
'    ',
'    UPDATE CABS_CORR_D',
'    SET ORDEN = -1',
'    WHERE ID = :P303_ORDEN_A_BAJAR;',
'    ',
'    UPDATE CABS_CORR_D',
'    SET ORDEN = vOrden',
'    WHERE ID = vCambio; ',
'    ',
'    UPDATE CABS_CORR_D',
'    SET ORDEN = vOrden + 1',
'    WHERE ID = :P303_ORDEN_A_BAJAR;  ',
'    ',
'    ',
'    EXCEPTION WHEN NO_DATA_FOUND THEN',
'    dbms_output.put_line(''ULTIMO LUGAR!''); ',
'END;    ',
'    ',
''))
,p_attribute_02=>'P303_ORDEN_A_BAJAR'
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7837347271105063)
,p_event_id=>wwv_flow_api.id(7836300903105062)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(18741328400976630)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7844574346105070)
,p_name=>'dibujar_uso'
,p_event_sequence=>100
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7845044810105071)
,p_event_id=>wwv_flow_api.id(7844574346105070)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'DibujarUso();'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7833166720105052)
,p_name=>'ORDEN_A_BORAR'
,p_event_sequence=>110
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P303_ORDEN_A_BORRAR'
,p_bind_type=>'bind'
,p_bind_event_type=>'change'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7834170108105060)
,p_event_id=>wwv_flow_api.id(7833166720105052)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'PROD_PKG.BORRAR_ORDEN_CORRUGADO(:P303_ORDEN_A_BORRAR);'
,p_attribute_02=>'P303_ORDEN_A_BORRAR'
,p_stop_execution_on_error=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7833602267105058)
,p_event_id=>wwv_flow_api.id(7833166720105052)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_api.id(18741328400976630)
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7843621768105070)
,p_name=>'set_focus'
,p_event_sequence=>120
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7844137978105070)
,p_event_id=>wwv_flow_api.id(7843621768105070)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P303_BOBINA'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7842767974105069)
,p_name=>'New_1'
,p_event_sequence=>130
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
,p_display_when_type=>'REQUEST_EQUALS_CONDITION'
,p_display_when_cond=>'BOBINA_LOAD'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7843255151105069)
,p_event_id=>wwv_flow_api.id(7842767974105069)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_FOCUS'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P303_FIN'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7841869800105068)
,p_name=>'CHANGE_A'
,p_event_sequence=>140
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(19901970553367845)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7842315586105068)
,p_event_id=>wwv_flow_api.id(7841869800105068)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'DibujarUso();'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7840975817105067)
,p_name=>'CHANGE_X'
,p_event_sequence=>150
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(18741328400976630)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7841468114105067)
,p_event_id=>wwv_flow_api.id(7840975817105067)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'DibujarUso();'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7840045957105066)
,p_name=>'CHANGE_C'
,p_event_sequence=>160
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(16304039289900840)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7840548162105067)
,p_event_id=>wwv_flow_api.id(7840045957105066)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'DibujarUso();'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_da_event(
 p_id=>wwv_flow_api.id(7839146254105065)
,p_name=>'CHANGE_B'
,p_event_sequence=>170
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_api.id(16305267994900852)
,p_bind_type=>'bind'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_api.create_page_da_action(
 p_id=>wwv_flow_api.id(7839630790105066)
,p_event_id=>wwv_flow_api.id(7839146254105065)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'DibujarUso();'
,p_stop_execution_on_error=>'Y'
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(7832752000105051)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'USAR_BOBINA'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'INSERT INTO BOB_USO(FECHA,LUGAR,BOBINA,INICIO,FIN)',
'VALUES(:P303_FECHA,:P303_LUGAR,:P303_BOBINA,:P303_INICIO,:P303_FIN);'))
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_api.id(7811356762104956)
);
wwv_flow_api.create_page_process(
 p_id=>wwv_flow_api.id(7832422953105048)
,p_process_sequence=>10
,p_process_point=>'BEFORE_BOX_BODY'
,p_process_type=>'NATIVE_FORM_FETCH'
,p_process_name=>'New'
,p_attribute_02=>'BOB'
,p_attribute_03=>'P303_BOBINA'
,p_attribute_04=>'ID'
,p_process_error_message=>'No existe Numero de Bobina'
,p_process_when=>'SELECT 1 FROM BOB WHERE ID = :P303_BOBINA'
,p_process_when_type=>'EXISTS'
);
end;
/
begin
wwv_flow_api.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false), p_is_component_import => true);
commit;
end;
/
set verify on feedback on define on
prompt  ...done
