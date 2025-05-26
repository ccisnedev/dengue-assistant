/**
 * Dengue Assistant - Implementación web del cuestionario de diagnóstico de dengue
 */

// Estado de la aplicación
const state = {
    currentQuestion: 0,
    answers: {},
    sintomasIniciales: 0,
    signosAlarma: 0,
    probableDengue: false,
    questionnaire: [],
    questionsActive: false
};

// Definición del cuestionario basado en el pseudocódigo original
const questionnaire = [
    {
        id: "welcome",
        type: "message",
        text: "Bienvenido al Asistente de Diagnóstico de Dengue. Este asistente te hará unas preguntas para evaluar tus síntomas. Presiona 'Iniciar' para comenzar.",
        options: null
    },
    {
        id: "fiebre",
        type: "question",
        text: "1. ¿Tiene fiebre actualmente o en los últimos días?",
        options: [
            { value: 1, text: "Sí" },
            { value: 2, text: "No" }
        ]
    },
    {
        id: "dolorCabeza",
        type: "question",
        text: "2. ¿Ha tenido dolor de cabeza muy intenso?",
        options: [
            { value: 1, text: "Sí" },
            { value: 2, text: "No" }
        ]
    },
    {
        id: "dolorMuscular",
        type: "question",
        text: "3. ¿Siente dolores fuertes en músculos o articulaciones?",
        options: [
            { value: 1, text: "Sí" },
            { value: 2, text: "No" }
        ]
    },
    {
        id: "dolorOcular",
        type: "question",
        text: "4. ¿Siente dolor detrás de los ojos al moverlos o mirar?",
        options: [
            { value: 1, text: "Sí" },
            { value: 2, text: "No" }
        ]
    },
    {
        id: "nauseas",
        type: "question",
        text: "5. ¿Ha tenido náuseas o vómitos?",
        options: [
            { value: 1, text: "Sí" },
            { value: 2, text: "No" }
        ]
    },
    {
        id: "rash",
        type: "question",
        text: "6. ¿Ha notado sarpullido o erupciones en la piel?",
        options: [
            { value: 1, text: "Sí" },
            { value: 2, text: "No" }
        ]
    },
    {
        id: "dolorAbdomen",
        type: "question",
        text: "7. ¿Tiene dolor abdominal muy fuerte?",
        options: [
            { value: 1, text: "Sí" },
            { value: 2, text: "No" }
        ]
    },
    {
        id: "sangrado",
        type: "question",
        text: "8. ¿Ha notado algún sangrado inusual?",
        options: [
            { value: 1, text: "Sí" },
            { value: 2, text: "No" }
        ]
    },
    {
        id: "debilidad",
        type: "question",
        text: "9. ¿Se siente extremadamente débil, somnoliento/a o muy inquieto/a?",
        options: [
            { value: 1, text: "Sí" },
            { value: 2, text: "No" }
        ]
    },
    {
        id: "dificultadRespirar",
        type: "question",
        text: "10. ¿Tiene dificultad para respirar o respiración muy acelerada?",
        options: [
            { value: 1, text: "Sí" },
            { value: 2, text: "No" }
        ]
    },
    {
        id: "zonaRiesgo",
        type: "question",
        text: "11. ¿Vive o viajó recientemente en una zona con casos de dengue?",
        options: [
            { value: 1, text: "Sí" },
            { value: 2, text: "No" },
            { value: 3, text: "No sabe" }
        ]
    }
];

// Elementos del DOM
const messageArea = document.getElementById('message-area');
const chatContainer = document.getElementById('chat-container');
const actionContainer = document.getElementById('action-container');
const startWrapper = document.getElementById('start-wrapper');
const startButton = document.getElementById('start-button');
const optionsContainer = document.getElementById('options-container');

// Inicializar la aplicación
function init() {
    state.questionnaire = [...questionnaire];
    messageArea.innerHTML = '';
    displayMessage(state.questionnaire[0].text, 'assistant');
    setupEventListeners();
    state.currentQuestion = 0;
    startWrapper.style.display = 'flex';
    optionsContainer.style.display = 'none';
}

// Configurar escuchadores de eventos
function setupEventListeners() {
    startButton.addEventListener('click', handleStart);
}

// Manejar el inicio del cuestionario
function handleStart() {
    state.questionsActive = true;
    startWrapper.style.display = 'none';
    optionsContainer.style.display = 'flex';
    displayMessage("Comenzando el cuestionario...", 'system');
    askNextQuestion();
}

// Manejar la selección de opción (solo botones)
function handleOptionSelect(optionIndex) {
    const currentQ = state.questionnaire[state.currentQuestion];
    // Mostrar respuesta del usuario en el chat
    displayMessage(currentQ.options[optionIndex].text, 'user');
    // Guardar respuesta
    state.answers[currentQ.id] = optionIndex + 1;
    // Avanzar al siguiente
    state.currentQuestion++;
    setTimeout(() => {
        if (state.currentQuestion < state.questionnaire.length) {
            askNextQuestion();
        } else {
            calculateResults();
            displayResults();
        }
    }, 800);
}

