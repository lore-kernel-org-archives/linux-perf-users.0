Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BA32641E3
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Sep 2025 03:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757908462; cv=none; b=LyHscmvM4iG8Y+9vMUUzLBjQbAqU/pHgAp8FDrPKSVu0S3qab2lwkiIcr0grsfzofCsj7ZpNTLwPiqWeh13Ml+1sc3hTodL1C5L9Skduo/omTOzpG9XAip7ewQHaZJmAeJhgFjqEnqlXjHTpd/J6AFuI6TAR5/eC2L5l0FOIrPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757908462; c=relaxed/simple;
	bh=2/sZD9zxcCRSMDBhL8ORm0Ol6QX2WSd0TWzHXVj9YPs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=lIAnftjBAZizPJkco5O1gpV350M9u1Kzbs5rZSuKjHWastTOs+6HI1lxkQCuMrUTk6S9oBVkx+ZMKvSAfjsSklZO5Q4opdzv04nubUaJ2ti9aFyIyLd0uWLjXiKUC3bP+glZwd+dV4xDnNLqnukLe8I/Kp2uCG6pxmksp0tAx6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bA9X3yAS; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bA9X3yAS"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7723f0924a3so4545404b3a.2
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Sep 2025 20:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757908460; x=1758513260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jvva0TL4zh+S2sr11l6cv20Cr9JEg4KFzWcybkVhfMQ=;
        b=bA9X3yASZgqr6E1dWeAljBVsxjnvfguBRldx3ASb/24hYl4VYaS66HDCZz+9GM6nTc
         Jn+upwszmWvFl+nTb2S2XD5IIvVKvvgergwuP5gbXV7cfKDcNBJQIvznGnIBbk4CSOGc
         XOi3QQeiOV5D6Of7NUlRqM1M6e+0slAtIpK95p2imNCOMESGfeR+Yca1DjF2RVmxBCVf
         KSkVRDiWcssbaDGudoOkB2zOv41JVTXLygAq4XK4D0DngCFZBJ4BKYjMmuKivTyP/wxE
         JMyii+wVOBVVtvuBd+KqTQfCd6uhHeQX6ZuTvdyQvDh0WUxekzdbbH8jKvlRQw2v8EGo
         hQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757908460; x=1758513260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jvva0TL4zh+S2sr11l6cv20Cr9JEg4KFzWcybkVhfMQ=;
        b=kcfOfCBFTcIOvWAWHlNjOv46MBe2mgXJs9g9uOoGKLo7FID2xUC8y0Wx6rMEwAvyFk
         nyi3In5F2LdYeCFjXaTqSQ6Zks4aPCagSToeRUSbw80gFdQVRugY34mi/vcq3xn4nV0j
         zouc7ShpGKGQ7yT3jAwYCKGAvO0IBau7W+drxLt6TNwC2xI4l1IV8lHVPZ8CodVvAHh/
         wIURPL69efUrTjOhU+MRZVEd/4Con666TVqEehtcTr9MATVVwZIJF4u1hmQu2xCOXAPE
         G4L6e6aTOVFOfv2PH8Fr5gH20Ta527bzRuWI0eeDpz3xtHN+DsJzoMkPbRCC/G5fFjW1
         qLBw==
X-Forwarded-Encrypted: i=1; AJvYcCWdldBnsuJuHJVnTOOknXytVXOZNDVaOjYOXmEdZWJdzgKUArdTDwsb6kQIUF6gg0UBDiGFDWP59EtXXy+jUSk+@vger.kernel.org
X-Gm-Message-State: AOJu0YzuA4Sk8ZDYRYPIEoR9g+HcVwAkeVpVrYwnZNVT2bwQ6u0r4+W7
	zkTax/1r2J8R8szi5do50DrlXmrYcGMTJy/x7SmTNabdUHNMW0S7usHcVmHA+fqJXhU=
