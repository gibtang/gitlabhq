import IntegrationSettingsForm from '~/integrations/integration_settings_form';
import PrometheusMetrics from '~/prometheus_metrics/prometheus_metrics';
import PrometheusAlerts from '~/prometheus_alerts';
import initAlertsSettings from '~/alerts_service_settings';

document.addEventListener('DOMContentLoaded', () => {
  const prometheusSettingsWrapper = document.querySelector('.js-prometheus-metrics-monitoring');
  const integrationSettingsForm = new IntegrationSettingsForm('.js-integration-settings-form');
  integrationSettingsForm.init();

  if (prometheusSettingsWrapper) {
    const prometheusMetrics = new PrometheusMetrics('.js-prometheus-metrics-monitoring');
    prometheusMetrics.loadActiveMetrics();
  }

  PrometheusAlerts();
  initAlertsSettings(document.querySelector('.js-alerts-service-settings'));
});
