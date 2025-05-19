// Diagnóstico de dengue
// @ccisnedev

Proceso DiagnosticoDengue
    // Definición de variables
    Definir fiebre, dolorCabeza, dolorMuscular, dolorOcular, nauseas, rash, dolorAbdomen, sangrado, debilidad, dificultadRespirar, zonaRiesgo Como Entero
    Definir diasFiebre, intensidadFiebre, vecesVomito Como Entero
    Definir tipoSangrado Como Cadena
    Definir sintomasIniciales, signosAlarma Como Entero
    Definir probableDengue Como Logico
	
    // Inicializar contadores
    sintomasIniciales <- 0
    signosAlarma <- 0
	
    // 1. Fiebre
    Escribir "1. ¿Tiene fiebre actualmente o en los últimos días?"
    Escribir "   1 = SI         2 = NO"
    Escribir "   (Escribe solo el número)"
    Leer fiebre
    Si fiebre = 1 Entonces
        Escribir "   ¿Cuántos días lleva con fiebre? (número entero)"
        Leer diasFiebre
        Escribir "   ¿Qué tan alta diría que es la fiebre?"
        Escribir "   (1=Moderada, 2=Alta, 3=Muy alta)"
        Leer intensidadFiebre
    FinSi
	
    // 2. Dolor de cabeza
    Escribir "2. ¿Ha tenido dolor de cabeza muy intenso?"
    Escribir "   1 = SI         2 = NO"
    Escribir "   (Escribe solo el número)"
    Leer dolorCabeza
	
    // 3. Dolores musculares/articulares
    Escribir "3. ¿Siente dolores fuertes en músculos o articulaciones?"
    Escribir "   1 = SI         2 = NO"
    Escribir "   (Escribe solo el número)"
    Leer dolorMuscular
	
    // 4. Dolor retro-ocular
    Escribir "4. ¿Siente dolor detrás de los ojos al moverlos o mirar?"
    Escribir "   1 = SI         2 = NO"
    Escribir "   (Escribe solo el número)"
    Leer dolorOcular
	
    // 5. Náuseas o vómitos
    Escribir "5. ¿Ha tenido náuseas o vómitos?"
    Escribir "   1 = SI         2 = NO"
    Escribir "   (Escribe solo el número)"
    Leer nauseas
    Si nauseas = 1 Entonces
        Escribir "   ¿Cuántas veces vomitó en 24 horas? (número entero)"
        Leer vecesVomito
    FinSi
	
    // 6. Erupción cutánea
    Escribir "6. ¿Ha notado sarpullido o erupciones en la piel?"
    Escribir "   1 = SI         2 = NO"
    Escribir "   (Escribe solo el número)"
    Leer rash
	
    // 7. Dolor abdominal intenso (signo de alarma)
    Escribir "7 ¿Tiene dolor abdominal muy fuerte? (SI/NO)"
    Leer dolorAbdomen
    dolorAbdomen <- dolorAbdomen
	
    // 8. Sangrado inusual (signo de alarma)
    Escribir "8 ¿Ha notado algún sangrado inusual? (SI/NO)"
    Leer sangrado
    sangrado <- sangrado
    Si sangrado = "SI" Entonces
        Escribir "   ¿De dónde proviene el sangrado?"
        Escribir "   (encías/nariz/moretones/vómito con sangre/heces con sangre)"
        Leer tipoSangrado
    FinSi
	
    // 9. Debilidad extrema o irritabilidad (signo de alarma)
    Escribir "9 ¿Se siente extremadamente débil, somnoliento/a o muy inquieto/a? (SI/NO)"
    Leer debilidad
    debilidad <- debilidad
	
    // 10. Dificultad para respirar (signo de alarma)
    Escribir "10 ¿Tiene dificultad para respirar o respiración muy acelerada? (SI/NO)"
    Leer dificultadRespirar
    dificultadRespirar <- dificultadRespirar
	
    // 11. Contexto epidemiológico
    Escribir "11 ¿Vive o viaj� recientemente en una zona con casos de dengue? (SI/NO/NO SABE)"
    Leer zonaRiesgo
    zonaRiesgo <- zonaRiesgo
	
    // Contar síntomas iniciales
    Si dolorCabeza = "SI" Entonces
        sintomasIniciales <- sintomasIniciales + 1
    FinSi
    Si dolorMuscular = "SI" Entonces
        sintomasIniciales <- sintomasIniciales + 1
    FinSi
    Si dolorOcular = "SI" Entonces
        sintomasIniciales <- sintomasIniciales + 1
    FinSi
    Si nauseas = "SI" Entonces
        sintomasIniciales <- sintomasIniciales + 1
    FinSi
    Si rash = "SI" Entonces
        sintomasIniciales <- sintomasIniciales + 1
    FinSi
	
    // Identificar signos de alarma
    Si dolorAbdomen = "SI" Entonces
        signosAlarma <- signosAlarma + 1
    FinSi
    Si nauseas = "SI" Y vecesVomito >= 3 Entonces
        signosAlarma <- signosAlarma + 1
    FinSi
    Si sangrado = "SI" Entonces
        signosAlarma <- signosAlarma + 1
    FinSi
    Si debilidad = "SI" Entonces
        signosAlarma <- signosAlarma + 1
    FinSi
    Si dificultadRespirar = "SI" Entonces
        signosAlarma <- signosAlarma + 1
    FinSi
	
    // Determinar caso probable de dengue
    probableDengue <- (fiebre = "SI" Y (sintomasIniciales >= 2))
	
    // Resultado final
    Si signosAlarma > 0 Entonces
        Escribir ""
        Escribir ">>> Signos de alarma detectados: Posible dengue grave."
        Escribir "    **Busque atención médica de inmediato**."
    Sino
        Si probableDengue Entonces
            Escribir ""
            Escribir ">>> Posible dengue no grave."
            Escribir "    Acuda a evaluación médica lo antes posible."
        Sino
            Escribir ""
            Escribir ">>> Poco probable dengue."
            Escribir "    Si sus síntomas persisten o empeoran, consulte con un médico."
        FinSi
    FinSi

FinProceso

