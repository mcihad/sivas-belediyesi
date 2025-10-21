<#import "field.ftl" as field>
<#import "footer.ftl" as loginFooter>
<#macro username>
  <#assign label>
    <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>
  </#assign>
  <@field.group name="username" label=label>
    <div class="input-group">
      <div class="flex-grow-1">
        <span class="form-control bg-light">
          <input id="kc-attempted-username" value="${auth.attemptedUsername}" readonly class="border-0 bg-transparent w-100">
        </span>
      </div>
      <div>
        <button id="reset-login" class="btn btn-outline-secondary" type="button"
              aria-label="${msg('restartLoginTooltip')}" onclick="location.href='${url.loginRestartFlowUrl}'"
              title="${msg('restartLoginTooltip')}">
            <i class="bi bi-arrow-clockwise" aria-hidden="true"></i>
        </button>
      </div>
    </div>
  </@field.group>
</#macro>

<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
<!DOCTYPE html>
<html class="${properties.kcHtmlClass!}" lang="${lang}"<#if realm.internationalizationEnabled> dir="${(locale.rtl)?then('rtl','ltr')}"</#if>>

<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="color-scheme" content="light${darkMode?then(' dark', '')}">
    <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover, minimum-scale=1, user-scalable=yes">
    <meta name="mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">

    <#if properties.meta?has_content>
        <#list properties.meta?split(' ') as meta>
            <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
        </#list>
    </#if>
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />

    <link href="${url.resourcesPath}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${url.resourcesPath}/css/bootstrap-icons.css" rel="stylesheet">
    <link href="${url.resourcesPath}/css/fontawesome.min.css" rel="stylesheet">

    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <script type="importmap">
        {
            "imports": {
                "rfc4648": "${url.resourcesCommonPath}/vendor/rfc4648/rfc4648.js"
            }
        }
    </script>
    <#if darkMode>
      <script type="module" async blocking="render">
          const mediaQuery = window.matchMedia("(prefers-color-scheme: dark)");

          updateDarkMode(mediaQuery.matches);
          mediaQuery.addEventListener("change", (event) => updateDarkMode(event.matches));

          function updateDarkMode(isEnabled) {
            if (isEnabled) {
              document.documentElement.setAttribute('data-bs-theme', 'dark');
            } else {
              document.documentElement.setAttribute('data-bs-theme', 'light');
            }
          }
      </script>
    </#if>
    <#if properties.scripts?has_content>
        <#list properties.scripts?split(' ') as script>
            <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <#if scripts??>
        <#list scripts as script>
            <script src="${script}" type="text/javascript"></script>
        </#list>
    </#if>
    <script type="module" src="${url.resourcesPath}/js/passwordVisibility.js"></script>
    <script type="module">
        import { startSessionPolling } from "${url.resourcesPath}/js/authChecker.js";

        startSessionPolling(
            "${url.ssoLoginInOtherTabsUrl?no_esc}"
        );
    </script>
    <script type="module">
        document.addEventListener("click", (event) => {
            const link = event.target.closest("a[data-once-link]");

            if (!link) {
                return;
            }

            if (link.getAttribute("aria-disabled") === "true") {
                event.preventDefault();
                return;
            }

            const { disabledClass } = link.dataset;

            if (disabledClass) {
                link.classList.add(...disabledClass.trim().split(/\s+/));
            }

            link.setAttribute("role", "link");
            link.setAttribute("aria-disabled", "true");
        });
    </script>
    <#if authenticationSession??>
        <script type="module">
            import { checkAuthSession } from "${url.resourcesPath}/js/authChecker.js";

            checkAuthSession(
                "${authenticationSession.authSessionIdHash}"
            );
        </script>
    </#if>
    <script>
      // Workaround for https://bugzilla.mozilla.org/show_bug.cgi?id=1404468
      const isFirefox = true;
    </script>

    <script src="${url.resourcesPath}/js/bootstrap.bundle.min.js"></script>
    <script src="${url.resourcesPath}/js/mobile-optimization.js"></script>

    <script>
      // Dark mode management - Auto detect based on system preference
      const getPreferredTheme = () => {
        return window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light'
      }

      const setTheme = theme => {
        if (theme === 'dark') {
          document.documentElement.setAttribute('data-bs-theme', 'dark')
        } else {
          document.documentElement.setAttribute('data-bs-theme', 'light')
        }
      }

      setTheme(getPreferredTheme())

      window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', () => {
        setTheme(getPreferredTheme())
      })
    </script>
</head>

<body id="keycloak-bg" class="min-vh-100 d-flex align-items-center justify-content-center bg-light" data-bs-theme="auto" data-page-id="login-${pageId}" style="padding: env(safe-area-inset-bottom) env(safe-area-inset-right) 0 env(safe-area-inset-left); margin: 0; overflow: hidden;">

