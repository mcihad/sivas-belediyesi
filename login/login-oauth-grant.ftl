<#import "template.ftl" as layout>
<#import "buttons.ftl" as buttons>
<@layout.registrationLayout bodyClass="oauth"; section>
    <#if section = "header">
        <#-- Başlık boş bırakıldı, form içinde gösterilecek -->
    <#elseif section = "form">
        <div id="kc-oauth" class="content-area">
            <#if client.attributes.logoUri??>
                <div class="text-center mb-4">
                    <img src="${client.attributes.logoUri}" alt="${client.name!'Client Logo'}" style="max-height: 60px; max-width: 200px;" class="img-fluid"/>
                </div>
            </#if>

            <div class="alert alert-primary border-0 rounded-3 mb-4 text-center">
                <h4 class="mb-0">
                <#if client.name?has_content>
                    ${msg("oauthGrantTitle",advancedMsg(client.name))}
                <#else>
                    ${msg("oauthGrantTitle",client.clientId)}
                </#if>
                </h4>
            </div>

            <div class="alert alert-info border-0 rounded-3 mb-4 d-flex align-items-center">
                <div class="me-3">
                    <i class="fas fa-info-circle text-info fs-4"></i>
                </div>
                <div>
                    <strong>${msg("oauthGrantRequest")}</strong>
                </div>
            </div>

            <#if oauth.clientScopesRequested??>
                <div class="mb-4">
                    <h5 class="mb-3">İstenen İzinler</h5>
                    <div class="row g-2">
                        <#list oauth.clientScopesRequested as clientScope>
                            <div class="col-12">
                                <div class="card border-0 shadow-sm">
                                    <div class="card-body py-3">
                                        <div class="d-flex align-items-center">
                                            <div class="me-3">
                                                <i class="fas fa-check-circle text-success fs-5"></i>
                                            </div>
                                            <div>
                                                <#if !clientScope.dynamicScopeParameter??>
                                                    ${advancedMsg(clientScope.consentScreenText)}
                                                <#else>
                                                    ${advancedMsg(clientScope.consentScreenText)}: <strong>${clientScope.dynamicScopeParameter}</strong>
                                                </#if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </#list>
                    </div>
                </div>
            </#if>

            <#if client.attributes.policyUri?? || client.attributes.tosUri??>
                <div class="alert alert-light border-0 rounded-3 mb-4">
                    <h6 class="mb-2">
                        <#if client.name?has_content>
                            ${msg("oauthGrantInformation",advancedMsg(client.name))}
                        <#else>
                            ${msg("oauthGrantInformation",client.clientId)}
                        </#if>
                    </h6>
                    <div class="d-flex flex-wrap gap-2">
                        <#if client.attributes.tosUri??>
                            <a href="${client.attributes.tosUri}" target="_blank" class="btn btn-outline-primary btn-sm">
                                <i class="fas fa-file-contract me-1"></i>${msg("oauthGrantTos")}
                            </a>
                        </#if>
                        <#if client.attributes.policyUri??>
                            <a href="${client.attributes.policyUri}" target="_blank" class="btn btn-outline-primary btn-sm">
                                <i class="fas fa-shield-alt me-1"></i>${msg("oauthGrantPolicy")}
                            </a>
                        </#if>
                    </div>
                </div>
            </#if>

            <form action="${url.oauthAction}" method="POST">
                <input type="hidden" name="code" value="${oauth.code}">
                <div class="d-grid gap-2">
                    <@buttons.button id="kc-login" name="accept" label="doYes" class=["btn","btn-success","w-100"]/>
                    <@buttons.button id="kc-cancel" name="cancel" label="doNo" class=["btn","btn-outline-secondary","w-100"]/>
                </div>
            </form>
        </div>
    </#if>
</@layout.registrationLayout>
