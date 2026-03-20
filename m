Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27983BC661
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 15:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774020579; cv=none; b=WIkp2PaCrFmHLmgFrWoUmkbGCzuFGLSu9AcNi8oh6x7q+78RYVjzntnWMoBgRf0jTe12KUtxuW4GS1EeE9Sz5n0LDK6Hkn8TL+T18+t7smUVqeRZAqFBYHNtxYU2Mj0/lx+7fYz2Mo/RSSQaE/HlauLwUulEMb+pbqvv5OwZS3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774020579; c=relaxed/simple;
	bh=Xt0oyCoANRknBAg74JLO5k+ywmj7macSsoY1aANe7W0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=A1OmXTRv4XZX4f6uf6jQ+6xfiZpK+e0S3429eNyRJ7tKHIoBgAPvRtbTOI/QDqqNzrOGlWh3Po7UMCuSVLj22JdxZALXaa8676Ut3Mqa5qAiu5p1cUVFxnxiaQvJXZgpRbqGLgiu4qYmNq21AYAhqwWpWPJtr3YDnnZjUZeb2+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S9hYe5UP; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jmattson.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S9hYe5UP"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b059ab124dso7718395ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 08:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774020578; x=1774625378; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jmlujj2bVl3FzbdDIVmQ4UUMo+lfTybxXtCuGCGh2ZY=;
        b=S9hYe5UPUpr2tsFSslQa2NpB9G0BI8FQ2JvEWlM2fyGvfdmv1B1RKf52lbWPTVEJH8
         j5gfklzQjMXguRNUHP9z3cRxTIoxcjgnY0VSIq5ZBITSIcbVDebb2EXtfwkyuJ5VSjjc
         mEOFtM7WaNKJR1jbZuwvA8ne2NL+Lnpa/upbdxSJGBxi2Z72ZPRBdWRIPI1ylVbe32M/
         gg85cNn8pGj8Pb4gR+0spBVaJ7aYzhitMWRGzIT1LGVy+o9qyxalUKg84jYusqJRPGfR
         fSnjX3IchwuuD62QHxoWSBNJ17vxafuDE02846/QxXaOQ9Uut4wdwR/Pe6iEjFPebGZO
         WPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774020578; x=1774625378;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jmlujj2bVl3FzbdDIVmQ4UUMo+lfTybxXtCuGCGh2ZY=;
        b=swqXIP4KSyzcTVFP+SXWdqjoycJPlzUccJ0o+Ezjh4+4TvT/kAsLnmsLK1M5y08P9U
         1lIXqQg17URYcDfGdKpREYiULcAoSNKwFgC90tR1wJdSvCYCDVSg5SgS6y5ZiYmR9no/
         0QIv9V7tFVdyNfBm9XedSolFS+bR1zo+mqYQgvwTT+pNKe3Lw2Nlei3/vNQIii6WXcP9
         gbV+rVFj6rQYJXFwyA/LNIYfGZoFuRUR/9zII1pG5kJO72kyQqjleQ0pFx2JCAtxxGCl
         yFe5DyjNTXEO5uXuIqeVTK+DPGpAq73z+NNRxnhRnoXhyxyOc7BR0hs3E+87hu5NPr91
         mhsw==
X-Forwarded-Encrypted: i=1; AJvYcCXFHcNh3dKuYPxAsKQ9KQeorEPvCQDAzak9tLOWmm64m7bUZSMrPu7cxNvjYOF+kciG9l1KCJw0WvisEsQWwN/n@vger.kernel.org
X-Gm-Message-State: AOJu0YxqOr4kB0ZJAQBYhCG9Ux7Pu6H1V2NLL57YNBYlcbRDJ6i5cdFS
	UPucAvm8J119cvGBACZqRY8QRuXu3rSoq9qIPfPcWu0rJ8XBxiPGslwBObIFcF4wCz6CQyx+oST
	Ph8karojARD1uNA==
