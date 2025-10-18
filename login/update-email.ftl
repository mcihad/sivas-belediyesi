<#import "template.ftl" as layout>
<#import "password-commons.ftl" as passwordCommons>
<#import "user-profile-commons.ftl" as userProfileCommons>
<#import "buttons.ftl" as buttons>
<@layout.registrationLayout displayMessage=messagesPerField.exists('global') displayRequiredFields=false; section>
    <#if section = "header">
        ${msg("updateEmailTitle")}
    <#elseif section = "form">
        <form id="kc-update-email-form" action="${url.loginAction}" method="post">
            <@userProfileCommons.userProfileFormFields/>

            <div class="mb-3">
                <div id="kc-form-options">
                    <div>
                    </div>
                </div>

                <@passwordCommons.logoutOtherSessions/>

                <@buttons.actionGroup horizontal=true>
                    <@buttons.button id="kc-submit" label="doSubmit" class=["btn-primary","w-100","btn-lg","rounded-pill"]>
                        <i class="bi bi-envelope-check me-2"></i>${msg("doSubmit")}
                    </@buttons.button>
                    <#if isAppInitiatedAction??>
                        <@buttons.button id="kc-cancel" label="doCancel" class=["btn-secondary","w-100","btn-lg","rounded-pill"]>
                            <i class="bi bi-x-circle me-2"></i>${msg("doCancel")}
                        </@buttons.button>
                    </#if>
                </@buttons.actionGroup>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
