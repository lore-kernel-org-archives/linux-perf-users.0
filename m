Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D190C43214
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 Aug 2021 00:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7594F60FDC
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 Aug 2021 00:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243966AbhH0A7u (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 Aug 2021 20:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244107AbhH0A71 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Aug 2021 20:59:27 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570E6C061140
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Aug 2021 17:57:59 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m66-20020a257145000000b00598282d96ceso4900615ybc.3
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Aug 2021 17:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=2Yb1yGb5fDFVhiHzotpZzkExCo5t0u5SIR8VcomG6Y8=;
        b=oWsDHoiAgF+Rhb3fLUc6FI/hmLn3kcWZvx8XtETflRRGA0RhU5jY1yIZDAGsQhoBpp
         1GJBEG0ciVc5J+SUb8a+Ao9XHC+o6ePIJEaj6rwWcsyMNZs4gGZqc7lzXXQCKUD4cl0c
         TRH/cFXEm6Rx0y/hBRfKtUfta8tkBrKjcdPY8umqV9V9fsCKuHTQ7mSyJMBSrgahXH0x
         lar1IXWEl6SGlmj++N0CiAloA9rKj68iYW0I4yXj2kb3Jns102ph3m6+Q2Bdd5QiIhz6
         k5kD3EQUqFV+FChTG+7KKqC3KPQuPp+dCSp1iLM55DlUy2uQ6DK+nKRfDfTvKe6dg2+c
         5JTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=2Yb1yGb5fDFVhiHzotpZzkExCo5t0u5SIR8VcomG6Y8=;
        b=gHWRyYDIwj4Q+s3C4cREdsN/Tbnn4eXQECHXaKk1wjinSVDrDG+GPEIXJIiuiXIgKP
         ChjhZAgRDkyWqIayaDT1W8kkLSnTwVQpq6h+3gS8/Mk9CnwqbTeTERBYEZxf1ZyC9utn
         ymhBrsCwzplvAwjh5Iy9jNACXpad1e4sdAUvCiWqHCfF2BetSI394TeI9wq49qxXjkRB
         veUMTqhgLz1BI0AHiCvV/BI6BEqJE9hPSRD3BOVPjh6YixeCpBAKwXG5VHGInm3cq4eC
         1Wgx7gTPRmhocx/1ZUdNsXyhlTF1Sh9nD55Avv8jtKdMfKv4N0pzh04UZPkG+9AKooxn
         plvQ==
X-Gm-Message-State: AOAM533o2ElKZMRN5v4v4hZah6WZ0gHvn/mqz4AwKg4sERYp1IfyO6nz
        bnrIimRG81dt8aujRJAadwwhFSDqfEg=
X-Google-Smtp-Source: ABdhPJyKOmCo1JFta7E0dfGCF9Bd2CrFpGk6nB1tappPD2rgxLfvtZsunCu2ZMBBzPSrD7zu0QWkL018uCA=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:c16c:db05:96b2:1475])
 (user=seanjc job=sendgmr) by 2002:a5b:c0a:: with SMTP id f10mr1802450ybq.353.1630025878542;
 Thu, 26 Aug 2021 17:57:58 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 26 Aug 2021 17:57:16 -0700
In-Reply-To: <20210827005718.585190-1-seanjc@google.com>
Message-Id: <20210827005718.585190-14-seanjc@google.com>
Mime-Version: 1.0
References: <20210827005718.585190-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH 13/15] KVM: arm64: Drop perf.c and fold its tiny bit of code
 into pmu.c
From:   Sean Christopherson <seanjc@google.com>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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

Fold that last few remnants of perf.c into pmu.c and rename the init
helper as appropriate.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/include/asm/kvm_host.h |  2 --
 arch/arm64/kvm/Makefile           |  2 +-
 arch/arm64/kvm/arm.c              |  3 ++-
 arch/arm64/kvm/perf.c             | 20 --------------------
 arch/arm64/kvm/pmu.c              |  8 ++++++++
 include/kvm/arm_pmu.h             |  1 +
 6 files changed, 12 insertions(+), 24 deletions(-)
 delete mode 100644 arch/arm64/kvm/perf.c

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 12e8d789e1ac..86c0fdd11ad2 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -670,8 +670,6 @@ unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len);
 int kvm_handle_mmio_return(struct kvm_vcpu *vcpu);
 int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa);
 
