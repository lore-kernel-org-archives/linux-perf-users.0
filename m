Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AE6ECAAD5
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Sep 2022 17:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiIARdZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Sep 2022 13:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbiIARdM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Sep 2022 13:33:12 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E1E9410F
        for <linux-perf-users@vger.kernel.org>; Thu,  1 Sep 2022 10:33:08 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id d16-20020a17090ad3d000b001fb42eb7467so7897032pjw.9
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Sep 2022 10:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date;
        bh=bQAGklJeyQtfbSP1sQy4j5NLftSXbGdRMGCxjEjeZBE=;
        b=PdkvWuh4lRJLlzLZBbjbzpy37xR6IQu9kwQz7qrAqd239iRTSJWykjxRYMmBimg3/Q
         xa4hrx7YMgkWl3jCAPCOdRSeu0/JVNri+7Acm6pWFis0pIPsjXO8IIk5GsLceQzgNiGH
         SRnMZArYW5WcVrbKZmCy+oXc5zexH/PAbnV8Y28bcsxVy7Wgb8GT93cAZ4+Kkn59cD0t
         +UsGw1gYCbHh6rj+1p2IZyVlNom+ZQuDpfFFWYhmEIM7K7A9tIpJWdQUYxw0rKd+aVRs
         synctq1mDKakYzMMdNZU2QjzenjaxjsnYPIVW33uxBJ/YquqpxS9IK4yoZnwSJZLyfIX
         /Gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date;
        bh=bQAGklJeyQtfbSP1sQy4j5NLftSXbGdRMGCxjEjeZBE=;
        b=IQmC9nj63tdMlEXV9sKILExTE7uzruqba9porEmhY554qC8WpfPLbIlXsfV5jKNNLN
         R3W3GDELcZyya2cZEl2VzMH3jGjwnLfWGI4ePAnrj2aC4jyWEHCKRwu1DoSwu9UCvjaG
         uHHVjyM4iORxhCNo51b2MoCi/9+Q74uunV2CCeza2wHsKbdNOCwY6sEK0DOr3lveqoLs
         Mymvt6J9omzuIyYl2ktuVHLjDJTmUshB+huoBGXQkvfiqZfcQWGC24/j69ZPIIPQiVMg
         Vsx8XHBKr7YkcLedpYhUQzMheZI8rdF49DhnG3/VHsQK6Kw+RlAabGjPosM6Lg8OOH6L
         WucA==
X-Gm-Message-State: ACgBeo15ZFwo1vaRMIE+0ZeF3Afmrb1c+F6eMIvjj/1tdso2pnIJUGQN
        wthmwcc1j2wkPdwmCBRLHc5U7aReiTo=
X-Google-Smtp-Source: AA6agR7I1859m8VZecCthmcgmvZYjzJM9cufmEyvv83W0quJFOCpP/gF1zvOWMDumK4rb5c+eAU4R1rl3t0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:a90:b0:530:2f3c:da43 with SMTP id
 b16-20020a056a000a9000b005302f3cda43mr32164396pfl.50.1662053587846; Thu, 01
 Sep 2022 10:33:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  1 Sep 2022 17:32:57 +0000
In-Reply-To: <20220901173258.925729-1-seanjc@google.com>
Mime-Version: 1.0
References: <20220901173258.925729-1-seanjc@google.com>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
Message-ID: <20220901173258.925729-5-seanjc@google.com>
Subject: [PATCH v4 4/5] KVM: VMX: Fold vmx_supported_debugctl() into vcpu_supported_debugctl()
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

Fold vmx_supported_debugctl() into vcpu_supported_debugctl(), its only
caller.  Setting bits only to clear them a few instructions later is
rather silly, and splitting the logic makes things seem more complicated
than they actually are.

Opportunistically drop DEBUGCTLMSR_LBR_MASK now that there's a single
reference to the pair of bits.  The extra layer of indirection provides
no meaningful value and makes it unnecessarily tedious to understand
what KVM is doing.

No functional change.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/vmx/capabilities.h | 15 ---------------
 arch/x86/kvm/vmx/vmx.c          | 12 +++++++-----
 2 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
index 23dca5ebae16..189a64a6e139 100644
--- a/arch/x86/kvm/vmx/capabilities.h
+++ b/arch/x86/kvm/vmx/capabilities.h
@@ -24,8 +24,6 @@ extern int __read_mostly pt_mode;
 #define PMU_CAP_FW_WRITES	(1ULL << 13)
 #define PMU_CAP_LBR_FMT		0x3f
 
-#define DEBUGCTLMSR_LBR_MASK		(DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI)
-
 struct nested_vmx_msrs {
 	/*
 	 * We only store the "true" versions of the VMX capability MSRs. We
@@ -403,19 +401,6 @@ static inline bool vmx_pebs_supported(void)
 	return boot_cpu_has(X86_FEATURE_PEBS) && kvm_pmu_cap.pebs_ept;
 }
 
-static inline u64 vmx_supported_debugctl(void)
-{
-	u64 debugctl = 0;
-
-	if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT))
-		debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;
-
-	if (vmx_get_perf_capabilities() & PMU_CAP_LBR_FMT)
-		debugctl |= DEBUGCTLMSR_LBR_MASK;
-
-	return debugctl;
-}
-
 static inline bool cpu_has_notify_vmexit(void)
 {
 	return vmcs_config.cpu_based_2nd_exec_ctrl &
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 657fa9908bf9..a5e3c1e6aa2b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2030,13 +2030,15 @@ static u64 nested_vmx_truncate_sysenter_addr(struct kvm_vcpu *vcpu,
 
 static u64 vcpu_supported_debugctl(struct kvm_vcpu *vcpu)
 {
-	u64 debugctl = vmx_supported_debugctl();
+	u64 debugctl = 0;
 
-	if (!intel_pmu_lbr_is_enabled(vcpu))
-		debugctl &= ~DEBUGCTLMSR_LBR_MASK;
+	if (boot_cpu_has(X86_FEATURE_BUS_LOCK_DETECT) &&
+	    guest_cpuid_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
+		debugctl |= DEBUGCTLMSR_BUS_LOCK_DETECT;
 
-	if (!guest_cpuid_has(vcpu, X86_FEATURE_BUS_LOCK_DETECT))
-		debugctl &= ~DEBUGCTLMSR_BUS_LOCK_DETECT;
+	if ((vmx_get_perf_capabilities() & PMU_CAP_LBR_FMT) &&
+	    intel_pmu_lbr_is_enabled(vcpu))
+		debugctl |= DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI;
 
 	return debugctl;
 }
-- 
2.37.2.789.g6183377224-goog

