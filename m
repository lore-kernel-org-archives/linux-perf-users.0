Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32126381B0A
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 22:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779144215; cv=none; b=C5Hc2J7vNevI3z4h71PARHivUmlI/aR3U8Ryjx9Xkf2cPjiROfZ7M+JoGCw53cLqV+tAXVpue6RMBYQOWaNiMg9gcx6HBGqQJCSzs1IJ+xjkBmpEIevkqFX/CkMANKG3nx9QDc4aXX1ZJXreaZMQ3xWocnEdUTFQ3WwwhO1F9f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779144215; c=relaxed/simple;
	bh=TfICAEzvWOk2mxaCMD2CPWDvxjawe769J89fx97LJfk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=a43JegyxKMcprHrrnKfdWSXe6Im1psRPQ133kdRCcW4m3pbBZE0rCF980hJ7aLrLLoTjgYLeV+UYPdF5e1dGglgSFwVXuiAn1HmjPfXsgnklF/vA1AYUjM63tBC+GuVcUa7tztyuyhwbBZ9jioI3e+ezTv37dKKPGYttZuFWEiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rsvVP03u; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rsvVP03u"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1329791f18fso5021920c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779144212; x=1779749012; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9isfTE4P0fJ6VI+Gl9uW+M+jrD927XwM2kSaRzjsyMQ=;
        b=rsvVP03u0WdXxfUhF+n5F+VbcDUZM6djRffRz+2hBlbnYCWSlSXFNPRWhmoG9Yu1gP
         m4PqUtVQvdX4Mr4wFVfLOVT54p1xxKvuOkITSvbOfJVe5D3BRQhR5e+9xN43FO1b2Vp6
         AUxI/6mdBwxRCpj6ag0JM61J0ZC5HiO6Bh6EiLPd4rbAKNSrLpuLPN0d+DJOiYgmXGGi
         6LxQTDhfr3gDs87FrA+vPs2bZPGg2pvj8jcY03afM7hz8CuQmvZ5iGajWom7qXnzMAz0
         yKVFOjVD+O4Wtg2I7sKv3iUZFLk1hVaIKWU9l+ofaU3t70RWZ9Ug09O8pIho1YE/7cWW
         XUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779144212; x=1779749012;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9isfTE4P0fJ6VI+Gl9uW+M+jrD927XwM2kSaRzjsyMQ=;
        b=FXy7DLedyiyDpVBXUN26L/G/3Ivb8sUSmXYmjlYWfRgOsHx7cg32xQYxbx7bYM2G9m
         WyAnzQMnBNKBojJ8XTXLpCZpOVzGYMAkT/eYCF6zIb8hXvc5/NK+HAtmDv0WR2ye9NjA
         K4TDc1ySOf3tzuFeh3OTPwtizHz6oeceWlLeA2nBEooHWotwbstkDvG27hGMYLYTRXRb
         0d8UYUPQ2+jFRw3yf5MRdd5yqlJtfHYKUx0Bcy7V3qpa4U2X7eKw/wrVv3blDQQTqscb
         ybonoh2Uc22n7lfl0bjb348r/rOUvrS02ATEpI/d75AxhXFwDmkTsbJ/AlMdVk3gN7Zy
         7Tdg==
X-Forwarded-Encrypted: i=1; AFNElJ+eukn4tG88RA/eS4KKNpSXvSqprn91clU5lIMCwyEc0c4VreHg22O87tuj87+/U6tEYJKAdr290eMTqrhWv7lb@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd5NpE/d7h3TIuecPTmIXj/6zNhybLJ2Dknfwajy16YPpN6hmZ
	TtVFcZM0UCVn30deiP1wbmvAEc/eKoO6vYcfDbSQMMtj9EwBHhpPQzGQvj/2b7sY9tXlkKbqzW3
	40gCefWyCRA==
