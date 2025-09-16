Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28767338F55
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 14:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034295; cv=none; b=q18M+cSHmInEZ8om/nt1IL7+RQaCuEz6ZfCMKIfYgMWIfFV7vd1+du44EIedZRBYNGsEJG8iZcInfljhbkHDbvR+Fchq5A+32RLuaCXsVxcF1hGfGaF3i4CFfawjvbzbBX/QwDYDR6rPogiJRn03i8TGxwDshWLdUQQsEoHKtK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034295; c=relaxed/simple;
	bh=yOPhsR+6OpKcNKrqhey8Xj+vyqWvzKZzXBp3TDEgG/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D5xj7NbtbPAUI/Uu+mioU3lYxc0zBaqedBL6NIgO/uIObVrui7+kgNxi0He74SXzEC8e6eCrPmXxL0RqQjoU7JPzUh4EdSkwsDnk8b+OLo/RgpeKSZTz5aqdD9WhbPL0wqNnp91nbkA7Ox+OYc/CY19OZpV2fVXj9nfpSZJ3e9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QA37iMzT; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QA37iMzT"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77251d7cca6so5295730b3a.3
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Sep 2025 07:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758034293; x=1758639093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUdV9b+MUzYSykR4K0EUwi33bkRUh9yRXeB209qpl0M=;
        b=QA37iMzTTb+XkTNYawuCX+Du7cLne7bvEtd7sHXX/cvCS1g2Qpfj7E6l02msnxR03u
         tPdxz3FvQl1zVHP+sCnAoXLfo6C8tDjF49YuuhdpA3TuNj89+fnKSr3S00XDrNjklDyk
         6kVnB/QgrZ2g2y5DBQuNszENE5X4GN9RvqeLAuC7utEA3Q96kHmaA6nCbN4Tb+znNBE4
         YWUiS2w83Kmdgz2/wQ7nSr7kY6l1J+40hh5ghoyVhTQNMJXIOeOPpFvjDKVTb43Wc/rk
         jit5i292+a3jjJo8XAAGZt44LwqdNK/D6puUeGmcOodViqxMv4jE7ra7i2UXiXxFDXGQ
         XzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758034293; x=1758639093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUdV9b+MUzYSykR4K0EUwi33bkRUh9yRXeB209qpl0M=;
        b=lYTsA/WSSa0TVdPgpocfBMQwdzQBbH3CFXXILCH+3qvvsAf1mY7hE8J0IBlmD6U/ob
         q1Rh54hCGlNBNsZBrtRYZFkVPSlxaLfkKqEtI4onZLlQk9Lwvo56dSeJEgPUWnfTEx3O
         leHHu6KxYA0o0dGX2njZYn24cndMi+GUZlgf+sV5ti3dRj/vIJMm4xnWlqs46uIy0GR6
         bTkT/tw9xxJsfrotdh+uEXYHbDBQq5rmImMhKqf896xLILjhOwrr56N98Um+L+lBL6nj
         ozbPNoBWoFTwBtG4eIMfEy2BhZLcJy411pKGhaH4UbhZ55EO336Yg1sFDKFTNVaJUF3g
         s2mQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTEGbmtHd/I5fulAvJjMCuKqeXx7VwqUL7zmOCybGVZ2b8v3q2rpp61DDG29ArrZBRWZE8bXGxP7786LfrXVwI@vger.kernel.org
X-Gm-Message-State: AOJu0YyaQmoL9xF1ZQ+MQBRwd9a+1mQ7jmwIJBfTTdbY+E5umv6RVsDU
	lkaKEsBNebsajsBw2O/DgrIa/L2P/pU7qcaRKLxDQ/GFcVoKmtREdKUH
X-Gm-Gg: ASbGncs6ioCvuUIFJZqzdLjwdYyj2VALwGf4AR4vP479t5BhvRFUqPffam6UEUXzowh
	gsbp7oBX8xr0enWkFoPqTLhibVmTSZLEgbREkVlIHdS34KWa4E7RiCqpSMoD1fM3cFiHVCpVwQo
	qyKbFEZprvPDYZCkxTvCi8Slrv+BkDISz+Z3hNZhsc3lDbNti1gD9Ch1+f+1DaenBHGhjL+2HYx
	zcJcHEiHo32NIlpuh19HfLvgqeM09ga61A1i4OuDDtULTr3QXrSOlTzopNTk01hzsvhzq6fQO3B
	Q//8vqHUvZC/cdBhyL+Aq7IK2HeuqkqRu7+r72IgcaKNA/OHefQbJEW39nIrcFM7b0htgGTjOBY
	vre7n1z6DQ4PD2w38IukKmrSC4DBo5jk7Ki1mVR73VA==
