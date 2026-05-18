Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7AD43E4A6
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779118695; cv=none; b=B83jv4TWNmTCujrmJSyQRJ6qfWrfH2zog1jCqkj60jaw+PHvfnw0gsC8kJuhQ/H+pp7MA/jfuCT1ZWZiDFKITjswGlqxlO3LJxEArOJ430bkVIEYkS5Li4HC/m5MPlVCUgwKBgNw4uMxAO0Rfur1fP6wKwW4zUPMh8VEBwb1Occ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779118695; c=relaxed/simple;
	bh=FZMY/gu0ZF9xM/NvcF+8V7CX16jfPEbqa3zJKKTN1x0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=opCWzYEtMF7xs+mZs2jGuO/8mh6r+ngp+dXCLXmuukuqAQaOOhjvJ0XQ4JYAscV8PM2BY5OTbnhfi2yiNbB5A1plSWJqrqCQYRmaK3fjccOfjLwqonDJ3zsRAQkOhsE04KMuEzOvbX4EkFWHDG3xQ+bPl+m0kjEc9z1mXaQOV60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=johhJorC; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="johhJorC"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2b4530a90fdso25144265ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 08:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779118691; x=1779723491; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YMVAypm126+VR+L5gc8vTkt3pun/NmGZ+ZXZjLarCMA=;
        b=johhJorCfFa4oOk/FjNYO0Gkrs07QYH6t22Eq93HYRpD3l62fw1W43YI5Gx3apbYqs
         /81MsBhNNdb5ETE3HxsmpF7WzNHQBokwKC1CmWc03JMH4bbxJhw06NpolNAo7qvsCINX
         0A8q950hOJMnMz/rPNzRmsXA+8xH3uQ+tVcdSUTQ5q8CQwvhCx6I5Rw2/GecWFB/EYSV
         TaQBr4HEp12ncPufKftnmjAgxEKqfCrEfhSv7t7GB+aG9hZSs+hM1kAb0CX/IsA/eBLc
         AhD9TKrCz0wUIk0S1wLDja1JpWdCLkQBZseqVqmDFrbEFDcpOxC23Yj1iEDVA4X4lxrB
         Wzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779118691; x=1779723491;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMVAypm126+VR+L5gc8vTkt3pun/NmGZ+ZXZjLarCMA=;
        b=pZUHVBmq8mKtLiU4e2FRRPInJpqEV2dD3fMX/0BLQFR/A3V5j2PfBFMOqq+0wzreLm
         ifGYYsoCB78Ei7PakU62Lx1FSzD9SAMLOKiBSP7+SKA/ZtnJBMgir6seyht2DPOzcS3Y
         T+ZZHK3T0iURr2AiGrmLDrGKa2PQS4hA7SxSUnRLE2xQ7KMbq7P8PZIVvsIxfmAIJ3Qd
         t3EPEZ1bg+oGPkE9udvToHjHqRDksFRnzpICryTPI73Z4tnl0NsWjbDbV77le1/2F8OM
         FX3Ih35g5rBgpQ/L2P/ozYiZSBPdKLv19Ji03Dyb92Nrr7yEfEB/vCFGIChvz2zA42/8
         oA8w==
X-Forwarded-Encrypted: i=1; AFNElJ8q8S1bvl1/VaQzKXdyMJrjW+eTMl3P3/JntmkKcGC6TQYeWPoQqz991MXm6tDpiP2wGnR3cvDzBlxa2lsGBOP7@vger.kernel.org
X-Gm-Message-State: AOJu0YwlRtouqPLkfcM9vlg+c4KXT4Acv+H21XlFr4eU/KLuCiT8Dns2
	NAVlW35LmRZ4+DAstCk+8oVGBBRDfDwXII5/yrf3cEo77wIiWm09DTKyYLvlxNjK46WlLWdtn6R
	biyQAK5/0Wg==
