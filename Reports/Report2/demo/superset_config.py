import os
from urllib.parse import urlencode

from flask import send_file, Response, redirect, session
from flask_appbuilder import expose
from flask_appbuilder.security.manager import AUTH_OAUTH
from flask_appbuilder.security.views import AuthOAuthView
from flask_login import logout_user
from superset.security import SupersetSecurityManager


# ============================================================
# Configuração base
# ============================================================

SECRET_KEY = os.getenv("SUPERSET_SECRET_KEY")
if not SECRET_KEY:
    raise ValueError("SUPERSET_SECRET_KEY is not set")

KEYCLOAK_CLIENT_SECRET = os.getenv("KEYCLOAK_CLIENT_SECRET")
if not KEYCLOAK_CLIENT_SECRET:
    raise ValueError("KEYCLOAK_CLIENT_SECRET is not set")

SQLALCHEMY_DATABASE_URI = "postgresql+psycopg2://superset:superset@db:5432/biua_dw"


# ============================================================
# Autenticação OAuth/OIDC com Keycloak
# ============================================================
#
# Keycloak:
#   Realm: ua-bi
#   Client ID: superset
#   Redirect URI: http://localhost:8088/oauth-authorized/keycloak
#
# Nota:
# - authorize_url usa localhost porque é o browser que redireciona para o Keycloak.
# - access_token_url e api_base_url usam "keycloak:8080" porque é o container
#   do Superset que comunica internamente com o container do Keycloak.
# ============================================================

AUTH_TYPE = AUTH_OAUTH

AUTH_USER_REGISTRATION = True
AUTH_USER_REGISTRATION_ROLE = "Admin"

# Força sincronização de roles em cada login OAuth
AUTH_ROLES_SYNC_AT_LOGIN = True

# Mapeia roles vindas do OAuth para roles internas do Superset
AUTH_ROLES_MAPPING = {
    "Admin": ["Admin"],
}

KEYCLOAK_PUBLIC_URL = "http://localhost:8081"
KEYCLOAK_INTERNAL_URL = "http://keycloak:8080"
KEYCLOAK_REALM = "ua-bi"
SUPERSET_PUBLIC_URL = "http://localhost:8088"

OAUTH_PROVIDERS = [
    {
        "name": "keycloak",
        "icon": "fa-key",
        "token_key": "access_token",
        "remote_app": {
            "client_id": "superset",
            "client_secret": KEYCLOAK_CLIENT_SECRET,

            # Chamadas internas feitas pelo container do Superset
            "api_base_url": f"{KEYCLOAK_INTERNAL_URL}/realms/{KEYCLOAK_REALM}/protocol/openid-connect/",
            "access_token_url": f"{KEYCLOAK_INTERNAL_URL}/realms/{KEYCLOAK_REALM}/protocol/openid-connect/token",
            "jwks_uri": f"{KEYCLOAK_INTERNAL_URL}/realms/{KEYCLOAK_REALM}/protocol/openid-connect/certs",

            # Redirecionamento feito pelo browser
            "authorize_url": f"{KEYCLOAK_PUBLIC_URL}/realms/{KEYCLOAK_REALM}/protocol/openid-connect/auth",

            "client_kwargs": {
                "scope": "openid email profile"
            },
        },
    }
]


class KeycloakLogoutView(AuthOAuthView):
    @expose("/logout/")
    def logout(self):
        # Guardar o id_token antes de limpar a sessão
        id_token = session.get("keycloak_id_token")

        # Terminar sessão local do Superset
        logout_user()
        session.clear()

        params = {
            "post_logout_redirect_uri": f"{SUPERSET_PUBLIC_URL}/login/",
        }

        # Com id_token_hint, o Keycloak consegue fazer logout sem mostrar
        # a página intermédia de confirmação.
        if id_token:
            params["id_token_hint"] = id_token
        else:
            # Fallback caso não exista id_token guardado
            params["client_id"] = "superset"

        keycloak_logout_url = (
            f"{KEYCLOAK_PUBLIC_URL}/realms/{KEYCLOAK_REALM}"
            f"/protocol/openid-connect/logout?{urlencode(params)}"
        )

        return redirect(keycloak_logout_url)


