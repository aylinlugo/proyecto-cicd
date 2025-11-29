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
    const res = await request(app)
      .post('/agregar')
      .send('titulo=Mi+primera+tarea')
      .set('Content-Type', 'application/x-www-form-urlencoded');

    expect(res.statusCode).toBe(302); // Redirige a /
    const home = await request(app).get('/');
    expect(home.text).toContain('Mi primera tarea');
  });

  test('GET /completar/:id marca la tarea como completada', async () => {
    await request(app)
      .post('/agregar')
      .send('titulo=Tarea a completar')
      .set('Content-Type', 'application/x-www-form-urlencoded');

    const res = await request(app).get('/completar/1');
    expect(res.statusCode).toBe(302);

    const home = await request(app).get('/');
    expect(home.text).toContain('Completada');
  });

  test('GET /metrics devuelve métricas de Prometheus', async () => {
    const res = await request(app).get('/metrics');
    expect(res.statusCode).toBe(200);
    expect(res.text).toContain('http_requests_total');
    expect(res.text).toContain('http_requests_success_total'); // SLI
  });

});
