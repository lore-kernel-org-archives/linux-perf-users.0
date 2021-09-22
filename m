Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886C3C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 00:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA0B61159
	for <linux-perf-users@archiver.kernel.org>; Wed, 22 Sep 2021 00:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhIVAIb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Sep 2021 20:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbhIVAIO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Sep 2021 20:08:14 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD000C0617A6
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 17:06:12 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id c21-20020ac85195000000b002a540bbf1caso5693691qtn.2
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 17:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=y8OYsYpDs1HLDvFjdurM0d7KqhhKHNQa2gUw1mVnDLE=;
        b=VgUrfICBEU208O8puU1yf0798dMNWQPdVEv1umOOfyY7+MLL+nmtJuMQRYhGk6ACPB
         kV7DCUw8x7TThTD9JohJr12iNp9IVCl2gpkkOQsZfWo7I0JLG16fmuO2MGI3z76Slotc
         tAS3raY0P7YO93IW++jVoxXSx7bgW6LXHh9Lg2GYrEnit4mDk0PviAE/NTWZXLAHL0sx
         tQX8bpmjgklBcXInIIRO8BoGyPy1BMCOolkyTRz+cls0PNm7fOz8/SKH73cd2RwpkSM5
         C8zyjgBkrIzTe2Xfi0y9KCgCoaxdmORS5u5QyM9nNkpibluFvb/Koa8wFffrHGQL3WIt
         pSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=y8OYsYpDs1HLDvFjdurM0d7KqhhKHNQa2gUw1mVnDLE=;
        b=hVATY99IXX7Q5ZtgIVPPq0F2pl0hskP/1f3GdmuOfOpchaFi/crLoUmmFwA0pyme2u
         r0JXcbXzlppow1+PUIlbdlZepW65A1tuRpyLxT3gvK3xhXJO3jhQDeVoWw2ijsUSTuwK
         y5ANfp+P7sEimnyDyDnW1Lf94URTymD7J4bejFVUCZZ4WsuO/R+x6kUbsaywVyS2IRAD
         5hNJY4/a2J7KGHMu5UgwHr5RIKIYVWWM6F05/EOyBAi5qbBsg5jum1jGV6U8VT9NFXlc
         aevdF6SUZIYKZk6AEhxKLAAGG7CJv1iri/yhw6UMBt0XTqk8pRGyY6axQAG78b856o41
         ii4g==
X-Gm-Message-State: AOAM530B6cOkK8lOPz7pyp1sqU2wnh9KIukzX+/JdMeAlZScWFtOpVM1
        j8PYl8JARIaUUdnX5SkUjS1Cbr21yOQ=
X-Google-Smtp-Source: ABdhPJyHtapTp0OfNUKTfdvcX6WW6HZmgDH9RXeTSlkheaqjZb44gygT11cJLtQ1bPei5p+RUE6ibKLU+f0=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:b022:92d6:d37b:686c])
 (user=seanjc job=sendgmr) by 2002:a25:d9cc:: with SMTP id q195mr41667087ybg.15.1632269171910;
 Tue, 21 Sep 2021 17:06:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Sep 2021 17:05:30 -0700
In-Reply-To: <20210922000533.713300-1-seanjc@google.com>
Message-Id: <20210922000533.713300-14-seanjc@google.com>
Mime-Version: 1.0
References: <20210922000533.713300-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3 13/16] KVM: x86: Move Intel Processor Trace interrupt
 handler to vmx.c
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Artem Kashkanov <artem.kashkanov@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Now that all state needed for VMX's PT interrupt handler is exposed to
vmx.c (specifically the currently running vCPU), move the handler into
vmx.c where it belongs.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/vmx/vmx.c          | 22 +++++++++++++++++++++-
 arch/x86/kvm/x86.c              | 20 +-------------------
 3 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6efe4e03a6d2..d40814b57ae8 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1495,7 +1495,7 @@ struct kvm_x86_init_ops {
 	int (*disabled_by_bios)(void);
 	int (*check_processor_compatibility)(void);
 	int (*hardware_setup)(void);
-	bool (*intel_pt_intr_in_guest)(void);
+	unsigned int (*handle_intel_pt_intr)(void);
 
 	struct kvm_x86_ops *runtime_ops;
 };
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 61a4f5ff2acd..33f92febe3ce 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7687,6 +7687,20 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
 	.vcpu_deliver_sipi_vector = kvm_vcpu_deliver_sipi_vector,
 };
 
