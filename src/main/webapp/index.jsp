<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="co.edu.cue.parcial1_p2.model.Competidor" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clasificación Olímpica de BMX</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/css/bootstrap.min.css">
    <style>
        body {
            padding-top: 70px;
            background-color: #f8f9fa;
        }
        .container {
            max-width: 600px;
        }
        header, footer {
            background-color: #343a40;
            color: #ffffff;
            padding: 15px 0;
        }
        .form-control, .form-select, .btn {
            border-radius: 0.25rem;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
        }
        .btn-primary:hover {
            background-color: #0056b3;
        }
        .form-label {
            font-weight: bold;
        }
        footer p {
            margin: 0;
        }
    </style>
</head>
<body>
<header>
    <div class="container text-center">
        <h1>Clasificación Olímpica de BMX</h1>
    </div>
</header>

<main>
    <div class="container mt-4">
        <form action="gestionarCompetidores" method="post">
            <input type="hidden" name="accion" value="agregar">
            <fieldset>
                <legend class="mb-4">Agregar Competidor</legend>
                <div class="mb-3">
                    <label for="nombres" class="form-label">Nombres:</label>
                    <input type="text" id="nombres" name="nombres" class="form-control" maxlength="40" required>
                </div>
                <div class="mb-3">
                    <label for="apellidos" class="form-label">Apellidos:</label>
                    <input type="text" id="apellidos" name="apellidos" class="form-control" maxlength="40" required>
                </div>
                <div class="mb-3">
                    <label for="fechaNacimiento" class="form-label">Fecha de Nacimiento:</label>
                    <input type="date" id="fechaNacimiento" name="fechaNacimiento" class="form-control" required>
                </div>
                <div class="mb-3">
                    <label for="pais" class="form-label">País:</label>
                    <select id="pais" name="pais" class="form-select" required onchange="updateCodigoPais()">
                        <option value="" disabled selected>Seleccionar país</option>
                        <%
                            for (String pais : Competidor.getListaPaises().keySet()) {
                        %>
                        <option value="<%= pais %>"><%= pais %></option>
                        <% } %>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="codigoPais" class="form-label">Código País:</label>
                    <input type="text" id="codigoPais" name="codigoPais" class="form-control" readonly>
                </div>
                <div class="mb-3">
                    <label for="ronda1" class="form-label">Ronda 1:</label>
                    <input type="number" id="ronda1" name="ronda1" class="form-control" min="0" max="10" value="0" required>
                </div>
                <div class="mb-3">
                    <label for="ronda2" class="form-label">Ronda 2:</label>
                    <input type="number" id="ronda2" name="ronda2" class="form-control" min="0" max="10" value="0" required>
                </div>
                <div class="mb-3">
                    <label for="ronda3" class="form-label">Ronda 3:</label>
                    <input type="number" id="ronda3" name="ronda3" class="form-control" min="0" max="10" value="0" required>
                </div>
                <div class="mb-3">
                    <label for="descripcion" class="form-label">Descripción:</label>
                    <textarea id="descripcion" name="descripcion" class="form-control" maxlength="200"></textarea>
                </div>
                <button href="inicioTablaCompetidores.jsp" type="submit" class="btn btn-primary">Agregar Competidor</button>
            </fieldset>
        </form>
    </div>
</main>

<footer>
    <div class="container text-center">
        <p>&copy; 2024 - Maria Luisa Londoño Moncada</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/5.3.0/js/bootstrap.min.js"></script>
<script>
    function updateCodigoPais() {
        var paisSelect = document.getElementById("pais");
        var codigoPaisInput = document.getElementById("codigoPais");
        var paises = {
            "Colombia": "COL",
            "Brasil": "BRA",
            "Francia": "FRA",
            "Suiza": "SUI",
            "Australia": "AUS",
            "Italia": "ITA",
            "Paises Bajos": "NED",
            "Nueva Zelandia": "NZL",
            "Gran Bretaña": "GBR",
            "Chile": "CHI",
            "Argentina": "ARG",
            "Bélgica": "BEL",
            "Alemania": "GER",
            "Marruecos": "MAR",
            "Tailandia": "THA",
            "Letonia": "LAT",
            "Bolivia": "BOL",
            "España": "ESP",
            "México": "MEX",
            "Perú": "PER"
        };
        var paisSeleccionado = paisSelect.value;
        codigoPaisInput.value = paises[paisSeleccionado] || "";
    }
</script>
<script>
    document.querySelector("form").addEventListener("submit", function(event) {
        var fechaNacimiento = document.getElementById("fechaNacimiento").value;
        if (fechaNacimiento) {
            var fecha = new Date(fechaNacimiento);
            var hoy = new Date();
            var edad = hoy.getFullYear() - fecha.getFullYear();
            var m = hoy.getMonth() - fecha.getMonth();
            if (m < 0 || (m === 0 && hoy.getDate() < fecha.getDate())) {
                edad--;
            }
            if (edad < 12) {
                alert("El competidor debe tener al menos 12 años.");
                event.preventDefault(); // Previene el envío del formulario
            }
        }
    });
</script>
</body>
</html>