X-Gm-Gg: ASbGnctoDTPCwDzE0OUOzokJ0rcvybWeX5/mOiYgFhVTnevUCZnQGwb9PM9OMhnwHIk
	/cOtOmoqrH9Ua2hVMECJiZaWjIlX6IQLgpl1mKxppHW/UbICvI5IKQXNfghiqsmGTBbEb6LRK2i
	6j2qkvVsaXCiRf2ekHhJAsPvq6zLtZK45d6t/bVE25iR0paluGx87b+yPl56hlM+DTvAnXaTvrX
	i6cOCIvhO8npxib6y4WN26O1PD967ClwhJrDN0rwQ0ZG4U6+6+nSdGoxk3LR/gpc/BYFUinLhVg
	sqbQPkx7nNmB20bQnpp1N2exDwtIQbyHtmp2dRUrvB6TZPCJIYe0ONWu3jh1e/kN6/NW8RNCQPq
	htrLdYjnDE7fY+RwJ/+zGZO6WQeqLJDngGp6FqwyUXo/XnoBwoBdmIDwD+CYM0+MvRxJwQjU/kQ
	==
X-Google-Smtp-Source: AGHT+IEUv47qgkoX4duiDYe5ibddYEaWl/+CzJjy+AV9oJ+RXLgTxH7LbdbzqFKva19jzTttLui6og==
X-Received: by 2002:a05:6a00:acc:b0:772:638e:5f72 with SMTP id d2e1a72fcca58-77612189faemr12341637b3a.25.1757908459288;
        Sun, 14 Sep 2025 20:54:19 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-776075fdd83sm11791895b3a.0.2025.09.14.20.54.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Sep 2025 20:54:18 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	peterz@infradead.org,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	kees@kernel.org,
	masahiroy@kernel.org,
	aliceryhl@google.com,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	xur@google.com,
	ruanjinjie@huawei.com,
	cuiyunhui@bytedance.com,
	gshan@redhat.com,
	maz@kernel.org,
	suzuki.poulose@arm.com,
	zhanjie9@hisilicon.com,
	yangyicong@hisilicon.com,
	dianders@chromium.org,
	gautam@linux.ibm.com,
	arnd@arndb.de,
	zhao.xichao@vivo.com,
	rppt@kernel.org,
	lihuafei1@huawei.com,
	coxu@redhat.com,
	jpoimboe@kernel.org,
	yaozhenguo1@gmail.com,
	luogengkun@huaweicloud.com,
	max.kellermann@ionos.com,
	tj@kernel.org,
	wangjinchao600@gmail.com,
	yury.norov@gmail.com,
	thorsten.blum@linux.dev,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH] watchdog: remove HARDLOCKUP_DETECTOR_PERF
Date: Mon, 15 Sep 2025 11:53:55 +0800
Message-Id: <20250915035355.10846-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are currently two hard lockup detector implementations:
HARDLOCKUP_DETECTOR_PERF (perf-based) and HARDLOCKUP_DETECTOR_BUDDY
(buddy-based). When enabling the hardlockup feature on new arch
(e.g., RISC-V), ambiguity arises regarding which detector to choose.

From the community discussion (see link below [1]), the buddy approach is
preferred. So remove the HARDLOCKUP_DETECTOR_PERF implementation.

Link: https://lore.kernel.org/all/CAD=FV=WWUiCi6bZCs_gseFpDDWNkuJMoL6XCftEo6W7q6jRCkg@mail.gmail.com/ [1]
Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/Kconfig                     |  14 --
 arch/arm64/Kconfig               |   3 -
 arch/arm64/kernel/Makefile       |   1 -
 arch/arm64/kernel/watchdog_hld.c |  94 ----------
 arch/powerpc/Kconfig             |   2 -
 arch/powerpc/kernel/setup_64.c   |  11 --
 arch/x86/Kconfig                 |   2 -
 arch/x86/events/intel/core.c     |   4 -
 arch/x86/kernel/apic/hw_nmi.c    |   7 -
 include/linux/nmi.h              |  24 ---
 kernel/Makefile                  |   1 -
 kernel/watchdog.c                |   3 -
 kernel/watchdog_perf.c           | 308 -------------------------------
 lib/Kconfig.debug                |  34 +---
 14 files changed, 3 insertions(+), 505 deletions(-)
 delete mode 100644 arch/arm64/kernel/watchdog_hld.c
 delete mode 100644 kernel/watchdog_perf.c

diff --git a/arch/Kconfig b/arch/Kconfig
index f18dbcc776140..76e99f25be8ca 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -459,20 +459,6 @@ config HAVE_MIXED_BREAKPOINTS_REGS
 config HAVE_USER_RETURN_NOTIFIER
 	bool
 
