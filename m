Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14610C7EE23
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jun 2023 21:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbjFAVhc (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 17:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjFAVh0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jun 2023 17:37:26 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282E81B0
        for <linux-perf-users@vger.kernel.org>; Thu,  1 Jun 2023 14:37:17 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d18d772bdso1610832b3a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jun 2023 14:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685655436; x=1688247436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9zVBczE5O/mOGSjCuNx2rXBFKme8bX0ZhvLdtMhoiJw=;
        b=gJtJ5FNgW645QFhWJrwgv+eoPxUDcKJjQ0xUeo56kyURgPks4SkoC2MQNDgXTtkZn7
         QpKWQwG1Ny/ElORyKFDpyWZbKE5bj+Wp8fgVBvS+d/n6lwbgm1qW/f/93p6MP2NY714A
         nlF2KzG2LMv/VRRI6kZ2Dt7zapyMsrojNB0GU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685655436; x=1688247436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9zVBczE5O/mOGSjCuNx2rXBFKme8bX0ZhvLdtMhoiJw=;
        b=Vtau10en4vOn6lnO56EHdfDeMsWhkbpZeoPxYUaGfRSGNhIO4klRoLonj5dZtzAsrH
         UQEuE7K54vBWJjoLP7gFtQk5FFXaPpsxNenAZdtqfllPCoWsb6Elav2De5yTAIZB1YJI
         TjiOPA9DBw9l6GzW54qQOlcVYCN4uyha3X0lKE3VMIzwu5fbsRvjeVRO+9q3l3KgFxj/
         JORLt8c6pghSuikllOWOOmOYYAbXYBcRo/Q7tG8GbZNDu5yi4T2ODVYkiH1OJoSrDDqH
         ojWO7wMxtWtZVtyD51VMBrrV003FOfLg04xTa/EXBv0YYgFVWiizjK1rPvvs+EO7d16j
         2ixA==
X-Gm-Message-State: AC+VfDxzVan08BKGmqSfutmovJaB7l0okHCjUFLIH2TWw0wZKmSnEWIL
        c90gNiUYE6vE55/GsQ1Ndw11TA==
X-Google-Smtp-Source: ACHHUZ5+oSxNdbJJZmlNccaogK7aaVEwJBbdqRJ3q2/KAcjer9oPcCVCtZIErTbQBeOU2bnwefC/oQ==
X-Received: by 2002:a05:6a00:1797:b0:651:ce88:27f5 with SMTP id s23-20020a056a00179700b00651ce8827f5mr2208089pfg.13.1685655436495;
        Thu, 01 Jun 2023 14:37:16 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:11b8:2d2:7e02:6bff])
        by smtp.gmail.com with ESMTPSA id g22-20020aa78756000000b0064d48d98260sm5319534pfo.156.2023.06.01.14.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 14:37:15 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Marc Zyngier <maz@kernel.org>
Cc:     linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Chen-Yu Tsai <wens@csie.org>, Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 5/7] arm64: ipi_debug: Add support for backtrace using the debug IPI
Date:   Thu,  1 Jun 2023 14:31:49 -0700
Message-ID: <20230601143109.v9.5.I65981105e1f62550b0316625dd1e599deaf9e1aa@changeid>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
In-Reply-To: <20230601213440.2488667-1-dianders@chromium.org>
References: <20230601213440.2488667-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Sumit Garg <sumit.garg@linaro.org>

Enable arch_trigger_cpumask_backtrace() support on arm64 using the new
debug IPI. With this arm64 can now get backtraces in cases where
callers of the trigger_xyz_backtrace() class of functions don't check
the return code and implement a fallback. One example is
`kernel.softlockup_all_cpu_backtrace`. This also allows us to
backtrace hard locked up CPUs in cases where the debug IPI is backed
by an NMI (or pseudo NMI).

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v9:
- Added comments that we might not be using NMI always.
- Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.
- arch_trigger_cpumask_backtrace() no longer returns bool

Changes in v8:
- Removed "#ifdef CONFIG_SMP" since arm64 is always SMP

 arch/arm64/include/asm/irq.h  |  3 +++
 arch/arm64/kernel/ipi_debug.c | 25 +++++++++++++++++++++++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index fac08e18bcd5..be2d103f316e 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -6,6 +6,9 @@
 
 #include <asm-generic/irq.h>
 
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
+
 struct pt_regs;
 
 int set_handle_irq(void (*handle_irq)(struct pt_regs *));
diff --git a/arch/arm64/kernel/ipi_debug.c b/arch/arm64/kernel/ipi_debug.c
index b57833e31eaf..6984ed507e1f 100644
--- a/arch/arm64/kernel/ipi_debug.c
+++ b/arch/arm64/kernel/ipi_debug.c
@@ -8,6 +8,7 @@
 
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/nmi.h>
 #include <linux/smp.h>
 
 #include "ipi_debug.h"
@@ -24,11 +25,31 @@ void arm64_debug_ipi(cpumask_t *mask)
 	__ipi_send_mask(ipi_debug_desc, mask);
 }
 
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+{
+	/*
+	 * NOTE: though nmi_trigger_cpumask_backtrace has "nmi_" in the name,
+	 * nothing about it truly needs to be backed by an NMI, it's just that
+	 * it's _allowed_ to be called from an NMI. If set_smp_debug_ipi()
+	 * failed to get an NMI (or pseudo-NMI) this will just be backed by a
+	 * regular IPI.
+	 */
+	nmi_trigger_cpumask_backtrace(mask, exclude_self, arm64_debug_ipi);
+}
+
 static irqreturn_t ipi_debug_handler(int irq, void *data)
 {
-	/* nop, NMI handlers for special features can be added here. */
+	irqreturn_t ret = IRQ_NONE;
+
+	/*
+	 * NOTE: Just like in arch_trigger_cpumask_backtrace(), we're calling
+	 * a function with "nmi_" in the name but it works fine even if we
+	 * are using a regulaor IPI.
+	 */
+	if (nmi_cpu_backtrace(get_irq_regs()))
+		ret = IRQ_HANDLED;
 
-	return IRQ_NONE;
+	return ret;
 }
 
 void debug_ipi_setup(void)
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

