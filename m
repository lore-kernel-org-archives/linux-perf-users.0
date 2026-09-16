Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB0537C11C;
	Wed, 16 Sep 2026 06:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541867; cv=none; b=DeSpukS5mf8zhORRrZTXXmkOMlIWcfop90i/dhEYCUcP9dkQzyCWeIaShv1GMjvU7BxWiOOMWdqYupZOrW0wweP3IdOORUjVwufo35lXHkr8HtdcomVB3SP86Vp/S7WKzyogvxHAJCkrCmPVv/DQqhCRgydxALtVA3wOBvcI5sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541867; c=relaxed/simple;
	bh=6I39GZGDcgx0Fu4ld873okS4rvWL1ptrWi8ryG4NrnE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PFwEA3T4nV5KGeMjfvd24K+8COqtpo/ZQ6W5UlYn4HxEBuDqpezMesIVZlKUNbnDUaDo0p+sX4r7GDIVQIb2E2CBNpr7elsHcH8r9khn3qLcppk+kKAORgU1o5IlCxcgnVLFY8UbxFuy1gY/9lMTRM4Iu7e3vNSOuBXI8BGxt/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bkZmc5lj; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bkZmc5lj"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789541860; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=KJ+Y6/ucHVtqbF5lQL2ZJvH3+e5O6kETbmwmn1ewBBI=;
	b=bkZmc5ljGo9A/ZBrQK6vP7dT87Vv28+spWdEuC/88SVMJKch4jVnMYDSM7qLLeqtInUoCxBaPSPwmjhN5lwsHP/vJ6HkNkEl1GkYqpG7vmHinqBNKkgMXat7PWnLKsKjZTZuv2PvqLJgX48Gm0EYaW3aAzJneyTVLeoww4e+JlA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=guanghuifeng@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0XB49fzX_1789541843;
Received: from VM20241011-104.tbsite.net(mailfrom:guanghuifeng@linux.alibaba.com fp:SMTPD_---0XB49fzX_1789541843 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Sep 2026 14:57:38 +0800
From: Guanghui Feng <guanghuifeng@linux.alibaba.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	tglx@kernel.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	seanjc@google.com,
	kai.huang@intel.com,
	radu@rendec.net
Cc: x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf/x86/amd: Move NMI latency window to last-resort suppression
Date: Wed, 16 Sep 2026 14:57:23 +0800
Message-ID: <20260916065723.1976131-1-guanghuifeng@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The upstream amd_pmu_adjust_nmi_window() mitigation claims every NMI
that arrives within a 100ms window opened after a PMC overflow. When no
counter overflowed, the handler still returns NMI_HANDLED, which makes
the NMI dispatch path take its "handled" exit. Everything that comes
after the perf handler is then skipped: the NMI reason port, which may
hold a latched SERR#/IOCHK# error, and all NMI_UNKNOWN handlers, such
as hpwdt. As a result unrelated NMIs are silently dropped for the whole
duration of the window.

Stop claiming NMIs from within the perf handler. When no counter
overflowed there is nothing to claim, so always report NMI_DONE and let
the remaining NMI sources be probed first. Defer the window check to the
very end of the dispatch path, where it is used only as a last resort.

Introduce perf_nmi_window_active(), which reports whether the latency
window opened by the last PMC overflow on this CPU is still open. It is
called from unknown_nmi_error() only after all NMI_LOCAL handlers, the
reason port and all NMI_UNKNOWN handlers failed to identify the NMI.
Only then is the bogus "unknown NMI" report suppressed. A __weak
fallback in arch/x86/kernel/nmi.c always returns false, so non-AMD
platforms are unaffected.

nmi_stats.unknown is still incremented before the suppression, so the
dropped NMIs remain observable through debugfs.

Fixes: df4d29732fda ("perf/x86/amd: Change/fix NMI latency mitigation to use a timestamp")
Signed-off-by: Guanghui Feng <guanghuifeng@linux.alibaba.com>
---
 arch/x86/events/amd/core.c | 56 ++++++++++++++++++++++++++++++--------
 arch/x86/include/asm/nmi.h |  8 ++++++
 arch/x86/kernel/nmi.c      | 23 ++++++++++++++++
 3 files changed, 76 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 49b6b8fce566..36721042c79c 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -868,18 +868,28 @@ static void amd_pmu_del_event(struct perf_event *event)
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
+ * reports NMI_DONE and the window is consulted by the dispatch path as the
+ * very last resort, once no handler was able to identify the NMI. See
+ * perf_nmi_window_active() below and unknown_nmi_error().
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
@@ -887,11 +897,35 @@ static inline int amd_pmu_adjust_nmi_window(int handled)
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
+ * This is the last resort of the x86 NMI dispatch path: it is only called
+ * after all NMI_LOCAL handlers, the NMI reason port and all NMI_UNKNOWN
+ * handlers failed to claim the NMI. It must never be used to claim an NMI on
+ * behalf of perf, otherwise unrelated NMI sources would be dropped.
+ *
+ * Context: NMI context. Must not sleep and must not take locks.
+ */
+bool perf_nmi_window_active(void)
+{
+	return !time_after(jiffies, this_cpu_read(perf_nmi_tstamp));
 }
+EXPORT_SYMBOL_GPL(perf_nmi_window_active);
 
 static int amd_pmu_handle_irq(struct pt_regs *regs)
 {
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
index 3c9f60d6ca5a..1aa161b56be0 100644
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
 
-- 
2.43.7

