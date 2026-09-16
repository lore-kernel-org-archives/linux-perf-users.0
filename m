Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568E937FF67;
	Wed, 16 Sep 2026 12:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563057; cv=none; b=u/CDVXe9tWaL2cVYV5zkWG9gf2V6fEqtKbYjfY8iLA3bEXtea40JGaIBfrmhfr5pXUVoCQyAIRwtCEw8hWJjXe2FzNTvWDuckS7t2ScP2PGsNwthnhM4EC3IbSX17962N/1qUpG79YUFG2hePRoqRehEHAdePpSKZJR2tHY5vRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563057; c=relaxed/simple;
	bh=gTyecV2L1b/Y1lJl9+5iev2fqAWMl5xVS4DMAZ9AR+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MeJGmDyuMtypj8nb9MRfub6PGitehT/wciIX+y+v9Wczr9LMf9FDtdyNTgDqeGX3Mnl5JILRc8t5pVXVGBJ4fT/0DjBcQf4hWuCNJcTGGq2f/20nIe3LJnXD2nzcztFwFHfVp098bRqsvQFhikkVZG8XvlN1bbsWD2a4u+pW+lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R6+zC8+1; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R6+zC8+1"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789563033; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RWV5DhIvmUvs3VkNV7lhOPkMWuv/Nd6y5wFd3c8qG/0=;
	b=R6+zC8+1VBYwSRbEP/06qPbZ1JdDw/RT/VYe12x2xjtqL6AzwD1Kq3ZhLIHOFODkqyJwRLCcfm9o4ftyA5fqi0CU/Y4vR7IaldjpQzYkcxYys3TcJPYliSTPrMB8HBSL7/h8UAG9K89xN0eejCXOljx4miGmsPoJK5n6IiuNicA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XB5.tYN_1789563016;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XB5.tYN_1789563016 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 20:50:32 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: peterz@infradead.org
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	guanghuifeng@linux.alibaba.com,
	hpa@zytor.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	kai.huang@intel.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	radu@rendec.net,
	seanjc@google.com,
	tglx@kernel.org,
	x86@kernel.org
Subject: [PATCH v2] perf/x86/amd: Move NMI latency window to last-resort suppression
Date: Wed, 16 Sep 2026 20:50:16 +0800
Message-ID: <20260916125016.2266596-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260916093217.GH4121339@noisy.programming.kicks-ass.net>
References: <20260916093217.GH4121339@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The upstream amd_pmu_adjust_nmi_window() mitigation claims every NMI
that arrives within a 100ms window opened after a PMC overflow. When
no counter overflowed, the handler still returns NMI_HANDLED, which
makes the NMI dispatch path take its "handled" exit. Everything after
the perf handler is skipped: the NMI reason port, which may hold a
latched SERR#/IOCHK# error, and all NMI_UNKNOWN handlers, such as
hpwdt. Unrelated NMIs are silently dropped for the window duration.

Stop claiming NMIs from within the perf handler. When no counter
overflowed there is nothing to claim, so always report NMI_DONE.

To avoid re-introducing the reason port scalability problem that the
original mitigation was designed to prevent (inb 0x61 + global
nmi_reason_lock contention across CPUs at high spurious PMI rates),
consult perf_nmi_window_active() in default_do_nmi() *before* the
reason port read. When the window is open, skip the expensive I/O
but continue into unknown_nmi_error(), which still invokes all
NMI_UNKNOWN handlers (hpwdt, etc.). Only after every handler fails
to identify the NMI is the window consulted a second time to
suppress the bogus "unknown NMI" report and potential panic.

This preserves the original performance intent: the reason port is
never read during the latency window, identical to the upstream
behaviour. The only additional cost is traversing the NMI_UNKNOWN
handler list -- no I/O, no global lock, negligible overhead.

Introduce perf_nmi_window_active() with a guard on perf_nmi_window
being non-zero. Since perf_nmi_window is set exclusively by
amd_core_pmu_init(), the function always returns false on non-AMD
platforms even when CONFIG_CPU_SUP_AMD=y links in the strong symbol.
A __weak fallback in nmi.c covers builds without AMD support.