+static unsigned int vmx_handle_intel_pt_intr(void)
+{
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
+
+	/* '0' on failure so that the !PT case can use a RET0 static call. */
+	if (!kvm_arch_pmi_in_guest(vcpu))
+		return 0;
+
+	kvm_make_request(KVM_REQ_PMI, vcpu);
+	__set_bit(MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT,
+		  (unsigned long *)&vcpu->arch.pmu.global_status);
+	return 1;
+}
+
 static __init void vmx_setup_user_return_msrs(void)
 {
 
@@ -7713,6 +7727,8 @@ static __init void vmx_setup_user_return_msrs(void)
 		kvm_add_user_return_msr(vmx_uret_msrs_list[i]);
 }
 
+static struct kvm_x86_init_ops vmx_init_ops __initdata;
+
 static __init int hardware_setup(void)
 {
 	unsigned long host_bndcfgs;
@@ -7873,6 +7889,10 @@ static __init int hardware_setup(void)
 		return -EINVAL;
 	if (!enable_ept || !cpu_has_vmx_intel_pt())
 		pt_mode = PT_MODE_SYSTEM;
+	if (pt_mode == PT_MODE_HOST_GUEST)
+		vmx_init_ops.handle_intel_pt_intr = vmx_handle_intel_pt_intr;
+	else
+		vmx_init_ops.handle_intel_pt_intr = NULL;
 
 	setup_default_sgx_lepubkeyhash();
 
@@ -7898,7 +7918,7 @@ static struct kvm_x86_init_ops vmx_init_ops __initdata = {
 	.disabled_by_bios = vmx_disabled_by_bios,
 	.check_processor_compatibility = vmx_check_processor_compat,
 	.hardware_setup = hardware_setup,
-	.intel_pt_intr_in_guest = vmx_pt_mode_is_host_guest,
+	.handle_intel_pt_intr = NULL,
 
 	.runtime_ops = &vmx_x86_ops,
 };
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1bea616402e6..b79b2d29260d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8264,20 +8264,6 @@ static void kvm_timer_init(void)
 			  kvmclock_cpu_online, kvmclock_cpu_down_prep);
 }
 
-static unsigned int kvm_handle_intel_pt_intr(void)
-{
-	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
-
-	/* '0' on failure so that the !PT case can use a RET0 static call. */
-	if (!kvm_arch_pmi_in_guest(vcpu))
-		return 0;
-
-	kvm_make_request(KVM_REQ_PMI, vcpu);
-	__set_bit(MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI_BIT,
-			(unsigned long *)&vcpu->arch.pmu.global_status);
-	return 1;
-}
-
 #ifdef CONFIG_X86_64
 static void pvclock_gtod_update_fn(struct work_struct *work)
 {
@@ -11031,11 +11017,7 @@ int kvm_arch_hardware_setup(void *opaque)
 	memcpy(&kvm_x86_ops, ops->runtime_ops, sizeof(kvm_x86_ops));
 	kvm_ops_static_call_update();
 
-	/* Temporary ugliness. */
-	if (ops->intel_pt_intr_in_guest && ops->intel_pt_intr_in_guest())
-		kvm_register_perf_callbacks(kvm_handle_intel_pt_intr);
-	else
-		kvm_register_perf_callbacks(NULL);
+	kvm_register_perf_callbacks(ops->handle_intel_pt_intr);
 
 	if (!kvm_cpu_cap_has(X86_FEATURE_XSAVES))
 		supported_xss = 0;
-- 
2.33.0.464.g1972c5931b-goog

