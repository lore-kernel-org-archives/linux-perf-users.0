Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD1E1C37AF;
	Tue,  6 Aug 2024 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722943988; cv=none; b=CfhlLQ+O/a8SAbDUGPuok+o8gbISBiowa7bTnxjpCY3ITo1+/vgoNvNutD/FLOYAv8mceSir2w60k7s1H6RvwBquiFAnAsNgtkhbMqHRk5PupLITyhne3RSK23Yktks8F++Gahb2cd+vOtWXU9YxVJkyS23bF6T6S3hKK2THoUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722943988; c=relaxed/simple;
	bh=OFD62wRB2zpm+RyrKFUiRca+gNeuDFf1kvCDZr1PDp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9BLmjnZIAvKRNoilSz34o/PEUzWstepshowZrSP1Ki6f4oJ22INAU5jVDFxGjn9M53sJ1C5I1xMiBf3ptUQT8rHBFlT/SBkkIY0QJu+6cQHWEME2I5mfxLy493Usy8ia+K0JSf4Zjz04PeNw70fscgne9GgTYn9fFcQS37fPv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IJ74lPpM; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IJ74lPpM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z6VG0JIpbLxI2trJ9q3LgWi7re73WaxG/xk3UlirF7E=; b=IJ74lPpMfMDm/linc30hotKtLK
	dIS2x6jAzO+Na/m/MzxL3q5NCLzbkUZDibtzlPfsqXKQoRHLqA+OYR6cc3KsV4STcBtL1PlNlHyDa
	UpAk0DRXyW0gjnB07z/EBelacRsrzRvtJEeyD/z5NDQa82bXV7Um8JPB7QLL5AgLkJMx6wfI7NE4S
	DPupxjkt9Mpo75hf/+fKpUidBvFQZJUUeeH0MJfDqyo6rdBmQETnRTJy7eX4+i8yiCzidpN6O8NE7
	nv1p+zf35xLz3TyRCkNa4SkWBZh8MosvzvWB/j6JDTbqU0vv/XZo4eUMjdXcjeGkfzsyy8Lw3RlRU
	/W/9KVQw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbIQx-00000005dfz-0Xi0;
	Tue, 06 Aug 2024 11:32:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3AD3530047C; Tue,  6 Aug 2024 13:32:54 +0200 (CEST)
Date: Tue, 6 Aug 2024 13:32:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] perf: Avoid -Wflex-array-member-not-at-end warnings
Message-ID: <20240806113254.GG12673@noisy.programming.kicks-ass.net>
References: <ZrFVW+6OOJ2tX23N@cute>
 <20240806105941.GV37996@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806105941.GV37996@noisy.programming.kicks-ass.net>

On Tue, Aug 06, 2024 at 12:59:41PM +0200, Peter Zijlstra wrote:
> On Mon, Aug 05, 2024 at 04:42:35PM -0600, Gustavo A. R. Silva wrote:
> > -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> > getting ready to enable it, globally.
> > 
> > So, in order to avoid ending up with a flexible-array member in the
> > middle of multiple other structs, we use the `struct_group_tagged()`
> > helper to create a new tagged `struct perf_branch_stack_hdr`.
> > This structure groups together all the members of the flexible
> > `struct perf_branch_stack` except the flexible array.
> > 
> > As a result, the array is effectively separated from the rest of the
> > members without modifying the memory layout of the flexible structure.
> > We then change the type of the middle struct members currently causing
> > trouble from `struct perf_branch_stack` to `struct perf_branch_stack_hdr`.
> > 
> > We also want to ensure that when new members need to be added to the
> > flexible structure, they are always included within the newly created
> > tagged struct. For this, we use `static_assert()`. This ensures that the
> > memory layout for both the flexible structure and the new tagged struct
> > is the same after any changes.
> > 
> > This approach avoids having to implement `struct perf_branch_stack_hdr`
> > as a completely separate structure, thus preventing having to maintain
> > two independent but basically identical structures, closing the door
> > to potential bugs in the future.
> > 
> > We also use `container_of()` whenever we need to retrieve a pointer to
> > the flexible structure, through which the flexible-array member can be
> > accessed, if necessary.
> > 
> > So, with these changes, fix the following warnings:
> > arch/x86/events/amd/../perf_event.h:289:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > arch/x86/events/intel/../perf_event.h:289:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > arch/x86/events/perf_event.h:289:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > arch/x86/events/zhaoxin/../perf_event.h:289:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > ./arch/x86/include/generated/../../events/perf_event.h:289:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > arch/x86/xen/../events/perf_event.h:289:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Urgh, this fugly.. And you're breaking coding style :-(
> 
> Let me see if this can't be done sanely...