-void kvm_perf_init(void);
-
 #ifdef CONFIG_PERF_EVENTS
 #define __KVM_WANT_PERF_CALLBACKS
 #else
diff --git a/arch/arm64/kvm/Makefile b/arch/arm64/kvm/Makefile
index 989bb5dad2c8..0bcc378b7961 100644
--- a/arch/arm64/kvm/Makefile
+++ b/arch/arm64/kvm/Makefile
@@ -12,7 +12,7 @@ obj-$(CONFIG_KVM) += hyp/
 
 kvm-y := $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o $(KVM)/eventfd.o \
 	 $(KVM)/vfio.o $(KVM)/irqchip.o $(KVM)/binary_stats.o \
-	 arm.o mmu.o mmio.o psci.o perf.o hypercalls.o pvtime.o \
+	 arm.o mmu.o mmio.o psci.o hypercalls.o pvtime.o \
 	 inject_fault.o va_layout.o handle_exit.o \
 	 guest.o debug.o reset.o sys_regs.o \
 	 vgic-sys-reg-v3.o fpsimd.o pmu.o \
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index dfc8078dd4f9..57e637dee71d 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1747,7 +1747,8 @@ static int init_subsystems(void)
 	if (err)
 		goto out;
 
-	kvm_perf_init();
+	kvm_pmu_init();
+
 	kvm_sys_reg_table_init();
 
 out:
diff --git a/arch/arm64/kvm/perf.c b/arch/arm64/kvm/perf.c
deleted file mode 100644
index ad9fdc2f2f70..000000000000
--- a/arch/arm64/kvm/perf.c
+++ /dev/null
@@ -1,20 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Based on the x86 implementation.
- *
- * Copyright (C) 2012 ARM Ltd.
- * Author: Marc Zyngier <marc.zyngier@arm.com>
- */
-
-#include <linux/perf_event.h>
-#include <linux/kvm_host.h>
-
-#include <asm/kvm_emulate.h>
-
-DEFINE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
-
-void kvm_perf_init(void)
-{
-	if (kvm_pmu_probe_pmuver() != 0xf && !is_protected_kvm_enabled())
-		static_branch_enable(&kvm_arm_pmu_available);
-}
diff --git a/arch/arm64/kvm/pmu.c b/arch/arm64/kvm/pmu.c
index 03a6c1f4a09a..d98b57a17043 100644
--- a/arch/arm64/kvm/pmu.c
+++ b/arch/arm64/kvm/pmu.c
@@ -7,6 +7,14 @@
 #include <linux/perf_event.h>
 #include <asm/kvm_hyp.h>
 
+DEFINE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
+
+void kvm_pmu_init(void)
+{
+	if (kvm_pmu_probe_pmuver() != 0xf && !is_protected_kvm_enabled())
+		static_branch_enable(&kvm_arm_pmu_available);
+}
+
 /*
  * Given the perf event attributes and system type, determine
  * if we are going to need to switch counters at guest entry/exit.
diff --git a/include/kvm/arm_pmu.h b/include/kvm/arm_pmu.h
index 864b9997efb2..42270676498d 100644
--- a/include/kvm/arm_pmu.h
+++ b/include/kvm/arm_pmu.h
@@ -14,6 +14,7 @@
 #define ARMV8_PMU_MAX_COUNTER_PAIRS	((ARMV8_PMU_MAX_COUNTERS + 1) >> 1)
 
 DECLARE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
+void kvm_pmu_init(void);
 
 static __always_inline bool kvm_arm_support_pmu_v3(void)
 {
-- 
2.33.0.259.gc128427fd7-goog

