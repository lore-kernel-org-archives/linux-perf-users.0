Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC105C77B7E
	for <linux-perf-users@archiver.kernel.org>; Thu,  1 Jun 2023 21:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjFAVh1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 1 Jun 2023 17:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjFAVhP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 1 Jun 2023 17:37:15 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC2C19D
        for <linux-perf-users@vger.kernel.org>; Thu,  1 Jun 2023 14:37:12 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64f47448aeaso1070762b3a.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Jun 2023 14:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685655432; x=1688247432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VxngL/nWZ9CvmSVXwg8pkM18NqkUW/hq6cWY9xHbU50=;
        b=aXtBMJsuEHVcZIKV7cLRpp9gJah5t0XCzX6mPhaAfDBP1dJ5ow0nIMbyHBqXyExXs/
         iONAnH757E2JdGKhPAJpJ0T+0at+owiwzn2oTUIqycF0fDPlNwbji/qaAjIXJsOAh/DF
         EzBp3VrZJfcftxuQAMYGMNArokNyBuLgHVwN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685655432; x=1688247432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxngL/nWZ9CvmSVXwg8pkM18NqkUW/hq6cWY9xHbU50=;
        b=MUEbVeHjSV7g63Oci3pjZOGV4ykXrQbaNlQ+uzPMNBMl3CahCi8l2QA6KWCEhuZ2BJ
         rTTp1Xf1oIE1IWoIMyiBIRRO73qY8evRSWFX2IqKA7lEEWjfdNJTdu66L6v1c35ZVH3c
         plnwvGC/eQ9bnWZnwKdY1yRM8y5SUMuDMFWIfamgAJN7axB8QdG3uBFE9WI3HkMMmFqE
         4lFgDMPpjztSTcqMZco9qud9IGuknjjsjr9cipziPj/5/B/wk4VMXHNRW2ZWxkgBhw4j
         yzxt9ctTl0zhbwGQZgwTCxXwfXIWs/zzI0nS2IUO0xYNHVEcpUg5N3jM4tatbWO9rkxU
         xhqA==
X-Gm-Message-State: AC+VfDyOdxUjnJFUU2ufCEeNYqKcpd9ii/VAovZT0pWmVVLN9HkfpqJb
        ApjC2mbvzU28U5fyxOLu2YQY+w==
X-Google-Smtp-Source: ACHHUZ5ef/rtEIYJxyW1OxKT1bSL//A95UwWPCmZBbTCdj36TOdor4jNJCZmCSlkwGKN3QsCenCWSg==
X-Received: by 2002:a05:6a00:8ca:b0:64c:b45f:fc86 with SMTP id s10-20020a056a0008ca00b0064cb45ffc86mr10767019pfu.17.1685655432123;
        Thu, 01 Jun 2023 14:37:12 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:11b8:2d2:7e02:6bff])
        by smtp.gmail.com with ESMTPSA id g22-20020aa78756000000b0064d48d98260sm5319534pfo.156.2023.06.01.14.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 14:37:11 -0700 (PDT)
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
        Andrey Konovalov <andreyknvl@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/7] arm64: Add framework for a debug IPI
Date:   Thu,  1 Jun 2023 14:31:47 -0700
Message-ID: <20230601143109.v9.3.Ie6c132b96ebbbcddbf6954b9469ed40a6960343c@changeid>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
In-Reply-To: <20230601213440.2488667-1-dianders@chromium.org>
References: <20230601213440.2488667-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Sumit Garg <sumit.garg@linaro.org>

Introduce a framework for an IPI that will be used for debug
purposes. The primary use case of this IPI will be to generate stack
crawls on other CPUs, but it will also be used to round up CPUs for
kgdb.

When possible, we try to allocate this debug IPI as an NMI (or a
pseudo NMI). If that fails (due to CONFIG, an incompatible interrupt
controller, a quirk, missing the "irqchip.gicv3_pseudo_nmi=1" kernel
parameter, etc) we fall back to a normal IPI.

NOTE: hooking this up for CPU backtrace / kgdb will happen in a future
patch, this just adds the framework.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
I didn't get any feedback from v8 patch #10 [1], but I went ahead and
folded it in here anyway since it really simplfies things. If people
don't like the fallback to regular IPI, I can also undo it.

