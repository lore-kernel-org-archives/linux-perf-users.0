Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826AA322774
	for <linux-perf-users@vger.kernel.org>; Wed, 27 Aug 2025 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289438; cv=none; b=YNji1apWHIxdo3UHLTAWV3sDy3G+wwzLFEJ1Bqiwe3Vc7QQ6VfSC+PVWmFKqBC2Nzi1rNeEQ8F65B1wQvhp9pSipNzYqI2NuPyTVTPw6pvuyaZiQ3nR6D+ZV1kEEvSZfBQut3836jGaFSUOE6MddYR1OLU7ZyVH4VULl9gdFxf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289438; c=relaxed/simple;
	bh=yeNan5k0cgSuNlvIrb3yh43RXINtEjul/GDw0ykoYZ4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mdL4CQMaBRP2ClvlxGGp0wsU986cOmBV108uT5bVHXK+Pg2srLSwGirfGgZ7YoNAlD09WICdSCtTUzj7fR9hZ8UEutdIkLDtYi9uRX5uSqeFgsAssS/6boBrhLi2tpSYNuxcELzvr3l7xGHV6JH/4gHq8aS6MUvClm0eB+lfaE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PZU0Pg0S; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PZU0Pg0S"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7720c9e2900so283214b3a.0
        for <linux-perf-users@vger.kernel.org>; Wed, 27 Aug 2025 03:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756289436; x=1756894236; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ogvjFdajJu5uEleDwj80v3hZV9fH5TDAuXMS6jOc2pE=;
        b=PZU0Pg0SiNeql1j9loQYsNasHG9jCfC4ukwLG4oceAtFMTGMjnVxaM9WaiNOe358Ya
         j2MCkBWA9qxFLLAl2FkvpBK0wPFmSvj8/2PCDBuTWoal+bd+AYRR9WeGkLmlS0a0lJ/q
         +dJmaACtlslillsCfXfEAn+5u3ZHAwX6Y7HCUwMMd/YKnir5Ix6EWpcLHxAjLd+gRw2S
         P57nFjMHm5djIH0jXsBrsFrrHF0cDcERfhe4I4Q1oLg/oTc7sOD4K2HJQ5tWY6Za8rMC
         I6U0rUAQ+zcpwM18boD6ni70g+D15uE1WY7lDyoyYP4g0MFl/dRBvcE698btdRUVKO32
         NHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756289436; x=1756894236;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ogvjFdajJu5uEleDwj80v3hZV9fH5TDAuXMS6jOc2pE=;
        b=YhpzkP8tFrsvw7mlW7PS7tb/rash3RZpaufRasw2ALuB1XXBsiJ853lsmG+Da80pq1
         TT7ugipwubAWHDCd91x82EX+45jKF5PmfaXzkh6Rs+TY6Wowm49bHYln7a2HwbvTnPq0
         xPxOBIgJW0ZGjG5Sami0cNAE2f/Jr+a4hXeoUBcVEWMUglTlH1zSl+225S2Ps3jhd3QL
         2Q0ev6vJ6oPS2sQYp3DCaxyO3xo2mWGS6dW93uGqbePucs5NNNV+3Nc9gSueFaL+FisP
         h+q48cUp2UAndwyGYsqn3GmfO+B/ub32neCQz2iV3VLZrvs8HkRwdLZAY9Tf1uTYE81Y
         cb2g==
X-Forwarded-Encrypted: i=1; AJvYcCV7hzHeI/OELMFGVHo9AxK6NnYwZmg7I8KpY5N40SRsjFOnsGFGOnBIyX1USNQOWGnbTZTNxQA4RH6UYVHl6rAv@vger.kernel.org
X-Gm-Message-State: AOJu0YxX8pWw35W7t7m1LDHFqRXritSmNMIel9ZJb7Co0CVVTchnpYIf
	ppER+HfdfONV4/c8v98+H6BnILOiWISPsIAZxwjeY/AA8QOT+YLJtSgkxM3C2AsPgEA=
X-Gm-Gg: ASbGncuu37QTgMLCXxTOK1J5j4RSoyyga/nQorp5g3m3ReYjlq1fhpIeq0eXGxmOgCs
	f3YZM927ajbSrSNCYFAJFrALYD6dtk+JbuqB+6RGfMsI7UY9vaz30zYw1ML7vTkBdn73t4lmGPW
	FOr4R5wQL/a35bhdLUxNLrqYVQAbE9A6WbbaSGD0EgEzSnfCMYnYnxN6MAlGKz5vqxhf5Us01T6
	zsYeAz493vjDaYJMHhdtQLS/twIcP+mG5MetfMnD7l8qhM7tqERxatE2izSQYZj7NFgyV4/DLHa
	+vE2g3KctmmvlelAQAke0xq4e8+tcV/7y2ZMIl/4uc1HBoCF+vujPnCOdm/FO/LYhKpzYJ7u9Nk
	ELv2ST2QjH06jlcVQbhXD1axzOyT5byv3JKY7HrEKh0NrCT9g5PalZqxeA8lstuiWsreX5zQ2Kg
	==
