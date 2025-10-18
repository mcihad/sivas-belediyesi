<#import "template.ftl" as layout>
<#import "field.ftl" as field>
<#import "buttons.ftl" as buttons>
<@layout.registrationLayout displayMessage=messagesPerField.existsError('totp'); section>
<!-- template: login-otp.ftl -->

    <#if section="header">
        ${msg("doLogIn")}
    <#elseif section="form">
        <form id="kc-otp-login-form" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
            <input id="selectedCredentialId" type="hidden" name="selectedCredentialId" value="${otpLogin.selectedCredentialId!''}">
            <#if otpLogin.userOtpCredentials?size gt 1>
                <div class="mb-3">
                    <#list otpLogin.userOtpCredentials as otpCredential>
                        <div id="kc-otp-credential-${otpCredential?index}" class="list-group-item list-group-item-action d-flex align-items-center"
                                onclick="toggleOTP(${otpCredential?index}, '${otpCredential.id}')">
                            <span class="me-2">
                              <i class="fas fa-mobile-alt" aria-hidden="true"></i>
                            </span>
                            <span>${otpCredential.userLabel}</span>
                        </div>
                    </#list>
                </div>
            </#if>

            <@field.input name="otp" label=msg("loginOtpOneTime") autocomplete="one-time-code" fieldName="totp" autofocus=true />

            <@buttons.loginButton />
        </form>
        <script>
            function toggleOTP(index, value) {
                // select the clicked OTP credential
                document.getElementById("selectedCredentialId").value = value;
                // remove selected class from all OTP credentials
                Array.from(document.getElementsByClassName("active")).map(i => i.classList.remove("active"));
                // add selected class to the clicked OTP credential
                document.getElementById("kc-otp-credential-" + index).classList.add("active");
            }
        </script>
    </#if>
</@layout.registrationLayout>