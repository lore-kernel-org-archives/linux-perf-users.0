Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F16A4266AE
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777372989; cv=none; b=WHLAdUP4w6VZAoa3JByYKF7Lxuk5OQHAkk4XnNSA8KkYWyTe6gJV44KtD2hJ/UVAFvVvWH+872qo4S9E1Xnop+N6fnU/BQR3KlnXYeptPMGdsg6RGLyf0otSjrYvorg13RYjVbCZGgwIUAuz3Plha+ReeHMRZAiuHVrow/u7zW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777372989; c=relaxed/simple;
	bh=WByTLPqc9b271QTzPgHdHQnJ14RNCgIfFszRx+wkw4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nc8iI+IN7L1Vi/xSRkxBCA5B41kTM1VnJumCWN95l+3sG8KyHqOkij4X9hYjkJGfI/0/Rg5ZiJVCNePhA6UPlcC9ld6AB1/Nrgbazvl1qQ009MdWaRTu1d2cDh1t0sxoOAJxZC4TQcaUvepL0E/qb5x1C7H2vaMMiRMqMErZ3rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uf/TbnW9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=uf/TbnW9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uf/TbnW9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="uf/TbnW9"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 912476A823;
	Tue, 28 Apr 2026 10:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1777372985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAJgwAvsmLE1WxhQCdFr1BDK13BpJhKkMZaeH5miMEQ=;
	b=uf/TbnW9yP2kASzFViPAzVdDh1dUW0BoZhTg2DV/8P6NoT7xme4zZEUDj5VoFxs8E5B7wH
	MLEptOTuKQ2YQLRm7Oft3ktVetu+/cqJQtE7Z+xjIHPd8ANSUAVTSfX66tFRSeUS1+jSTu
	UXu/HyxbBTbaHwDRxoVUCsmjN2FIl8g=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="uf/TbnW9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1777372985; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAJgwAvsmLE1WxhQCdFr1BDK13BpJhKkMZaeH5miMEQ=;
	b=uf/TbnW9yP2kASzFViPAzVdDh1dUW0BoZhTg2DV/8P6NoT7xme4zZEUDj5VoFxs8E5B7wH
	MLEptOTuKQ2YQLRm7Oft3ktVetu+/cqJQtE7Z+xjIHPd8ANSUAVTSfX66tFRSeUS1+jSTu
	UXu/HyxbBTbaHwDRxoVUCsmjN2FIl8g=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31F39593B0;
	Tue, 28 Apr 2026 10:43:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id e2McCzmP8Gm6PgAAD6G6ig
	(envelope-from <jgross@suse.com>); Tue, 28 Apr 2026 10:43:05 +0000
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
Subject: [PATCH RFC 10/11] x86/events: Switch core parts to use 64-bit rdmsr/wrmsr() variants
Date: Tue, 28 Apr 2026 12:42:04 +0200
Message-ID: <20260428104205.916924-11-jgross@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428104205.916924-1-jgross@suse.com>
References: <20260428104205.916924-1-jgross@suse.com>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLkdkdrsxe9hqhhs5ask8616i6)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:dkim,suse.com:mid,suse.com:email]
X-Rspamd-Queue-Id: 912476A823
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Switch the core parts of the x86 events subsystem to use the new
64-bit forms of rdmsr(), rdmasr_safe(), wrmsr() and wrmsr_safe().

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/events/core.c       | 42 ++++++++++++++++++------------------
 arch/x86/events/msr.c        |  2 +-
 arch/x86/events/perf_event.h | 26 +++++++++++-----------
 arch/x86/events/probe.c      |  2 +-
 arch/x86/events/rapl.c       |  8 +++----
 5 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 810ab21ffd99..dc75b9537ab5 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -279,7 +279,7 @@ bool check_hw_exists(struct pmu *pmu, unsigned long *cntr_mask,
 	 */
 	for_each_set_bit(i, cntr_mask, X86_PMC_IDX_MAX) {
 		reg = x86_pmu_config_addr(i);
-		ret = rdmsrq_safe(reg, &val);
+		ret = rdmsr_safe(reg, &val);
 		if (ret)
 			goto msr_fail;
 		if (val & ARCH_PERFMON_EVENTSEL_ENABLE) {
@@ -293,7 +293,7 @@ bool check_hw_exists(struct pmu *pmu, unsigned long *cntr_mask,
 
 	if (*(u64 *)fixed_cntr_mask) {
 		reg = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
-		ret = rdmsrq_safe(reg, &val);
+		ret = rdmsr_safe(reg, &val);
 		if (ret)
 			goto msr_fail;
 		for_each_set_bit(i, fixed_cntr_mask, X86_PMC_IDX_MAX) {
@@ -324,11 +324,11 @@ bool check_hw_exists(struct pmu *pmu, unsigned long *cntr_mask,
 	 * (qemu/kvm) that don't trap on the MSR access and always return 0s.
 	 */
 	reg = x86_pmu_event_addr(reg_safe);
-	if (rdmsrq_safe(reg, &val))
+	if (rdmsr_safe(reg, &val))
 		goto msr_fail;
 	val ^= 0xffffUL;
-	ret = wrmsrq_safe(reg, val);
-	ret |= rdmsrq_safe(reg, &val_new);
+	ret = wrmsr_safe(reg, val);
+	ret |= rdmsr_safe(reg, &val_new);
 	if (ret || val != val_new)
 		goto msr_fail;
 
@@ -713,13 +713,13 @@ void x86_pmu_disable_all(void)
 
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
-		rdmsrq(x86_pmu_config_addr(idx), val);
+		val = rdmsr(x86_pmu_config_addr(idx));
 		if (!(val & ARCH_PERFMON_EVENTSEL_ENABLE))
 			continue;
 		val &= ~ARCH_PERFMON_EVENTSEL_ENABLE;
-		wrmsrq(x86_pmu_config_addr(idx), val);
+		wrmsr(x86_pmu_config_addr(idx), val);
 		if (is_counter_pair(hwc))
-			wrmsrq(x86_pmu_config_addr(idx + 1), 0);
+			wrmsr(x86_pmu_config_addr(idx + 1), 0);
 	}
 }
 
@@ -1446,14 +1446,14 @@ int x86_perf_event_set_period(struct perf_event *event)
 	 */
 	local64_set(&hwc->prev_count, (u64)-left);
 
-	wrmsrq(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
+	wrmsr(hwc->event_base, (u64)(-left) & x86_pmu.cntval_mask);
 
 	/*
 	 * Sign extend the Merge event counter's upper 16 bits since
 	 * we currently declare a 48-bit counter width
 	 */
 	if (is_counter_pair(hwc))
-		wrmsrq(x86_pmu_event_addr(idx + 1), 0xffff);
+		wrmsr(x86_pmu_event_addr(idx + 1), 0xffff);
 
 	perf_event_update_userpage(event);
 
@@ -1575,10 +1575,10 @@ void perf_event_print_debug(void)
 		return;
 
 	if (x86_pmu.version >= 2) {
-		rdmsrq(MSR_CORE_PERF_GLOBAL_CTRL, ctrl);
-		rdmsrq(MSR_CORE_PERF_GLOBAL_STATUS, status);
-		rdmsrq(MSR_CORE_PERF_GLOBAL_OVF_CTRL, overflow);
-		rdmsrq(MSR_ARCH_PERFMON_FIXED_CTR_CTRL, fixed);
+		ctrl = rdmsr(MSR_CORE_PERF_GLOBAL_CTRL);
+		status = rdmsr(MSR_CORE_PERF_GLOBAL_STATUS);
+		overflow = rdmsr(MSR_CORE_PERF_GLOBAL_OVF_CTRL);
+		fixed = rdmsr(MSR_ARCH_PERFMON_FIXED_CTR_CTRL);
 
 		pr_info("\n");
 		pr_info("CPU#%d: ctrl:       %016llx\n", cpu, ctrl);
@@ -1586,19 +1586,19 @@ void perf_event_print_debug(void)
 		pr_info("CPU#%d: overflow:   %016llx\n", cpu, overflow);
 		pr_info("CPU#%d: fixed:      %016llx\n", cpu, fixed);
 		if (pebs_constraints) {
-			rdmsrq(MSR_IA32_PEBS_ENABLE, pebs);
+			pebs = rdmsr(MSR_IA32_PEBS_ENABLE);
 			pr_info("CPU#%d: pebs:       %016llx\n", cpu, pebs);
 		}
 		if (x86_pmu.lbr_nr) {
-			rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
+			debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
 			pr_info("CPU#%d: debugctl:   %016llx\n", cpu, debugctl);
 		}
 	}
 	pr_info("CPU#%d: active:     %016llx\n", cpu, *(u64 *)cpuc->active_mask);
 
 	for_each_set_bit(idx, cntr_mask, X86_PMC_IDX_MAX) {
-		rdmsrq(x86_pmu_config_addr(idx), pmc_ctrl);
-		rdmsrq(x86_pmu_event_addr(idx), pmc_count);
+		pmc_ctrl = rdmsr(x86_pmu_config_addr(idx));
+		pmc_count = rdmsr(x86_pmu_event_addr(idx));
 
 		prev_left = per_cpu(pmc_prev_left[idx], cpu);
 
@@ -1612,7 +1612,7 @@ void perf_event_print_debug(void)
 	for_each_set_bit(idx, fixed_cntr_mask, X86_PMC_IDX_MAX) {
 		if (fixed_counter_disabled(idx, cpuc->pmu))
 			continue;
-		rdmsrq(x86_pmu_fixed_ctr_addr(idx), pmc_count);
+		pmc_count = rdmsr(x86_pmu_fixed_ctr_addr(idx));
 
 		pr_info("CPU#%d: fixed-PMC%d count: %016llx\n",
 			cpu, idx, pmc_count);
@@ -2560,9 +2560,9 @@ void perf_clear_dirty_counters(void)
 			if (!test_bit(i - INTEL_PMC_IDX_FIXED, hybrid(cpuc->pmu, fixed_cntr_mask)))
 				continue;
 
-			wrmsrq(x86_pmu_fixed_ctr_addr(i - INTEL_PMC_IDX_FIXED), 0);
+			wrmsr(x86_pmu_fixed_ctr_addr(i - INTEL_PMC_IDX_FIXED), 0);
 		} else {
-			wrmsrq(x86_pmu_event_addr(i), 0);
+			wrmsr(x86_pmu_event_addr(i), 0);
 		}
 	}
 
diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 76d6418c5055..476069924e6b 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -158,7 +158,7 @@ static inline u64 msr_read_counter(struct perf_event *event)
 	u64 now;
 
 	if (event->hw.event_base)
-		rdmsrq(event->hw.event_base, now);
+		now = rdmsr(event->hw.event_base);
 	else
 		now = rdtsc_ordered();
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fad87d3c8b2c..e5f189c91f82 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1271,16 +1271,16 @@ static inline void __x86_pmu_enable_event(struct hw_perf_event *hwc,
 	u64 disable_mask = __this_cpu_read(cpu_hw_events.perf_ctr_virt_mask);
 
 	if (hwc->extra_reg.reg)
-		wrmsrq(hwc->extra_reg.reg, hwc->extra_reg.config);
+		wrmsr(hwc->extra_reg.reg, hwc->extra_reg.config);
 
 	/*
 	 * Add enabled Merge event on next counter
 	 * if large increment event being enabled on this counter
 	 */
 	if (is_counter_pair(hwc))
-		wrmsrq(x86_pmu_config_addr(hwc->idx + 1), x86_pmu.perf_ctr_pair_en);
+		wrmsr(x86_pmu_config_addr(hwc->idx + 1), x86_pmu.perf_ctr_pair_en);
 
-	wrmsrq(hwc->config_base, (hwc->config | enable_mask) & ~disable_mask);
+	wrmsr(hwc->config_base, (hwc->config | enable_mask) & ~disable_mask);
 }
 
 void x86_pmu_enable_all(int added);
@@ -1296,10 +1296,10 @@ static inline void x86_pmu_disable_event(struct perf_event *event)
 	u64 disable_mask = __this_cpu_read(cpu_hw_events.perf_ctr_virt_mask);
 	struct hw_perf_event *hwc = &event->hw;
 
-	wrmsrq(hwc->config_base, hwc->config & ~disable_mask);
+	wrmsr(hwc->config_base, hwc->config & ~disable_mask);
 
 	if (is_counter_pair(hwc))
-		wrmsrq(x86_pmu_config_addr(hwc->idx + 1), 0);
+		wrmsr(x86_pmu_config_addr(hwc->idx + 1), 0);
 }
 
 void x86_pmu_enable_event(struct perf_event *event);
@@ -1473,12 +1473,12 @@ static __always_inline void __amd_pmu_lbr_disable(void)
 {
 	u64 dbg_ctl, dbg_extn_cfg;
 
-	rdmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
-	wrmsrq(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
+	dbg_extn_cfg = rdmsr(MSR_AMD_DBG_EXTN_CFG);
+	wrmsr(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
 
 	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
-		rdmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
-		wrmsrq(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+		dbg_ctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
+		wrmsr(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
 	}
 }
 
@@ -1619,21 +1619,21 @@ static inline bool intel_pmu_has_bts(struct perf_event *event)
 
 static __always_inline void __intel_pmu_pebs_disable_all(void)
 {
-	wrmsrq(MSR_IA32_PEBS_ENABLE, 0);
+	wrmsr(MSR_IA32_PEBS_ENABLE, 0);
 }
 
 static __always_inline void __intel_pmu_arch_lbr_disable(void)
 {
-	wrmsrq(MSR_ARCH_LBR_CTL, 0);
+	wrmsr(MSR_ARCH_LBR_CTL, 0);
 }
 
 static __always_inline void __intel_pmu_lbr_disable(void)
 {
 	u64 debugctl;
 
-	rdmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
+	debugctl = rdmsr(MSR_IA32_DEBUGCTLMSR);
 	debugctl &= ~(DEBUGCTLMSR_LBR | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
-	wrmsrq(MSR_IA32_DEBUGCTLMSR, debugctl);
+	wrmsr(MSR_IA32_DEBUGCTLMSR, debugctl);
 }
 
 int intel_pmu_save_and_restart(struct perf_event *event);
diff --git a/arch/x86/events/probe.c b/arch/x86/events/probe.c
index bb719d0d3f0b..ac53bb5ba869 100644
--- a/arch/x86/events/probe.c
+++ b/arch/x86/events/probe.c
@@ -45,7 +45,7 @@ perf_msr_probe(struct perf_msr *msr, int cnt, bool zero, void *data)
 			if (msr[bit].test && !msr[bit].test(bit, data))
 				continue;
 			/* Virt sucks; you cannot tell if a R/O MSR is present :/ */
-			if (rdmsrq_safe(msr[bit].msr, &val))
+			if (rdmsr_safe(msr[bit].msr, &val))
 				continue;
 
 			mask = msr[bit].mask;
diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 8ed03c32f560..4ac91ed65fde 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -193,7 +193,7 @@ static inline unsigned int get_rapl_pmu_idx(int cpu, int scope)
 static inline u64 rapl_read_counter(struct perf_event *event)
 {
 	u64 raw;
-	rdmsrq(event->hw.event_base, raw);
+	raw = rdmsr(event->hw.event_base);
 	return raw;
 }
 
@@ -222,7 +222,7 @@ static u64 rapl_event_update(struct perf_event *event)
 
 	prev_raw_count = local64_read(&hwc->prev_count);
 	do {
-		rdmsrq(event->hw.event_base, new_raw_count);
+		new_raw_count = rdmsr(event->hw.event_base);
 	} while (!local64_try_cmpxchg(&hwc->prev_count,
 				      &prev_raw_count, new_raw_count));
 
@@ -611,8 +611,8 @@ static int rapl_check_hw_unit(void)
 	u64 msr_rapl_power_unit_bits;
 	int i;
 
-	/* protect rdmsrq() to handle virtualization */
-	if (rdmsrq_safe(rapl_model->msr_power_unit, &msr_rapl_power_unit_bits))
+	/* protect rdmsr() to handle virtualization */
+	if (rdmsr_safe(rapl_model->msr_power_unit, &msr_rapl_power_unit_bits))
 		return -1;
 	for (i = 0; i < NR_RAPL_PKG_DOMAINS; i++)
 		rapl_pkg_hw_unit[i] = (msr_rapl_power_unit_bits >> 8) & 0x1FULL;
-- 
2.53.0

