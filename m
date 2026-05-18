Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3863DD847
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 06:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779084761; cv=none; b=oZ9ZVjIO3vGE5nGqGVbBgHoR5M4l0XeFMxxe3+llgl97RjwdRGrlC996Y74cGhYxq/nIOLJr5LmwLab0bviF8rI04jQIXHJ5SVi5vsEJWGT2KKFxcLGb1ubfYCIf2jJUbZADuFU2QBrVXnkpuLJ/lO1QXDKexIcbp6xzRwJKTCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779084761; c=relaxed/simple;
	bh=hS26fB3aRc6qP0GVW7N2gPl2K+VDOVCX4wGExwq3vyc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jxeDt8yCefSSz3xmEJlhvozzGCVa0mboFnAkBfpCEPHINglTB0KaoCQTMWFo8mrvBfdXY0tfmVHfbhT9u6+zgIiwmkNwsjwqnnViWst0tmGrgQJpYp7eR+RrHBDiFe2lakduysqZGsFV8krZ3958JQXDPbOkLmb7F/Zh8f8EZbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jMM+sY/6; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jMM+sY/6"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-303b38ec2f6so2486973eec.0
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 23:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779084756; x=1779689556; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rEvUNQLWRWVPA3++AhllkRaTmO8gUfxDp//Tvh1x8JM=;
        b=jMM+sY/60rUWKo0fBoeDOPZvaAtYfIjvpxfUZjvAckTIGXnjCLAI/SK45jQHGBg1sa
         c7Xts5zYYNfIRkj7l5N9Y/qIqqIgbA+wpyujiYvh4Qi+Tmk4Ad0z4RZ+h61ekw/elsrw
         VUMMkT9tkeGCUJZer/B0UKTW2HJZYGqnMzmfxRC8QqrqhZy+O1EpPKnw6IiHdFX+vIZ8
         r2kj7XhajS0SxS3naXdQ9E0+DxEUCMN8efP2dAVE6Bk4ES4JR9zO38SaeqYjxTwRZYf7
         IV5BznJbIPvokoT2xVpCwx8xaUxUvWtvb/SZWFaTp13MRF95aIB+bdcngx7GQntcL/rI
         9blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779084756; x=1779689556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEvUNQLWRWVPA3++AhllkRaTmO8gUfxDp//Tvh1x8JM=;
        b=pHJqDChwF2qIE1t7xlezyNZx/rNG3d8cdar+7o07P9WZQKR3EcaI4GPUXtLKy4zSrn
         Ej8C0XWyjEEZDffh7hpZMJqjQJhu3D/Rhso9Z5AzJlZLGWXP9/dvbPwXh6FJTlLAkeTG
         UBG2cvUDSFnWy/Rzi4/xlm930LBSlACKw3t28oB9bV0ps/ANbDvk3em5GvzAWvQkUFtf
         nck1XEjVQpgE7q+EGvH1jtM51CReK0aEYVrXxYxeseROLAlSiUYM6AveHtWpe9JVfX6U
         1fw4ueRKIns9vFydPfGB9MaW7lmlhYWoxAfR2tqV0h5+55sG6QTw8lWk3dGUt1JOfLvd
         GXsA==
X-Forwarded-Encrypted: i=1; AFNElJ8OfivPLHNeJDRGWYAVx/O9kj3N+oxX0YVD82ppd/ef39xzADeM4kQZ4J5k3Uv1dviHKcydyz/Jkup76Gf/6Umk@vger.kernel.org
X-Gm-Message-State: AOJu0YwwzsZ/SDE7EWeb2fWtdqf6DCIZjtNLFuxwleWDwAtQT1LRYVEV
	N087wAX88kM0NGpJRngN2ZsOxNOs6xXVKKMPUj5w5eQRNwMLh6g6EUhZwabmwvc6fYcLupcRn+o
	PsY7dJZhhiQ==
