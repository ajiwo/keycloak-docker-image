FROM keycloak/keycloak:23.0.6 AS builder

WORKDIR /opt/keycloak

ENV KC_DB=oracle
RUN /opt/keycloak/bin/kc.sh build

FROM keycloak/keycloak:23.0.6
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized"]

