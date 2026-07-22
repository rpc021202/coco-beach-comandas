const express = require('express');
const http = require('http');
const WebSocket = require('ws');
const path = require('path');

const app = express();
const server = http.createServer(app);
const wss = new WebSocket.Server({ server });

app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

// ─── WebSocket broadcast ─────────────────────────────────────────────────────
function broadcast(data) {
  wss.clients.forEach(client => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(JSON.stringify(data));
    }
  });
}

// ─── Pedidos en memoria ──────────────────────────────────────────────────────
let orders = [];
let counter = 1;

// ─── Rutas API ───────────────────────────────────────────────────────────────
app.post('/comanda', (req, res) => {
  const comanda = {
    id: counter++,
    mesa: req.body.mesa,
    items: req.body.items,
    nota: req.body.nota || '',
    timestamp: new Date().toISOString(),
    estado: 'pendiente'
  };

  orders.push(comanda);
  broadcast({ type: 'nueva_comanda', comanda });
  res.json({ ok: true, id: comanda.id });
});

app.post('/comanda/:id/completar', (req, res) => {
  const order = orders.find(o => o.id == req.params.id);
  if (order) {
    order.estado = 'completada';
    broadcast({ type: 'comanda_completada', id: order.id });
  }
  res.json({ ok: true });
});

app.get('/api/orders', (req, res) => {
  res.json(orders.filter(o => o.estado === 'pendiente'));
});

// ─── Arranque ────────────────────────────────────────────────────────────────
const PORT = process.env.PORT || 3000;
server.listen(PORT, '0.0.0.0', () => {
  console.log('COCO BEACH - Servidor activo en puerto ' + PORT);
});
