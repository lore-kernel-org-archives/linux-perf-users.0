Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9412FD1B7
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Oct 2025 03:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411702; cv=none; b=Afw+65M0GYhHgI7DlCTMzJI7Jl/7sl+FKNs2RqfEGRicNf0TgmjOqEovzOetv0mY39JMyX/AfvkBFgj0Vw4YAjf7jbDjFk3kTbp1VbAAs4RVnz/vyJYQjQdz9osnj3qzcgZH0QU4EoteksCjGaHEbzIoWazGwClTy8L3N3rY5Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411702; c=relaxed/simple;
	bh=V9FM7Tg9n3f4d7CYo7NE9JJpV4txYTiyYxsaaJYPrfc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=s5I3O+1HsqsY5lE8EhyPr8XnyAb3cV1MmbT9r1CEuMQ09TIIlMuuGNvPKB+GsIMRSTN1ZrBAQZcI8m5xguxq/4GSe7a4PajUBQ065mDCdmisYAhNwrwg7sd3E6/m/VDFmSuWMe/KaL4Ul0/mPEPEV+/ctbhZC64dIP5ZMp47YFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YzF/wxSs; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YzF/wxSs"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b55517e74e3so5334157a12.2
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Oct 2025 20:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760411700; x=1761016500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U0CkwtYJ00kWUx1+j2pAoMdQDJBRSeEDCDOjkRoM+EY=;
        b=YzF/wxSsmh9ibOrVNAqQnfxvElm0Qvtnm/1Hrc6iaiHCNbZIaOUXOpai8DUa/heczM
         snvSo72iBSwYbrnjlZO6CvGcqoeIij3EWAwo8hDM6HShjrwccGYp1azw1lHe6kz75DaH
         GFHV6MfFeSMXX+kLpnJFC7P9izTdAv7U+aSRHD2c9A9rrMd3eLKp34ad8LN304p8h1B9
         ksbAV6HWQBlGIPlmGhV/JmhMS6+acfN6QORkVDzASA8xqaCPIohUKIvnqxBNS33JAvDk
         tCBoI6ong1besMUqqea9J+0g5GaPmBjc5WNLb4z7GkvnYjEiN46kLrFoQ4SPNPHbFMHy
         5vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760411700; x=1761016500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U0CkwtYJ00kWUx1+j2pAoMdQDJBRSeEDCDOjkRoM+EY=;
        b=dzOdUrd6bXzECIc3ESXyJ/IWCexSuYo2Z8n80bOWTQFAoudbw2wPMb9tALCX7LjWh/
         O0J5sCksTO+dIqovF2SdjnZI1XE6nfGjcmjvDHu/Mf3SYIbWBCwVAETho9GTM4uyZem8
         /IT0FepyNzkzuPe/YEzMdZjdnL+2pWKIFxXOJKPdeqlLW+DAYmfSVQ/EKsSDt7cZTHvJ
         WRuQaIDnNyvgywDb6r5LmlOCmgzavpYUSsFy/6Qba1Jd1FmRoul5fsS0JwV/V1XQiYPq
         UT5TxKI/9JFmFOdpetIHDcw1RJpfxVsjAy1AQ2fMmgi/lHtEaVWK+yHl8AZkeBxgvaVF
         GY0g==
X-Forwarded-Encrypted: i=1; AJvYcCVTtynssjHaRQ+QtEOC2vObFH8sq6XSnMTlLqPJyW8j0frkhjagdXwr47RVtZ1xJ2hiqWYU4ExyGP9YRtpFbXdF@vger.kernel.org
X-Gm-Message-State: AOJu0YzLVaeKb5LpH8nNhoyk+LoSUpc2Ob2FVz2z8pivttYOJI1U40oT
	Vx7fKolUQuUFu4guxrA8M7QPLVnwwUnqlbkyEctrXJTN/quizIJkEsXsqW7Kd+wQNro=