class KeycloakSecurityManager(SupersetSecurityManager):
    authoauthview = KeycloakLogoutView

    def oauth_user_info(self, provider, response=None):
        if provider == "keycloak":
            if response and response.get("id_token"):
                session["keycloak_id_token"] = response.get("id_token")

            userinfo_response = self.oauth_remotes[provider].get("userinfo")
            userinfo = userinfo_response.json()

            username = (
                userinfo.get("preferred_username")
                or userinfo.get("email")
                or "keycloak_user"
            )

            return {
                "username": username,
                "first_name": userinfo.get("given_name") or userinfo.get("name") or username,
                "last_name": userinfo.get("family_name") or "",
                "email": userinfo.get("email") or f"{username}@local",
                "role_keys": ["Admin"],
            }

        return super().oauth_user_info(provider, response)


CUSTOM_SECURITY_MANAGER = KeycloakSecurityManager


# ============================================================
# Branding / Identidade visual UA
# ============================================================

UA_LOGO = "/ua-logo.png"

APP_NAME = "UA BI"
APP_ICON = UA_LOGO
APP_ICON_WIDTH = 160

LOGO_TARGET_PATH = "/superset/welcome/"
LOGO_TOOLTIP = "UA Business Intelligence"
LOGO_RIGHT_TEXT = ""

THEME_DEFAULT = {
    "token": {
        "brandAppName": "UA BI",
        "brandLogoUrl": UA_LOGO,
        "brandLogoAlt": "Universidade de Aveiro",
        "brandLogoHref": "/superset/welcome/",
        "brandLogoHeight": "32px",
        "brandIconMaxWidth": 180,
        "colorPrimary": "#84BD00"
    }
}

UA_CUSTOM_CSS = """
/* ============================================================
   UA BI - Custom navbar
   Apenas altera a barra superior.
   O resto da interface mantém o tema claro.
   ============================================================ */

/* Navbar superior */
header,
.navbar,
.navbar-static-top,
.ant-layout-header {
    background: #000000 !important;
    border-color: #000000 !important;
}

/* Containers internos da navbar */
header > div,
header .navbar,
header .navbar-header,
header .navbar-brand,
header [class*="Brand"],
header [class*="brand"] {
    background: #000000 !important;
}

/* Texto e botões apenas dentro do header */
header a,
header button,
header span {
    color: #ffffff !important;
}

/* Hover dentro da navbar */
header a:hover,
header button:hover,
header span:hover {
    color: #84BD00 !important;
}

/* Menus Ant Design apenas dentro do header */
header .ant-menu,
header .ant-menu-root,
header .ant-menu-horizontal {
    background: #000000 !important;
    border-bottom: none !important;
}

/* Items do menu principal apenas dentro do header */
header .ant-menu-horizontal > .ant-menu-item,
header .ant-menu-horizontal > .ant-menu-submenu {
    background: #000000 !important;
    color: #ffffff !important;
}

/* Hover/ativo do menu principal */
header .ant-menu-horizontal > .ant-menu-item:hover,
header .ant-menu-horizontal > .ant-menu-submenu:hover,
header .ant-menu-horizontal > .ant-menu-item-selected,
header .ant-menu-horizontal > .ant-menu-submenu-selected {
    background: #000000 !important;
    color: #84BD00 !important;
}

/* Ícones da direita apenas na navbar */
header svg {
    color: #ffffff !important;
    fill: currentColor !important;
}

header svg:hover {
    color: #84BD00 !important;
}
"""


def FLASK_APP_MUTATOR(app):
    @app.route("/ua-logo.png")
    def ua_logo():
        return send_file("/app/branding/ua-logo.png", mimetype="image/png")

    @app.route("/ua-custom.css")
    def ua_custom_css():
        return Response(UA_CUSTOM_CSS, mimetype="text/css")

    @app.after_request
    def inject_ua_css(response):
        content_type = response.headers.get("Content-Type", "")

        if "text/html" in content_type:
            html = response.get_data(as_text=True)

            css_link = '<link rel="stylesheet" href="/ua-custom.css">'
            if css_link not in html:
                html = html.replace("</head>", f"{css_link}</head>")
                response.set_data(html)

        return response