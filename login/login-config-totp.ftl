<#import "template.ftl" as layout>
<#import "field.ftl" as field>
<#import "password-commons.ftl" as passwordCommons>
<@layout.registrationLayout displayRequiredFields=false displayMessage=messagesPerField.existsError('totp','userLabel'); section>
<!-- template: login-config-totp.ftl -->

    <#if section = "header">
        ${msg("loginTotpTitle")}
    <#elseif section = "form">
        <ol id="kc-totp-settings" class="list-group mb-3">
            <li class="list-group-item">
                <p>${msg("loginTotpStep1")}</p>

                <ul id="kc-totp-supported-apps">
                    <#list totp.supportedApplications as app>
                        <li>${msg(app)}</li>
                    </#list>
                </ul>
            </li>

            <#if mode?? && mode = "manual">
                <li class="list-group-item">
                    <p>${msg("loginTotpManualStep2")}</p>
                    <p><span id="kc-totp-secret-key">${totp.totpSecretEncoded}</span></p>
                    <p><a href="${totp.qrUrl}" id="mode-barcode">${msg("loginTotpScanBarcode")}</a></p>
                </li>
                <li class="list-group-item">
                    <p>${msg("loginTotpManualStep3")}</p>
                    <p>
                    <ul>
                        <li id="kc-totp-type">${msg("loginTotpType")}: ${msg("loginTotp." + totp.policy.type)}</li>
                        <li id="kc-totp-algorithm">${msg("loginTotpAlgorithm")}: ${totp.policy.getAlgorithmKey()}</li>
                        <li id="kc-totp-digits">${msg("loginTotpDigits")}: ${totp.policy.digits}</li>
                        <#if totp.policy.type = "totp">
                            <li id="kc-totp-period">${msg("loginTotpInterval")}: ${totp.policy.period}</li>
                        <#elseif totp.policy.type = "hotp">
                            <li id="kc-totp-counter">${msg("loginTotpCounter")}: ${totp.policy.initialCounter}</li>
                        </#if>
                    </ul>
                    </p>
                </li>
            <#else>
                <li class="list-group-item">
                    <p>${msg("loginTotpStep2")}</p>
                    <img id="kc-totp-secret-qr-code" src="data:image/png;base64, ${totp.totpSecretQrCode}" alt="Figure: Barcode"><br/>
                    <p><a href="${totp.manualUrl}" id="mode-manual">${msg("loginTotpUnableToScan")}</a></p>
                </li>
            </#if>
            <li class="list-group-item">
                <p>${msg("loginTotpStep3")}</p>
                <p>${msg("loginTotpStep3DeviceName")}</p>
            </li>
        </ol>

        <form action="${url.loginAction}" id="kc-totp-settings-form" method="post" novalidate="novalidate">
            <div class="mb-3">
                <label class="form-label" for="totp">
                    <span>${msg("authenticatorCode")}</span>&nbsp;<span class="text-danger" aria-hidden="true">*</span>
                </label>
                <input type="text" required id="totp" name="totp" class="form-control <#if messagesPerField.existsError('totp')>is-invalid</#if>" autocomplete="one-time-code"
                       aria-invalid="<#if messagesPerField.existsError('totp')>true</#if>"
                       inputmode="numeric"
                />
                <#if messagesPerField.existsError('totp')>
                    <div class="invalid-feedback" aria-live="polite">
                        ${kcSanitize(messagesPerField.get('totp'))?no_esc}
                    </div>
                </#if>
                <input type="hidden" id="totpSecret" name="totpSecret" value="${totp.totpSecret}" />
                <#if mode??><input type="hidden" id="mode" name="mode" value="${mode}"/></#if>
            </div>
            <div class="mb-3">
                <label class="form-label" for="userLabel">
                    <span>${msg("loginTotpDeviceName")}</span><#if totp.otpCredentials?size gte 1>&nbsp;<span class="text-danger" aria-hidden="true">*</span></#if>
                </label>
                <input type="text" id="userLabel" name="userLabel" class="form-control <#if messagesPerField.existsError('userLabel')>is-invalid</#if>" autocomplete="off"
                       aria-invalid="<#if messagesPerField.existsError('userLabel')>true</#if>"
                />
                <#if messagesPerField.existsError('userLabel')>
                    <div class="invalid-feedback" aria-live="polite">
                        ${kcSanitize(messagesPerField.get('userLabel'))?no_esc}
                    </div>
                </#if>
            </div>

            <div class="mb-3">
                <@passwordCommons.logoutOtherSessions/>
            </div>

            <div class="d-grid gap-2">
                <#if isAppInitiatedAction??>
                    <input type="submit"
                        class="btn btn-primary"
                        id="saveTOTPBtn" value="${msg("doSubmit")}"
                    />
                    <button type="submit"
                            class="btn btn-secondary"
                            id="cancelTOTPBtn" name="cancel-aia" value="true">${msg("doCancel")}
                    </button>
                <#else>
                    <input type="submit"
                        class="btn btn-primary w-100"
                        id="saveTOTPBtn" value="${msg("doSubmit")}"
                    />
                </#if>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
