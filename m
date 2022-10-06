Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F41C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Oct 2022 00:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJFADb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Oct 2022 20:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiJFADY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Oct 2022 20:03:24 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C2F86827
        for <linux-perf-users@vger.kernel.org>; Wed,  5 Oct 2022 17:03:23 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id j3-20020a170902da8300b001782a6fbc87so119879plx.5
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Oct 2022 17:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QqkTsotquztSOhKCsGxZ7jnMJ1Q4/SxQ9WGAiQ1iUM4=;
        b=VltPshIZbtjK6IQgaxvnmemzbjNs/4JCfY+W4Mo3ZlbMjHQuYb4eKA2UrXPOjZtST3
         yL+tKIjdh5Yy0BhH+uiyehGydzHKC6RnFth6N3qoi1UcFzeSY3bZiLcLcCbzjoOD77yX
         ahawA7j+QuYh38QO2nSkBXQPEtnJIO3LDHgudJzE5RelpK5wRfP7J8ce05VO7kxKuLOd
         x1mxp4QHtad1xLi6OsoIxKg1v8BUCdXHyzpt/4UE31Y7PiEMDYA5N+V++ZoCQUYhZrEH
         bnGk6dlCiqX/cy1CNN6x7KpHLa70f16MphBduRav+N9KHNueytrrKGjTRnYA4zZoRBXs
         c/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QqkTsotquztSOhKCsGxZ7jnMJ1Q4/SxQ9WGAiQ1iUM4=;
        b=B9CpczIlaqqEZlrQoJQA8hhbZzjD0gGI/jXzrBsc8ivrnf6F/mGcjMsDVeJdSq6kQQ
         x8nZf4qJcsc01SiGwS70e3rFE/CHaP8oG4VaJZTzfYNUPZDJe2HyLktAj2q4osaOBznn
         OBGglN7GlKtdXC6PeeD48y7A5tg/DIXSNU2nI9vb8ESEd26FsodHZjYo5Orwb0uh33JJ
         BUdV3jBd0yCL87PltVWFQg4qB/+6hqaDyjZN4Jqtc4Xd+cT5sfrLHRPHHBVqQ7Vfb/sS
         Uo7qi/0wqp8cfz0jKqivRHATHj4ZNgLo7BzG/xH+bZyJoL55fecxn7BUCpyMENR9gPvp
         r7AQ==
X-Gm-Message-State: ACrzQf1hxYmOcvyEWuo0JbH8gH1D3Gpm3CCQY9gws3kpPiMfL42+xUbq
        5vQk+XwGVT/VfEIVRj0kT61zawusdak=
X-Google-Smtp-Source: AMsMyM5oLSMANpLQHpKw/HhjgHATYwn9XSrmp+P17cUSX7wQwWAdEe7Cv7AzuAqabzuS9ywPvyZx5XMwynU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1503:b0:546:833c:ed05 with SMTP id
 q3-20020a056a00150300b00546833ced05mr2299761pfu.44.1665014602996; Wed, 05 Oct
 2022 17:03:22 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu,  6 Oct 2022 00:03:09 +0000
In-Reply-To: <20221006000314.73240-1-seanjc@google.com>
Mime-Version: 1.0
References: <20221006000314.73240-1-seanjc@google.com>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
Message-ID: <20221006000314.73240-4-seanjc@google.com>
Subject: [PATCH v5 3/8] KVM: VMX: Fold vmx_supported_debugctl() into vcpu_supported_debugctl()
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
index a6689bf06542..479124e49bbd 100644
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
@@ -422,19 +420,6 @@ static inline u64 vmx_get_perf_capabilities(void)
 	return perf_cap;
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
index 9dba04b6b019..97fc873c37fa 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2023,13 +2023,15 @@ static u64 nested_vmx_truncate_sysenter_addr(struct kvm_vcpu *vcpu,
 
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
2.38.0.rc1.362.ged0d419d3c-goog

