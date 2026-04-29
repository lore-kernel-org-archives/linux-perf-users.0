Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AA72580CF
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486335; cv=none; b=cLyyILuVrm5lMoVa0XjsrSVYRAFjkMFGdt5IceCa2tWxMF+eNE9poQgQleHmRbOPNq6SfgwFk4YCzvG9699aIvDIfO6hJYfwQ5oXgf/8MxZpgrmnbg5q7XdjqV4jrKfasItJq4h+ff6BaFVyApoHY/xGjwUw/+9P74qv11UlO/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486335; c=relaxed/simple;
	bh=iUDtWJ9GZFgc8/2/kgSqLcPy8fgN1HhdljG4tGQ0xXg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j8WjUF2bL1sgCC8QhH+bSwMPiqmvoY8ZbHu7NRGYXcylpldBBsxUJ/hjnKHVV4KxFCyRq+UFdy3WjkDZNvwpehzPJ8MMwQO5SPcVZPWsRCHwk3VmVqITxzdxVEzNCnXMevG/9LQRXrXuT1skye8V2XNOjQwQCbcvZWdg8Segjv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aL5dM99h; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aL5dM99h"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12c21dbc9c1so318297c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 11:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777486333; x=1778091133; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CC+WVhu74Qgg75vUJAa5DPRZl7RZuRZuq+lVZf+PXJw=;
        b=aL5dM99hYzyO7EUBfGFJuqNNRXnMYqBbmGa+i8eCosVzJedSss/ELefolz2YZR+fB2
         xcve/P90HOtxsYy1Fk9DRnFOWN+zscGVcnWZKtf5wPimpSwxqqUUqmcyLl7105DSxMhX
         CZe+gmbT9FgdOFJUzsjwrkjAGCNZ7+7qSQyYT0ApFrdFcZHzSUJF+WjMaOG+mpxk0Evq
         rvWoE1aR55sFMG8JBc2FpSwl2tPjuIAMu2K2gREdxO2gDDDeaK0qfO5RIrIJhhM5MK2h
         tS5qA9HswpsAzy47DFWlETtj1GU+WdRfiyQ8/QeQaF1xTGsZHWDcxdmn63rcI+SEBdHj
         oV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777486333; x=1778091133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CC+WVhu74Qgg75vUJAa5DPRZl7RZuRZuq+lVZf+PXJw=;
        b=kPFRDzmud9zD+XlK+JvTpLngG4V6P9YW+0uZHXVgfZhd4aJi/xl8XdJ4BaRKup23sF
         vaUGXc+EC6XAECjWMXyOfI6ImA/OmEjSk9l7fmSLGl3bu56Ylsq5LUwNAm44f5+7ayl7
         GyjwKejJOYBu2nX0tm91+YHanbIj2rNAmvrEUzAjr74v9rLcvmHocK4b5SKzrNvyDdZH
         N+02dfaFcbOtOeCmKBH6WmU8jna9eUnJyYpUnZ3pwDcoIagQFtdXaeozrrw+F0S7UOSE
         cM8SUhDq1pGVYhPcQOHonDh97q9Y31X09F9fjewnJxKd9D4+zPx7SWydSneHC7S/juCb
         cMXQ==
X-Forwarded-Encrypted: i=1; AFNElJ9jRMKPgM1DhGr/hQ/oZCIpC+zttmD/QWy/lduRIKSVq0LNP29ler+T6hJY2LhKj0qQaDm6PaI+B83K1GKylbb1@vger.kernel.org
X-Gm-Message-State: AOJu0YxTUyvb7dJWX8V3U9aN4phmk7pMO7yxjunli5wFguxKh6CvK+LF
	GZr9rfcTd30C6RKt/p9+k3Y0YHyLilcI9DjtscKMSAhm61VvWGuKiYE1ASAuk8R95Dxv6V/Kh6v
	CLbrWe2duLg==
