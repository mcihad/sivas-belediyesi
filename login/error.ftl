<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
<!-- template: error.ftl -->

    <#if section = "header">
        
    <#elseif section = "form">
        <div class="card shadow-none">
            <div class="card-body text-center">
                <h1 class="h3 mb-3">${msg("errorTitle")}</h1>
                <p class="mb-4">${message.summary}</p>
                <#if client?? && client.baseUrl?has_content>
                    <a href="${client.baseUrl}" class="btn btn-danger">${msg("backToApplication")?replace("&laquo;", "")}</a>
                </#if>
            </div>
        </div>
    </#if>

</@layout.registrationLayout>
