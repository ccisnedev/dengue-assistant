# Firma para Windows Store

## ✅ Opción recomendada

Generar un certificado autofirmado `.pfx` (válido para pruebas y Store si no tienes CA comercial).

---

## 🛠 Paso 1: Crear el .pfx autofirmado desde PowerShell

Abre **PowerShell como Administrador** y ejecuta:

```powershell
$cert = New-SelfSignedCertificate -Type CodeSigningCert -Subject "CN=ccisnedev-open" -CertStoreLocation "Cert:\CurrentUser\My" -KeyExportPolicy Exportable -KeySpec Signature

$pwd = ConvertTo-SecureString -String "1234" -Force -AsPlainText

Export-PfxCertificate -Cert $cert -FilePath "$env:USERPROFILE\Desktop\denguebot_cert.pfx" -Password $pwd
```

Esto generará un archivo:

- 📄 `denguebot_cert.pfx` en tu escritorio
- 🔐 **Contraseña:** `1234` (puedes cambiarla si lo deseas)

---

## 🔏 Paso 2: Usar el .pfx en MSIX Packaging Tool

En el menú **Signing preference**, selecciona:

- 👉 **Sign with a certificate (.pfx)**

Te pedirá:

- **Ruta del archivo .pfx:**  
  `C:\Users\TuUsuario\Desktop\denguebot_cert.pfx`
- **Contraseña:**  
  `1234`

Marca la opción:

- ☑️ **Check this box if this app installs silently by default**  
  (ya que no hay asistente de instalación para Flutter .exe)

Haz clic en **Next** para continuar con la configuración del paquete.