X-Google-Smtp-Source: AGHT+IGKq+xCbT38FLHdMDvm1hcp5EAcutLkJLn66CFHjFRgZpXlNTya/iJ1ORo8WxdEG7UC3P6/tQ==
X-Received: by 2002:a05:6a00:929d:b0:771:fbb0:b1cf with SMTP id d2e1a72fcca58-771fbb0b2b0mr7265480b3a.17.1756289429909;
        Wed, 27 Aug 2025 03:10:29 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm12813462b3a.79.2025.08.27.03.10.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 27 Aug 2025 03:10:29 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	atish.patra@linux.dev,
	anup@brainfault.org,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	catalin.marinas@arm.com,
	masahiroy@kernel.org,
	suzuki.poulose@arm.com,
	cuiyunhui@bytedance.com,
	maz@kernel.org,
	zhanjie9@hisilicon.com,
	yangyicong@hisilicon.com,
	dianders@chromium.org,
	mingo@kernel.org,
	lihuafei1@huawei.com,
	akpm@linux-foundation.org,
	jpoimboe@kernel.org,
	rppt@kernel.org,
	kees@kernel.org,
	thomas.weissschuh@linutronix.de
Subject: [PATCH 1/2] watchdog: refactor watchdog_hld functionality
Date: Wed, 27 Aug 2025 18:09:58 +0800
Message-Id: <20250827100959.83023-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250827100959.83023-1-cuiyunhui@bytedance.com>
References: <20250827100959.83023-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move watchdog_hld.c to kernel/, and rename arm_pmu_irq_is_nmi()
to arch_pmu_irq_is_nmi() for cross-arch reusability.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/arm64/kernel/Makefile                   | 1 -
 drivers/perf/arm_pmu.c                       | 2 +-
 include/linux/nmi.h                          | 1 +
 include/linux/perf/arm_pmu.h                 | 2 --
 kernel/Makefile                              | 2 +-
 {arch/arm64/kernel => kernel}/watchdog_hld.c | 8 ++++++--
 6 files changed, 9 insertions(+), 7 deletions(-)
 rename {arch/arm64/kernel => kernel}/watchdog_hld.c (97%)

diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 76f32e424065e..12d77f373fea4 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -44,7 +44,6 @@ obj-$(CONFIG_KUSER_HELPERS)		+= kuser32.o
 obj-$(CONFIG_FUNCTION_TRACER)		+= ftrace.o entry-ftrace.o
 obj-$(CONFIG_MODULES)			+= module.o module-plts.o
 obj-$(CONFIG_PERF_EVENTS)		+= perf_regs.o perf_callchain.o
-obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF)	+= watchdog_hld.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_CPU_PM)			+= sleep.o suspend.o
 obj-$(CONFIG_KGDB)			+= kgdb.o
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 5c310e803dd78..4fd7f88d44543 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -696,7 +696,7 @@ static int armpmu_get_cpu_irq(struct arm_pmu *pmu, int cpu)
 	return per_cpu(hw_events->irq, cpu);
 }
 
-bool arm_pmu_irq_is_nmi(void)
+bool arch_pmu_irq_is_nmi(void)
 {
 	return has_nmi;
 }
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index cf3c6ab408aac..c34bdc4f43f6d 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -207,6 +207,7 @@ static inline bool trigger_single_cpu_backtrace(int cpu)
 #ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
 u64 hw_nmi_get_sample_period(int watchdog_thresh);
 bool arch_perf_nmi_is_available(void);
+bool arch_pmu_irq_is_nmi(void);
 #endif
 
 #if defined(CONFIG_HARDLOCKUP_CHECK_TIMESTAMP) && \
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 93c9a26492fcf..6b53fb453fd63 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -184,8 +184,6 @@ void kvm_host_pmu_init(struct arm_pmu *pmu);
 #define kvm_host_pmu_init(x)	do { } while(0)
 #endif
 
-bool arm_pmu_irq_is_nmi(void);
-
 /* Internal functions only for core arm_pmu code */
 struct arm_pmu *armpmu_alloc(void);
 void armpmu_free(struct arm_pmu *pmu);
diff --git a/kernel/Makefile b/kernel/Makefile
index c60623448235f..4ec7702b00aa1 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -101,7 +101,7 @@ obj-$(CONFIG_KGDB) += debug/
 obj-$(CONFIG_DETECT_HUNG_TASK) += hung_task.o
 obj-$(CONFIG_LOCKUP_DETECTOR) += watchdog.o
 obj-$(CONFIG_HARDLOCKUP_DETECTOR_BUDDY) += watchdog_buddy.o
-obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_perf.o
+obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_perf.o watchdog_hld.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_SYSCTL) += utsname_sysctl.o
diff --git a/arch/arm64/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
similarity index 97%
rename from arch/arm64/kernel/watchdog_hld.c
rename to kernel/watchdog_hld.c
index 3093037dcb7be..f3864e604a6b5 100644
--- a/arch/arm64/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/nmi.h>
 #include <linux/cpufreq.h>
-#include <linux/perf/arm_pmu.h>
 
 /*
  * Safe maximum CPU frequency in case a particular platform doesn't implement
@@ -25,6 +24,11 @@ u64 hw_nmi_get_sample_period(int watchdog_thresh)
 	return (u64)max_cpu_freq * watchdog_thresh;
 }
 
+__weak bool arch_pmu_irq_is_nmi(void)
+{
+	return false;
+}
+
 bool __init arch_perf_nmi_is_available(void)
 {
 	/*
@@ -32,7 +36,7 @@ bool __init arch_perf_nmi_is_available(void)
 	 * however, the pmu interrupts will act like a normal interrupt instead of
 	 * NMI and the hardlockup detector would be broken.
 	 */
-	return arm_pmu_irq_is_nmi();
+	return arch_pmu_irq_is_nmi();
 }
 
 static int watchdog_perf_update_period(void *data)
-- 
2.39.5

