FROM keycloak/keycloak:26.0.5 AS builder

WORKDIR /opt/keycloak
ENV KC_DB=postgres
RUN /opt/keycloak/bin/kc.sh build

FROM keycloak/keycloak:26.0.5
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized"]

