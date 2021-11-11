Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1409FC4332F
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 02:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBC786108B
	for <linux-perf-users@archiver.kernel.org>; Thu, 11 Nov 2021 02:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbhKKCL5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 10 Nov 2021 21:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234298AbhKKCL2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 10 Nov 2021 21:11:28 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8272DC0797B8
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 18:08:02 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id m26-20020a62a21a000000b0041361973ba7so3026089pff.15
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Nov 2021 18:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=fHeYagzJUlx8WvSWOWzAacKfteJvqH26iwX6/BL5oRM=;
        b=I1iMFlsTKJ7I9ZBlooH8LUuysl6kvigdxx570TJkSRxR5Epl554X0SupugqMgxooRa
         Js7Gd3LnB4f/Od2LdYQfjJvJrd7Jj5SR+bgYd/KsVTHaX78qwBxLzlhPNrgrGQW9HBZM
         Gf+2IkKjJau7mgLZiDcv4KWoS8FOEgdksbSmIKXguTp9uiLzYV0qE4TCK48GTJ0xK34S
         pPAdtQowal2kVffJJ8FkMF2ePQNvYgo/wLvddDptRGq7iTfLonp7DuFAyOF+gUabTETs
         Um+LI0mma5pdcsVh0PUQ0Cq0ms/rh1QbrsfaYQV7RfZ7Xi1vwzyVVaWe1zMfes0/v0pu
         VVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=fHeYagzJUlx8WvSWOWzAacKfteJvqH26iwX6/BL5oRM=;
        b=cdAk6+b5v4F/Duy24dtM8IrxnZdmh9b9WpNiQ+oUmGEGJxoSuUSVhk08mVtlqP0zMw
         QFKf7F2bbquO13Iu02DZq70k6CdQ/kzpcFD9/vnTMik7XlwbuWDqby1tho/EknYpY6AL
         IZ17ZmvNMG0iogh1vWV1Qt07OnZ46w2HvdsQYV1zY7oDOM8Ph1iqn9ow5Y5Zsjycpd7l
         Z4mtGLwUbs/G0C54YpQHOsOlyti5O0rSTmlUk15++X6Fd+9xDkiVYmUiazoQ7h7sBwqr
         JNbbxjy1T1wwksRu9tW+J3IrGgIe4KK/le940fNILLQLFsbal61pr3qBJAImP/FhPq1f
         Vxtg==
X-Gm-Message-State: AOAM530nttY7+OY0Ey5ECx4APkzn95X58XBRzG+zBuBedPQRipoi5XN1
        bIX3+ip0y373P5g83Q0UXDE5dDmyxaE=
X-Google-Smtp-Source: ABdhPJwlj+RL95wDPLaJIcjI0VzoyEr26DB5cELwjkd8PtU9zdr9HE6g2qmDfqx1IbL5j6HU26ZztAJb2Z8=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:aa7:808e:0:b0:493:f071:274f with SMTP id
 v14-20020aa7808e000000b00493f071274fmr3568138pff.37.1636596481978; Wed, 10
 Nov 2021 18:08:01 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 11 Nov 2021 02:07:34 +0000
In-Reply-To: <20211111020738.2512932-1-seanjc@google.com>
Message-Id: <20211111020738.2512932-14-seanjc@google.com>
Mime-Version: 1.0
References: <20211111020738.2512932-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v4 13/17] KVM: x86: Move Intel Processor Trace interrupt
 handler to vmx.c
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        Artem Kashkanov <artem.kashkanov@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Like Xu <like.xu@linux.intel.com>,
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
index ec16f645cb8c..621bedff0aa5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1515,7 +1515,7 @@ struct kvm_x86_init_ops {
 	int (*disabled_by_bios)(void);
 	int (*check_processor_compatibility)(void);
 	int (*hardware_setup)(void);
-	bool (*intel_pt_intr_in_guest)(void);
+	unsigned int (*handle_intel_pt_intr)(void);
 
 	struct kvm_x86_ops *runtime_ops;
 };
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 36098eb9a7f9..7cb7f261f7dc 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -7708,6 +7708,20 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
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
 
@@ -7734,6 +7748,8 @@ static __init void vmx_setup_user_return_msrs(void)
 		kvm_add_user_return_msr(vmx_uret_msrs_list[i]);
 }
 
+static struct kvm_x86_init_ops vmx_init_ops __initdata;
+
 static __init int hardware_setup(void)
 {
 	unsigned long host_bndcfgs;
@@ -7892,6 +7908,10 @@ static __init int hardware_setup(void)
 		return -EINVAL;
 	if (!enable_ept || !cpu_has_vmx_intel_pt())
 		pt_mode = PT_MODE_SYSTEM;
+	if (pt_mode == PT_MODE_HOST_GUEST)
+		vmx_init_ops.handle_intel_pt_intr = vmx_handle_intel_pt_intr;
+	else
+		vmx_init_ops.handle_intel_pt_intr = NULL;
 
 	setup_default_sgx_lepubkeyhash();
 
@@ -7920,7 +7940,7 @@ static struct kvm_x86_init_ops vmx_init_ops __initdata = {
 	.disabled_by_bios = vmx_disabled_by_bios,
 	.check_processor_compatibility = vmx_check_processor_compat,
 	.hardware_setup = hardware_setup,
-	.intel_pt_intr_in_guest = vmx_pt_mode_is_host_guest,
+	.handle_intel_pt_intr = NULL,
 
 	.runtime_ops = &vmx_x86_ops,
 };
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index bafd2e78ad04..a4d25d0587e6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8410,20 +8410,6 @@ static void kvm_timer_init(void)
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
@@ -11116,11 +11102,7 @@ int kvm_arch_hardware_setup(void *opaque)
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
2.34.0.rc0.344.g81b53c2807-goog

