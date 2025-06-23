# Dengue Assistant Demo

Esta es una implementación web responsiva (mobile-first) del Asistente de Diagnóstico de Dengue.

## Características

- ✅ Diseño mobile-first, funcional en dispositivos móviles y de escritorio
- 💬 Interfaz de chat similar a ChatGPT
- 🌐 Funciona completamente offline (sin conexión a internet)
- 🔄 Cuestionario completo de evaluación de síntomas de dengue
- 📋 Resultados inmediatos con recomendaciones según los síntomas
- 🔒 Página de [Política de Privacidad](privacidad.html) incluida

## Uso del Asistente

1. Abre `index.html` en cualquier navegador moderno
2. Haz clic en "Enviar" para comenzar el cuestionario
3. Contesta cada pregunta seleccionando una opción o escribiendo el número correspondiente
4. Al finalizar, recibirás un diagnóstico orientativo basado en tus respuestas
5. Puedes reiniciar el cuestionario con el botón que aparece al final

## Cómo modificar el cuestionario

El cuestionario está implementado en el archivo `script.js`. Para modificarlo:

### Añadir o modificar preguntas

Las preguntas se definen en el arreglo `questionnaire`, que contiene objetos con la siguiente estructura:

```javascript
{
    id: "identificadorUnico",
    type: "question", // Puede ser "question" o "message"
    text: "Texto de la pregunta",
    options: [ // Solo si type es "question"
        { value: 1, text: "Sí" },
        { value: 2, text: "No" }
    ]
}
```

Para añadir una nueva pregunta, agrega un nuevo objeto al arreglo `questionnaire` siguiendo el formato anterior.

### Modificar la lógica de evaluación

La lógica de evaluación se encuentra en la función `calculateResults()`:

1. El conteo de síntomas iniciales se realiza verificando cada respuesta asociada a síntomas
2. La identificación de signos de alarma verifica respuestas asociadas a complicaciones
3. La determinación de "caso probable de dengue" combina fiebre y número de síntomas iniciales

Para modificar esta lógica, actualiza la función `calculateResults()` según sea necesario.

### Modificar las recomendaciones finales

Las recomendaciones finales se muestran en la función `displayResults()`. Para modificarlas, actualiza los mensajes en esa función.

## Estructura de archivos

- `index.html`: Estructura HTML básica
- `style.css`: Estilos CSS para la aplicación
- `script.js`: Lógica del cuestionario y manejo de la interfaz
- `test.html`: Herramienta para verificar el funcionamiento correcto

## Nota sobre el desarrollo

Esta implementación está basada en el pseudocódigo original ubicado en `/pseint/diagnostico_dengue.psc`. Cualquier modificación importante al algoritmo de diagnóstico debe ser reflejada en ambos archivos para mantener la consistencia.