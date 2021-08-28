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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EF1C43214
	for <linux-perf-users@archiver.kernel.org>; Sat, 28 Aug 2021 00:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8383360ED5
	for <linux-perf-users@archiver.kernel.org>; Sat, 28 Aug 2021 00:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233143AbhH1AiR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 27 Aug 2021 20:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbhH1Ahw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 27 Aug 2021 20:37:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0BFC0611C2
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Aug 2021 17:36:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m66-20020a257145000000b00598282d96ceso8297867ybc.3
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Aug 2021 17:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=8sgYBBoPv+2JwgnSGYhHNhVlG76cGIWAxgCtg/V/coQ=;
        b=H5N4ryA5hWTUAeyuBk5XizZ7N0trA7JIKj0csm/SnRrBSvZI4fvOfdylQj2HI9uGWb
         FlgA7RqivFC20QT3Fgdghq9BURCUg84MC8EYToh6OEPEn485kgBO2eBqSmuI+BgUif0L
         X0t7BSgnBR2SJjDLf8mzg4n0cr87GdYxedcIPWDQMs1CgXbr3dAKzNI+Ec51COkbfFee
         M/XLorZxISoZWBr6d43w4+OCYBUTM9KVOhPDBEHcmSrOb67+e2vyyj7m1qI8rapB1/sj
         sUKaaIlY0oFXPavLrApCVJnrUrYLouBq/sRrV1srDbUivxaMXuuYz/XSg705ezUGG1EI
         utYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=8sgYBBoPv+2JwgnSGYhHNhVlG76cGIWAxgCtg/V/coQ=;
        b=SXJJOKGkoaDFjABQfC4p9I403UZ3c2vDIW/zPYIAwGjzNdWlKl4O8q7Yimhq13cQef
         3cMbCmeJ6kaJKZITM5RURNtOyW34GZCvfXR0jf1kOH0Oq+Q2F5XMn0hZObIsSN323cxS
         69zXtWOtBXlJyz3NiZapKW/c6J6/PlUtTqrP8magqHFSsA6Ft/sqhu+1+/0jTZxcnVtg
         1DXI6UCfdS777IKHaBNByK4q1rneR/a6t4TTEPB4BLt2Rz2e4xYOD4XpkAIBREJZnkvi
         Pde6O10FlimuXXR6Kg9Vhyba+zEGLA7jCCBhWXcDMyyZVMUyOR8dOhx9UA++4bp37er5
         KzBQ==
X-Gm-Message-State: AOAM530Epo05TuU017T4LXkz3McFGgMMc6VLl4JgKbbhM/m3FBl0JIw5
        RQnCqe45qaK+LoD9xxGqBCF3eJWY4Xo=
X-Google-Smtp-Source: ABdhPJzymXWQza3vAsItF0sAPdCE8iLSMVzwPpM+LtdWMA9TXI8otz549S9ZetrsOJXPExeTt/x3hD0mXJY=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:f66c:b851:7e79:7ed4])
 (user=seanjc job=sendgmr) by 2002:a25:bb48:: with SMTP id b8mr7895492ybk.275.1630111012286;
 Fri, 27 Aug 2021 17:36:52 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri, 27 Aug 2021 17:35:57 -0700
In-Reply-To: <20210828003558.713983-1-seanjc@google.com>
Message-Id: <20210828003558.713983-13-seanjc@google.com>
Mime-Version: 1.0
References: <20210828003558.713983-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH v2 12/13] KVM: arm64: Convert to the generic perf callbacks
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
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
        Zhu Lingshan <lingshan.zhu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Drop arm64's version of the callbacks in favor of the callbacks provided
by generic KVM, which are semantically identical.  Implement the "get ip"
hook as needed.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/include/asm/kvm_host.h | 12 +++++++++++
 arch/arm64/kvm/arm.c              |  5 +++++
 arch/arm64/kvm/perf.c             | 34 ++-----------------------------
 3 files changed, 19 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index ed940aec89e0..73dc402ded1f 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -673,6 +673,18 @@ int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa);
 void kvm_perf_init(void);
 void kvm_perf_teardown(void);
 
+#ifdef CONFIG_PERF_EVENTS
+#define __KVM_WANT_PERF_CALLBACKS
+static inline bool kvm_arch_pmi_in_guest(struct kvm_vcpu *vcpu)
+{
+	/* Any callback while a vCPU is loaded is considered to be in guest. */
+	return !!vcpu;
+}
+#else
+static inline void kvm_register_perf_callbacks(void) {}
+static inline void kvm_unregister_perf_callbacks(void) {}
+#endif
+
 long kvm_hypercall_pv_features(struct kvm_vcpu *vcpu);
 gpa_t kvm_init_stolen_time(struct kvm_vcpu *vcpu);
 void kvm_update_stolen_time(struct kvm_vcpu *vcpu);
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index e9a2b8f27792..2b542fdc237e 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -500,6 +500,11 @@ bool kvm_arch_vcpu_in_kernel(struct kvm_vcpu *vcpu)
 	return vcpu_mode_priv(vcpu);
 }
 
+unsigned long kvm_arch_vcpu_get_ip(struct kvm_vcpu *vcpu)
+{
+	return *vcpu_pc(vcpu);
+}
+
 /* Just ensure a guest exit from a particular CPU */
 static void exit_vm_noop(void *info)
 {
diff --git a/arch/arm64/kvm/perf.c b/arch/arm64/kvm/perf.c
index 893de1a51fea..0b902e0d5b5d 100644
--- a/arch/arm64/kvm/perf.c
+++ b/arch/arm64/kvm/perf.c
@@ -13,45 +13,15 @@
 
 DEFINE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
 
-static unsigned int kvm_guest_state(void)
-{
-	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
-	unsigned int state;
-
-	if (!vcpu)
-		return 0;
-
-	state = PERF_GUEST_ACTIVE;
-	if (!vcpu_mode_priv(vcpu))
-		state |= PERF_GUEST_USER;
-
-	return state;
-}
-
-static unsigned long kvm_get_guest_ip(void)
-{
-	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
-
-	if (WARN_ON_ONCE(!vcpu))
-		return 0;
-
-	return *vcpu_pc(vcpu);
-}
-
-static struct perf_guest_info_callbacks kvm_guest_cbs = {
-	.state		= kvm_guest_state,
-	.get_ip		= kvm_get_guest_ip,
-};
-
 void kvm_perf_init(void)
 {
 	if (kvm_pmu_probe_pmuver() != 0xf && !is_protected_kvm_enabled())
 		static_branch_enable(&kvm_arm_pmu_available);
 
-	perf_register_guest_info_callbacks(&kvm_guest_cbs);
+	kvm_register_perf_callbacks(NULL);
 }
 
 void kvm_perf_teardown(void)
 {
-	perf_unregister_guest_info_callbacks();
+	kvm_unregister_perf_callbacks();
 }
-- 
2.33.0.259.gc128427fd7-goog

