package global.anderseknert.kubernetes

opa_container := {
  "image": "openpolicyagent/opa:0.21.0-istio",
  "name": "opa",
  "args": [
    "run",
    "--server",
    "--config-file=/config/config.yaml",
    "--addr=localhost:8181",
    "--diagnostic-addr=0.0.0.0:8282",
    "/policy/policy.rego",
  ],
  "volumeMounts": [{
    "mountPath": "/config",
    "name": "opa-istio-config",
  }, {
    "mountPath": "/policy",
    "name": "opa-policy",
  }],
  "readinessProbe": {
    "httpGet": {
      "path": "/health?plugins",
      "port": 8282,
    },
  },
  "livenessProbe": {
    "httpGet": {
      "path": "/health?plugins",
      "port": 8282,
    },
  }
}