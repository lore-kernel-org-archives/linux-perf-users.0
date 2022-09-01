Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79066ECAAD1
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Sep 2022 17:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbiIARdZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Sep 2022 13:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbiIARdN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Sep 2022 13:33:13 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E7294EC8
        for <linux-perf-users@vger.kernel.org>; Thu,  1 Sep 2022 10:33:10 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id r74-20020a632b4d000000b0041bc393913eso8925055pgr.10
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Sep 2022 10:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=toQG5Z5nBBy1r8xg7zoFpTxuXMus911akVxRxr9n+oM=;
        b=Hdz2/W9HzWlTkRMQsR89JPn80MjKvE7MBUKdVInOy6m5SPM6rc/dQBlPRS2RFSF2bc
         Sk8W7t6tRQ0+B3KqjEfxT4UpAlh4qKZaQBIAFPzBTOKu04VcYD9CrBaW4DHRwOXujX2p
         prMyNb7FMLNVE4HibzgTIruHq2XJ+IMNFJ380TC/cWOKFU1+hdMD23MzMQUnLuuH/hiy
         ZxFhY8Tef7TfOTI4bIDCDNSVn3zP57ybZUyi3TJPf3cOhnyBW6thTa0u+4QByQWrHwCm
         3/U1g/Orlh3zGf7KihYQIvS3JffKt8F8CkKy7lNl7A/Pulaxqw7gFcsRrHkXaF29JPtt
         wxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=toQG5Z5nBBy1r8xg7zoFpTxuXMus911akVxRxr9n+oM=;
        b=1ooFO0VDTuqO1fBelhp5LubBF7ugUgcN215Dk8MGwWhHug9B3JIWXM735vaZBM1ZaL
         CyhHSydaLKmoqaNgMxPxiwLBF4HVj2NJTZbu8MOiLxVErHuzXyZ2kA/bMmFSvDnZagmZ
         eytKZnRaKO4s4UgQPxqw3T/ZFrwAAVlpFcX1OCJUjxR6bjSzbjwthUIf6lLk2ctCpDuP
         SSIAJp2nNj/LNj+cjH5KSVg1q+gXH3twYaWDa/TgxOOn5ltDkiI85/99xq+uiIbzMJQQ
         rb2JQow24WTFRFFhNr4VTmKqZmxhoepR7MBLaQ5yXn1viHOA3d894rs9MkmDtQWiBJhi
         CPyA==
X-Gm-Message-State: ACgBeo3HX78q433G0Gwlx0jPhfE+TSZMLwrvyaWTpo5a+d4puubjHDyU
        UM0km2OdHCFUma27545j1io5+2HYLo4=
X-Google-Smtp-Source: AA6agR6ZaSAAeeYRAm64gGT138n9rAuKa5Qq6wwfx5dLRyHcXluRD1qCzGz+zpDN1ff5O1o2pTq82DP1zz0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2446:b0:528:5da9:cc7 with SMTP id
 d6-20020a056a00244600b005285da90cc7mr32728141pfj.51.1662053589567; Thu, 01
 Sep 2022 10:33:09 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  1 Sep 2022 17:32:58 +0000
In-Reply-To: <20220901173258.925729-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220901173258.925729-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173258.925729-6-seanjc@google.com>
Subject: [PATCH v4 5/5] KVM: VMX: Advertise PMU LBRs if and only if perf
 supports LBRs
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Like Xu <like.xu.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Advertise LBR support to userspace via MSR_IA32_PERF_CAPABILITIES if and
only if perf fully supports LBRs.  Perf may disable LBRs (by zeroing the
number of LBRs) even on platforms the allegedly support LBRs, e.g. if
probing any LBR MSRs during setup fails.

Fixes: be635e34c284 ("KVM: vmx/pmu: Expose LBR_FMT in the MSR_IA32_PERF_CAPABILITIES")
Reported-by: Like Xu <like.xu.linux@gmail.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/vmx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index a5e3c1e6aa2b..8e237268ac10 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -1829,6 +1829,7 @@ static inline bool vmx_feature_control_msr_valid(struct kvm_vcpu *vcpu,
 u64 vmx_get_perf_capabilities(void)
 {
 	u64 perf_cap = PMU_CAP_FW_WRITES;
+	struct x86_pmu_lbr lbr;
 	u64 host_perf_cap = 0;
 
 	if (!enable_pmu)
@@ -1837,7 +1838,9 @@ u64 vmx_get_perf_capabilities(void)
 	if (boot_cpu_has(X86_FEATURE_PDCM))
 		rdmsrl(MSR_IA32_PERF_CAPABILITIES, host_perf_cap);
 
-	perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
+	x86_perf_get_lbr(&lbr);
+	if (lbr.nr)
+		perf_cap |= host_perf_cap & PMU_CAP_LBR_FMT;
 
 	if (vmx_pebs_supported()) {
 		perf_cap |= host_perf_cap & PERF_CAP_PEBS_MASK;
-- 
2.37.2.789.g6183377224-goog