X-Received: from dlcio24.prod.google.com ([2002:a05:7023:c018:b0:135:9081:542c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ebc3:b0:135:26d3:3f81
 with SMTP id a92af1059eb24-13526d34185mr4523695c88.32.1779084755666; Sun, 17
 May 2026 23:12:35 -0700 (PDT)
Date: Sun, 17 May 2026 23:12:28 -0700
In-Reply-To: <20260518061228.2582860-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260429181136.2712655-1-irogers@google.com> <20260518061228.2582860-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518061228.2582860-3-irogers@google.com>
Subject: [PATCH v3 2/2] perf inject: Fix itrace branch stack synthesis
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
   branch_stack if it was synthesized, even if not in the original
   sample_type.

7. Modifying event attributes in perf_event__repipe_attr in-place caused
   SIGSEGV on read-only mmap buffers in file mode and downstream parser
   breakage in pipe mode. Fixed by processing the unmodified attribute
   first, returning immediately in non-pipe mode, and correctly
   synthesizing a new attribute event for pipe output using
   perf_event__synthesize_attr.

8. Potential dangling pointer vulnerability in perf_event__repipe_sample:
   Addressed by restoring the original sample->branch_stack pointer
   before returning.

9. Off-by-one error in sample size check in perf_event__repipe_sample:
   Fixed by checking if sz >= PERF_SAMPLE_MAX_SIZE instead of >.

10. Unadvertised size field left in payload by cut_auxtrace_sample:
    Addressed by excluding the 8-byte size field from the copied
    payload to correctly match the cleared PERF_SAMPLE_AUX bit.

11. Inaccurate sample size calculation and uninitialized memory leaks in
    convert_sample_callchain: Fixed by replacing manual arithmetic with
    perf_event__sample_event_size and adding a bounds check against
    PERF_SAMPLE_MAX_SIZE.

12. Omission of hw_idx in synthesized samples: Fixed by retrieving the
    correct evsel->core.attr.branch_sample_type instead of hardcoding 0 in
    intel-pt.c, arm-spe.c, and cs-etm.c.

Fixes: 0f0aa5e0693c ("perf inject: Add Instruction Tracing support")
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 131 +++++++++++++++++++++++++++++++-----
 tools/perf/util/arm-spe.c   |  18 +++--
 tools/perf/util/cs-etm.c    |  21 ++++--
 tools/perf/util/intel-pt.c  |  23 +++++--
 4 files changed, 161 insertions(+), 32 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 6bde3cc173b2..04921fb47b35 100644
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
@@ -232,7 +243,24 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
 	if (!inject->output.is_pipe)
 		return 0;
 
-	return perf_event__repipe_synth(tool, event);
+	if (!inject->itrace_synth_opts.set)
+		return perf_event__repipe_synth(tool, event);
+
+	attr = event->attr.attr;
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
@@ -331,8 +359,8 @@ perf_inject__cut_auxtrace_sample(struct perf_inject *inject,
 				 union perf_event *event,
 				 struct perf_sample *sample)
 {
-	size_t sz1 = sample->aux_sample.data - (void *)event;
-	size_t sz2 = event->header.size - sample->aux_sample.size - sz1;
+	size_t sz1 = sample->aux_sample.data - (void *)event - sizeof(u64);
+	size_t sz2 = event->header.size - sample->aux_sample.size - (sz1 + sizeof(u64));
 	union perf_event *ev;
 
 	if (inject->event_copy == NULL) {
@@ -343,13 +371,12 @@ perf_inject__cut_auxtrace_sample(struct perf_inject *inject,
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
@@ -376,7 +403,63 @@ static int perf_event__repipe_sample(const struct perf_tool *tool,
 
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
@@ -397,7 +480,7 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
 	struct callchain_cursor_node *node;
 	struct thread *thread;
 	u64 sample_type = evsel->core.attr.sample_type;
-	u32 sample_size = event->header.size;
+	size_t sz;
 	u64 i, k;
 	int ret;
 
@@ -456,16 +539,19 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
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
 
-	ret = perf_event__synthesize_sample(event_copy, evsel->core.attr.sample_type,
+	sz = perf_event__sample_event_size(sample, sample_type,
+					   evsel->core.attr.read_format,
+					   evsel->core.attr.branch_sample_type);
+	if (sz >= PERF_SAMPLE_MAX_SIZE) {
+		pr_err("Sample size %zu exceeds max size %d\n", sz, PERF_SAMPLE_MAX_SIZE);
+		return -EFAULT;
+	}
+	event_copy->header.size = sz;
+
+	ret = perf_event__synthesize_sample(event_copy, sample_type,
 					    evsel->core.attr.read_format,
 					    evsel->core.attr.branch_sample_type, sample);
 	if (ret) {
@@ -2442,12 +2528,25 @@ static int __cmd_inject(struct perf_inject *inject)
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
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 24714f516856..ae14bfda9f50 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -487,13 +487,23 @@ static void arm_spe__prep_branch_stack(struct arm_spe_queue *speq)
 	bstack->hw_idx = -1ULL;
 }
 
-static int arm_spe__inject_event(union perf_event *event, struct perf_sample *sample, u64 type)
+static int arm_spe__inject_event(struct arm_spe *spe, union perf_event *event,
+				 struct perf_sample *sample, u64 type)
 {
+	struct evsel *evsel = NULL;
+	u64 branch_sample_type = 0;
+
+	if (spe->session && spe->session->evlist)
+		evsel = evlist__id2evsel(spe->session->evlist, sample->id);
+
+	if (evsel)
+		branch_sample_type = evsel->core.attr.branch_sample_type;
+
 	event->header.type = PERF_RECORD_SAMPLE;
 	event->header.size = perf_event__sample_event_size(sample, type, /*read_format=*/0,
-							   /*branch_sample_type=*/0);
+							   branch_sample_type);
 	return perf_event__synthesize_sample(event, type, /*read_format=*/0,
-					     /*branch_sample_type=*/0, sample);
+					     branch_sample_type, sample);
 }
 
 static inline int
@@ -505,7 +515,7 @@ arm_spe_deliver_synth_event(struct arm_spe *spe,
 	int ret;
 
 	if (spe->synth_opts.inject) {
-		ret = arm_spe__inject_event(event, sample, spe->sample_type);
+		ret = arm_spe__inject_event(spe, event, sample, spe->sample_type);
 		if (ret)
 			return ret;
 	}
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 1ebc1a6a5e75..7922e830e0c9 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1422,13 +1422,22 @@ static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq,
 		bs->nr += 1;
 }
 
-static int cs_etm__inject_event(union perf_event *event,
-			       struct perf_sample *sample, u64 type)
+static int cs_etm__inject_event(struct cs_etm_auxtrace *etm, union perf_event *event,
+				struct perf_sample *sample, u64 type)
 {
+	struct evsel *evsel = NULL;
+	u64 branch_sample_type = 0;
+
+	if (etm->session && etm->session->evlist)
+		evsel = evlist__id2evsel(etm->session->evlist, sample->id);
+
+	if (evsel)
+		branch_sample_type = evsel->core.attr.branch_sample_type;
+
 	event->header.size = perf_event__sample_event_size(sample, type, /*read_format=*/0,
-							   /*branch_sample_type=*/0);
+							   branch_sample_type);
 	return perf_event__synthesize_sample(event, type, /*read_format=*/0,
-					     /*branch_sample_type=*/0, sample);
+					     branch_sample_type, sample);
 }
 
 
@@ -1594,7 +1603,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 		sample.branch_stack = tidq->last_branch;
 
 	if (etm->synth_opts.inject) {
-		ret = cs_etm__inject_event(event, &sample,
+		ret = cs_etm__inject_event(etm, event, &sample,
 					   etm->instructions_sample_type);
 		if (ret)
 			return ret;
@@ -1669,7 +1678,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	}
 
 	if (etm->synth_opts.inject) {
-		ret = cs_etm__inject_event(event, &sample,
+		ret = cs_etm__inject_event(etm, event, &sample,
 					   etm->branches_sample_type);
 		if (ret)
 			return ret;
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
2.54.0.563.g4f69b47b94-goog

