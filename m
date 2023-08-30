Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7041C83F14
	for <linux-perf-users@archiver.kernel.org>; Wed, 30 Aug 2023 20:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbjH3UZg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 30 Aug 2023 16:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236280AbjH3UZW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 30 Aug 2023 16:25:22 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F50C3
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Aug 2023 12:50:05 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68becf931d0so27186b3a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Aug 2023 12:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693424942; x=1694029742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=slAW2Im/sTTYajsirP7USWN9swEAOtCmSWTeStPwo7o=;
        b=gEpalaxyLa6CJpEaiUkH+fFXTUxndwT3iSQIF2y7fU7k5kE1Ob2UDbw8JnmXq9WZY5
         5bvCV/4Y4Mjlaz6r0lR15IIX1aZqIidIVRn6wRCvWrsOqXc9eMCgtizpS98up7+3LKwn
         he2fLP+RMNdlBAFU9G1j3lSsHUSz5XaIOFbj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693424942; x=1694029742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=slAW2Im/sTTYajsirP7USWN9swEAOtCmSWTeStPwo7o=;
        b=SwxDXmEK5biAuMPQjGioZJ2C9fFWHQAuUy5+cYobINbT3J4JpkY5T94JT/CGKRgztQ
         dEMsZOwK5WNstO5wBprkdzUCuI8oSdrxslf8Uuml0RSWxor1ECcrjbBHbW+IkoxzL40E
         Uq63CNgInHDNBHmE7j9gmMHL6qlug7cH2PKtlQ6J4/HYxEJOyibd6ykkZbQmE/IwywTB
         yFgkg3pUZ4WyGflwIejGq8u883pBMfrAYlxzfOE+AGVwivQJWITz+TNhMAL2ES+ptFfC
         IcebyYKC3QAk/xMIqz0NZVHPIraXKwj2IdGfad62dBqFbL8fahn+8dM4Bjhmldkfxv4W
         v9Bw==
X-Gm-Message-State: AOJu0YzgPAlHpSPjoW+BQCvZv1IkDVYcT5L2FEZkNjOQIDuwmwdahjAM
        uKC2MpYktpFhL9c6snlgPbqakiMHBHVgCmM1hFKqhcpq
X-Google-Smtp-Source: AGHT+IGs5wmPH6VUj5vxSMDVt8IZit/qtArisBlDNtIox6ThtJQg2l+nj/lBya2WEJt+SNieKhhn9g==
X-Received: by 2002:a17:902:6b42:b0:1c0:a5c9:e05a with SMTP id g2-20020a1709026b4200b001c0a5c9e05amr2579799plt.43.1693422825157;
        Wed, 30 Aug 2023 12:13:45 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:e315:dec6:467c:83c5])
        by smtp.gmail.com with ESMTPSA id c15-20020a170902d48f00b001bbdf32f011sm11338928plg.269.2023.08.30.12.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 12:13:44 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Tomohiro Misono <misono.tomohiro@fujitsu.com>,
        Stephane Eranian <eranian@google.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <swboyd@chromium.org>, ito-yuichi@fujitsu.com,
        linux-perf-users@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v12 4/7] arm64: smp: Add arch support for backtrace using pseudo-NMI
Date:   Wed, 30 Aug 2023 12:11:25 -0700
Message-ID: <20230830121115.v12.4.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230830191314.1618136-1-dianders@chromium.org>
References: <20230830191314.1618136-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Enable arch_trigger_cpumask_backtrace() support on arm64. This enables
things much like they are enabled on arm32 (including some of the
funky logic around NR_IPI, nr_ipi, and MAX_IPI) but with the
difference that, unlike arm32, we'll try to enable the backtrace to
use pseudo-NMI.

NOTE: this patch is a squash of the little bit of code adding the
ability to mark an IPI to try to use pseudo-NMI plus the little bit of
code to hook things up for kgdb. This approach was decided upon in the
discussion of v9 [1].

This patch depends on commit 8d539b84f1e3 ("nmi_backtrace: allow
excluding an arbitrary CPU") since that commit changed the prototype
of arch_trigger_cpumask_backtrace(), which this patch implements.

[1] https://lore.kernel.org/r/ZORY51mF4alI41G1@FVFF77S0Q05N

Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Co-developed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Misono Tomohiro <misono.tomohiro@fujitsu.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v12:
- Minor comment change to add "()" after nmi_trigger_cpumask_backtrace.
- Updated the commit hash of the commit this depends on.

Changes in v11:
- Adjust comment about NR_IPI/MAX_IPI.
- Don't use confusing "backed by" idiom in comment.
- Made arm64_backtrace_ipi() static.

Changes in v10:
- Backtrace now directly supported in smp.c
- Squash backtrace into patch adding support for pseudo-NMI IPIs.

Changes in v9:
- Added comments that we might not be using NMI always.
- Fold in v8 patch #10 ("Fallback to a regular IPI if NMI isn't enabled")
- Moved header file out of "include" since it didn't need to be there.
- Remove arm64_supports_nmi()
- Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.
- arch_trigger_cpumask_backtrace() no longer returns bool

Changes in v8:
- Removed "#ifdef CONFIG_SMP" since arm64 is always SMP
- debug_ipi_setup() and debug_ipi_teardown() no longer take cpu param

 arch/arm64/include/asm/irq.h |  3 ++
 arch/arm64/kernel/smp.c      | 86 +++++++++++++++++++++++++++++++-----
 2 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index fac08e18bcd5..50ce8b697ff3 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -6,6 +6,9 @@
 
 #include <asm-generic/irq.h>
 
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
+
 struct pt_regs;
 
 int set_handle_irq(void (*handle_irq)(struct pt_regs *));
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index a5848f1ef817..28c904ca499a 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -33,6 +33,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/kexec.h>
 #include <linux/kvm_host.h>
+#include <linux/nmi.h>
 
 #include <asm/alternative.h>
 #include <asm/atomic.h>
@@ -72,12 +73,18 @@ enum ipi_msg_type {
 	IPI_CPU_CRASH_STOP,
 	IPI_TIMER,
 	IPI_IRQ_WORK,
-	NR_IPI
+	NR_IPI,
+	/*
+	 * Any enum >= NR_IPI and < MAX_IPI is special and not tracable
+	 * with trace_ipi_*
+	 */
+	IPI_CPU_BACKTRACE = NR_IPI,
+	MAX_IPI
 };
 
 static int ipi_irq_base __read_mostly;
 static int nr_ipi __read_mostly = NR_IPI;
-static struct irq_desc *ipi_desc[NR_IPI] __read_mostly;
+static struct irq_desc *ipi_desc[MAX_IPI] __read_mostly;
 
 static void ipi_setup(int cpu);
 
@@ -845,6 +852,22 @@ static void __noreturn ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs
 #endif
 }
 
