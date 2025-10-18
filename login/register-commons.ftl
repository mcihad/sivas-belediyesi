<#macro termsAcceptance>
    <#if termsAcceptanceRequired??>
        <div class="mb-3">
            ${msg("termsTitle")}
            <div id="kc-registration-terms-text">
                ${kcSanitize(msg("termsText"))?no_esc}
            </div>
        </div>
        <div class="mb-3">
            <div class="form-check">
                <input type="checkbox" id="termsAccepted" name="termsAccepted" class="form-check-input"
                       aria-invalid="<#if messagesPerField.existsError('termsAccepted')>true</#if>"
                />
                <label for="termsAccepted" class="form-check-label">${msg("acceptTerms")}</label>
            </div>
            <#if messagesPerField.existsError('termsAccepted')>
                <div class="invalid-feedback" aria-live="polite">
                    ${kcSanitize(messagesPerField.get('termsAccepted'))?no_esc}
                </div>
            </#if>
        </div>
    </#if>
</#macro>
