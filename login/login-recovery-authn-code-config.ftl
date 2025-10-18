<#import "template.ftl" as layout>
<#import "password-commons.ftl" as passwordCommons>
<@layout.registrationLayout; section>
<!-- template: login-recovery-authn-code-config.ftl -->
<#if section = "header">
    ${msg("recovery-code-config-header")}
<#elseif section = "form">
    <!-- warning -->
    <div class="alert alert-warning" aria-label="Warning alert">
        <i class="fas fa-fw fa-bell me-2" aria-hidden="true"></i>
        <h4 class="alert-heading">
            <span class="visually-hidden">Warning alert:</span>
            ${msg("recovery-code-config-warning-title")}
        </h4>
        <p class="mb-0">${msg("recovery-code-config-warning-message")}</p>
    </div>

    <div class="card">
        <div class="card-body">
            <ol id="kc-recovery-codes-list" class="list-group list-group-numbered" role="list">
                <#list recoveryAuthnCodesConfigBean.generatedRecoveryAuthnCodesList as code>
                    <li class="list-group-item">${code[0..3]}-${code[4..7]}-${code[8..]}</li>
                </#list>
            </ol>
        </div>
    </div>

    <!-- actions -->
    <div class="d-flex gap-2 mt-3">
        <button id="printRecoveryCodes" class="btn btn-link" type="button" onclick="printRecoveryCodes()">
            <i class="fas fa-print"></i> ${msg("recovery-codes-print")}
        </button>
        <button id="downloadRecoveryCodes" class="btn btn-link" type="button" onclick="downloadRecoveryCodes()">
            <i class="fas fa-download"></i> ${msg("recovery-codes-download")}
        </button>
        <button id="copyRecoveryCodes" class="btn btn-link" type="button" onclick="copyRecoveryCodes()">
            <i class="fas fa-copy"></i> ${msg("recovery-codes-copy")}
        </button>
    </div>

    <!-- confirmation checkbox -->
    <div class="form-check mt-3">
        <input class="form-check-input" type="checkbox" id="kcRecoveryCodesConfirmationCheck" name="kcRecoveryCodesConfirmationCheck"
        onchange="document.getElementById('saveRecoveryAuthnCodesBtn').disabled = !this.checked;"
        />
        <label for="kcRecoveryCodesConfirmationCheck" class="form-check-label">${msg("recovery-codes-confirmation-message")}</label>
    </div>

    <form action="${url.loginAction}" class="mb-3" id="kc-recovery-codes-settings-form" method="post">
        <input type="hidden" name="generatedRecoveryAuthnCodes" value="${recoveryAuthnCodesConfigBean.generatedRecoveryAuthnCodesAsString}" />
        <input type="hidden" name="generatedAt" value="${recoveryAuthnCodesConfigBean.generatedAt?c}" />
        <input type="hidden" id="userLabel" name="userLabel" value="${msg("recovery-codes-label-default")}" />
        <@passwordCommons.logoutOtherSessions/>

        <#if isAppInitiatedAction??>
            <input type="submit"
            class="btn btn-primary"
            id="saveRecoveryAuthnCodesBtn" value="${msg("recovery-codes-action-complete")}"
            disabled
            />
            <button type="submit"
                class="btn btn-secondary ms-2"
                id="cancelRecoveryAuthnCodesBtn" name="cancel-aia" value="true">${msg("recovery-codes-action-cancel")}
            </button>
        <#else>
            <input type="submit"
            class="btn btn-primary w-100"
            id="saveRecoveryAuthnCodesBtn" value="${msg("recovery-codes-action-complete")}"
            disabled
            />
        </#if>
    </form>

    <script>
        /* copy recovery codes  */
        function copyRecoveryCodes() {
            const tmpTextarea = document.createElement("textarea");
            tmpTextarea.innerHTML = parseRecoveryCodeList();
            document.body.appendChild(tmpTextarea);
            tmpTextarea.select();
            document.execCommand("copy");
            document.body.removeChild(tmpTextarea);
        }

        /* download recovery codes  */
        function formatCurrentDateTime() {
            const dt = new Date();
            const options = {
                month: 'long',
                day: 'numeric',
                year: 'numeric',
                hour: 'numeric',
                minute: 'numeric',
                timeZoneName: 'short'
            };

            return dt.toLocaleString('en-US', options);
        }

        function parseRecoveryCodeList() {
            const recoveryCodes = document.getElementById("kc-recovery-codes-list").getElementsByTagName("li");
            let recoveryCodeList = "";

            for (let i = 0; i < recoveryCodes.length; i++) {
                const recoveryCodeLiElement = recoveryCodes[i].innerText;
                <#noparse>
                recoveryCodeList += `${i+1}: ${recoveryCodeLiElement}\r\n`;
                </#noparse>
            }

            return recoveryCodeList;
        }

        function buildDownloadContent() {
            const recoveryCodeList = parseRecoveryCodeList();
            const dt = new Date();
            const options = {
                month: 'long',
                day: 'numeric',
                year: 'numeric',
                hour: 'numeric',
                minute: 'numeric',
                timeZoneName: 'short'
            };

            return fileBodyContent =
                "${msg("recovery-codes-download-file-header")}\n\n" +
                recoveryCodeList + "\n" +
                "${msg("recovery-codes-download-file-description")}\n\n" +
                "${msg("recovery-codes-download-file-date")} " + formatCurrentDateTime();
        }

        function setUpDownloadLinkAndDownload(filename, text) {
            const el = document.createElement('a');
            el.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(text));
            el.setAttribute('download', filename);
            el.style.display = 'none';
            document.body.appendChild(el);
            el.click();
            document.body.removeChild(el);
        }

        function downloadRecoveryCodes() {
            setUpDownloadLinkAndDownload('kc-download-recovery-codes.txt', buildDownloadContent());
        }

        /* print recovery codes */
        function buildPrintContent() {
            const recoveryCodeListHTML = document.getElementById('kc-recovery-codes-list').parentNode.innerHTML;
            const styles =
                `@page { size: auto;  margin-top: 0; }
                body { width: 480px; }
                div { font-family: monospace }
                p:first-of-type { margin-top: 48px }`;

            return printFileContent =
                "<html><style>" + styles + "</style><body>" +
                "<title>kc-download-recovery-codes</title>" +
                "<p>${msg("recovery-codes-download-file-header")}</p>" +
                "<div>" + recoveryCodeListHTML + "</div>" +
                "<p>${msg("recovery-codes-download-file-description")}</p>" +
                "<p>${msg("recovery-codes-download-file-date")} " + formatCurrentDateTime() + "</p>" +
                "</body></html>";
        }

        function printRecoveryCodes() {
            const w = window.open();
            w.document.write(buildPrintContent());
            w.print();
            w.close();
        }
    </script>
</#if>
</@layout.registrationLayout>