Initialize per-CPU perf_nmi_tstamp to (jiffies - 1) during AMD PMU
init so the window starts in a definitively closed state, preventing
false positives on 32-bit kernels where INITIAL_JIFFIES is near the
wrap point.

nmi_stats.unknown is still incremented before suppression, keeping
dropped NMIs observable through debugfs.

Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 arch/x86/events/amd/core.c | 85 ++++++++++++++++++++++++++++++++------
 arch/x86/include/asm/nmi.h |  8 ++++
 arch/x86/kernel/nmi.c      | 83 ++++++++++++++++++++++++++-----------
 3 files changed, 140 insertions(+), 36 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 49b6b8fce566..0f239978a490 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -868,18 +868,29 @@ static void amd_pmu_del_event(struct perf_event *event)
  * handler when multiple PMCs are active or PMC overflow while handling some
  * other source of an NMI.
  *
- * Attempt to mitigate this by creating an NMI window in which un-handled NMIs
- * received during this window will be claimed. This prevents extending the
- * window past when it is possible that latent NMIs should be received. The
- * per-CPU perf_nmi_tstamp will be set to the window end time whenever perf has
- * handled a counter. When an un-handled NMI is received, it will be claimed
- * only if arriving within that window.
+ * Attempt to mitigate this by creating an NMI window in which a latent NMI
+ * generated by an already handled overflow may still show up. This prevents
+ * extending the window past when it is possible that latent NMIs should be
+ * received. The per-CPU perf_nmi_tstamp will be set to the window end time
+ * whenever perf has handled a counter.
+ *
+ * The window is deliberately *not* used to claim NMIs from within this
+ * handler. Claiming an NMI although no counter overflowed makes the NMI
+ * dispatch path take the "handled" exit and skip everything that comes after
+ * it: the NMI reason port, which may hold a latched SERR#/IOCHK# error, and
+ * all NMI_UNKNOWN handlers, such as hpwdt. Those unrelated NMIs would then be
+ * silently dropped for the whole duration of the window. Instead this handler
+ * reports NMI_DONE and the window is only consulted by the dispatch path
+ * itself: once to skip the expensive reason port read, and a second time as
+ * the very last resort, when no handler was able to identify the NMI. See
+ * perf_nmi_window_active() below, default_do_nmi() and unknown_nmi_error().
  */
 static inline int amd_pmu_adjust_nmi_window(int handled)
 {
 	/*
-	 * If a counter was handled, record a timestamp such that un-handled
-	 * NMIs will be claimed if arriving within that window.
+	 * If a counter was handled, record a timestamp such that a latent NMI
+	 * generated by that overflow can still be recognized later on by the
+	 * NMI dispatch path.
 	 */
 	if (handled) {
 		this_cpu_write(perf_nmi_tstamp, jiffies + perf_nmi_window);
@@ -887,11 +898,51 @@ static inline int amd_pmu_adjust_nmi_window(int handled)
 		return handled;
 	}
 
-	if (time_after(jiffies, this_cpu_read(perf_nmi_tstamp)))
-		return NMI_DONE;
+	/*
+	 * No counter overflowed here, so there is nothing to claim. Report
+	 * NMI_DONE even when the window is open and let the remaining NMI
+	 * sources be probed first.
+	 */
+	return NMI_DONE;
+}
 
