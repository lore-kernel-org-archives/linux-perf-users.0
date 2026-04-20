Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC47F3890F6
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Apr 2026 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676635; cv=none; b=DmVOGBvcHbmDJDmG3gACBapSfbuRHddcpyqUjA4Y6+R9YbcTidK9WVwp9basBkWTaNLxCaNySM5o3mxWQnMMz7tsqhsoX15fnPpwfrwnkvxD1U0cwd3RC46kpSCk0Es4th80e07riUbHx42SscBptiJfJ0m2HCaHFbeJVmuU5PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676635; c=relaxed/simple;
	bh=D3U5LdGFb+vzdoquwuvp70L8A5JVwF2Y+/m9coxoCbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cA1WwqZf9bx3K6Sbhr55WOQemxvUldYFhFJTzvuK44/HrFAjhOQjPSJz0jJDI/2yW+ki6RE8DQzRWRli8V+NPwplyZUthfxOLbmt0+ZDyYwEr8H3uyA+67I6ktSEPpPv14KhQ3dI2ha+g1RvH1OhWcnKsGimVxB6MwtOXWYwNkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Q3ntXF2g; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Q3ntXF2g; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Q3ntXF2g";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Q3ntXF2g"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 09FD15BD2B;
	Mon, 20 Apr 2026 09:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1776676632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vv/M4Z9PXi0GEHr3QkUSw4FciIOYNriK9SiqYNb/cMU=;
	b=Q3ntXF2gNok4hGtLT2dDQqCvhcgE8x8YaOJSsppkATO/HQ8mkRNmE9/9rx2rZL9nynecH0
	esrGf4vmfO5Ujta5V7bWX8BPiaWuw7yLgd8cWRAHMHkHLqHv/5REZUEckJwJNh+2MYEDAa
	REmXekpDOBp4vqTKQO9w5mSSBD/Fp7Y=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Q3ntXF2g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1776676632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vv/M4Z9PXi0GEHr3QkUSw4FciIOYNriK9SiqYNb/cMU=;
	b=Q3ntXF2gNok4hGtLT2dDQqCvhcgE8x8YaOJSsppkATO/HQ8mkRNmE9/9rx2rZL9nynecH0
	esrGf4vmfO5Ujta5V7bWX8BPiaWuw7yLgd8cWRAHMHkHLqHv/5REZUEckJwJNh+2MYEDAa
	REmXekpDOBp4vqTKQO9w5mSSBD/Fp7Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E010593AE;
	Mon, 20 Apr 2026 09:17:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4tR9JRfv5WnYPQAAD6G6ig
	(envelope-from <jgross@suse.com>); Mon, 20 Apr 2026 09:17:11 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH RFC 5/6] x86/events: Switch core parts to use new MSR access functions
Date: Mon, 20 Apr 2026 11:16:33 +0200
Message-ID: <20260420091634.128787-6-jgross@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420091634.128787-1-jgross@suse.com>
References: <20260420091634.128787-1-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid,suse.com:email];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 09FD15BD2B
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Switch the core parts of the x86 events subsystem to use the new
msr_*() functions instead of the rdmsr*()/wrmsr*() ones.

