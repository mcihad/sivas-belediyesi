<#macro group name label error="" required=false>

<div class="mb-3">
    <label for="${name}" class="form-label">
        <span>
            ${label}
        </span>
        <#if required>
            <span class="text-danger" aria-hidden="true">*</span>
        </#if>
    </label>

    <#nested>

    <div id="input-error-container-${name}">
        <#if error?has_content>
            <div class="invalid-feedback" aria-live="polite">
                ${error}
            </div>
        </#if>
    </div>
</div>

</#macro>

<#macro errorIcon error="">
  <#if error?has_content>
    <span class="input-group-text">
        <i class="fas fa-exclamation-triangle text-danger" aria-hidden="true"></i>
    </span>
  </#if>
</#macro>

<#macro input name label value="" required=false autocomplete="off" fieldName=name error=kcSanitize(messagesPerField.get(fieldName))?no_esc autofocus=false>
  <@group name=name label=label error=error required=required>
    <input id="${name}" name="${name}" value="${value}" type="text" class="form-control <#if error?has_content>is-invalid</#if>" autocomplete="${autocomplete}" <#if autofocus>autofocus</#if>
            <#if autocomplete == "one-time-code">inputmode="numeric"</#if>
            aria-invalid="<#if error?has_content>true</#if>"/>
  </@group>
</#macro>

<#macro password name label value="" required=false forgotPassword=false fieldName=name error=kcSanitize(messagesPerField.get(fieldName))?no_esc autocomplete="off" autofocus=false>
  <@group name=name label=label error=error required=required>
    <div class="input-group">
      <input id="${name}" name="${name}" value="${value}" type="password" class="form-control <#if error?has_content>is-invalid</#if>" autocomplete="${autocomplete}" <#if autofocus>autofocus</#if>
              aria-invalid="<#if error?has_content>true</#if>"/>
      <button class="btn btn-outline-secondary" type="button" aria-label="${msg('showPassword')}"
              aria-controls="${name}" data-password-toggle
              data-icon-show="fa-eye fas" data-icon-hide="fa-eye-slash fas"
              data-label-show="${msg('showPassword')}" data-label-hide="${msg('hidePassword')}" id="${name}-show-password">
          <i class="fa-eye fas" aria-hidden="true"></i>
      </button>
    </div>
    <div class="form-text" aria-live="polite">
        <#nested>
        <#if forgotPassword>
            <div class="d-flex justify-content-end">
              <a href="${url.loginResetCredentialsUrl}" class="btn btn-outline-secondary btn-sm">
                  <i class="fas fa-key me-1"></i>
                  ${msg("doForgotPassword")}
              </a>
            </div>
        </#if>
    </div>

  </@group>
</#macro>

<#macro clipboard name label ariaLabel=label value="" readonly=true>
  <@group name=name label=label>
    <div id="kc-${name}-clipboard">
      <div>
        <div class="input-group">
          <button
            class="btn btn-outline-secondary"
            type="button"
            aria-label="${msg("code-clipboard-label")}"
            aria-expanded="false"
            aria-controls="kc-${name}-content"
            data-icon-expanded-class="fa-angle-down"
            data-icon-collapsed-class="fa-angle-right"
            data-expanded-class=""
            id="kc-${name}-toggle"
          >
            <i id="kc-${name}-toggle-icon" class="fa-angle-right" aria-hidden="true"></i>
          </button>
          <input
            id="${name}"
            name="${name}"
            value="${value}"
            type="text"
            class="form-control <#if readonly>bg-light</#if>"
            <#if readonly>readonly</#if>
            aria-label="${ariaLabel}"
          />
          <button
            class="btn btn-outline-secondary"
            type="button"
            aria-label="${msg("code-copy-label")}"
            data-icon-success="fa-check"
            data-icon-failure="fa-exclamation-triangle"
            data-success-label="${msg("code-copy-success")}"
            data-failure-label="${msg("code-copy-failure")}"
            id="kc-${name}-copy-button"
          >
            <i id="kc-${name}-copy-icon" class="fa-copy" aria-hidden="true"></i>
          </button>
        </div>
      </div>
      <div id="kc-${name}-content" hidden>
        <pre><code aria-label="${ariaLabel}">${value}</code></pre>
      </div>
    </div>
  </@group>
</#macro>

<#macro checkbox name label value=false required=false>
  <div class="form-check">
    <input
      class="form-check-input"
      type="checkbox"
      id="${name}"
      name="${name}"
      <#if value>checked</#if>
    />
    <label for="${name}" class="form-check-label">${label}</label>
    <#if required>
      <span class="text-danger" aria-hidden="true">*</span>
    </#if>
  </div>
</#macro>