X-Received: from plqc18.prod.google.com ([2002:a17:902:9d92:b0:2b2:3f89:e9d2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e787:b0:2ba:4e84:966
 with SMTP id d9443c01a7336-2bd7e953232mr165784515ad.36.1779118690976; Mon, 18
 May 2026 08:38:10 -0700 (PDT)
Date: Mon, 18 May 2026 08:37:54 -0700
In-Reply-To: <20260518153754.2795820-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518061228.2582860-1-irogers@google.com> <20260518153754.2795820-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518153754.2795820-3-irogers@google.com>
Subject: [PATCH v4 2/2] perf inject: Fix itrace branch stack synthesis
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	thomas.falcon@intel.com
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
   branch_stack if it warrants synthesis, even if not in the original
   sample_type.

7. Modifying event attributes in perf_event__repipe_attr in-place caused
   SIGSEGV on read-only mmap buffers in file mode and downstream parser
   breakage in pipe mode. Fixed by processing the unmodified attribute
   first, returning immediately in non-pipe mode, and correctly
   synthesizing a new attribute event for pipe output using
   perf_event__synthesize_attr. Also added a size validation check to
   prevent n_ids underflow when parsing header size.

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
 tools/perf/builtin-inject.c | 139 ++++++++++++++++++++++++++++++++----
 1 file changed, 124 insertions(+), 15 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 2f20e782c7f2..3d6ec2c7f990 100644
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
@@ -232,7 +243,28 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
 	if (!inject->output.is_pipe)
 		return 0;
 
-	return perf_event__repipe_synth(tool, event);
+	if (!inject->itrace_synth_opts.set)
+		return perf_event__repipe_synth(tool, event);
+
+	attr = event->attr.attr;
+	if (event->header.size < sizeof(event->header) + event->attr.attr.size) {
+		pr_err("Attribute event size %u is too small\n", event->header.size);
+		return -EINVAL;
+	}
+	n_ids = event->header.size - sizeof(event->header) - event->attr.attr.size;
+	n_ids /= sizeof(u64);
+	ids = perf_record_header_attr_id(event);
+
+	attr.sample_type &= ~PERF_SAMPLE_AUX;
+
+	if (inject->itrace_synth_opts.add_last_branch) {
+		attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
+		if (attr.size < PERF_ATTR_SIZE_VER2)
+			attr.size = PERF_ATTR_SIZE_VER2;
+		attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
+	}
+	return perf_event__synthesize_attr(tool, &attr, (u32)n_ids, ids,
+					   perf_event__repipe_synth_cb);
 }
 
 static int perf_event__repipe_event_update(const struct perf_tool *tool,
@@ -331,8 +363,8 @@ perf_inject__cut_auxtrace_sample(struct perf_inject *inject,
 				 union perf_event *event,
 				 struct perf_sample *sample)
 {
-	size_t sz1 = sample->aux_sample.data - (void *)event;
-	size_t sz2 = event->header.size - sample->aux_sample.size - sz1;
+	size_t sz1 = sample->aux_sample.data - (void *)event - sizeof(u64);
+	size_t sz2 = event->header.size - sample->aux_sample.size - (sz1 + sizeof(u64));
 	union perf_event *ev;
 
 	if (inject->event_copy == NULL) {
@@ -343,13 +375,12 @@ perf_inject__cut_auxtrace_sample(struct perf_inject *inject,
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
@@ -376,7 +407,67 @@ static int perf_event__repipe_sample(const struct perf_tool *tool,
 
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
@@ -397,7 +488,7 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
 	struct callchain_cursor_node *node;
 	struct thread *thread;
 	u64 sample_type = evsel->core.attr.sample_type;
-	u32 sample_size = event->header.size;
+	size_t sz;
 	u64 i, k;
 	int ret;
 
@@ -456,15 +547,18 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
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
@@ -2442,12 +2536,27 @@ static int __cmd_inject(struct perf_inject *inject)
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
-- 
2.54.0.563.g4f69b47b94-goog

