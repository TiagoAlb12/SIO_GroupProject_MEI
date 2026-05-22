import os
from flask import send_file, Response

SECRET_KEY = os.getenv("SUPERSET_SECRET_KEY")
if not SECRET_KEY:
    raise ValueError("SUPERSET_SECRET_KEY is not set")

SQLALCHEMY_DATABASE_URI = "postgresql+psycopg2://superset:superset@db:5432/biua_dw"

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
    