[1] https://lore.kernel.org/r/20230419155341.v8.10.Ic3659997d6243139d0522fc3afcdfd88d7a5f030@changeid/

Changes in v9:
- Fold in v8 patch #10 ("Fallback to a regular IPI if NMI isn't enabled")
- Moved header file out of "include" since it didn't need to be there.
- Remove arm64_supports_nmi()
- Renamed "NMI IPI" to "debug IPI" since it might not be backed by NMI.

Changes in v8:
- debug_ipi_setup() and debug_ipi_teardown() no longer take cpu param

 arch/arm64/kernel/Makefile    |  2 +-
 arch/arm64/kernel/ipi_debug.c | 76 +++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/ipi_debug.h | 13 ++++++
 3 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/kernel/ipi_debug.c
 create mode 100644 arch/arm64/kernel/ipi_debug.h

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index cc22011ab66a..737838f803b7 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -34,7 +34,7 @@ obj-y			:= debug-monitors.o entry.o irq.o fpsimd.o		\
 			   cpufeature.o alternative.o cacheinfo.o		\
 			   smp.o smp_spin_table.o topology.o smccc-call.o	\
 			   syscall.o proton-pack.o idreg-override.o idle.o	\
-			   patching.o
+			   patching.o ipi_debug.o
 
 obj-$(CONFIG_COMPAT)			+= sys32.o signal32.o			\
 					   sys_compat.o
diff --git a/arch/arm64/kernel/ipi_debug.c b/arch/arm64/kernel/ipi_debug.c
new file mode 100644
index 000000000000..b57833e31eaf
--- /dev/null
+++ b/arch/arm64/kernel/ipi_debug.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Debug IPI support
+ *
+ * Copyright (C) 2020 Linaro Limited
+ * Author: Sumit Garg <sumit.garg@linaro.org>
+ */
+
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/smp.h>
+
+#include "ipi_debug.h"
+
+static struct irq_desc *ipi_debug_desc __read_mostly;
+static int ipi_debug_id __read_mostly;
+static bool is_nmi;
+
+void arm64_debug_ipi(cpumask_t *mask)
+{
+	if (WARN_ON_ONCE(!ipi_debug_desc))
+		return;
+
+	__ipi_send_mask(ipi_debug_desc, mask);
+}
+
+static irqreturn_t ipi_debug_handler(int irq, void *data)
+{
+	/* nop, NMI handlers for special features can be added here. */
+
+	return IRQ_NONE;
+}
+
+void debug_ipi_setup(void)
+{
+	if (!ipi_debug_desc)
+		return;
+
+	if (is_nmi) {
+		if (!prepare_percpu_nmi(ipi_debug_id))
+			enable_percpu_nmi(ipi_debug_id, IRQ_TYPE_NONE);
+	} else {
+		enable_percpu_irq(ipi_debug_id, IRQ_TYPE_NONE);
+	}
+}
+
+void debug_ipi_teardown(void)
+{
+	if (!ipi_debug_desc)
+		return;
+
+	if (is_nmi) {
+		disable_percpu_nmi(ipi_debug_id);
+		teardown_percpu_nmi(ipi_debug_id);
+	} else {
+		disable_percpu_irq(ipi_debug_id);
+	}
+}
+
+void __init set_smp_debug_ipi(int ipi)
+{
+	int err;
+
+	if (!request_percpu_nmi(ipi, ipi_debug_handler, "IPI", &cpu_number)) {
+		is_nmi = true;
+	} else {
+		err = request_percpu_irq(ipi, ipi_debug_handler, "IPI", &cpu_number);
+		if (WARN_ON(err))
+			return;
+
+		irq_set_status_flags(ipi, IRQ_HIDDEN);
+	}
+
+	ipi_debug_desc = irq_to_desc(ipi);
+	ipi_debug_id = ipi;
+}
diff --git a/arch/arm64/kernel/ipi_debug.h b/arch/arm64/kernel/ipi_debug.h
new file mode 100644
index 000000000000..f6011a09282f
--- /dev/null
+++ b/arch/arm64/kernel/ipi_debug.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_NMI_H
+#define __ASM_NMI_H
+
+#include <linux/cpumask.h>
+
+void arm64_debug_ipi(cpumask_t *mask);
+
+void set_smp_debug_ipi(int ipi);
+void debug_ipi_setup(void);
+void debug_ipi_teardown(void);
+
+#endif
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

