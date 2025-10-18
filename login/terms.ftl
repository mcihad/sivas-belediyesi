<#import "template.ftl" as layout>
<#import "buttons.ftl" as buttons>

<@layout.registrationLayout displayMessage=false; section>
<!-- template: terms.ftl -->

    <#if section = "header">
        ${msg("termsTitle")}
    <#elseif section = "form">
    <div class="mb-3">
        ${kcSanitize(msg("termsText"))?no_esc}
    </div>
    <form action="${url.loginAction}" method="POST">
        <@buttons.actionGroup horizontal=true>
            <@buttons.button name="accept" id="kc-accept" label="doAccept" class=["btn-primary"]/>
            <@buttons.button name="cancel" id="kc-decline" label="doDecline" class=["btn-secondary"]/>
        </@buttons.actionGroup>
    </form>
    </#if>
</@layout.registrationLayout>