-config HAVE_PERF_EVENTS_NMI
-	bool
-	help
-	  System hardware can generate an NMI using the perf event
-	  subsystem.  Also has support for calculating CPU cycle events
-	  to determine how many clock cycles in a given period.
-
-config HAVE_HARDLOCKUP_DETECTOR_PERF
-	bool
-	depends on HAVE_PERF_EVENTS_NMI
-	help
-	  The arch chooses to use the generic perf-NMI-based hardlockup
-	  detector. Must define HAVE_PERF_EVENTS_NMI.
-
 config HAVE_HARDLOCKUP_DETECTOR_ARCH
 	bool
 	help
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 63e7d8a86b92c..d04ad76ecf67b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -229,8 +229,6 @@ config ARM64
 	select HAVE_FUNCTION_GRAPH_FREGS
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_GCC_PLUGINS
-	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && \
-		HW_PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 	select HAVE_HW_BREAKPOINT if PERF_EVENTS
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_TIME_ACCOUNTING
@@ -238,7 +236,6 @@ config ARM64
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_PERF_EVENTS
-	select HAVE_PERF_EVENTS_NMI if ARM64_PSEUDO_NMI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_PREEMPT_DYNAMIC_KEY
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
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a72d15bbbd7c7..4feebc0ba6adf 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -253,7 +253,6 @@ config PPC
 	select HAVE_GCC_PLUGINS
 	select HAVE_GENERIC_VDSO
 	select HAVE_HARDLOCKUP_DETECTOR_ARCH	if PPC_BOOK3S_64 && SMP
-	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 	select HAVE_HW_BREAKPOINT		if PERF_EVENTS && (PPC_BOOK3S || PPC_8xx)
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_TIME_ACCOUNTING
@@ -272,7 +271,6 @@ config PPC
 	select HAVE_OBJTOOL			if ARCH_USING_PATCHABLE_FUNCTION_ENTRY || MPROFILE_KERNEL || PPC32
 	select HAVE_OBJTOOL_MCOUNT		if HAVE_OBJTOOL
 	select HAVE_PERF_EVENTS
-	select HAVE_PERF_EVENTS_NMI		if PPC64
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_PREEMPT_DYNAMIC_KEY
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 8fd7cbf3bd048..8deea36ed97d1 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -894,13 +894,6 @@ struct ppc_pci_io ppc_pci_io;
 EXPORT_SYMBOL(ppc_pci_io);
 #endif
 
-#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
-u64 hw_nmi_get_sample_period(int watchdog_thresh)
-{
-	return ppc_proc_freq * watchdog_thresh;
-}
-#endif
-
 /*
  * The perf based hardlockup detector breaks PMU event based branches, so
  * disable it by default. Book3S has a soft-nmi hardlockup detector based
@@ -913,15 +906,11 @@ u64 hw_nmi_get_sample_period(int watchdog_thresh)
  */
 static int __init disable_hardlockup_detector(void)
 {
-#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
-	hardlockup_detector_disable();
-#else
 	if (firmware_has_feature(FW_FEATURE_LPAR)) {
 		check_kvm_guest();
 		if (is_kvm_guest())
 			hardlockup_detector_disable();
 	}
-#endif
 
 	return 0;
 }
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d68b5f6202e2f..099fa9fc725c1 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -273,8 +273,6 @@ config X86
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCSPKR_PLATFORM
 	select HAVE_PERF_EVENTS
-	select HAVE_PERF_EVENTS_NMI
-	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 	select HAVE_PCI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 28f5468a6ea36..756929be84992 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7818,16 +7818,12 @@ static __init int fixup_ht_bug(void)
 
 	cpus_read_lock();
 
-	hardlockup_detector_perf_stop();
-
 	x86_pmu.flags &= ~(PMU_FL_EXCL_CNTRS | PMU_FL_EXCL_ENABLED);
 
 	x86_pmu.start_scheduling = NULL;
 	x86_pmu.commit_scheduling = NULL;
 	x86_pmu.stop_scheduling = NULL;
 
-	hardlockup_detector_perf_restart();
-
 	for_each_online_cpu(c)
 		free_excl_cntrs(&per_cpu(cpu_hw_events, c));
 
diff --git a/arch/x86/kernel/apic/hw_nmi.c b/arch/x86/kernel/apic/hw_nmi.c
index 45af535c44a07..bc534f4f6fbc5 100644
--- a/arch/x86/kernel/apic/hw_nmi.c
+++ b/arch/x86/kernel/apic/hw_nmi.c
@@ -23,13 +23,6 @@
 
 #include "local.h"
 
