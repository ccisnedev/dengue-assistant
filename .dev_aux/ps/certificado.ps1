$cert = New-SelfSignedCertificate `
  -Type CodeSigningCert `
  -Subject "CN=4B15AF1A-93BD-46AA-83E3-7ACCDFF6D960" `
  -CertStoreLocation "Cert:\CurrentUser\My" `
  -KeyAlgorithm RSA `
  -KeyLength 2048 `
  -KeyExportPolicy Exportable `
  -HashAlgorithm SHA256 `
  -KeyUsage DigitalSignature `
  -NotAfter (Get-Date).AddYears(2)

$certPwd = ConvertTo-SecureString -String "cc1sn3d3v" -Force -AsPlainText

Export-PfxCertificate `
  -Cert $cert `
  -FilePath ".\.dev_aux\ps\denguebot_cert.pfx" `
  -Password $certPwd