Use msr_write_noser() in case there is another MSR write later in the
same function and msr_write_ser() for the last MSR write in a function.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/events/core.c       | 42 ++++++++++++++++++------------------
 arch/x86/events/msr.c        |  2 +-
 arch/x86/events/perf_event.h | 26 +++++++++++-----------
 arch/x86/events/probe.c      |  2 +-
 arch/x86/events/rapl.c       |  8 +++----
 5 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 810ab21ffd99..c15e0d1a6658 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -279,7 +279,7 @@ bool check_hw_exists(struct pmu *pmu, unsigned long *cntr_mask,
 	 */
 	for_each_set_bit(i, cntr_mask, X86_PMC_IDX_MAX) {
 		reg = x86_pmu_config_addr(i);
-		ret = rdmsrq_safe(reg, &val);
+		ret = msr_read_safe(reg, &val);
 		if (ret)
 			goto msr_fail;
 		if (val & ARCH_PERFMON_EVENTSEL_ENABLE) {
@@ -293,7 +293,7 @@ bool check_hw_exists(struct pmu *pmu, unsigned long *cntr_mask,
 
 	if (*(u64 *)fixed_cntr_mask) {
 		reg = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
-		ret = rdmsrq_safe(reg, &val);
+		ret = msr_read_safe(reg, &val);
 		if (ret)
 			goto msr_fail;
 		for_each_set_bit(i, fixed_cntr_mask, X86_PMC_IDX_MAX) {
@@ -324,11 +324,11 @@ bool check_hw_exists(struct pmu *pmu, unsigned long *cntr_mask,
 	 * (qemu/kvm) that don't trap on the MSR access and always return 0s.
 	 */
 	reg = x86_pmu_event_addr(reg_safe);
-	if (rdmsrq_safe(reg, &val))
+	if (msr_read_safe(reg, &val))
 		goto msr_fail;
 	val ^= 0xffffUL;
-	ret = wrmsrq_safe(reg, val);
-	ret |= rdmsrq_safe(reg, &val_new);
+	ret = msr_write_safe_noser(reg, val);
+	ret |= msr_read_safe(reg, &val_new);
 	if (ret || val != val_new)
 		goto msr_fail;
 
@@ -713,13 +713,13 @@ void x86_pmu_disable_all(void)
 
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
-		rdmsrq(x86_pmu_config_addr(idx), val);
+		val = msr_read(x86_pmu_config_addr(idx));
 		if (!(val & ARCH_PERFMON_EVENTSEL_ENABLE))
 			continue;
 		val &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
-		wrmsrq(x86_pmu_config_addr(idx), val);
+		msr_write_noser(x86_pmu_config_addr(idx), val);
 		if (is_counter_pair(hwc))
-			wrmsrq(x86_pmu_config_addr(idx + 1), 0);
+			msr_write_noser(x86_pmu_config_addr(idx + 1), 0);
 	}
 }
 
@@ -1446,14 +1446,14 @@ int x86_perf_event_set_period(struct perf_event *event)
 	 */
 	local64_set(&hwc->prev_count, (u64)-left);
 
-	wrmsrq(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
+	msr_write_noser(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
 
 	/*
 	 * Sign extend the Merge event counter's upper 16 bits since
 	 * we currently declare a 48-bit counter width
 	 */
 	if (is_counter_pair(hwc))
-		wrmsrq(x86_pmu_event_addr(idx + 1), 0xffff);
+		msr_write_noser(x86_pmu_event_addr(idx + 1), 0xffff);
 
 	perf_event_update_userpage(event);
 
@@ -1575,10 +1575,10 @@ void perf_event_print_debug(void)
 		return;
 
 	if (x86_pmu.version >= 2) {
-		rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
-		rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
-		rdmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, overflow);
-		rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
+		ctrl = msr_read(MSR_CORE_PERF_GLOBAL_CTRL);
+		status = msr_read(MSR_CORE_PERF_GLOBAL_STATUS);
+		overflow = msr_read(MSR_CORE_PERF_GLOBAL_OVF_CTRL);
+		fixed = msr_read(MSR_ARCH_PERFMON_FIXED_CTR_CTRL);
 
 		pr_info("\n");
 		pr_info("CPU#%d: ctrl:       %016llx\n", cpu, ctrl);
@@ -1586,19 +1586,19 @@ void perf_event_print_debug(void)
 		pr_info("CPU#%d: overflow:   %016llx\n", cpu, overflow);
 		pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
 		if (pebs_constraints) {
-			rdmsrq(MSR_IA32_PEBS_ENABLE, pebs);
+			pebs = msr_read(MSR_IA32_PEBS_ENABLE);
 			pr_info("CPU#%d: pebs:       %016llx\n", cpu, pebs);
 		}
 		if (x86_pmu.lbr_nr) {
-			rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
+			debugctl = msr_read(MSR_IA32_DEBUGCTLMSR);
 			pr_info("CPU#%d: debugctl:   %016llx\n", cpu, debugctl);
 		}
 	}
 	pr_info("CPU#%d: active:     %016llx\n", cpu, *(u64 *)cpuc->active_mask);
 
 	for_each_set_bit(idx, cntr_mask, X86_PMC_IDX_MAX) {
-		rdmsrq(x86_pmu_config_addr(idx), pmc_ctrl);
-		rdmsrq(x86_pmu_event_addr(idx), pmc_count);
+		pmc_ctrl = msr_read(x86_pmu_config_addr(idx));
+		pmc_count = msr_read(x86_pmu_event_addr(idx));
 
 		prev_left = per_cpu(pmc_prev_left[idx], cpu);
 
@@ -1612,7 +1612,7 @@ void perf_event_print_debug(void)
 	for_each_set_bit(idx, fixed_cntr_mask, X86_PMC_IDX_MAX) {
 		if (fixed_counter_disabled(idx, cpuc->pmu))
 			continue;
-		rdmsrq(x86_pmu_fixed_ctr_addr(idx), pmc_count);
+		pmc_count = msr_read(x86_pmu_fixed_ctr_addr(idx));
 
 		pr_info("CPU#%d: fixed-PMC%d count: %016llx\n",
 			cpu, idx, pmc_count);
@@ -2560,9 +2560,9 @@ void perf_clear_dirty_counters(void)
 			if (!test_bit(i - INTEL_PMC_IDX_FIXED, hybrid(cpuc->pmu, fixed_cntr_mask)))
 				continue;
 
-			wrmsrq(x86_pmu_fixed_ctr_addr(i - INTEL_PMC_IDX_FIXED), 0);
+			msr_write_noser(x86_pmu_fixed_ctr_addr(i - INTEL_PMC_IDX_FIXED), 0);
 		} else {
-			wrmsrq(x86_pmu_event_addr(i), 0);
+			msr_write_noser(x86_pmu_event_addr(i), 0);
 		}
 	}
 
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 76d6418c5055..09d5b2808727 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -158,7 +158,7 @@ static inline u64 msr_read_counter(struct perf_event *event)
 	u64 now;
 
 	if (event->hw.event_base)
-		rdmsrq(event->hw.event_base, now);
+		now = msr_read(event->hw.event_base);
 	else
 		now = rdtsc_ordered();
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fad87d3c8b2c..cce2e7b67c01 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1271,16 +1271,16 @@ static inline void __x86_pmu_enable_event(struct hw_perf_event *hwc,
 	u64 disable_mask = __this_cpu_read(cpu_hw_events.perf_ctr_virt_mask);
 
 	if (hwc->extra_reg.reg)
-		wrmsrq(hwc->extra_reg.reg, hwc->extra_reg.config);
+		msr_write_noser(hwc->extra_reg.reg, hwc->extra_reg.config);
 
 	/*
 	 * Add enabled Merge event on next counter
 	 * if large increment event being enabled on this counter
 	 */
 	if (is_counter_pair(hwc))
-		wrmsrq(x86_pmu_config_addr(hwc->idx + 1), x86_pmu.perf_ctr_pair_en);
+		msr_write_noser(x86_pmu_config_addr(hwc->idx + 1), x86_pmu.perf_ctr_pair_en);
 
-	wrmsrq(hwc->config_base, (hwc->config | enable_mask) & ~disable_mask);
+	msr_write_ser(hwc->config_base, (hwc->config | enable_mask) & ~disable_mask);
 }
 
 void x86_pmu_enable_all(int added);
@@ -1296,10 +1296,10 @@ static inline void x86_pmu_disable_event(struct perf_event *event)
 	u64 disable_mask = __this_cpu_read(cpu_hw_events.perf_ctr_virt_mask);
 	struct hw_perf_event *hwc = &event->hw;
 
-	wrmsrq(hwc->config_base, hwc->config & ~disable_mask);
+	msr_write_ser(hwc->config_base, hwc->config & ~disable_mask);
 
 	if (is_counter_pair(hwc))
-		wrmsrq(x86_pmu_config_addr(hwc->idx + 1), 0);
+		msr_write_ser(x86_pmu_config_addr(hwc->idx + 1), 0);
 }
 
 void x86_pmu_enable_event(struct perf_event *event);
@@ -1473,12 +1473,12 @@ static __always_inline void __amd_pmu_lbr_disable(void)
 {
 	u64 dbg_ctl, dbg_extn_cfg;
 
-	rdmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
-	wrmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
+	dbg_extn_cfg = msr_read(MSR_AMD_DBG_EXTN_CFG);
+	msr_write_ser(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
 
 	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
-		rdmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
-		wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+		dbg_ctl = msr_read(MSR_IA32_DEBUGCTLMSR);
+		msr_write_ser(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
 	}
 }
 
@@ -1619,21 +1619,21 @@ static inline bool intel_pmu_has_bts(struct perf_event *event)
 
 static __always_inline void __intel_pmu_pebs_disable_all(void)
 {
-	wrmsrq(MSR_IA32_PEBS_ENABLE, 0);
+	msr_write_ser(MSR_IA32_PEBS_ENABLE, 0);
 }
 
 static __always_inline void __intel_pmu_arch_lbr_disable(void)
 {
-	wrmsrq(MSR_ARCH_LBR_CTL, 0);
+	msr_write_ser(MSR_ARCH_LBR_CTL, 0);
 }
 
 static __always_inline void __intel_pmu_lbr_disable(void)
 {
 	u64 debugctl;
 
-	rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
+	debugctl = msr_read(MSR_IA32_DEBUGCTLMSR);
 	debugctl &= ~(DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
-	wrmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
+	msr_write_ser(MSR_IA32_DEBUGCTLMSR, debugctl);
 }
 
 int intel_pmu_save_and_restart(struct perf_event *event);
diff --git a/arch/x86/events/probe.c b/arch/x86/events/probe.c
index bb719d0d3f0b..85d591fab26c 100644
--- a/arch/x86/events/probe.c
+++ b/arch/x86/events/probe.c
@@ -45,7 +45,7 @@ perf_msr_probe(struct perf_msr *msr, int cnt, bool zero, void *data)
 			if (msr[bit].test && !msr[bit].test(bit, data))
 				continue;
 			/* Virt sucks; you cannot tell if a R/O MSR is present :/ */
-			if (rdmsrq_safe(msr[bit].msr, &val))
+			if (msr_read_safe(msr[bit].msr, &val))
 				continue;
 
 			mask = msr[bit].mask;
diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 8ed03c32f560..bb9ecf78fd90 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -193,7 +193,7 @@ static inline unsigned int get_rapl_pmu_idx(int cpu, int scope)
 static inline u64 rapl_read_counter(struct perf_event *event)
 {
 	u64 raw;
-	rdmsrq(event->hw.event_base, raw);
+	raw = msr_read(event->hw.event_base);
 	return raw;
 }
 
@@ -222,7 +222,7 @@ static u64 rapl_event_update(struct perf_event *event)
 
 	prev_raw_count = local64_read(&hwc->prev_count);
 	do {
-		rdmsrq(event->hw.event_base, new_raw_count);
+		new_raw_count = msr_read(event->hw.event_base);
 	} while (!local64_try_cmpxchg(&hwc->prev_count,
 				      &prev_raw_count, new_raw_count));
 
@@ -611,8 +611,8 @@ static int rapl_check_hw_unit(void)
 	u64 msr_rapl_power_unit_bits;
 	int i;
 
-	/* protect rdmsrq() to handle virtualization */
-	if (rdmsrq_safe(rapl_model->msr_power_unit, &msr_rapl_power_unit_bits))
+	/* protect msr_read() to handle virtualization */
+	if (msr_read_safe(rapl_model->msr_power_unit, &msr_rapl_power_unit_bits))
 		return -1;
 	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++)
 		rapl_pkg_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
-- 
2.53.0