X-Google-Smtp-Source: AGHT+IHnm4FCK6Te/CibvzapeGhIkDjpDqsd9Sk7/lgMPhn0W5OUMZuiBGRdKNd0yHfUApRIAYjXUQ==
X-Received: by 2002:a05:6a00:13a5:b0:772:5165:3f68 with SMTP id d2e1a72fcca58-77612194091mr20274566b3a.27.1758034293145;
        Tue, 16 Sep 2025 07:51:33 -0700 (PDT)
Received: from localhost ([194.50.154.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b18371sm16676053b3a.49.2025.09.16.07.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 07:51:32 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Doug Anderson <dianders@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	akpm@linux-foundation.org,
	catalin.marinas@arm.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	kees@kernel.org,
	masahiroy@kernel.org,
	aliceryhl@google.com,
	ojeda@kernel.org,
	thomas.weissschuh@linutronix.de,
	xur@google.com,
	ruanjinjie@huawei.com,
	gshan@redhat.com,
	maz@kernel.org,
	suzuki.poulose@arm.com,
	zhanjie9@hisilicon.com,
	yangyicong@hisilicon.com,
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
	yury.norov@gmail.com,
	thorsten.blum@linux.dev,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-perf-users@vger.kernel.org,
	Ian Rogers <irogers@google.com>
Cc: Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH V1] watchdog: Add boot-time selection for hard lockup detector
Date: Tue, 16 Sep 2025 22:50:10 +0800
Message-ID: <20250916145122.416128-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <https://lore.kernel.org/all/20250915035355.10846-1-cuiyunhui@bytedance.com/>
References: <https://lore.kernel.org/all/20250915035355.10846-1-cuiyunhui@bytedance.com/>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, the hard lockup detector is selected at compile time via
Kconfig, which requires a kernel rebuild to switch implementations.
This is inflexible, especially on systems where a perf event may not
be available or may be needed for other tasks.

This commit refactors the hard lockup detector to replace a rigid
compile-time choice with a flexible build-time and boot-time solution.
The patch supports building the kernel with either detector
independently, or with both. When both are built, a new boot parameter
`hardlockup_detector="perf|buddy"` allows the selection at boot time.
This is a more robust and user-friendly design.

This patch is a follow-up to the discussion on the kernel mailing list
regarding the preference and future of the hard lockup detectors. It
implements a flexible solution that addresses the community's need to
select an appropriate detector at boot time.

The core changes are:
- The `perf` and `buddy` watchdog implementations are separated into
  distinct functions (e.g., `watchdog_perf_hardlockup_enable`).
- Global function pointers are introduced (`watchdog_hardlockup_enable_ptr`)
  to serve as a single API for the entire feature.
- A new `hardlockup_detector=` boot parameter is added to allow the
  user to select the desired detector at boot time.
- The Kconfig options are simplified by removing the complex
  `HARDLOCKUP_DETECTOR_PREFER_BUDDY` and allowing both detectors to be
  built without mutual exclusion.
- The weak stubs are updated to call the new function pointers,
  centralizing the watchdog logic.

Link: https://lore.kernel.org/all/20250915035355.10846-1-cuiyunhui@bytedance.com/
Link: https://lore.kernel.org/all/CAD=FV=WWUiCi6bZCs_gseFpDDWNkuJMoL6XCftEo6W7q6jRCkg@mail.gmail.com/

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 +++
 include/linux/nmi.h                           |  6 +++
 kernel/watchdog.c                             | 46 ++++++++++++++++++-
 kernel/watchdog_buddy.c                       |  7 +--
 kernel/watchdog_perf.c                        | 10 ++--
 lib/Kconfig.debug                             | 37 +++++++--------
 6 files changed, 85 insertions(+), 28 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 5a7a83c411e9..0af214ee566c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1828,6 +1828,13 @@
 			backtraces on all cpus.
 			Format: 0 | 1
 
+	hardlockup_detector=
+			[perf, buddy] Selects the hard lockup detector to use at
+			boot time.
+			Format: <string>
+			- "perf": Use the perf-based detector.
+			- "buddy": Use the buddy-based detector.
+
 	hash_pointers=
 			[KNL,EARLY]
 			By default, when pointers are printed to the console
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index cf3c6ab408aa..9298980ce572 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -100,6 +100,9 @@ void watchdog_hardlockup_check(unsigned int cpu, struct pt_regs *regs);
 #endif
 
 #if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
+void watchdog_perf_hardlockup_enable(unsigned int cpu);
+void watchdog_perf_hardlockup_disable(unsigned int cpu);
+extern int watchdog_perf_hardlockup_probe(void);
 extern void hardlockup_detector_perf_stop(void);
 extern void hardlockup_detector_perf_restart(void);
 extern void hardlockup_config_perf_event(const char *str);
@@ -120,6 +123,9 @@ void watchdog_hardlockup_disable(unsigned int cpu);
 void lockup_detector_reconfigure(void);
 
 #ifdef CONFIG_HARDLOCKUP_DETECTOR_BUDDY
+void watchdog_buddy_hardlockup_enable(unsigned int cpu);
+void watchdog_buddy_hardlockup_disable(unsigned int cpu);
+int watchdog_buddy_hardlockup_probe(void);
 void watchdog_buddy_check_hardlockup(int hrtimer_interrupts);
 #else
 static inline void watchdog_buddy_check_hardlockup(int hrtimer_interrupts) {}
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 80b56c002c7f..85451d24a77d 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -55,6 +55,37 @@ unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
 
 #ifdef CONFIG_HARDLOCKUP_DETECTOR
 
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
+/* The global function pointers */
+void (*watchdog_hardlockup_enable_ptr)(unsigned int cpu) = watchdog_perf_hardlockup_enable;
+void (*watchdog_hardlockup_disable_ptr)(unsigned int cpu) = watchdog_perf_hardlockup_disable;
+int (*watchdog_hardlockup_probe_ptr)(void) = watchdog_perf_hardlockup_probe;
+#elif defined(CONFIG_HARDLOCKUP_DETECTOR_BUDDY)
+void (*watchdog_hardlockup_enable_ptr)(unsigned int cpu) = watchdog_buddy_hardlockup_enable;
+void (*watchdog_hardlockup_disable_ptr)(unsigned int cpu) = watchdog_buddy_hardlockup_disable;
+int (*watchdog_hardlockup_probe_ptr)(void) = watchdog_buddy_hardlockup_probe;
+#endif
+
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_MULTIPLE
+static char *hardlockup_detector_type = "perf"; /* Default to perf */
+static int __init set_hardlockup_detector_type(char *str)
+{
+	if (!strncmp(str, "perf", 4)) {
+		watchdog_hardlockup_enable_ptr = watchdog_perf_hardlockup_enable;
+		watchdog_hardlockup_disable_ptr = watchdog_perf_hardlockup_disable;
+		watchdog_hardlockup_probe_ptr = watchdog_perf_hardlockup_probe;
+	} else if (!strncmp(str, "buddy", 5)) {
+		watchdog_hardlockup_enable_ptr = watchdog_buddy_hardlockup_enable;
+		watchdog_hardlockup_disable_ptr = watchdog_buddy_hardlockup_disable;
+		watchdog_hardlockup_probe_ptr = watchdog_buddy_hardlockup_probe;
+	}
+	return 1;
+}
+
+__setup("hardlockup_detector=", set_hardlockup_detector_type);
+
+#endif
+
 # ifdef CONFIG_SMP
 int __read_mostly sysctl_hardlockup_all_cpu_backtrace;
 # endif /* CONFIG_SMP */
@@ -262,9 +293,17 @@ static inline void watchdog_hardlockup_kick(void) { }
  * softlockup watchdog start and stop. The detector must select the
  * SOFTLOCKUP_DETECTOR Kconfig.
  */
-void __weak watchdog_hardlockup_enable(unsigned int cpu) { }
+void __weak watchdog_hardlockup_enable(unsigned int cpu)
+{
+	if (watchdog_hardlockup_enable_ptr)
+		watchdog_hardlockup_enable_ptr(cpu);
+}
 
-void __weak watchdog_hardlockup_disable(unsigned int cpu) { }
+void __weak watchdog_hardlockup_disable(unsigned int cpu)
+{
+	if (watchdog_hardlockup_disable_ptr)
+		watchdog_hardlockup_disable_ptr(cpu);
+}
 
 /*
  * Watchdog-detector specific API.
@@ -275,6 +314,9 @@ void __weak watchdog_hardlockup_disable(unsigned int cpu) { }
  */
 int __weak __init watchdog_hardlockup_probe(void)
 {
+	if (watchdog_hardlockup_probe_ptr)
+		return watchdog_hardlockup_probe_ptr();
+
 	return -ENODEV;
 }
 
diff --git a/kernel/watchdog_buddy.c b/kernel/watchdog_buddy.c
index ee754d767c21..390d89bfcafa 100644
--- a/kernel/watchdog_buddy.c
+++ b/kernel/watchdog_buddy.c
@@ -19,15 +19,16 @@ static unsigned int watchdog_next_cpu(unsigned int cpu)
 	return next_cpu;
 }
 