-#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
-u64 hw_nmi_get_sample_period(int watchdog_thresh)
-{
-	return (u64)(cpu_khz) * 1000 * watchdog_thresh;
-}
-#endif
-
 #ifdef arch_trigger_cpumask_backtrace
 static void nmi_raise_cpu_backtrace(cpumask_t *mask)
 {
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index cf3c6ab408aac..ff2b70cfd39bb 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -99,18 +99,6 @@ void watchdog_hardlockup_touch_cpu(unsigned int cpu);
 void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs);
 #endif
 
-#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
-extern void hardlockup_detector_perf_stop(void);
-extern void hardlockup_detector_perf_restart(void);
-extern void hardlockup_config_perf_event(const char *str);
-extern void hardlockup_detector_perf_adjust_period(u64 period);
-#else
-static inline void hardlockup_detector_perf_stop(void) { }
-static inline void hardlockup_detector_perf_restart(void) { }
-static inline void hardlockup_config_perf_event(const char *str) { }
-static inline void hardlockup_detector_perf_adjust_period(u64 period) { }
-#endif
-
 void watchdog_hardlockup_stop(void);
 void watchdog_hardlockup_start(void);
 int watchdog_hardlockup_probe(void);
@@ -204,18 +192,6 @@ static inline bool trigger_single_cpu_backtrace(int cpu)
 }
 #endif
 
-#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
-u64 hw_nmi_get_sample_period(int watchdog_thresh);
-bool arch_perf_nmi_is_available(void);
-#endif
-
-#if defined(CONFIG_HARDLOCKUP_CHECK_TIMESTAMP) && \
-    defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
-void watchdog_update_hrtimer_threshold(u64 period);
-#else
-static inline void watchdog_update_hrtimer_threshold(u64 period) { }
-#endif
-
 #ifdef CONFIG_HAVE_ACPI_APEI_NMI
 #include <asm/nmi.h>
 #endif
diff --git a/kernel/Makefile b/kernel/Makefile
index 216a7dfc3a688..76de2a3df2fb9 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -102,7 +102,6 @@ obj-$(CONFIG_KGDB) += debug/
 obj-$(CONFIG_DETECT_HUNG_TASK) += hung_task.o
 obj-$(CONFIG_LOCKUP_DETECTOR) += watchdog.o
 obj-$(CONFIG_HARDLOCKUP_DETECTOR_BUDDY) += watchdog_buddy.o
-obj-$(CONFIG_HARDLOCKUP_DETECTOR_PERF) += watchdog_perf.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
 obj-$(CONFIG_RELAY) += relay.o
 obj-$(CONFIG_SYSCTL) += utsname_sysctl.o
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 5b62d10027836..8d058389a3565 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -111,8 +111,6 @@ static int __init hardlockup_panic_setup(char *str)
 		watchdog_hardlockup_user_enabled = 0;
 	else if (!strncmp(str, "1", 1))
 		watchdog_hardlockup_user_enabled = 1;