+static void arm64_backtrace_ipi(cpumask_t *mask)
+{
+	__ipi_send_mask(ipi_desc[IPI_CPU_BACKTRACE], mask);
+}
+
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, int exclude_cpu)
+{
+	/*
+	 * NOTE: though nmi_trigger_cpumask_backtrace() has "nmi_" in the name,
+	 * nothing about it truly needs to be implemented using an NMI, it's
+	 * just that it's _allowed_ to work with NMIs. If ipi_should_be_nmi()
+	 * returned false our backtrace attempt will just use a regular IPI.
+	 */
+	nmi_trigger_cpumask_backtrace(mask, exclude_cpu, arm64_backtrace_ipi);
+}
+
 /*
  * Main handler for inter-processor interrupts
  */
@@ -888,6 +911,14 @@ static void do_handle_IPI(int ipinr)
 		break;
 #endif
 
+	case IPI_CPU_BACKTRACE:
+		/*
+		 * NOTE: in some cases this _won't_ be NMI context. See the
+		 * comment in arch_trigger_cpumask_backtrace().
+		 */
+		nmi_cpu_backtrace(get_irq_regs());
+		break;
+
 	default:
 		pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
 		break;
@@ -909,6 +940,19 @@ static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
 	__ipi_send_mask(ipi_desc[ipinr], target);
 }
 
+static bool ipi_should_be_nmi(enum ipi_msg_type ipi)
+{
+	if (!system_uses_irq_prio_masking())
+		return false;
+
+	switch (ipi) {
+	case IPI_CPU_BACKTRACE:
+		return true;
+	default:
+		return false;
+	}
+}
+
 static void ipi_setup(int cpu)
 {
 	int i;
@@ -916,8 +960,14 @@ static void ipi_setup(int cpu)
 	if (WARN_ON_ONCE(!ipi_irq_base))
 		return;
 
-	for (i = 0; i < nr_ipi; i++)
-		enable_percpu_irq(ipi_irq_base + i, 0);
+	for (i = 0; i < nr_ipi; i++) {
+		if (ipi_should_be_nmi(i)) {
+			prepare_percpu_nmi(ipi_irq_base + i);
+			enable_percpu_nmi(ipi_irq_base + i, 0);
+		} else {
+			enable_percpu_irq(ipi_irq_base + i, 0);
+		}
+	}
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -928,8 +978,14 @@ static void ipi_teardown(int cpu)
 	if (WARN_ON_ONCE(!ipi_irq_base))
 		return;
 
-	for (i = 0; i < nr_ipi; i++)
-		disable_percpu_irq(ipi_irq_base + i);
+	for (i = 0; i < nr_ipi; i++) {
+		if (ipi_should_be_nmi(i)) {
+			disable_percpu_nmi(ipi_irq_base + i);
+			teardown_percpu_nmi(ipi_irq_base + i);
+		} else {
+			disable_percpu_irq(ipi_irq_base + i);
+		}
+	}
 }
 #endif
 
@@ -937,15 +993,23 @@ void __init set_smp_ipi_range(int ipi_base, int n)
 {
 	int i;
 
-	WARN_ON(n < NR_IPI);
-	nr_ipi = min(n, NR_IPI);
+	WARN_ON(n < MAX_IPI);
+	nr_ipi = min(n, MAX_IPI);
 
 	for (i = 0; i < nr_ipi; i++) {
 		int err;
 
-		err = request_percpu_irq(ipi_base + i, ipi_handler,
-					 "IPI", &cpu_number);
-		WARN_ON(err);
+		if (ipi_should_be_nmi(i)) {
+			err = request_percpu_nmi(ipi_base + i, ipi_handler,
+						 "IPI", &cpu_number);
+			WARN(err, "Could not request IPI %d as NMI, err=%d\n",
+			     i, err);
+		} else {
+			err = request_percpu_irq(ipi_base + i, ipi_handler,
+						 "IPI", &cpu_number);
+			WARN(err, "Could not request IPI %d as IRQ, err=%d\n",
+			     i, err);
+		}
 
 		ipi_desc[i] = irq_to_desc(ipi_base + i);
 		irq_set_status_flags(ipi_base + i, IRQ_HIDDEN);
-- 
2.42.0.283.g2d96d420d3-goog