-int __init watchdog_hardlockup_probe(void)
+int __init watchdog_buddy_hardlockup_probe(void)
 {
 	return 0;
 }
 
-void watchdog_hardlockup_enable(unsigned int cpu)
+void watchdog_buddy_hardlockup_enable(unsigned int cpu)
 {
 	unsigned int next_cpu;
 
+	pr_info("ddddd %s\n", __func__);
 	/*
 	 * The new CPU will be marked online before the hrtimer interrupt
 	 * gets a chance to run on it. If another CPU tests for a
@@ -58,7 +59,7 @@ void watchdog_hardlockup_enable(unsigned int cpu)
 	cpumask_set_cpu(cpu, &watchdog_cpus);
 }
 
-void watchdog_hardlockup_disable(unsigned int cpu)
+void watchdog_buddy_hardlockup_disable(unsigned int cpu)
 {
 	unsigned int next_cpu = watchdog_next_cpu(cpu);
 
diff --git a/kernel/watchdog_perf.c b/kernel/watchdog_perf.c
index 9c58f5b4381d..270110e58f20 100644
--- a/kernel/watchdog_perf.c
+++ b/kernel/watchdog_perf.c
@@ -153,10 +153,12 @@ static int hardlockup_detector_event_create(void)
  * watchdog_hardlockup_enable - Enable the local event
  * @cpu: The CPU to enable hard lockup on.
  */
-void watchdog_hardlockup_enable(unsigned int cpu)
+void watchdog_perf_hardlockup_enable(unsigned int cpu)
 {
 	WARN_ON_ONCE(cpu != smp_processor_id());
 
+	pr_info("ddddd %s\n", __func__);
+
 	if (hardlockup_detector_event_create())
 		return;
 
@@ -172,7 +174,7 @@ void watchdog_hardlockup_enable(unsigned int cpu)
  * watchdog_hardlockup_disable - Disable the local event
  * @cpu: The CPU to enable hard lockup on.
  */
-void watchdog_hardlockup_disable(unsigned int cpu)
+void watchdog_perf_hardlockup_disable(unsigned int cpu)
 {
 	struct perf_event *event = this_cpu_read(watchdog_ev);
 
@@ -257,10 +259,12 @@ bool __weak __init arch_perf_nmi_is_available(void)
 /**
  * watchdog_hardlockup_probe - Probe whether NMI event is available at all
  */
-int __init watchdog_hardlockup_probe(void)
+int __init watchdog_perf_hardlockup_probe(void)
 {
 	int ret;
 
+	pr_info("ddddd %s\n", __func__);
+
 	if (!arch_perf_nmi_is_available())
 		return -ENODEV;
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index dc0e0c6ed075..443353fad1c1 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1167,36 +1167,33 @@ config HARDLOCKUP_DETECTOR
 #
 # Note that arch-specific variants are always preferred.
 #
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
 config HARDLOCKUP_DETECTOR_PERF
-	bool
+	bool "Enable perf-based hard lockup detector (preferred)"
 	depends on HARDLOCKUP_DETECTOR
-	depends on HAVE_HARDLOCKUP_DETECTOR_PERF && !HARDLOCKUP_DETECTOR_PREFER_BUDDY
+	depends on HAVE_HARDLOCKUP_DETECTOR_PERF
 	depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
+	help
+	  This detector uses a perf event on the CPU to detect when a CPU
+	  has become non-maskable interrupt (NMI) stuck. This is the
+	  preferred method on modern systems as it can detect lockups on
+	  all CPUs at the same time.
 
 config HARDLOCKUP_DETECTOR_BUDDY
-	bool
+	bool "Enable buddy-based hard lockup detector"
 	depends on HARDLOCKUP_DETECTOR
 	depends on HAVE_HARDLOCKUP_DETECTOR_BUDDY
-	depends on !HAVE_HARDLOCKUP_DETECTOR_PERF || HARDLOCKUP_DETECTOR_PREFER_BUDDY
 	depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
 	select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
+	help
+	  This is an alternative lockup detector that uses a heartbeat
+	  mechanism between CPUs to detect when one has stopped responding.
+	  It is less precise than the perf-based detector and cannot detect
+	  all-CPU lockups, but it does not require a perf counter.
+
+config CONFIG_HARDLOCKUP_DETECTOR_MULTIPLE
+	bool
+	depends on HARDLOCKUP_DETECTOR_PERF && HARDLOCKUP_DETECTOR_BUDDY
 
 config HARDLOCKUP_DETECTOR_ARCH
 	bool
-- 
2.43.0