X-Received: from dlad13.prod.google.com ([2002:a05:701b:220d:b0:12c:34da:e06e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:418e:b0:123:34e8:aec2
 with SMTP id a92af1059eb24-12de29f9b90mr2122644c88.1.1777486332662; Wed, 29
 Apr 2026 11:12:12 -0700 (PDT)
Date: Wed, 29 Apr 2026 11:11:36 -0700
In-Reply-To: <20260429181136.2712655-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428070328.1880314-1-irogers@google.com> <20260429181136.2712655-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260429181136.2712655-3-irogers@google.com>
Subject: [PATCH v2 2/2] perf inject: Fix itrace branch stack synthesis
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	namhyung@kernel.org, thomas.falcon@intel.com
Cc: james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

When using "perf inject --itrace=L" to synthesize branch stacks from
AUX data, several issues caused failures with the generated file:

1. The synthesized samples were delivered without the
   PERF_SAMPLE_BRANCH_STACK flag if it was not in the original event's
   sample_type. Fixed by using sample_type | evsel->synth_sample_type
   in intel_pt_do_synth_pebs_sample.

2. Modifying evsel->core.attr.sample_type early in __cmd_inject caused
   parse failures for subsequent records in the input file. Fixed by
   moving this modification to just before writing the header.

3. perf_event__repipe_sample was narrowed to only synthesize samples
   when branch stack injection was requested, and restored the use of
   perf_inject__cut_auxtrace_sample as a fallback to preserve
   functionality.

4. Potential Heap Overflow in perf_event__repipe_sample: Addressed by
   adding a check that prints an error and returns -EFAULT if the
   calculated event size exceeds PERF_SAMPLE_MAX_SIZE.

5. Header vs Payload Mismatch in __cmd_inject: Addressed by narrowing
   the condition so that HEADER_BRANCH_STACK is only set in the file
   header if add_last_branch was true.

6. NULL Pointer Dereference in intel-pt.c: Addressed by updating the
   condition in intel_pt_do_synth_pebs_sample to fill sample.
   branch_stack if it was synthesized, even if not in the original
   sample_type.

7. Modifying event attributes in perf_event__repipe_attr early caused
   downstream parser breakage in pipe mode. Fixed by clearing
   PERF_SAMPLE_AUX when itrace_synth_opts.set is true to ensure the
   headers match the stripped payload. Also added a size check against
   struct perf_record_header_attr to prevent out-of-bounds writes.

8. Potential dangling pointer vulnerability in perf_event__repipe_sample:
   Addressed by restoring the original sample->branch_stack pointer
   before returning.

9. Off-by-one error in sample size check in perf_event__repipe_sample:
   Fixed by checking if sz >= PERF_SAMPLE_MAX_SIZE instead of >.

10. Unadvertised size field left in payload by cut_auxtrace_sample:
    Addressed by excluding the 8-byte size field from the copied
    payload to correctly match the cleared PERF_SAMPLE_AUX bit.

11. Silent data corruption in convert_sample_callchain: Addressed by
    restoring the error check for perf_event__synthesize_sample to
    prevent writing malformed or uninitialized memory.

12. Omission of hw_idx in PEBS synthesis: Fixed by passing the correct
    evsel->core.attr.branch_sample_type instead of 0 in intel-pt.c.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
v2:
- Fix error handling in callchain conversion by keeping the error check.
- Fix header advertise issues in pipe mode by clearing PERF_SAMPLE_AUX.
- Prevent out-of-bounds writes in attribute repiping with size checks.
- Fix sample payload misalignment by cutting the unadvertised AUX size field.
- Fix off-by-one check in sample size overflow to correctly use >=.
- Avoid dangling pointer vulnerability by restoring the branch_stack pointer.
- Pass evsel's branch_sample_type to synthesized samples to prevent hw_idx omission.
---
 tools/perf/builtin-inject.c | 97 ++++++++++++++++++++++++++++++++++---
 tools/perf/util/intel-pt.c  | 23 ++++++---
 2 files changed, 106 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 0c51cb4250d1..13fb1f05ceb2 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -223,6 +223,19 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
 						  tool);
 	int ret;
 
+	if (event->header.size < sizeof(struct perf_record_header_attr)) {
+		pr_err("Attribute event size %u is too small\n", event->header.size);
+		return -EINVAL;
+	}
+
+	if (inject->itrace_synth_opts.set)
+		event->attr.attr.sample_type &= ~PERF_SAMPLE_AUX;
+
+	if (inject->itrace_synth_opts.add_last_branch) {
+		event->attr.attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
+		event->attr.attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
+	}
+
 	ret = perf_event__process_attr(tool, event, pevlist);
 	if (ret)
 		return ret;
@@ -330,8 +343,8 @@ perf_inject__cut_auxtrace_sample(struct perf_inject *inject,
 				 union perf_event *event,
 				 struct perf_sample *sample)
 {
-	size_t sz1 = sample->aux_sample.data - (void *)event;
-	size_t sz2 = event->header.size - sample->aux_sample.size - sz1;
+	size_t sz1 = sample->aux_sample.data - (void *)event - sizeof(u64);
+	size_t sz2 = event->header.size - sample->aux_sample.size - (sz1 + sizeof(u64));
 	union perf_event *ev;
 
 	if (inject->event_copy == NULL) {
@@ -342,13 +355,12 @@ perf_inject__cut_auxtrace_sample(struct perf_inject *inject,
 	ev = (union perf_event *)inject->event_copy;
 	if (sz1 > event->header.size || sz2 > event->header.size ||
 	    sz1 + sz2 > event->header.size ||
-	    sz1 < sizeof(struct perf_event_header) + sizeof(u64))
+	    sz1 < sizeof(struct perf_event_header))
 		return event;
 
 	memcpy(ev, event, sz1);
 	memcpy((void *)ev + sz1, (void *)event + event->header.size - sz2, sz2);
 	ev->header.size = sz1 + sz2;
-	((u64 *)((void *)ev + sz1))[-1] = 0;
 
 	return ev;
 }
@@ -375,7 +387,63 @@ static int perf_event__repipe_sample(const struct perf_tool *tool,
 
 	build_id__mark_dso_hit(tool, event, sample, evsel, machine);
 
-	if (inject->itrace_synth_opts.set && sample->aux_sample.size) {
+	if (inject->itrace_synth_opts.set &&
+	    (inject->itrace_synth_opts.last_branch ||
+	     inject->itrace_synth_opts.add_last_branch)) {
+		union perf_event *event_copy = (void *)inject->event_copy;
+		struct branch_stack dummy_bs = { .nr = 0, .hw_idx = 0 };
+		int err;
+		size_t sz;
+		u64 orig_type = evsel->core.attr.sample_type;
+		u64 orig_branch_type = evsel->core.attr.branch_sample_type;
+
+		struct branch_stack *orig_bs = sample->branch_stack;
+
+		if (event_copy == NULL) {
+			inject->event_copy = malloc(PERF_SAMPLE_MAX_SIZE);
+			if (!inject->event_copy)
+				return -ENOMEM;
+
+			event_copy = (void *)inject->event_copy;
+		}
+
+		if (!sample->branch_stack)
+			sample->branch_stack = &dummy_bs;
+
+		if (inject->itrace_synth_opts.add_last_branch) {
+			/* Temporarily add in type bits for synthesis. */
+			evsel->core.attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
+			evsel->core.attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
+		}
+		evsel->core.attr.sample_type &= ~PERF_SAMPLE_AUX;
+
+		sz = perf_event__sample_event_size(sample, evsel->core.attr.sample_type,
+						   evsel->core.attr.read_format,
+						   evsel->core.attr.branch_sample_type);
+
+		if (sz >= PERF_SAMPLE_MAX_SIZE) {
+			pr_err("Sample size %zu exceeds max size %d\n", sz, PERF_SAMPLE_MAX_SIZE);
+			return -EFAULT;
+		}
+
+		event_copy->header.type = PERF_RECORD_SAMPLE;
+		event_copy->header.misc = event->header.misc;
+		event_copy->header.size = sz;
+
+		err = perf_event__synthesize_sample(event_copy, evsel->core.attr.sample_type,
+						    evsel->core.attr.read_format,
+						    evsel->core.attr.branch_sample_type, sample);
+
+		evsel->core.attr.sample_type = orig_type;
+		evsel->core.attr.branch_sample_type = orig_branch_type;
+		sample->branch_stack = orig_bs;
+
+		if (err) {
+			pr_err("Failed to synthesize sample\n");
+			return err;
+		}
+		event = event_copy;
+	} else if (inject->itrace_synth_opts.set && sample->aux_sample.size) {
 		event = perf_inject__cut_auxtrace_sample(inject, event, sample);
 		if (IS_ERR(event))
 			return PTR_ERR(event);
@@ -463,7 +531,7 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
 	/* remove sample_type {STACK,REGS}_USER for synthesize */
 	sample_type &= ~(PERF_SAMPLE_STACK_USER | PERF_SAMPLE_REGS_USER);
 
-	ret = perf_event__synthesize_sample(event_copy, evsel->core.attr.sample_type,
+	ret = perf_event__synthesize_sample(event_copy, sample_type,
 					    evsel->core.attr.read_format,
 					    evsel->core.attr.branch_sample_type, sample);
 	if (ret) {
@@ -2440,12 +2508,25 @@ static int __cmd_inject(struct perf_inject *inject)
 		 * synthesized hardware events, so clear the feature flag.
 		 */
 		if (inject->itrace_synth_opts.set) {
+			struct evsel *evsel;
+
 			perf_header__clear_feat(&session->header,
 						HEADER_AUXTRACE);
-			if (inject->itrace_synth_opts.last_branch ||
-			    inject->itrace_synth_opts.add_last_branch)
+
+			evlist__for_each_entry(session->evlist, evsel) {
+				evsel->core.attr.sample_type &= ~PERF_SAMPLE_AUX;
+			}
+
+			if (inject->itrace_synth_opts.add_last_branch) {
 				perf_header__set_feat(&session->header,
 						      HEADER_BRANCH_STACK);
+
+				evlist__for_each_entry(session->evlist, evsel) {
+					evsel->core.attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
+					evsel->core.attr.branch_sample_type |=
+						PERF_SAMPLE_BRANCH_HW_INDEX;
+				}
+			}
 		}
 
 		/*
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 5142983e3243..f45dbdd4d323 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1728,14 +1728,24 @@ static void intel_pt_prep_b_sample(struct intel_pt *pt,
 	event->sample.header.misc = sample->cpumode;
 }
 
-static int intel_pt_inject_event(union perf_event *event,
+static int intel_pt_inject_event(struct intel_pt *pt, union perf_event *event,
 				 struct perf_sample *sample, u64 type)
 {
+	struct evsel *evsel = NULL;
+	u64 branch_sample_type = 0;
+
+	if (pt->session && pt->session->evlist)
+		evsel = evlist__id2evsel(pt->session->evlist, sample->id);
+
+	if (evsel)
+		branch_sample_type = evsel->core.attr.branch_sample_type;
+
+	event->header.type = PERF_RECORD_SAMPLE;
 	event->header.size = perf_event__sample_event_size(sample, type, /*read_format=*/0,
-							   /*branch_sample_type=*/0);
+							   branch_sample_type);
 
 	return perf_event__synthesize_sample(event, type, /*read_format=*/0,
-					     /*branch_sample_type=*/0, sample);
+					     branch_sample_type, sample);
 }
 
 static inline int intel_pt_opt_inject(struct intel_pt *pt,
@@ -1745,7 +1755,7 @@ static inline int intel_pt_opt_inject(struct intel_pt *pt,
 	if (!pt->synth_opts.inject)
 		return 0;
 
-	return intel_pt_inject_event(event, sample, type);
+	return intel_pt_inject_event(pt, event, sample, type);
 }
 
 static int intel_pt_deliver_synth_event(struct intel_pt *pt,
@@ -2489,7 +2499,7 @@ static int intel_pt_do_synth_pebs_sample(struct intel_pt_queue *ptq, struct evse
 		intel_pt_add_xmm(intr_regs, pos, items, regs_mask);
 	}
 
-	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
+	if ((sample_type | evsel->synth_sample_type) & PERF_SAMPLE_BRANCH_STACK) {
 		if (items->mask[INTEL_PT_LBR_0_POS] ||
 		    items->mask[INTEL_PT_LBR_1_POS] ||
 		    items->mask[INTEL_PT_LBR_2_POS]) {
@@ -2560,7 +2570,8 @@ static int intel_pt_do_synth_pebs_sample(struct intel_pt_queue *ptq, struct evse
 		sample.transaction = txn;
 	}
 
-	ret = intel_pt_deliver_synth_event(pt, event, &sample, sample_type);
+	ret = intel_pt_deliver_synth_event(pt, event, &sample,
+					   sample_type | evsel->synth_sample_type);
 	perf_sample__exit(&sample);
 	return ret;
 }
-- 
2.54.0.545.g6539524ca2-goog