-	else if (!strncmp(str, "r", 1))
-		hardlockup_config_perf_event(str + 1);
 	while (*(str++)) {
 		if (*str == ',') {
 			str++;
@@ -623,7 +621,6 @@ static void set_sample_period(void)
 	 * hardlockup detector generates a warning
 	 */
 	sample_period = get_softlockup_thresh() * ((u64)NSEC_PER_SEC / NUM_SAMPLE_PERIODS);
-	watchdog_update_hrtimer_threshold(sample_period);
 }
 
 static void update_report_ts(void)
diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
deleted file mode 100644
index d3ca70e3c256a..0000000000000
--- a/kernel/watchdog_perf.c
+++ /dev/null
@@ -1,308 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Detect hard lockups on a system using perf
- *
- * started by Don Zickus, Copyright (C) 2010 Red Hat, Inc.
- *
- * Note: Most of this code is borrowed heavily from the original softlockup
- * detector, so thanks to Ingo for the initial implementation.
- * Some chunks also taken from the old x86-specific nmi watchdog code, thanks
- * to those contributors as well.
- */
-
-#define pr_fmt(fmt) "NMI watchdog: " fmt
-
-#include <linux/panic.h>
-#include <linux/nmi.h>
-#include <linux/atomic.h>
-#include <linux/module.h>
-#include <linux/sched/debug.h>
-
-#include <asm/irq_regs.h>
-#include <linux/perf_event.h>
-
-static DEFINE_PER_CPU(struct perf_event *, watchdog_ev);
-
-static atomic_t watchdog_cpus = ATOMIC_INIT(0);
-
-#ifdef CONFIG_HARDLOCKUP_CHECK_TIMESTAMP
-static DEFINE_PER_CPU(ktime_t, last_timestamp);
-static DEFINE_PER_CPU(unsigned int, nmi_rearmed);
-static ktime_t watchdog_hrtimer_sample_threshold __read_mostly;
-
-void watchdog_update_hrtimer_threshold(u64 period)
-{
-	/*
-	 * The hrtimer runs with a period of (watchdog_threshold * 2) / 5
-	 *
-	 * So it runs effectively with 2.5 times the rate of the NMI
-	 * watchdog. That means the hrtimer should fire 2-3 times before
-	 * the NMI watchdog expires. The NMI watchdog on x86 is based on
-	 * unhalted CPU cycles, so if Turbo-Mode is enabled the CPU cycles
-	 * might run way faster than expected and the NMI fires in a
-	 * smaller period than the one deduced from the nominal CPU
-	 * frequency. Depending on the Turbo-Mode factor this might be fast
-	 * enough to get the NMI period smaller than the hrtimer watchdog
-	 * period and trigger false positives.
-	 *
-	 * The sample threshold is used to check in the NMI handler whether
-	 * the minimum time between two NMI samples has elapsed. That
-	 * prevents false positives.
-	 *
-	 * Set this to 4/5 of the actual watchdog threshold period so the
-	 * hrtimer is guaranteed to fire at least once within the real
-	 * watchdog threshold.
-	 */
-	watchdog_hrtimer_sample_threshold = period * 2;
-}
-
-static bool watchdog_check_timestamp(void)
-{
-	ktime_t delta, now = ktime_get_mono_fast_ns();
-
-	delta = now - __this_cpu_read(last_timestamp);
-	if (delta < watchdog_hrtimer_sample_threshold) {
-		/*
-		 * If ktime is jiffies based, a stalled timer would prevent
-		 * jiffies from being incremented and the filter would look
-		 * at a stale timestamp and never trigger.
-		 */
-		if (__this_cpu_inc_return(nmi_rearmed) < 10)
-			return false;
-	}
-	__this_cpu_write(nmi_rearmed, 0);
-	__this_cpu_write(last_timestamp, now);
-	return true;
-}
-
-static void watchdog_init_timestamp(void)
-{
-	__this_cpu_write(nmi_rearmed, 0);
-	__this_cpu_write(last_timestamp, ktime_get_mono_fast_ns());
-}
-#else
-static inline bool watchdog_check_timestamp(void) { return true; }
-static inline void watchdog_init_timestamp(void) { }
-#endif
-
-static struct perf_event_attr wd_hw_attr = {
-	.type		= PERF_TYPE_HARDWARE,
-	.config		= PERF_COUNT_HW_CPU_CYCLES,
-	.size		= sizeof(struct perf_event_attr),
-	.pinned		= 1,
-	.disabled	= 1,
-};
-
-static struct perf_event_attr fallback_wd_hw_attr = {
-	.type		= PERF_TYPE_HARDWARE,
-	.config		= PERF_COUNT_HW_CPU_CYCLES,
-	.size		= sizeof(struct perf_event_attr),
-	.pinned		= 1,
-	.disabled	= 1,
-};
-
-/* Callback function for perf event subsystem */
-static void watchdog_overflow_callback(struct perf_event *event,
-				       struct perf_sample_data *data,
-				       struct pt_regs *regs)
-{
-	/* Ensure the watchdog never gets throttled */
-	event->hw.interrupts = 0;
-
-	if (panic_in_progress())
-		return;
-
-	if (!watchdog_check_timestamp())
-		return;
-
-	watchdog_hardlockup_check(smp_processor_id(), regs);
-}
-
-static int hardlockup_detector_event_create(void)
-{
-	unsigned int cpu;
-	struct perf_event_attr *wd_attr;
-	struct perf_event *evt;
-
-	/*
-	 * Preemption is not disabled because memory will be allocated.
-	 * Ensure CPU-locality by calling this in per-CPU kthread.
-	 */
-	WARN_ON(!is_percpu_thread());
-	cpu = raw_smp_processor_id();
-	wd_attr = &wd_hw_attr;
-	wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
-
-	/* Try to register using hardware perf events */
-	evt = perf_event_create_kernel_counter(wd_attr, cpu, NULL,
-					       watchdog_overflow_callback, NULL);
-	if (IS_ERR(evt)) {
-		wd_attr = &fallback_wd_hw_attr;
-		wd_attr->sample_period = hw_nmi_get_sample_period(watchdog_thresh);
-		evt = perf_event_create_kernel_counter(wd_attr, cpu, NULL,
-						       watchdog_overflow_callback, NULL);
-	}
-
-	if (IS_ERR(evt)) {
-		pr_debug("Perf event create on CPU %d failed with %ld\n", cpu,
-			 PTR_ERR(evt));
-		return PTR_ERR(evt);
-	}
-	WARN_ONCE(this_cpu_read(watchdog_ev), "unexpected watchdog_ev leak");
-	this_cpu_write(watchdog_ev, evt);
-	return 0;
-}
-
-/**
- * watchdog_hardlockup_enable - Enable the local event
- * @cpu: The CPU to enable hard lockup on.
- */
-void watchdog_hardlockup_enable(unsigned int cpu)
-{
-	WARN_ON_ONCE(cpu != smp_processor_id());
-
-	if (hardlockup_detector_event_create())
-		return;
-
-	/* use original value for check */
-	if (!atomic_fetch_inc(&watchdog_cpus))
-		pr_info("Enabled. Permanently consumes one hw-PMU counter.\n");
-
-	watchdog_init_timestamp();
-	perf_event_enable(this_cpu_read(watchdog_ev));
-}
-
-/**
- * watchdog_hardlockup_disable - Disable the local event
- * @cpu: The CPU to enable hard lockup on.
- */
-void watchdog_hardlockup_disable(unsigned int cpu)
-{
-	struct perf_event *event = this_cpu_read(watchdog_ev);
-
-	WARN_ON_ONCE(cpu != smp_processor_id());
-
-	if (event) {
-		perf_event_disable(event);
-		perf_event_release_kernel(event);
-		this_cpu_write(watchdog_ev, NULL);
-		atomic_dec(&watchdog_cpus);
-	}
-}
-
-/**
- * hardlockup_detector_perf_adjust_period - Adjust the event period due
- *                                          to current cpu frequency change
- * @period: The target period to be set
- */
-void hardlockup_detector_perf_adjust_period(u64 period)
-{
-	struct perf_event *event = this_cpu_read(watchdog_ev);
-
-	if (!(watchdog_enabled & WATCHDOG_HARDLOCKUP_ENABLED))
-		return;
-
-	if (!event)
-		return;
-
-	if (event->attr.sample_period == period)
-		return;
-
-	if (perf_event_period(event, period))
-		pr_err("failed to change period to %llu\n", period);
-}
-
-/**
- * hardlockup_detector_perf_stop - Globally stop watchdog events
- *
- * Special interface for x86 to handle the perf HT bug.
- */
-void __init hardlockup_detector_perf_stop(void)
-{
-	int cpu;
-
-	lockdep_assert_cpus_held();
-
-	for_each_online_cpu(cpu) {
-		struct perf_event *event = per_cpu(watchdog_ev, cpu);
-
-		if (event)
-			perf_event_disable(event);
-	}
-}
-
-/**
- * hardlockup_detector_perf_restart - Globally restart watchdog events
- *
- * Special interface for x86 to handle the perf HT bug.
- */
-void __init hardlockup_detector_perf_restart(void)
-{
-	int cpu;
-
-	lockdep_assert_cpus_held();
-
-	if (!(watchdog_enabled & WATCHDOG_HARDLOCKUP_ENABLED))
-		return;
-
-	for_each_online_cpu(cpu) {
-		struct perf_event *event = per_cpu(watchdog_ev, cpu);
-
-		if (event)
-			perf_event_enable(event);
-	}
-}
-
-bool __weak __init arch_perf_nmi_is_available(void)
-{
-	return true;
-}
-
-/**
- * watchdog_hardlockup_probe - Probe whether NMI event is available at all
- */
-int __init watchdog_hardlockup_probe(void)
-{
-	int ret;
-
-	if (!arch_perf_nmi_is_available())
-		return -ENODEV;
-
-	ret = hardlockup_detector_event_create();
-
-	if (ret) {
-		pr_info("Perf NMI watchdog permanently disabled\n");
-	} else {
-		perf_event_release_kernel(this_cpu_read(watchdog_ev));
-		this_cpu_write(watchdog_ev, NULL);
-	}
-	return ret;
-}
-
-/**
- * hardlockup_config_perf_event - Overwrite config of wd_hw_attr.
- * @str: number which identifies the raw perf event to use
- */
-void __init hardlockup_config_perf_event(const char *str)
-{
-	u64 config;
-	char buf[24];
-	char *comma = strchr(str, ',');
-
-	if (!comma) {
-		if (kstrtoull(str, 16, &config))
-			return;
-	} else {
-		unsigned int len = comma - str;
-
-		if (len > sizeof(buf))
-			return;
-
-		strscpy(buf, str, len);
-		if (kstrtoull(buf, 16, &config))
-			return;
-	}
-
-	wd_hw_attr.type = PERF_TYPE_RAW;
-	wd_hw_attr.config = config;
-}
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 099abf128ce67..5981d33e12f6d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1159,8 +1159,7 @@ config HAVE_HARDLOCKUP_DETECTOR_BUDDY
 config HARDLOCKUP_DETECTOR
 	bool "Detect Hard Lockups"
 	depends on DEBUG_KERNEL && !S390 && !HARDLOCKUP_DETECTOR_SPARC64
-	depends on HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETECTOR_BUDDY || HAVE_HARDLOCKUP_DETECTOR_ARCH
-	imply HARDLOCKUP_DETECTOR_PERF
+	depends on HAVE_HARDLOCKUP_DETECTOR_BUDDY || HAVE_HARDLOCKUP_DETECTOR_ARCH
 	imply HARDLOCKUP_DETECTOR_BUDDY
 	imply HARDLOCKUP_DETECTOR_ARCH
 	select LOCKUP_DETECTOR
@@ -1174,37 +1173,10 @@ config HARDLOCKUP_DETECTOR
 	  chance to run.  The current stack trace is displayed upon detection
 	  and the system will stay locked up.
 
-#
-# Note that arch-specific variants are always preferred.
-#
-config HARDLOCKUP_DETECTOR_PREFER_BUDDY
-	bool "Prefer the buddy CPU hardlockup detector"
-	depends on HARDLOCKUP_DETECTOR
-	depends on HAVE_HARDLOCKUP_DETECTOR_PERF && HAVE_HARDLOCKUP_DETECTOR_BUDDY
-	depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
-	help
-	  Say Y here to prefer the buddy hardlockup detector over the perf one.
-
-	  With the buddy detector, each CPU uses its softlockup hrtimer
-	  to check that the next CPU is processing hrtimer interrupts by
-	  verifying that a counter is increasing.
-
-	  This hardlockup detector is useful on systems that don't have
-	  an arch-specific hardlockup detector or if resources needed
-	  for the hardlockup detector are better used for other things.
-
-config HARDLOCKUP_DETECTOR_PERF
-	bool
-	depends on HARDLOCKUP_DETECTOR
-	depends on HAVE_HARDLOCKUP_DETECTOR_PERF && !HARDLOCKUP_DETECTOR_PREFER_BUDDY
-	depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
-	select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
-
 config HARDLOCKUP_DETECTOR_BUDDY
 	bool
 	depends on HARDLOCKUP_DETECTOR
 	depends on HAVE_HARDLOCKUP_DETECTOR_BUDDY
-	depends on !HAVE_HARDLOCKUP_DETECTOR_PERF || HARDLOCKUP_DETECTOR_PREFER_BUDDY
 	depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
 
@@ -1217,8 +1189,8 @@ config HARDLOCKUP_DETECTOR_ARCH
 	  be used.
 
 #
-# Both the "perf" and "buddy" hardlockup detectors count hrtimer
-# interrupts. This config enables functions managing this common code.
+# Buddy hardlockup detectors count hrtimer interrupts. This config enables
+# functions managing this common code.
 #
 config HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
 	bool
-- 
2.39.5

