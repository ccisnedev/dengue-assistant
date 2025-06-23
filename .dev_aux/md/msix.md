https://pub.dev/packages/msix

 flutter pub add --dev msix

 dart run msix:create --certificate-path=".\\.dev_aux\\ps\\denguebot_cert.pfx" --certificate-password="cc1sn3d3v"

pubspec.yaml:

msix_config:
  display_name: dengueBot
  publisher_display_name: ccisnedev
  identity_name: ccisnedev.denguebot
  publisher: CN=4B15AF1A-93BD-46AA-83E3-7ACCDFF6D960
  logo_path: windows/runner/resources/app_icon.ico
  capabilities: internetClient
  app_installer:
    uri: https://your-download-link.com/denguebot.msix
    hours_between_update_checks: 0
    show_prompt: truey

