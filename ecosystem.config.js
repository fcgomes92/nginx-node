module.exports = [
  {
    script: "/app/server/server.js",
    name: "server",
    exec_mode: "cluster",
    instances: 1
  }
];