X-Gm-Gg: ASbGncsUOzlnB7SrkAwjdVeJozWHLo2KPIMYfRf3Psr6spYkUF09n9cXoDC8hPAWQ2y
	HH2Nll4hj1OPfHDUH7dIqZP2TO08y2rBix1CY9QQQpNQglojxBnOXUKTCyC4+i/8QzanCmQ+HIF
	z6MZRaTCtJC05H0+srtAMBBXnx1Ms7vgqivpuHPY5kkX/mtmi0DjoaZkGzm5xF/xXtyB+4sC8MS
	j5fSs0sCEkkk83lvDpGOWYYGRLUkOb71IpyueWK3ecBo/V9srqq/Z8JIF8Kb8ibi1wZMgwUZWP8
	VKoJw87oSFuIwZIF0IPF+0jHae2F9KkjAAzPHXHbrt1zdf3Wbm2G1zS5Itrse43cxYsx+/noUvi
	4fAcYUKAxiVN/6JRZi7eJbYdUlc1hexOvqVzXyIWuLDtB9908YU/nRrlRDxCUs730yZ6wAuQbvm
	wDHrHgIce8siHUfLbn
X-Google-Smtp-Source: AGHT+IHuXcrJrrIrjll72fsxv4RHpCBmdn7Yx1Z4GmzqoA4/59E8YLw53tmhFZ/k1k4idVPxjl767A==
X-Received: by 2002:a17:903:94e:b0:290:55d5:41dd with SMTP id d9443c01a7336-29055d5427dmr141146545ad.5.1760411700144;
        Mon, 13 Oct 2025 20:15:00 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f3de4asm148315845ad.92.2025.10.13.20.14.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 20:14:59 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: akpm@linux-foundation.org,
	alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	catalin.marinas@arm.com,
	cuiyunhui@bytedance.com,
	dianders@chromium.org,
	johannes@sipsolutions.net,
	lihuafei1@huawei.com,
	mark.rutland@arm.com,
	masahiroy@kernel.org,
	maz@kernel.org,
	mingo@kernel.org,
	nicolas.schier@linux.dev,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	suzuki.poulose@arm.com,
	thorsten.blum@linux.dev,
	wangjinchao600@gmail.com,
	will@kernel.org,
	yangyicong@hisilicon.com,
	zhanjie9@hisilicon.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v4 1/2] watchdog: move arm64 watchdog_hld into common code
Date: Tue, 14 Oct 2025 11:14:24 +0800
Message-Id: <20251014031425.93284-2-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20251014031425.93284-1-cuiyunhui@bytedance.com>
References: <20251014031425.93284-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the contents of arch/arm64/watchdog_hld.c to kernel/watchdog_perf.c
to create a generic implementation that can be reused by other arch,
such as RISC-V.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/kernel/Makefile       |  1 -
 arch/arm64/kernel/watchdog_hld.c | 94 --------------------------------
 drivers/perf/arm_pmu.c           | 10 +++-
 include/linux/perf/arm_pmu.h     |  2 -
 kernel/watchdog_perf.c           | 83 ++++++++++++++++++++++++++++
 lib/Kconfig.debug                |  8 +++
 7 files changed, 101 insertions(+), 98 deletions(-)
 delete mode 100644 arch/arm64/kernel/watchdog_hld.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b5438ff4772ce..33072adc88332 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -231,6 +231,7 @@ config ARM64
 	select HAVE_GCC_PLUGINS
 	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && \
 		HW_PERF_EVENTS && HAVE_PERF_EVENTS_NMI