-	return NMI_HANDLED;
+/**
+ * perf_nmi_window_active - Check if the PMC NMI latency window is still open
+ *
+ * Returns true if the current time is within the NMI latency mitigation window
+ * that was opened by the last PMC counter overflow handled on this CPU. An
+ * open window means that a recently processed overflow may have generated an
+ * NMI which arrived too late to be paired with that overflow, and which
+ * therefore cannot be identified by any NMI handler.
+ *
+ * The x86 NMI dispatch path consults this twice. First, right after the
+ * NMI_LOCAL handlers failed to claim the NMI, in order to skip the reason
+ * port read (inb 0x61 under the global nmi_reason_lock), which does not scale
+ * when spurious PMIs arrive at high frequency. The NMI_UNKNOWN handlers are
+ * still run afterwards, so unrelated sources such as hpwdt are not lost.
+ * Second, as the very last resort in unknown_nmi_error(), to suppress the
+ * bogus "unknown NMI" report. It must never be used to claim an NMI on behalf
+ * of perf, otherwise unrelated NMI sources would be dropped.
+ *
+ * Context: NMI context. Must not sleep and must not take locks.
+ * Return: true if the PMC NMI latency window is still open on this CPU,
+ *	   false otherwise.
+ */
+bool perf_nmi_window_active(void)
+{
+	/*
+	 * perf_nmi_window is initialized to a non-zero value only by
+	 * amd_core_pmu_init(), which runs exclusively on AMD CPUs where the
+	 * PMU driver binds. If it is still zero, either we are on a different
+	 * vendor or the PMU has not been initialized yet - in either case no
+	 * latency window can be active.
+	 */
+	if (!perf_nmi_window)
+		return false;
+
+	return !time_after(jiffies, this_cpu_read(perf_nmi_tstamp));
 }
