When you run `curl https://example.com` from a pod with an Istio sidecar:

1. **Curl Command Execution**:
   - The application container executes `curl https://example.com`.

2. **Traffic Interception by Envoy Sidecar**:
   - Envoy sidecar intercepts the outbound HTTP request using iptables rules.

3. **Envoy Sidecar Processing**:
   - Envoy checks the request against egress policies and routing rules.

4. **DNS Resolution**:
   - Envoy resolves `example.com` to an IP address.

5. **TLS Handshake**:
   - Envoy initiates a TLS handshake with `example.com`.

6. **Request Forwarding**:
   - Envoy forwards the HTTPS request to `example.com`.

7. **(Optional) Egress Gateway Processing**:
   - If configured, the request is routed through the Egress Gateway, which applies additional policies and forwards the request to `example.com`.

8. **External Service (example.com) Response**:
   - `example.com` processes the request and sends back an HTTP response.

9. **Envoy Receives and Processes Response**:
   - Envoy receives the response, applies any configured response policies, and forwards it to the application container.

10. **Curl Command Receives Response**:
    - The application container receives and displays the response from `example.com`.