+	select WATCHDOG_PERF_ADJUST_PERIOD if HARDLOCKUP_DETECTOR_PERF && CPU_FREQ
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_TIME_ACCOUNTING
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
diff --git a/arch/arm64/kernel/watchdog_hld.c b/arch/arm64/kernel/watchdog_hld.c
deleted file mode 100644
index 3093037dcb7be..0000000000000
--- a/arch/arm64/kernel/watchdog_hld.c
+++ /dev/null
@@ -1,94 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <linux/nmi.h>
-#include <linux/cpufreq.h>
-#include <linux/perf/arm_pmu.h>
-
-/*
- * Safe maximum CPU frequency in case a particular platform doesn't implement
- * cpufreq driver. Although, architecture doesn't put any restrictions on
- * maximum frequency but 5 GHz seems to be safe maximum given the available
- * Arm CPUs in the market which are clocked much less than 5 GHz. On the other
- * hand, we can't make it much higher as it would lead to a large hard-lockup
- * detection timeout on parts which are running slower (eg. 1GHz on
- * Developerbox) and doesn't possess a cpufreq driver.
- */
-#define SAFE_MAX_CPU_FREQ	5000000000UL // 5 GHz
-u64 hw_nmi_get_sample_period(int watchdog_thresh)
-{
-	unsigned int cpu = smp_processor_id();
-	unsigned long max_cpu_freq;
-
-	max_cpu_freq = cpufreq_get_hw_max_freq(cpu) * 1000UL;
-	if (!max_cpu_freq)
-		max_cpu_freq = SAFE_MAX_CPU_FREQ;
-
-	return (u64)max_cpu_freq * watchdog_thresh;
-}
-
-bool __init arch_perf_nmi_is_available(void)
-{
-	/*
-	 * hardlockup_detector_perf_init() will success even if Pseudo-NMI turns off,
-	 * however, the pmu interrupts will act like a normal interrupt instead of
-	 * NMI and the hardlockup detector would be broken.
-	 */
-	return arm_pmu_irq_is_nmi();
-}
-
-static int watchdog_perf_update_period(void *data)
-{
-	int cpu = smp_processor_id();
-	u64 max_cpu_freq, new_period;
-
-	max_cpu_freq = cpufreq_get_hw_max_freq(cpu) * 1000UL;
-	if (!max_cpu_freq)
-		return 0;
-
-	new_period = watchdog_thresh * max_cpu_freq;
-	hardlockup_detector_perf_adjust_period(new_period);
-
-	return 0;
-}
-
-static int watchdog_freq_notifier_callback(struct notifier_block *nb,
-					   unsigned long val, void *data)
-{
-	struct cpufreq_policy *policy = data;
-	int cpu;
-
-	if (val != CPUFREQ_CREATE_POLICY)
-		return NOTIFY_DONE;
-
-	/*
-	 * Let each online CPU related to the policy update the period by their
-	 * own. This will serialize with the framework on start/stop the lockup
-	 * detector (softlockup_{start,stop}_all) and avoid potential race
-	 * condition. Otherwise we may have below theoretical race condition:
-	 * (core 0/1 share the same policy)
-	 * [core 0]                      [core 1]
-	 *                               hardlockup_detector_event_create()
-	 *                                 hw_nmi_get_sample_period()
-	 * (cpufreq registered, notifier callback invoked)
-	 * watchdog_freq_notifier_callback()
-	 *   watchdog_perf_update_period()
-	 *   (since core 1's event's not yet created,
-	 *    the period is not set)
-	 *                                 perf_event_create_kernel_counter()
-	 *                                 (event's period is SAFE_MAX_CPU_FREQ)
-	 */
-	for_each_cpu(cpu, policy->cpus)
-		smp_call_on_cpu(cpu, watchdog_perf_update_period, NULL, false);
-
-	return NOTIFY_DONE;
-}
-
-static struct notifier_block watchdog_freq_notifier = {
-	.notifier_call = watchdog_freq_notifier_callback,
-};
-
-static int __init init_watchdog_freq_notifier(void)
-{
-	return cpufreq_register_notifier(&watchdog_freq_notifier,
-					 CPUFREQ_POLICY_NOTIFIER);
-}
-core_initcall(init_watchdog_freq_notifier);
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 5c310e803dd78..ca4e1d07b61cb 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -17,6 +17,7 @@
 #include <linux/cpu_pm.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
+#include <linux/nmi.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/slab.h>
 #include <linux/sched/clock.h>
@@ -696,10 +697,17 @@ static int armpmu_get_cpu_irq(struct arm_pmu *pmu, int cpu)
 	return per_cpu(hw_events->irq, cpu);
 }
 
-bool arm_pmu_irq_is_nmi(void)
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
+bool arch_perf_nmi_is_available(void)
 {
+	/*
+	 * watchdog_hardlockup_probe() will success even if Pseudo-NMI turns off,
+	 * however, the pmu interrupts will act like a normal interrupt instead of
+	 * NMI and the hardlockup detector would be broken.
+	 */
 	return has_nmi;
 }
