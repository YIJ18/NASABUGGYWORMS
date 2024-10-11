<?php
// Conexión a la base de datos
$host = "localhost";
$username = "root"; // Cambiar si es necesario
$password = ""; // Cambiar si es necesario
$database = "orbitalobjectsdb"; // Cambiar si es necesario

$conn = new mysqli($host, $username, $password, $database);

if ($conn->connect_error) {
    die("Error en la conexión: " . $conn->connect_error);
}

// Consulta para obtener los cometas que contengan "2024" en tp_cal
$sql = "SELECT name, diameter, eccentricity, inclination, perihelion, M1, Q, n, tp_cal FROM comets WHERE tp_cal LIKE '%2024%'";
$result = $conn->query($sql);

$comets = [];

if ($result->num_rows > 0) {
    // Procesar cada fila
    while($row = $result->fetch_assoc()) {
        $comets[] = [
            "name" => $row["name"],
            // Verificar si el diámetro es 0 y asignar 0.5 si es necesario
            "diameter" => (float)$row["diameter"] == 0 ? 0.5 : (float)$row["diameter"],
            "eccentricity" => (float)$row["eccentricity"],
            "inclination" => (float)$row["inclination"],
            "perihelion" => (float)$row["perihelion"],
            "M1" => (float)$row["M1"],
            "Q" => (float)$row["Q"],
            "n" => (float)$row["n"],
            "tp_cal" => $row["tp_cal"]
        ];
    }
}

// Devolver los cometas en formato JSON
echo json_encode(["comets" => $comets]);

$conn->close();
?>
