console.log("===> Iniciando Mini App Gestión de Tareas");

// Lista de tareas (simulada en memoria)
let tareas = [];

// Función para agregar tarea
function agregarTarea(titulo) {
    const tarea = { id: tareas.length + 1, titulo, completada: false };
    tareas.push(tarea);
    console.log(`Tarea agregada: ${titulo}`);
}

// Función para listar tareas
function listarTareas() {
    console.log("=== Lista de Tareas ===");
    if (tareas.length === 0) {
        console.log("No hay tareas");
    } else {
        tareas.forEach(t => {
            console.log(`#${t.id} - ${t.titulo} [${t.completada ? "✅" : "❌"}]`);
        });
    }
}

// Función para marcar como completada
function completarTarea(id) {
    const tarea = tareas.find(t => t.id === id);
    if (tarea) {
        tarea.completada = true;
        console.log(`Tarea completada: ${tarea.titulo}`);
    } else {
        console.log(`Tarea con ID ${id} no encontrada`);
    }
}

// Simulación de uso
agregarTarea("Preparar documentación CI/CD");
agregarTarea("Subir cambios a GitHub");
listarTareas();
completarTarea(1);
listarTareas();

console.log("Mini App CI/CD ejecutada correctamente");
