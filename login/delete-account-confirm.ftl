<#import "template.ftl" as layout>
<#import "buttons.ftl" as buttons>

<@layout.registrationLayout; section>
<!-- template: delete-account-confirm.ftl -->

    <#if section = "header">
      ${msg("deleteAccountConfirm")}

   <#elseif section = "form">

    <form action="${url.loginAction}" id="kc-deleteaccount-form" method="post">

      <div class="alert alert-warning border-0 rounded-3 mb-3">
        <i class="fas fa-exclamation-triangle me-2" aria-hidden="true"></i>
        <strong class="alert-heading">${msg("irreversibleAction")}</strong>
      </div>

      <p>${msg("deletingImplies")}</p>
      <ul class="list-group mb-3" role="list">
        <li class="list-group-item">${msg("loggingOutImmediately")}</li>
        <li class="list-group-item">${msg("errasingData")}</li>
      </ul>

      <p class="delete-account-text">${msg("finalDeletionConfirmation")}</p>

      <@buttons.actionGroup>
        <@buttons.button id="kc-submit" label="doConfirmDelete" class=["btn", "btn-primary"]/>
        <#if triggered_from_aia>
          <@buttons.button id="kc-cancel" name="cancel-aia" label="doCancel" class=["btn", "btn-secondary"]/>
        </#if>
      </@buttons.actionGroup>
    </form>
   </#if>

</@layout.registrationLayout>