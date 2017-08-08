angular.module 'frontendAdmin'

#======================================================================================
# IMPAC-ROUTES: Configuring routes
#======================================================================================
.config((ImpacRoutesProvider, IMPAC_CONFIG) ->
  mnoHub = IMPAC_CONFIG.paths.mnohub_api

  data =
    mnoHub: mnoHub
    impacApi: "#{IMPAC_CONFIG.protocol}://#{IMPAC_CONFIG.host}/api"
    dashboards:
      index: "#{mnoHub}/admin/impac/dashboard_templates"
      show: "#{mnoHub}/admin/impac/dashboard_templates/:id"
    widgets:
      update: "#{mnoHub}/admin/impac/widgets/:id"
      del: "#{mnoHub}/admin/impac/widgets/:id"
    kpis:
      index: "#{mnoHub}/impac/kpis"
      update: "#{mnoHub}/admin/impac/kpis/:id"
      del: "#{mnoHub}/admin/impac/kpis/:id"

  ImpacRoutesProvider.configureRoutes(data)
)

#======================================================================================
# IMPAC-THEMING: Configuring colour theme, layout, labels, descriptions, and features
#======================================================================================
.config((ImpacThemingProvider) ->
  options =
    # link to the marketplace
    dataNotFoundConfig:
      linkUrl: '#!/marketplace'
      linkTarget: '_self'
    dhbConfig:
      designerMode:
        enabled: true
        dhbLabelName: 'Template'
    # remove useless messages
    dhbErrorsConfig:
      firstTimeCreated:
        note: ''
    # configurations for the dashboard selector feature.
    dhbSelectorConfig:
      pdfModeEnabled: false
      addDhbEnabled: false
      deleteDhbEnabled: false
      selectorType: 'dropdown'
    dhbSettings:
      syncApps:
        show: -> false
    # kpis options
    dhbKpisConfig:
      enableKpis: true
    # alert notifications options
    alertsConfig:
      enableAlerts: false

  ImpacThemingProvider.configure(options)
)

#======================================================================================
# IMPAC-ASSETS: Configuring assets
#======================================================================================
.config((ImpacAssetsProvider) ->
  options =
    defaultImagesPath: '/dashboard/images'

  ImpacAssetsProvider.configure(options)
)

#======================================================================================
# IMPAC-LINKING: Configuring linking
#======================================================================================
.run((ImpacLinking, ImpacConfigSvc, IMPAC_CONFIG) ->
  data =
    user: ImpacConfigSvc.getUserData
    organizations: ImpacConfigSvc.getOrganizations

  data.pusher_key = IMPAC_CONFIG.pusher.key if IMPAC_CONFIG.pusher? && IMPAC_CONFIG.pusher.key?

  ImpacLinking.linkData(data)
)