This seems to build...

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 920e3a640cad..9477dfd34e07 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1001,7 +1001,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 			continue;
 
 		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
+			perf_sample_save_brstack(&data, event, cpu_lbr_stack(cpuc), NULL);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 19c7b76e21bc..2a7a8673ed17 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -107,7 +107,7 @@ static void amd_pmu_lbr_filter(void)
 	    ((br_sel & X86_BR_TYPE_SAVE) != X86_BR_TYPE_SAVE))
 		fused_only = true;
 
-	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
+	for (i = 0; i < cpu_lbr_stack(cpuc)->nr; i++) {
 		from = cpuc->lbr_entries[i].from;
 		to = cpuc->lbr_entries[i].to;
 		type = branch_type_fused(from, to, 0, &offset);
@@ -137,12 +137,12 @@ static void amd_pmu_lbr_filter(void)
 		return;
 
 	/* Remove all invalid entries */
-	for (i = 0; i < cpuc->lbr_stack.nr; ) {
+	for (i = 0; i < cpu_lbr_stack(cpuc)->nr; ) {
 		if (!cpuc->lbr_entries[i].from) {
 			j = i;
-			while (++j < cpuc->lbr_stack.nr)
+			while (++j < cpu_lbr_stack(cpuc)->nr)
 				cpuc->lbr_entries[j - 1] = cpuc->lbr_entries[j];
-			cpuc->lbr_stack.nr--;
+			cpu_lbr_stack(cpuc)->nr--;
 			if (!cpuc->lbr_entries[i].from)
 				continue;
 		}
@@ -208,13 +208,13 @@ void amd_pmu_lbr_read(void)
 		out++;
 	}
 
-	cpuc->lbr_stack.nr = out;
+	cpu_lbr_stack(cpuc)->nr = out;
 
 	/*
 	 * Internal register renaming always ensures that LBR From[0] and
 	 * LBR To[0] always represent the TOS
 	 */
-	cpuc->lbr_stack.hw_idx = 0;
+	cpu_lbr_stack(cpuc)->hw_idx = 0;
 
 	/* Perform further software filtering */
 	amd_pmu_lbr_filter();
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index be01823b1bb4..6054d209bcd1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1706,7 +1706,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 		perf_sample_data_init(&data, 0, event->hw.last_period);
 
 		if (has_branch_stack(event))
-			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
+			perf_sample_save_brstack(&data, event, cpu_lbr_stack(cpuc), NULL);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index fa5ea65de0d0..f4d5efb52d9b 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1573,7 +1573,7 @@ static int intel_pmu_pebs_fixup_ip(struct pt_regs *regs)
 	/*
 	 * No LBR entry, no basic block, no rewinding
 	 */
-	if (!cpuc->lbr_stack.nr || !from || !to)
+	if (!cpu_lbr_stack(cpuc)->nr || !from || !to)
 		return 0;
 
 	/*
@@ -1869,7 +1869,7 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 		setup_pebs_time(event, data, pebs->tsc);
 
 	if (has_branch_stack(event))
-		perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
+		perf_sample_save_brstack(data, event, cpu_lbr_stack(cpuc), NULL);
 }
 
 static void adaptive_pebs_save_regs(struct pt_regs *regs,
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index dc641b50814e..1e9c4f114720 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -751,8 +751,8 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 		br->to		= msr_lastbranch.to;
 		br++;
 	}
-	cpuc->lbr_stack.nr = i;
-	cpuc->lbr_stack.hw_idx = tos;
+	cpu_lbr_stack(cpuc)->nr = i;
+	cpu_lbr_stack(cpuc)->hw_idx = tos;
 }
 
 /*
@@ -846,8 +846,8 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		br[out].cycles	 = cycles;
 		out++;
 	}
-	cpuc->lbr_stack.nr = out;
-	cpuc->lbr_stack.hw_idx = tos;
+	cpu_lbr_stack(cpuc)->nr = out;
+	cpu_lbr_stack(cpuc)->hw_idx = tos;
 }
 
 static DEFINE_STATIC_KEY_FALSE(x86_lbr_mispred);
@@ -930,7 +930,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		e->reserved	= (info >> LBR_INFO_BR_CNTR_OFFSET) & LBR_INFO_BR_CNTR_FULL_MASK;
 	}
 
-	cpuc->lbr_stack.nr = i;
+	cpu_lbr_stack(cpuc)->nr = i;
 }
 
 /*
@@ -956,7 +956,7 @@ static void intel_pmu_lbr_counters_reorder(struct cpu_hw_events *cpuc,
 
 	WARN_ON_ONCE(!pos);
 
-	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
+	for (i = 0; i < cpu_lbr_stack(cpuc)->nr; i++) {
 		src = cpuc->lbr_entries[i].reserved;
 		dst = 0;
 		for (j = 0; j < pos; j++) {
@@ -974,11 +974,11 @@ void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 {
 	if (is_branch_counters_group(event)) {
 		intel_pmu_lbr_counters_reorder(cpuc, event);
-		perf_sample_save_brstack(data, event, &cpuc->lbr_stack, cpuc->lbr_counters);
+		perf_sample_save_brstack(data, event, cpu_lbr_stack(cpuc), cpuc->lbr_counters);
 		return;
 	}
 
-	perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
+	perf_sample_save_brstack(data, event, cpu_lbr_stack(cpuc), NULL);
 }
 
 static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc)
@@ -1210,7 +1210,7 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 	    ((br_sel & X86_BR_TYPE_SAVE) != X86_BR_TYPE_SAVE))
 		return;
 
-	for (i = 0; i < cpuc->lbr_stack.nr; i++) {
+	for (i = 0; i < cpu_lbr_stack(cpuc)->nr; i++) {
 
 		from = cpuc->lbr_entries[i].from;
 		to = cpuc->lbr_entries[i].to;
@@ -1248,14 +1248,14 @@ intel_pmu_lbr_filter(struct cpu_hw_events *cpuc)
 		return;
 
 	/* remove all entries with from=0 */
-	for (i = 0; i < cpuc->lbr_stack.nr; ) {
+	for (i = 0; i < cpu_lbr_stack(cpuc)->nr; ) {
 		if (!cpuc->lbr_entries[i].from) {
 			j = i;
-			while (++j < cpuc->lbr_stack.nr) {
+			while (++j < cpu_lbr_stack(cpuc)->nr) {
 				cpuc->lbr_entries[j-1] = cpuc->lbr_entries[j];
 				cpuc->lbr_counters[j-1] = cpuc->lbr_counters[j];
 			}
-			cpuc->lbr_stack.nr--;
+			cpu_lbr_stack(cpuc)->nr--;
 			if (!cpuc->lbr_entries[i].from)
 				continue;
 		}
@@ -1270,9 +1270,9 @@ void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr)
 	/* Cannot get TOS for large PEBS and Arch LBR */
 	if (static_cpu_has(X86_FEATURE_ARCH_LBR) ||
 	    (cpuc->n_pebs == cpuc->n_large_pebs))
-		cpuc->lbr_stack.hw_idx = -1ULL;
+		cpu_lbr_stack(cpuc)->hw_idx = -1ULL;
 	else
-		cpuc->lbr_stack.hw_idx = intel_pmu_lbr_tos();
+		cpu_lbr_stack(cpuc)->hw_idx = intel_pmu_lbr_tos();
 
 	intel_pmu_store_lbr(cpuc, lbr);
 	intel_pmu_lbr_filter(cpuc);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ac1182141bf6..0daab579264f 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -286,7 +286,7 @@ struct cpu_hw_events {
 	 */
 	int				lbr_users;
 	int				lbr_pebs_users;
-	struct perf_branch_stack	lbr_stack;
+	u64				lbr_hdr[sizeof(struct perf_branch_stack)/sizeof(u64)];
 	struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
 	u64				lbr_counters[MAX_LBR_ENTRIES]; /* branch stack extra */
 	union {
@@ -349,6 +349,11 @@ struct cpu_hw_events {
 	struct pmu			*pmu;
 };
 
+static __always_inline struct perf_branch_stack *cpu_lbr_stack(struct cpu_hw_events *cpuc)
+{
+	return (void *)&cpuc->lbr_hdr;
+}
+
 #define __EVENT_CONSTRAINT_RANGE(c, e, n, m, w, o, f) {	\
 	{ .idxmsk64 = (n) },		\
 	.code = (c),			\
