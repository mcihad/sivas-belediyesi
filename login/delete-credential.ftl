<#import "template.ftl" as layout>
<#import "buttons.ftl" as buttons>

<@layout.registrationLayout displayMessage=false; section>
<!-- template: delete-credential.ftl -->

    <#if section = "header">
        ${msg("deleteCredentialTitle", credentialLabel)}
    <#elseif section = "form">
        <div class="alert alert-warning border-0 rounded-3 mb-4 d-flex align-items-center">
            <div class="me-3">
                <i class="fas fa-exclamation-triangle text-warning fs-4"></i>
            </div>
            <div>
                <strong>${msg("deleteCredentialMessage", credentialLabel)}</strong>
            </div>
        </div>

        <form action="${url.loginAction}" method="POST">
            <div class="d-grid gap-2">
                <@buttons.button name="accept" id="kc-accept" label="doConfirmDelete" class=["btn", "btn-danger", "w-100"]/>
                <@buttons.button name="cancel-aia" id="kc-decline" label="doDecline" class=["btn", "btn-outline-secondary", "w-100"]/>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
