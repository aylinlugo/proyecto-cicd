const request = require('supertest');
const app = require('../index');

test('GET /health debe devolver 200', async () => {
  const res = await request(app).get('/health');
  expect(res.statusCode).toBe(200);
  expect(res.body.status).toBe("ok");
});
