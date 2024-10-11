<?php
// Configuraciones de conexión a la base de datos
$servername = "localhost"; 
$username = "root";
$password = ""; 
$dbname = "orbitalobjectsdb"; 

// Crear conexión
$conn = new mysqli($servername, $username, $password, $dbname);

// Verificar conexión
if ($conn->connect_error) {
    die("Error de conexión: " . $conn->connect_error);
}

// Consulta SQL para obtener asteroides con tp_cal en el año 2024
$sql = "SELECT * FROM asteroids WHERE YEAR(tp_cal) = 2024";
$result = $conn->query($sql);

// Verificar si hay resultados
if ($result->num_rows > 0) {
    // Crear un array para almacenar los resultados
    $asteroids = array();

    // Recorrer los resultados
    while ($row = $result->fetch_assoc()) {
        $asteroids[] = $row;
    }

    // Devolver los resultados como JSON
    header('Content-Type: application/json');
    echo json_encode($asteroids);
} else {
    // Si no hay resultados, devolver un mensaje vacío
    echo json_encode([]);
}

// Cerrar conexión
$conn->close();
?>
