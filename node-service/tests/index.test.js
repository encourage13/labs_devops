const request = require('supertest');
const app = require('../src/index');

describe('Node.js service', () => {
    test('GET /health returns ok', async () => {
        const res = await request(app).get('/health');
        expect(res.statusCode).toBe(200);
        expect(res.body.status).toBe('ok');
    });

    test('GET /hello returns message', async () => {
        const res = await request(app).get('/hello');
        expect(res.statusCode).toBe(200);
        expect(res.body.message).toBe('Hello from Node.js service');
    });
});