+EXPORT_SYMBOL_GPL(perf_nmi_window_active);
 
 static int amd_pmu_handle_irq(struct pt_regs *regs)
 {
@@ -1416,11 +1467,21 @@ static int __init amd_core_pmu_init(void)
 {
 	union cpuid_0x80000022_ebx ebx;
 	u64 even_ctr_mask = 0ULL;
-	int i;
+	int cpu, i;
 
 	/* Avoid calculating the value each time in the NMI handler */
 	perf_nmi_window = msecs_to_jiffies(100);
 
+	/*
+	 * Initialize the per-CPU timestamps to an already-expired value so
+	 * that perf_nmi_window_active() returns false until the first PMC
+	 * overflow actually opens a window. This avoids false positives on
+	 * 32-bit kernels where jiffies starts near the wrap point and a
+	 * zero-initialized timestamp would appear to be in the future.
+	 */
+	for_each_possible_cpu(cpu)
+		per_cpu(perf_nmi_tstamp, cpu) = jiffies - 1;
+
 	if (!boot_cpu_has(X86_FEATURE_PERFCTR_CORE))
 		return 0;
 
diff --git a/arch/x86/include/asm/nmi.h b/arch/x86/include/asm/nmi.h
index 79d88d12c8fb..703d717a21a3 100644
--- a/arch/x86/include/asm/nmi.h
+++ b/arch/x86/include/asm/nmi.h
@@ -105,4 +105,12 @@ void stop_nmi(void);
 void restart_nmi(void);
 void local_touch_nmi(void);
 
+/*
+ * Last resort check of the NMI dispatch path, used to suppress "unknown NMI"
+ * reports caused by PMC overflow NMI latency. The strong implementation lives
+ * in the AMD perf core, arch/x86/kernel/nmi.c provides a __weak fallback which
+ * always returns false.
+ */
+bool perf_nmi_window_active(void);
+
 #endif /* _ASM_X86_NMI_H */
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 3c9f60d6ca5a..1226c18e37a6 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -322,6 +322,16 @@ io_check_error(unsigned char reason, struct pt_regs *regs)
 }
 NOKPROBE_SYMBOL(io_check_error);
 
+/*
+ * Fallback used when the AMD perf core, which provides the strong
+ * implementation, is not built in. Without it no PMC overflow NMI latency
+ * window is tracked at all, so no "unknown NMI" report is ever suppressed.
+ */
+bool __weak perf_nmi_window_active(void)
+{
+	return false;
+}
+
 static void
 unknown_nmi_error(unsigned char reason, struct pt_regs *regs)
 {
@@ -340,6 +350,19 @@ unknown_nmi_error(unsigned char reason, struct pt_regs *regs)
 
 	__this_cpu_add(nmi_stats.unknown, 1);
 
+	/*
+	 * No handler was able to identify this NMI, so its source is unknown.
+	 * The one exception is a latent PMC overflow NMI: the overflow NMI can
+	 * arrive long after the counter was already processed by an earlier
+	 * NMI, which leaves nothing here that could identify it. If the perf
+	 * NMI latency window is still open, this NMI is very likely that late
+	 * arrival, so keep quiet about it instead of reporting a bogus unknown
+	 * NMI (and instead of panicking on unknown_nmi_panic). It is still
+	 * accounted in nmi_stats.unknown and thus stays visible in debugfs.
+	 */
+	if (perf_nmi_window_active())
+		return;
+
 	pr_emerg_ratelimited("Uhhuh. NMI received for unknown reason %02x on CPU %d.\n",
 			     reason, smp_processor_id());
 
@@ -407,38 +430,50 @@ static noinstr void default_do_nmi(struct pt_regs *regs)
 	}
 
 	/*
-	 * Non-CPU-specific NMI: NMI sources can be processed on any CPU.
+	 * If the perf NMI latency window is still open, a recently handled PMC
+	 * overflow may have generated a latent NMI that arrives too late to be
+	 * paired with that overflow. Skip the expensive reason port read
+	 * (inb 0x61 + global nmi_reason_lock) which is a known scalability
+	 * bottleneck when spurious PMIs arrive at high frequency on AMD.
 	 *
-	 * Another CPU may be processing panic routines while holding
-	 * nmi_reason_lock. Check if the CPU issued the IPI for crash dumping,
-	 * and if so, call its callback directly.  If there is no CPU preparing
-	 * crash dump, we simply loop here.
+	 * NMI_UNKNOWN handlers (hpwdt, etc.) are still invoked below via
+	 * unknown_nmi_error(), so hardware watchdog NMIs are not lost.
 	 */
-	while (!raw_spin_trylock(&nmi_reason_lock)) {
-		run_crash_ipi_callback(regs);
-		cpu_relax();
-	}
+	if (!perf_nmi_window_active()) {
+		/*
+		 * Non-CPU-specific NMI: NMI sources can be processed on any CPU.
+		 *
+		 * Another CPU may be processing panic routines while holding
+		 * nmi_reason_lock. Check if the CPU issued the IPI for crash
+		 * dumping, and if so, call its callback directly.  If there is no
+		 * CPU preparing crash dump, we simply loop here.
+		 */
+		while (!raw_spin_trylock(&nmi_reason_lock)) {
+			run_crash_ipi_callback(regs);
+			cpu_relax();
+		}
 
-	reason = x86_platform.get_nmi_reason();
+		reason = x86_platform.get_nmi_reason();
 
-	if (reason & NMI_REASON_MASK) {
-		if (reason & NMI_REASON_SERR)
-			pci_serr_error(reason, regs);
-		else if (reason & NMI_REASON_IOCHK)
-			io_check_error(reason, regs);
+		if (reason & NMI_REASON_MASK) {
+			if (reason & NMI_REASON_SERR)
+				pci_serr_error(reason, regs);
+			else if (reason & NMI_REASON_IOCHK)
+				io_check_error(reason, regs);
 
-		/*
-		 * Reassert NMI in case it became active
-		 * meanwhile as it's edge-triggered:
-		 */
-		if (IS_ENABLED(CONFIG_X86_32))
-			reassert_nmi();
+			/*
+			 * Reassert NMI in case it became active
+			 * meanwhile as it's edge-triggered:
+			 */
+			if (IS_ENABLED(CONFIG_X86_32))
+				reassert_nmi();
 
-		__this_cpu_add(nmi_stats.external, 1);
+			__this_cpu_add(nmi_stats.external, 1);
+			raw_spin_unlock(&nmi_reason_lock);
+			goto out;
+		}
 		raw_spin_unlock(&nmi_reason_lock);
-		goto out;
 	}
-	raw_spin_unlock(&nmi_reason_lock);
 
 	/*
 	 * Only one NMI can be latched at a time.  To handle
-- 
2.43.7

