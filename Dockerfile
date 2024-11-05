FROM keycloak/keycloak:26.0.5 AS builder

WORKDIR /opt/keycloak
ADD --chown=keycloak:keycloak --chmod=644 https://repo1.maven.org/maven2/com/oracle/database/jdbc/ojdbc11/23.5.0.24.07/ojdbc11-23.5.0.24.07.jar /opt/keycloak/providers/ojdbc11.jar
ADD --chown=keycloak:keycloak --chmod=644 https://repo1.maven.org/maven2/com/oracle/database/nls/orai18n/23.5.0.24.07/orai18n-23.5.0.24.07.jar /opt/keycloak/providers/orai18n.jar

ENV KC_DB=oracle
RUN /opt/keycloak/bin/kc.sh build

FROM keycloak/keycloak:26.0.5
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized"]

