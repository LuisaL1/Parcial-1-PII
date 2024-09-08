package co.edu.cue.parcial1_p2.DAO;

import co.edu.cue.parcial1_p2.model.Competidor;

import java.io.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Random;
public class CompetidorDAO {
    private static final String FILE_PATH = "competidores.csv";
    private List<Competidor> listaCompetidores;

    public CompetidorDAO() {
        listaCompetidores = new ArrayList<>();
        cargarCompetidoresDesdeArchivo();
    }

    public void agregarCompetidor(Competidor competidor) {
        listaCompetidores.add(competidor);
        guardarCompetidoresEnArchivo();
    }

    public List<Competidor> listarCompetidores() {
        return listaCompetidores;
    }

    public void eliminarTodosCompetidores() {
        listaCompetidores.clear();
        guardarCompetidoresEnArchivo();
    }

    public void eliminarTodosYAgregarAleatorio() {
        eliminarTodosCompetidores();
        Competidor competidorAleatorio = generarCompetidorAleatorio();
        agregarCompetidor(competidorAleatorio);
    }

    public List<Competidor> obtenerTopTresCompetidores() {
        listaCompetidores.sort((c1, c2) -> Integer.compare(c2.getPuntajeTotal(), c1.getPuntajeTotal()));
        // Obtener los primeros tres competidores
        return listaCompetidores.size() > 3 ? listaCompetidores.subList(0, 3) : listaCompetidores;
    }

    private void guardarCompetidoresEnArchivo() {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Competidor competidor : listaCompetidores) {
                writer.write(competidor.toCSV());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private void cargarCompetidoresDesdeArchivo() {
        File file = new File(FILE_PATH);
        if (!file.exists()) {
            return;
        }
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                try {
                    Competidor competidor = Competidor.fromCSV(line);
                    listaCompetidores.add(competidor);
                } catch (IllegalArgumentException e) {
                    System.err.println("Error processing line: " + line);
                    e.printStackTrace();
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private Competidor generarCompetidorAleatorio() {
        Random random = new Random();
        String nombres = "Competidor" + random.nextInt(1000);
        String apellidos = "Apellidos" + random.nextInt(1000);
        String id = "ID" + random.nextInt(1000);
        LocalDate fechaNacimiento = LocalDate.of(random.nextInt(30) + 1980, random.nextInt(12) + 1, random.nextInt(28) + 1);
        String pais = "Pais" + random.nextInt(1000);
        String codigoPais = "CP" + random.nextInt(1000);

        List<Integer> rondas = new ArrayList<>();
        for (int i = 0; i < 3; i++) {
            rondas.add(random.nextInt(10) + 1);
        }

        int puntajeTotal = calcularPuntajeTotal(rondas);

        return new Competidor(nombres, apellidos, id, fechaNacimiento, pais, codigoPais, rondas, 0, "", puntajeTotal);
    }

    private int calcularPuntajeTotal(List<Integer> rondas) {
        int puntaje = 0;
        for (int ronda : rondas) {
            switch (ronda) {
                case 1: puntaje += 10; break;
                case 2: puntaje += 8; break;
                case 3: puntaje += 6; break;
                case 4: puntaje += 5; break;
                case 5: puntaje += 4; break;
                case 6: puntaje += 3; break;
                case 7: puntaje += 2; break;
                case 8: puntaje += 1; break;
                case 9: case 10: puntaje += 0; break;
                default: throw new IllegalArgumentException("Posición de ronda inválida");
            }
        }
        return puntaje;
    }
}





