<#macro actionGroup horizontal=false>
  <div class="mb-2">
    <div class="d-grid gap-2 <#if horizontal>d-sm-flex</#if>">
      <#nested>
    </div>
  </div>
</#macro>

<#macro button label id="" name="" class=["btn", "btn-primary"] extra...>
  <button class="<#list class as c>${c} </#list>" name="${name}" id="${id}"
          type="submit" <#list extra as attrName, attrVal>${attrName}="${attrVal}"</#list>>
  ${kcSanitize(msg(label))?no_esc}
  </button>
</#macro>

<#macro buttonLink href label id="" class=["btn", "btn-link"]>
  <a id="${id}" href="${href}" class="<#list class as c>${c} </#list>">${kcSanitize(msg(label))?no_esc}</a>
</#macro>

<#macro loginButton>
  <@buttons.actionGroup>
    <@buttons.button id="kc-login" name="login" label="doLogIn" class=["btn", "btn-primary", "w-100"] />
  </@buttons.actionGroup>
</#macro>