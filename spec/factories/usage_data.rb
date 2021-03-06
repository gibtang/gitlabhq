# frozen_string_literal: true

FactoryBot.define do
  factory :usage_data, class: 'Gitlab::UsageData' do
    skip_create # non-model factories (i.e. without #save)

    initialize_with do
      projects = create_list(:project, 4)
      create(:board, project: projects[0])
      create(:jira_service, project: projects[0])
      create(:jira_service, :without_properties_callback, project: projects[1])
      create(:jira_service, :jira_cloud_service, project: projects[2])
      create(:jira_service, :without_properties_callback, project: projects[3],
             properties: { url: 'https://mysite.atlassian.net' })
      create(:prometheus_service, project: projects[1])
      create(:service, project: projects[0], type: 'SlackSlashCommandsService', active: true)
      create(:service, project: projects[1], type: 'SlackService', active: true)
      create(:service, project: projects[2], type: 'SlackService', active: true)
      create(:service, project: projects[2], type: 'MattermostService', active: false)
      create(:service, :template, type: 'MattermostService', active: true)
      create(:service, project: projects[2], type: 'CustomIssueTrackerService', active: true)
      create(:project_error_tracking_setting, project: projects[0])
      create(:project_error_tracking_setting, project: projects[1], enabled: false)
      create(:alerts_service, project: projects[0])
      create(:alerts_service, :inactive, project: projects[1])
      create_list(:issue, 2, project: projects[0], author: User.alert_bot)
      create_list(:issue, 2, project: projects[1], author: User.alert_bot)
      create_list(:issue, 4, project: projects[0])
      create(:prometheus_alert, project: projects[0])
      create(:prometheus_alert, project: projects[0])
      create(:prometheus_alert, project: projects[1])
      create(:zoom_meeting, project: projects[0], issue: projects[0].issues[0], issue_status: :added)
      create_list(:zoom_meeting, 2, project: projects[0], issue: projects[0].issues[1], issue_status: :removed)
      create(:zoom_meeting, project: projects[0], issue: projects[0].issues[2], issue_status: :added)
      create_list(:zoom_meeting, 2, project: projects[0], issue: projects[0].issues[2], issue_status: :removed)
      create(:sentry_issue, issue: projects[0].issues[0])

      # Enabled clusters
      gcp_cluster = create(:cluster_provider_gcp, :created).cluster
      create(:cluster_provider_aws, :created)
      create(:cluster_platform_kubernetes)
      create(:cluster, :group)

      # Disabled clusters
      create(:cluster, :disabled)
      create(:cluster, :group, :disabled)
      create(:cluster, :group, :disabled)

      # Applications
      create(:clusters_applications_helm, :installed, cluster: gcp_cluster)
      create(:clusters_applications_ingress, :installed, cluster: gcp_cluster)
      create(:clusters_applications_cert_manager, :installed, cluster: gcp_cluster)
      create(:clusters_applications_prometheus, :installed, cluster: gcp_cluster)
      create(:clusters_applications_crossplane, :installed, cluster: gcp_cluster)
      create(:clusters_applications_runner, :installed, cluster: gcp_cluster)
      create(:clusters_applications_knative, :installed, cluster: gcp_cluster)
      create(:clusters_applications_elastic_stack, :installed, cluster: gcp_cluster)
      create(:clusters_applications_jupyter, :installed, cluster: gcp_cluster)

      create(:grafana_integration, project: projects[0], enabled: true)
      create(:grafana_integration, project: projects[1], enabled: true)
      create(:grafana_integration, project: projects[2], enabled: false)

      ProjectFeature.first.update_attribute('repository_access_level', 0)
    end
  end
end
