<#import "template.ftl" as layout>
<#import "field.ftl" as field>
<#import "buttons.ftl" as buttons>
<@layout.registrationLayout displayInfo=true displayMessage=messagesPerField.existsError('username'); section>
    <#if section = "header">
        ${msg("emailForgotTitle")}
    <#elseif section = "form">
        <form id="kc-reset-password-form" action="${url.loginAction}" method="post">
            <#assign label>
                <#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if>
            </#assign>
            <@field.input name="username" label=label value=auth.attemptedUsername!'' autofocus=true />

            <@buttons.actionGroup>
              <@buttons.button id="kc-form-buttons" label="doSubmit" class=["btn", "btn-primary", "w-100"]/>
              <@buttons.buttonLink href=url.loginUrl label="backToLogin" class=["btn", "btn-secondary", "w-100"]/>
            </@buttons.actionGroup>

        </form>
    <#elseif section = "info" >
        <span class="text-muted">
            <#if realm.duplicateEmailsAllowed>
                ${msg("emailInstructionUsername")}
            <#else>
                ${msg("emailInstruction")}
            </#if>
        </span>
    </#if>
</@layout.registrationLayout>