+#endif
 
 /*
  * PMU hardware loses all context when a CPU goes offline.
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
diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index d3ca70e3c256a..a61e35fc9673e 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -15,6 +15,7 @@
 #include <linux/panic.h>
 #include <linux/nmi.h>
 #include <linux/atomic.h>
+#include <linux/cpufreq.h>
 #include <linux/module.h>
 #include <linux/sched/debug.h>
 
@@ -306,3 +307,85 @@ void __init hardlockup_config_perf_event(const char *str)
 	wd_hw_attr.type = PERF_TYPE_RAW;
 	wd_hw_attr.config = config;
 }
+
+#ifdef CONFIG_WATCHDOG_PERF_ADJUST_PERIOD
+/*
+ * Safe maximum CPU frequency in case a particular platform doesn't implement
+ * cpufreq driver. Although, architecture doesn't put any restrictions on
+ * maximum frequency but 5 GHz seems to be safe maximum given the available
+ * CPUs in the market which are clocked much less than 5 GHz. On the other
+ * hand, we can't make it much higher as it would lead to a large hard-lockup
+ * detection timeout on parts which are running slower (eg. 1GHz on
+ * Developerbox) and doesn't possess a cpufreq driver.
+ */
+#define SAFE_MAX_CPU_FREQ	5000000000UL // 5 GHz
+__weak u64 hw_nmi_get_sample_period(int watchdog_thresh)
+{
+	unsigned int cpu = smp_processor_id();
+	unsigned long max_cpu_freq;
+
+	max_cpu_freq = cpufreq_get_hw_max_freq(cpu) * 1000UL;
+	if (!max_cpu_freq)
+		max_cpu_freq = SAFE_MAX_CPU_FREQ;
+
+	return (u64)max_cpu_freq * watchdog_thresh;
+}
+
+static int watchdog_perf_update_period(void *data)
+{
+	int cpu = smp_processor_id();
+	u64 max_cpu_freq, new_period;
+
+	max_cpu_freq = cpufreq_get_hw_max_freq(cpu) * 1000UL;
+	if (!max_cpu_freq)
+		return 0;
+
+	new_period = watchdog_thresh * max_cpu_freq;
+	hardlockup_detector_perf_adjust_period(new_period);
+
+	return 0;
+}
+
+static int watchdog_freq_notifier_callback(struct notifier_block *nb,
+					   unsigned long val, void *data)
+{
+	struct cpufreq_policy *policy = data;
+	int cpu;
+
+	if (val != CPUFREQ_CREATE_POLICY)
+		return NOTIFY_DONE;
+
+	/*
+	 * Let each online CPU related to the policy update the period by their
+	 * own. This will serialize with the framework on start/stop the lockup
+	 * detector (softlockup_{start,stop}_all) and avoid potential race
+	 * condition. Otherwise we may have below theoretical race condition:
+	 * (core 0/1 share the same policy)
+	 * [core 0]                      [core 1]
+	 *                               hardlockup_detector_event_create()
+	 *                                 hw_nmi_get_sample_period()
+	 * (cpufreq registered, notifier callback invoked)
+	 * watchdog_freq_notifier_callback()
+	 *   watchdog_perf_update_period()
+	 *   (since core 1's event's not yet created,
+	 *    the period is not set)
+	 *                                 perf_event_create_kernel_counter()
+	 *                                 (event's period is SAFE_MAX_CPU_FREQ)
+	 */
+	for_each_cpu(cpu, policy->cpus)
+		smp_call_on_cpu(cpu, watchdog_perf_update_period, NULL, false);
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block watchdog_freq_notifier = {
+	.notifier_call = watchdog_freq_notifier_callback,
+};
+
+static int __init init_watchdog_freq_notifier(void)
+{
+	return cpufreq_register_notifier(&watchdog_freq_notifier,
+					 CPUFREQ_POLICY_NOTIFIER);
+}
+core_initcall(init_watchdog_freq_notifier);
+#endif
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 099abf128ce67..ceba3e28cb0d0 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1200,6 +1200,14 @@ config HARDLOCKUP_DETECTOR_PERF
 	depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
 
+config WATCHDOG_PERF_ADJUST_PERIOD
+	bool
+	help
+	  Adjust the watchdog hardlockup detector's period based on CPU max
+	  frequency. Uses cpufreq if available; falls back to a safe 5 GHz
+	  default otherwise. Registers a cpufreq notifier to update the period
+	  automatically.
+
 config HARDLOCKUP_DETECTOR_BUDDY
 	bool
 	depends on HARDLOCKUP_DETECTOR
-- 
2.39.5

