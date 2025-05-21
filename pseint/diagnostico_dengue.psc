// Diagnóstico de dengue
// @ccisnedev

Proceso DiagnosticoDengue
    // Definición de variables
    Definir fiebre, dolorCabeza, dolorMuscular, dolorOcular, nauseas, rash, dolorAbdomen, sangrado, debilidad, dificultadRespirar, zonaRiesgo Como Entero
    Definir sintomasIniciales, signosAlarma Como Entero
    Definir probableDengue Como Logico
	
    // Inicializar contadores
    sintomasIniciales <- 0
    signosAlarma <- 0
	
    // Encabezado inicial
    Escribir "********************************************"
    Escribir "*     ASISTENTE DE DIAGNÓSTICO DE DENGUE    *"
    Escribir "********************************************"
    Escribir ""
    
    // 1. Fiebre
    Escribir "1. ¿Tiene fiebre actualmente o en los últimos días?"
    Escribir "   1 = SI         2 = NO"
    Escribir "   (Escribe solo el número)"
    Leer fiebre
	
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
	
    // 6. Erupción cutánea
    Escribir "6. ¿Ha notado sarpullido o erupciones en la piel?"
    Escribir "   1 = SI         2 = NO"
    Escribir "   (Escribe solo el número)"
    Leer rash
	
    // 7. Dolor abdominal intenso (signo de alarma)
    Escribir "7. ¿Tiene dolor abdominal muy fuerte?"
    Escribir "   1 = SI         2 = NO"
    Escribir "   (Escribe solo el número)"
    Leer dolorAbdomen
	
    // 8. Sangrado inusual (signo de alarma)
    Escribir "8. ¿Ha notado algún sangrado inusual?"
    Escribir "   1 = SI         2 = NO"
    Escribir "   (Escribe solo el número)"
    Leer sangrado
	
    // 9. Debilidad extrema o irritabilidad (signo de alarma)
    Escribir "9. ¿Se siente extremadamente débil, somnoliento/a o muy inquieto/a?"
    Escribir "   1 = SI         2 = NO"
    Escribir "   (Escribe solo el número)"
    Leer debilidad
	
    // 10. Dificultad para respirar (signo de alarma)
    Escribir "10. ¿Tiene dificultad para respirar o respiración muy acelerada?"
    Escribir "   1 = SI         2 = NO"
    Escribir "   (Escribe solo el número)"
    Leer dificultadRespirar
	
    // 11. Contexto epidemiológico
    Escribir "11. ¿Vive o viajó recientemente en una zona con casos de dengue?"
    Escribir "   1 = SI         2 = NO         3 = NO SABE"
    Escribir "   (Escribe solo el número)"
    Leer zonaRiesgo
	
    // Contar síntomas iniciales
    Si dolorCabeza = 1 Entonces
        sintomasIniciales <- sintomasIniciales + 1
    FinSi
    Si dolorMuscular = 1 Entonces
        sintomasIniciales <- sintomasIniciales + 1
    FinSi
    Si dolorOcular = 1 Entonces
        sintomasIniciales <- sintomasIniciales + 1
    FinSi
    Si nauseas = 1 Entonces
        sintomasIniciales <- sintomasIniciales + 1
    FinSi
    Si rash = 1 Entonces
        sintomasIniciales <- sintomasIniciales + 1
    FinSi
	
    // Identificar signos de alarma
    Si dolorAbdomen = 1 Entonces
        signosAlarma <- signosAlarma + 1
    FinSi
    Si nauseas = 1 Y vecesVomito >= 3 Entonces
        signosAlarma <- signosAlarma + 1
    FinSi
    Si sangrado = 1 Entonces
        signosAlarma <- signosAlarma + 1
    FinSi
    Si debilidad = 1 Entonces
        signosAlarma <- signosAlarma + 1
    FinSi
    Si dificultadRespirar = 1 Entonces
        signosAlarma <- signosAlarma + 1
    FinSi
	
    // Determinar caso probable de dengue
    probableDengue <- (fiebre = 1 Y (sintomasIniciales >= 2))
	
    // Resultado final
    Escribir ""
    Escribir "********************************************"
    Escribir "*              RESULTADO FINAL             *"
    Escribir "********************************************"
    Escribir ""
    
    Si signosAlarma > 0 Entonces
        Escribir "[!] SIGNOS DE ALARMA DETECTADOS: POSIBLE DENGUE GRAVE"
        Escribir "    --> BUSQUE ATENCIÓN MÉDICA DE INMEDIATO <--"
    Sino
        Si probableDengue Entonces
            Escribir ""
            Escribir "[!] POSIBLE DENGUE NO GRAVE"
            Escribir "    Acuda a evaluación médica lo antes posible."
        Sino
            Escribir "[ ] POCO PROBABLE DENGUE"
            Escribir "    Si sus síntomas persisten o empeoran, consulte con un médico."
        FinSi
    FinSi
    
    Escribir ""
    Escribir "--------------------------------------------"

FinProceso