<div class="container-fluid" style="height: 100vh; display: flex; flex-direction: column; padding: 0; margin: 0;">
  <div class="row justify-content-center" style="flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: center; margin: 0;">
    <div class="col-12 col-sm-10 col-md-8 col-lg-6 col-xl-5 col-xxl-4" style="display: flex; flex-direction: column; padding: 0; margin: 0;">

    <main class="card shadow-md border-0 rounded-3 overflow-hidden" style="flex: 1; display: flex; flex-direction: column; margin: 0; ">
      
      <div class="p-3 p-md-3 kc-header-bg">
          <div class="d-flex align-items-center">
              <div class="flex-shrink-0">
                  <img src="${url.resourcesPath}/img/sivaslogo.png" alt="${(realm.displayName!'')} Logo" style="height: 36px; width: auto; margin-right: 0.75rem;" />
              </div>
              
              <div class="flex-grow-1">
                  <div id="kc-header-wrapper" class="h6 fw-bold text-primary mb-0">
                      ${kcSanitize(msg("loginTitleHtml",(realm.displayNameHtml!'')))?no_esc}
                  </div>
                  <h1 class="text-muted" id="kc-page-title" style="font-size: 0.85rem; margin: 0;">
                      <#nested "header">
                  </h1>
              </div>
          </div>
      </div>

      <div class="card-body p-2 p-md-3" style="flex: 1; overflow-y: auto; -webkit-overflow-scrolling: touch; display: flex; flex-direction: column;">
        
        <#if !(auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
            <#if displayRequiredFields>
                <div class="alert alert-info border-0 rounded-3 mb-3">
                    <div class="small">
                        <span class="text-danger fw-bold">*</span> ${msg("requiredFields")}
                    </div>
                </div>
            </#if>
        <#else>
            <#if displayRequiredFields>
                <div class="alert alert-info border-0 rounded-3 mb-3">
                    <div class="small">
                        <span class="text-danger fw-bold">*</span> ${msg("requiredFields")}
                    </div>
                </div>
                <div class="mb-3">
                    <#nested "show-username">
                    <@username />
                </div>
            <#else>
                <div class="mb-3">
                  <#nested "show-username">
                  <@username />
                </div>
            </#if>
        </#if>

        <#-- App-initiated actions should not see warning messages about the need to complete the action -->
        <#-- during login.                                                                               -->
        <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
            <div class="alert alert-${(message.type = 'error')?then('danger', message.type)} border-0 rounded-3 mb-3 d-flex align-items-center">
                <div class="me-3">
                    <#if message.type = 'success'><i class="bi bi-check-circle-fill text-success fs-5"></i></#if>
                    <#if message.type = 'warning'><i class="bi bi-exclamation-triangle-fill text-warning fs-5"></i></#if>
                    <#if message.type = 'error'><i class="bi bi-x-circle-fill text-danger fs-5"></i></#if>
                    <#if message.type = 'info'><i class="bi bi-info-circle-fill text-info fs-5"></i></#if>
                </div>
                <span class="flex-grow-1">${kcSanitize(message.summary)?no_esc}</span>
            </div>
        </#if>

        <#nested "form">

        <#if auth?has_content && auth.showTryAnotherWayLink()>
          <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post" novalidate="novalidate">
              <input type="hidden" name="tryAnotherWay" value="on"/>
              <div class="d-grid mt-3">
                <a id="try-another-way" href="javascript:document.forms['kc-select-try-another-way-form'].requestSubmit()"
                    class="btn btn-outline-secondary">
                      ${kcSanitize(msg("doTryAnotherWay"))?no_esc}
                </a>
              </div>
          </form>
        </#if>

          <div class="mt-1" style="margin-top: auto;">
              <#nested "socialProviders">

              <#if displayInfo>
                  <div id="kc-info" class="mt-3 p-3 bg-light rounded-3">
                      <div id="kc-info-wrapper">
                          <#nested "info">
                      </div>
                  </div>
              </#if>
          </div>
      </div>

      <div class="card-footer bg-body-tertiary py-3 px-2 px-md-4" style="margin-top: auto; padding-bottom: max(1.25rem, env(safe-area-inset-bottom, 15px)) !important;">
          <div class="d-flex flex-column align-items-center justify-content-center gap-2">
              <div class="kc-footer-links small text-center">
                  <@loginFooter.content/>
              </div>

              <div class="d-flex align-items-center justify-content-center gap-2">
                  <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
                  <select
                    aria-label="${msg("languages")}"
                    id="login-select-toggle"
                    onchange="if (this.value) window.location.href=this.value"
                  >
                    <#list locale.supported?sort_by("label") as l>
                      <option
                        value="${l.url}"
                        ${(l.languageTag == locale.currentLanguageTag)?then('selected','')}
                      >
                        ${l.label}
                      </option>
                    </#list>
                  </select>
                  </#if>
              </div>
          </div>
      </div>
    </main>
    </div>
  </div>
</div>
</body>
</html>
</#macro>