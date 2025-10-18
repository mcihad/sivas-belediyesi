<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=false; section>
<!-- template: select-authenticator.ftl -->

    <#if section = "header" || section = "show-username">
        <#if section = "header">
            ${msg("loginChooseAuthenticator")}
        </#if>
    <#elseif section = "form">

    <ul class="list-group" role="list">
        <#list auth.authenticationSelections as authenticationSelection>
            <li class="list-group-item list-group-item-action d-flex align-items-center justify-content-between" onclick="document.forms[${authenticationSelection?index}].requestSubmit()">
                <form id="kc-select-credential-form" action="${url.loginAction}" method="post">
                    <input type="hidden" name="authenticationExecution" value="${authenticationSelection.authExecId}">
                </form>
                <div class="d-flex align-items-center">
                    <div class="me-3">
                        <i class="${authenticationSelection.iconCssClass} fa-lg" aria-hidden="true"></i>
                    </div>
                    <div>
                        <h5 class="mb-1">${msg('${authenticationSelection.displayName}')}</h5>
                        <p class="mb-0 text-muted">${msg('${authenticationSelection.helpText}')}</p>
                    </div>
                </div>
                <div>
                    <i class="fas fa-chevron-right text-muted" aria-hidden="true"></i>
                </div>
            </li>
        </#list>
    </ul>

    </#if>
</@layout.registrationLayout>