X-Received: from plgc17.prod.google.com ([2002:a17:902:d491:b0:2b0:51f0:272d])
 (user=jmattson job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:191:b0:2b0:60b2:4f8 with SMTP id d9443c01a7336-2b0827219a0mr33739825ad.15.1774020577769;
 Fri, 20 Mar 2026 08:29:37 -0700 (PDT)
Date: Fri, 20 Mar 2026 08:27:52 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.959.g497ff81fa9-goog
Message-ID: <20260320152928.1916447-1-jmattson@google.com>
Subject: [PATCH] perf/x86/intel: Don't update PEBS_ENABLE MSR in NMI context
From: Jim Mattson <jmattson@google.com>
To: Peter Zijlstra <peterz@infraded.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>, 
	Mingwei Zhang <mizhang@google.com>
Cc: Jim Mattson <jmattson@google.com>
Content-Type: text/plain; charset="UTF-8"

Writing MSR_IA32_PEBS_ENABLE in handle_pmi_common() when a PEBS event is
throttled is problematic for KVM, which may have an older value for the MSR
(previously obtained via perf_guest_get_msrs()) stored in the VM-exit
MSR-load list.

It isn't necessary to update the MSR in the PMI handler, because the
throttled counter's PerfEvtSel ENABLE bit has been cleared, so its
PEBS_ENABLE bit is irrelevant. However, the MSR must be updated before the
stale bit becomes relevant again (i.e. when the PMC starts counting a new
perf event).

When the PEBS_ENABLE MSR is rendered stale in the PMI handler, just record
that fact in a new cpu_hw_events boolean, pebs_stale.  Extend
intel_pmu_pebs_enable_all() to write MSR_IA32_PEBS_ENABLE when pebs_stale
is set and to clear pebs_stale.  This ensures stale bits are cleared
during the normal PMU enable path, before PERF_GLOBAL_CTRL is restored and
any new event can start counting.

Signed-off-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/events/intel/core.c | 28 ++++++++++++++++++++++------
 arch/x86/events/intel/ds.c   |  4 +++-
 arch/x86/events/perf_event.h |  1 +
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cf3a4fe06ff2..3b0173d25232 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3548,14 +3548,26 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		static_call(x86_pmu_drain_pebs)(regs, &data);
 
 		/*
-		 * PMI throttle may be triggered, which stops the PEBS event.
-		 * Although cpuc->pebs_enabled is updated accordingly, the
-		 * MSR_IA32_PEBS_ENABLE is not updated. Because the
-		 * cpuc->enabled has been forced to 0 in PMI.
-		 * Update the MSR if pebs_enabled is changed.
+		 * PMI throttling may be triggered, which stops the PEBS
+		 * event.  Although cpuc->pebs_enabled was updated
+		 * accordingly, MSR_IA32_PEBS_ENABLE has not been updated.
+		 *
+		 * The MSR must not be updated in NMI context, because KVM
+		 * may be in a critical region on its way to VM-entry, with
+		 * the now-stale MSR value stored in the VM-exit MSR-load
+		 * list.  On VM-exit, the CPU will restore the stale value.
+		 *
+		 * Deferring the MSR update is harmless because the
+		 * throttled event's PerfEvtSel ENABLE bit has been
+		 * cleared, so the stale PEBS_ENABLE bit is irrelevant for
+		 * now.
+		 *
+		 * Track when MSR_IA32_PEBS_ENABLE is stale, so that
+		 * pebs_enable_all() will write cpuc->pebs_enabled to the
+		 * MSR, even when cpuc->pebs_enabled is 0.
 		 */
 		if (pebs_enabled != cpuc->pebs_enabled)
-			wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
+			cpuc->pebs_stale = true;
 
 		/*
 		 * Above PEBS handler (PEBS counters snapshotting) has updated fixed
@@ -4978,6 +4990,10 @@ static int intel_pmu_hw_config(struct perf_event *event)
  * These values have nothing to do with the emulated values the guest sees
  * when it uses {RD,WR}MSR, which should be handled by the KVM context,
  * specifically in the intel_pmu_{get,set}_msr().
+ *
+ * Note that MSRs returned from this function must not be modified in NMI
+ * context. Doing so could result in a stale host value being restored at
+ * the next VM-exit.
  */
 static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
 {
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 5027afc97b65..852baf6a05e9 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1982,8 +1982,10 @@ void intel_pmu_pebs_enable_all(void)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (cpuc->pebs_enabled)
+	if (cpuc->pebs_enabled || cpuc->pebs_stale)
 		wrmsrq(MSR_IA32_PEBS_ENABLE, cpuc->pebs_enabled);
+
+	cpuc->pebs_stale = false;
 }
 
 void intel_pmu_pebs_disable_all(void)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fad87d3c8b2c..22102296e31b 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -298,6 +298,7 @@ struct cpu_hw_events {
 	/* DS based PEBS or arch-PEBS buffer address */
 	void			*pebs_vaddr;
 	u64			pebs_enabled;
+	bool			pebs_stale;
 	int			n_pebs;
 	int			n_large_pebs;
 	int			n_pebs_via_pt;
-- 
2.53.0.959.g497ff81fa9-goog