// Mostrar la siguiente pregunta
function askNextQuestion() {
    if (state.currentQuestion >= state.questionnaire.length || state.currentQuestion < 0) {
        return;
    }
    
    state.currentQuestion++;

    const currentQ = state.questionnaire[state.currentQuestion];
    displayMessage(currentQ.text, 'assistant');

    // Mostrar cada opción como mensaje separado para mejor visibilidad
    setTimeout(() => {
        currentQ.options.forEach((opt, index) => {
            displayMessage(`   ${index + 1} = ${opt.text}`, 'assistant');
        });
        displayMessage('   (Selecciona una opción)', 'assistant');
        showOptions(currentQ.options);
    }, 500);
}

// Mostrar opciones como botones
function showOptions(options) {
    optionsContainer.style.display = 'flex';
    optionsContainer.innerHTML = '';
    options.forEach((option, index) => {
        const button = document.createElement('button');
        button.className = 'option-button';
        button.textContent = `${index + 1}: ${option.text}`;
        button.onclick = () => {
            handleOptionSelect(index);
            // Ocultar opciones después de seleccionar
            optionsContainer.style.display = 'none';
        };
        optionsContainer.appendChild(button);
    });
}

// Calcular resultados basados en las respuestas
function calculateResults() {
    // Contar síntomas iniciales
    if (state.answers.dolorCabeza === 1) state.sintomasIniciales++;
    if (state.answers.dolorMuscular === 1) state.sintomasIniciales++;
    if (state.answers.dolorOcular === 1) state.sintomasIniciales++;
    if (state.answers.nauseas === 1) state.sintomasIniciales++;
    if (state.answers.rash === 1) state.sintomasIniciales++;
    
    // Identificar signos de alarma
    if (state.answers.dolorAbdomen === 1) state.signosAlarma++;
    if (state.answers.sangrado === 1) state.signosAlarma++;
    if (state.answers.debilidad === 1) state.signosAlarma++;
    if (state.answers.dificultadRespirar === 1) state.signosAlarma++;
    
    // Determinar caso probable de dengue
    state.probableDengue = (state.answers.fiebre === 1 && state.sintomasIniciales >= 2);
}

// Mostrar resultados finales
function displayResults() {
    displayMessage("Analizando sus respuestas...", 'system');
    
    setTimeout(() => {
        displayMessage("*************************\n*   RESULTADO FINAL   *\n*************************", 'assistant');

        setTimeout(() => {
            if (state.signosAlarma > 0) {
                displayMessage("[!] SIGNOS DE ALARMA DETECTADOS: POSIBLE DENGUE GRAVE\n    --> BUSQUE ATENCIÓN MÉDICA DE INMEDIATO <--", 'assistant urgent');
            } else if (state.probableDengue) {
                displayMessage("[!] POSIBLE DENGUE NO GRAVE\n    Acuda a evaluación médica lo antes posible.", 'assistant');
            } else {
                displayMessage("[ ] POCO PROBABLE DENGUE\n    Si sus síntomas persisten o empeoran, consulte con un médico.", 'assistant');
            }
            
            // Mostrar botón de reinicio
            setTimeout(showRestartButton, 1000);
        }, 1000);
    }, 1000);
}

// Mostrar botón de reinicio
function showRestartButton() {
    optionsContainer.style.display = 'flex';
    optionsContainer.innerHTML = '';

    const restartButton = document.createElement('button');
    restartButton.className = 'restart-button';
    restartButton.textContent = 'Reiniciar Cuestionario';
    restartButton.onclick = resetQuestionnaire;

    optionsContainer.appendChild(restartButton);

    setTimeout(scrollToBottom, 0);
}

// Reiniciar el cuestionario
function resetQuestionnaire() {
    // Limpiar estado
    state.currentQuestion = 0;
    state.answers = {};
    state.sintomasIniciales = 0;
    state.signosAlarma = 0;
    state.probableDengue = false;
    state.questionsActive = false;

    // Limpiar UI
    messageArea.innerHTML = '';
    optionsContainer.innerHTML = '';
    optionsContainer.style.display = 'none';
    startWrapper.style.display = 'flex';

    // Mostrar mensaje de bienvenida al reiniciar
    displayMessage(state.questionnaire[0].text, 'assistant');
}

// Mostrar un mensaje en el área de chat
function displayMessage(text, type) {
    const messageElement = document.createElement('div');
    messageElement.className = `message ${type}`;
    const formattedText = text.replace(/\n/g, '<br>');
    messageElement.innerHTML = formattedText;
    messageArea.appendChild(messageElement);

    // Espera a que el DOM pinte el mensaje antes de hacer scroll
    setTimeout(scrollToBottom, 0);
}

function scrollToBottom() {
    chatContainer.scrollTop = chatContainer.scrollHeight;
}

// Ajusta el espacio inferior dinámicamente según el área segura del dispositivo (opcional avanzado)
function adjustBottomSpacer() {
    const spacer = document.getElementById('bottom-spacer');
    if (window.visualViewport) {
        // Usa visualViewport si está disponible
        const extra = window.innerHeight - window.visualViewport.height;
        spacer.style.height = (extra > 0 ? extra : 0) + 'px';
    }
}
window.addEventListener('resize', adjustBottomSpacer);
window.addEventListener('orientationchange', adjustBottomSpacer);
document.addEventListener('DOMContentLoaded', adjustBottomSpacer);

// Iniciar la aplicación cuando se carga la página
document.addEventListener('DOMContentLoaded', init);