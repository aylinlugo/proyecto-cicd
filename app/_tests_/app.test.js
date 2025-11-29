const request = require('supertest');
const app = require('../index');

describe('Mini App CI/CD - Pruebas', () => {
  test('GET /health devuelve 200 y status ok', async () => {
    const res = await request(app).get('/health');
    expect(res.statusCode).toBe(200);
    expect(res.body.status).toBe("ok");
  });

  test('GET / devuelve página con lista de tareas', async () => {
    const res = await request(app).get('/');
    expect(res.statusCode).toBe(200);
    expect(res.text).toContain('Mini App CI/CD - Gestión de Tareas');
  });

  test('POST /agregar agrega una tarea correctamente', async () => {
    // Enviar datos como form-urlencoded para que bodyParser.urlencoded los lea
    await request(app)
      .post('/agregar')
      .type('form')
      .send({ titulo: 'Tarea de prueba' })
      .expect(302); // redirección después de agregar

    const res2 = await request(app).get('/');
    expect(res2.text).toContain('Tarea de prueba');
  });

  test('GET /completar/:id marca la tarea como completada', async () => {
    // Agregar una tarea nueva para completar
    await request(app)
      .post('/agregar')
      .type('form')
      .send({ titulo: 'Completar tarea' });

    const res = await request(app).get('/completar/2'); // ID de la nueva tarea
    expect(res.statusCode).toBe(302);

    const res2 = await request(app).get('/');
    expect(res2.text).toContain('[Completada]');
  });

  test('GET /metrics devuelve métricas de Prometheus', async () => {
    const res = await request(app).get('/metrics');
    expect(res.statusCode).toBe(200);
    expect(res.text).toContain('http_requests_success_total'); // SLI
    expect(res.text).toContain('up'); // otra métrica existente
  });
});