X-Received: from dlk5.prod.google.com ([2002:a05:7022:105:b0:135:3d53:71e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea26:b0:12c:8b9:71d9
 with SMTP id a92af1059eb24-1350483ccf4mr7737287c88.27.1779144212109; Mon, 18
 May 2026 15:43:32 -0700 (PDT)
Date: Mon, 18 May 2026 15:43:25 -0700
In-Reply-To: <20260518224325.3037838-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518203805.2955241-1-irogers@google.com> <20260518224325.3037838-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260518224325.3037838-3-irogers@google.com>
Subject: [PATCH v8 2/2] perf inject: Fix itrace branch stack synthesis
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, thomas.falcon@intel.com
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

6. NULL Pointer Dereference in intel-pt.c: When branch stack injection
   is requested (add_last_branch is true) but last_branch is false
   (e.g., perf inject --itrace=L), ptq->last_branch was not allocated.
   However, PEBS branch stack synthesis (via synth_sample_type) still
   forced LBR handling in do_synth_pebs_sample(), dereferencing the
   NULL ptq->last_branch pointer. Guarding the dereference is not
   sufficient because downstream sample size calculation and synthesis
   strictly require a non-NULL branch_stack when the bit is set.
   Fixed by ensuring ptq->last_branch is allocated in
   intel_pt_alloc_queue() when add_last_branch is requested.

7. Modifying event attributes in perf_event__repipe_attr in-place caused
   SIGSEGV on read-only mmap buffers in file mode and downstream parser
   breakage in pipe mode. Fixed by processing the unmodified attribute
   first, returning immediately in non-pipe mode, and correctly
   synthesizing a new attribute event for pipe output using
   perf_event__synthesize_attr. Also:
   - Added a size validation check and integer underflow protection when
     parsing n_ids.
   - Prevented Trailing ID memory corruption by zero-initializing the
     local attr copy and safely copying using min_t(size_t, sizeof(attr),
     event->attr.attr.size).
   - Resolved ID array parsing mismatch downstream by expanding attr.size
     to sizeof(struct perf_event_attr) before synthesis to guarantee
     perfect header/attribute size alignment.

8. Potential dangling pointer vulnerability in perf_event__repipe_sample:
   Addressed by restoring the original sample->branch_stack pointer
   before returning, including on early error return paths.

9. Off-by-one error in sample size check in perf_event__repipe_sample:
   Fixed by checking if sz >= PERF_SAMPLE_MAX_SIZE instead of >.

10. Unadvertised size field left in payload by cut_auxtrace_sample:
    Addressed by excluding the 8-byte size field from the copied
    payload to correctly match the cleared PERF_SAMPLE_AUX bit. Cut
    the AUX sample payload even if size is 0.

11. Inaccurate sample size calculation and uninitialized memory leaks in
    convert_sample_callchain: Fixed by replacing manual arithmetic with
    perf_event__sample_event_size and adding a bounds check against
    PERF_SAMPLE_MAX_SIZE.

12. Omission of branch_sample_type in file headers: Addressed by
    expanding older, smaller attributes to PERF_ATTR_SIZE_VER2 in
    __cmd_inject to ensure branch_sample_type is not silently omitted.

Fixes: 0f0aa5e0693c ("perf inject: Add Instruction Tracing support")
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 153 ++++++++++++++++++++++++++++++++----
 tools/perf/util/intel-pt.c  |   8 +-
 2 files changed, 142 insertions(+), 19 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 2f20e782c7f2..7a64935b7e2b 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -216,12 +216,23 @@ static int perf_event__repipe_op4_synth(const struct perf_tool *tool,
 	return perf_event__repipe_synth(tool, event);
 }
 
+static int perf_event__repipe_synth_cb(const struct perf_tool *tool,
+				       union perf_event *event,
+				       struct perf_sample *sample __maybe_unused,
+				       struct machine *machine __maybe_unused)
+{
+	return perf_event__repipe_synth(tool, event);
+}
+
 static int perf_event__repipe_attr(const struct perf_tool *tool,
 				   union perf_event *event,
 				   struct evlist **pevlist)
 {
 	struct perf_inject *inject = container_of(tool, struct perf_inject,
 						  tool);
+	struct perf_event_attr attr;
+	size_t n_ids;
+	u64 *ids;
 	int ret;
 
 	ret = perf_event__process_attr(tool, event, pevlist);
@@ -232,7 +243,37 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
 	if (!inject->output.is_pipe)
 		return 0;
 
-	return perf_event__repipe_synth(tool, event);
+	if (!inject->itrace_synth_opts.set)
+		return perf_event__repipe_synth(tool, event);
+
+	if (event->header.size < sizeof(struct perf_event_header) + sizeof(u64)) {
+		pr_err("Attribute event size %u is too small\n", event->header.size);
+		return -EINVAL;
+	}
+
+	if (event->header.size - sizeof(event->header) < event->attr.attr.size) {
+		pr_err("Attribute event size %u is too small for attr.size %u\n",
+		       event->header.size, event->attr.attr.size);
+		return -EINVAL;
+	}
+
+	memset(&attr, 0, sizeof(attr));
+	memcpy(&attr, &event->attr.attr,
+	       min_t(size_t, sizeof(attr), (size_t)event->attr.attr.size));
+
+	n_ids = event->header.size - sizeof(event->header) - event->attr.attr.size;
+	n_ids /= sizeof(u64);
+	ids = perf_record_header_attr_id(event);
+
+	attr.size = sizeof(struct perf_event_attr);
+	attr.sample_type &= ~PERF_SAMPLE_AUX;
+
+	if (inject->itrace_synth_opts.add_last_branch) {
+		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
+		attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
+	}
+	return perf_event__synthesize_attr(tool, &attr, (u32)n_ids, ids,
+					   perf_event__repipe_synth_cb);
 }
 
 static int perf_event__repipe_event_update(const struct perf_tool *tool,
@@ -331,8 +372,8 @@ perf_inject__cut_auxtrace_sample(struct perf_inject *inject,
 				 union perf_event *event,
 				 struct perf_sample *sample)
 {
-	size_t sz1 = sample->aux_sample.data - (void *)event;
-	size_t sz2 = event->header.size - sample->aux_sample.size - sz1;
+	size_t sz1 = sample->aux_sample.data - (void *)event - sizeof(u64);
+	size_t sz2 = event->header.size - sample->aux_sample.size - (sz1 + sizeof(u64));
 	union perf_event *ev;
 
 	if (inject->event_copy == NULL) {
@@ -343,13 +384,12 @@ perf_inject__cut_auxtrace_sample(struct perf_inject *inject,
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
@@ -369,14 +409,77 @@ static int perf_event__repipe_sample(const struct perf_tool *tool,
 	struct perf_inject *inject = container_of(tool, struct perf_inject,
 						  tool);
 
-	if (evsel && evsel->handler) {
+	if (evsel == NULL)
+		return perf_event__repipe_synth(tool, event);
+
+	if (evsel->handler) {
 		inject_handler f = evsel->handler;
 		return f(tool, event, sample, evsel, machine);
 	}
 
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
+			evsel->core.attr.sample_type = orig_type;
+			evsel->core.attr.branch_sample_type = orig_branch_type;
+			sample->branch_stack = orig_bs;
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
+	} else if (inject->itrace_synth_opts.set &&
+		   (evsel->core.attr.sample_type & PERF_SAMPLE_AUX)) {
 		event = perf_inject__cut_auxtrace_sample(inject, event, sample);
 		if (IS_ERR(event))
 			return PTR_ERR(event);
@@ -397,7 +500,7 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
 	struct callchain_cursor_node *node;
 	struct thread *thread;
 	u64 sample_type = evsel->core.attr.sample_type;
-	u32 sample_size = event->header.size;
+	size_t sz;
 	u64 i, k;
 	int ret;
 
@@ -456,15 +559,18 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
 out:
 	memcpy(event_copy, event, sizeof(event->header));
 
-	/* adjust sample size for stack and regs */
-	sample_size -= sample->user_stack.size;
-	sample_size -= (hweight64(evsel->core.attr.sample_regs_user) + 1) * sizeof(u64);
-	sample_size += (sample->callchain->nr + 1) * sizeof(u64);
-	event_copy->header.size = sample_size;
-
 	/* remove sample_type {STACK,REGS}_USER for synthesize */
 	sample_type &= ~(PERF_SAMPLE_STACK_USER | PERF_SAMPLE_REGS_USER);
 
+	sz = perf_event__sample_event_size(sample, sample_type,
+					   evsel->core.attr.read_format,
+					   evsel->core.attr.branch_sample_type);
+	if (sz >= PERF_SAMPLE_MAX_SIZE) {
+		pr_err("Sample size %zu exceeds max size %d\n", sz, PERF_SAMPLE_MAX_SIZE);
+		return -EFAULT;
+	}
+	event_copy->header.size = sz;
+
 	ret = perf_event__synthesize_sample(event_copy, sample_type,
 					    evsel->core.attr.read_format,
 					    evsel->core.attr.branch_sample_type, sample);
@@ -2442,12 +2548,27 @@ static int __cmd_inject(struct perf_inject *inject)
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
+					if (evsel->core.attr.size < PERF_ATTR_SIZE_VER2)
+						evsel->core.attr.size = PERF_ATTR_SIZE_VER2;
+					evsel->core.attr.branch_sample_type |=
+						PERF_SAMPLE_BRANCH_HW_INDEX;
+				}
+			}
 		}
 
 		/*
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index dd2637678b40..d9c86ac49748 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1307,7 +1307,8 @@ static struct intel_pt_queue *intel_pt_alloc_queue(struct intel_pt *pt,
 			goto out_free;
 	}
 
-	if (pt->synth_opts.last_branch || pt->synth_opts.other_events) {
+	if (pt->synth_opts.last_branch || pt->synth_opts.add_last_branch ||
+	    pt->synth_opts.other_events) {
 		unsigned int entry_cnt = max(LBRS_MAX, pt->br_stack_sz);
 
 		ptq->last_branch = intel_pt_alloc_br_stack(entry_cnt);
@@ -2505,7 +2506,7 @@ static int intel_pt_do_synth_pebs_sample(struct intel_pt_queue *ptq, struct evse
 		intel_pt_add_xmm(intr_regs, pos, items, regs_mask);
 	}
 
-	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
+	if ((sample_type | evsel->synth_sample_type) & PERF_SAMPLE_BRANCH_STACK) {
 		if (items->mask[INTEL_PT_LBR_0_POS] ||
 		    items->mask[INTEL_PT_LBR_1_POS] ||
 		    items->mask[INTEL_PT_LBR_2_POS]) {
@@ -2576,7 +2577,8 @@ static int intel_pt_do_synth_pebs_sample(struct intel_pt_queue *ptq, struct evse
 		sample.transaction = txn;
 	}
 
-	ret = intel_pt_deliver_synth_event(pt, event, &sample, sample_type);
+	ret = intel_pt_deliver_synth_event(pt, event, &sample,
+					   sample_type | evsel->synth_sample_type);
 	perf_sample__exit(&sample);
 	return ret;
 }
-- 
2.54.0.631.ge1b05301d1-goog

