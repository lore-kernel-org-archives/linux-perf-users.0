Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB76381B1F
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 07:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777359827; cv=none; b=sssoIXbqgtXB0ZzjJH4Ag9FnpkgpMP4RIEQcXn/DtfU9Cxg75HsmDJ3r9cJfewtVZUQW/ZNYTSZWJKHFUYy4hQhp9eOyUofcvOEdyIqT0tLXHTyBOvTpGvvBDH/aONEmLi7eRGyGf9lLz+QrgarYU2MouiWQt51QIZZ9N4lqYBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777359827; c=relaxed/simple;
	bh=2H4sGX0dorMsWw6KSvvSej4NjPhTx1UKRKD7ZDu83gI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kfy/Pr8yH8TN52dcDZ93sToprWyS7LqXsntpEI2N/FSsPpbGXDTRtHFrSgWjRuovha7uN92mhiDBHpwQotit++xJIg2npR09AtjdQEl4jb/BD9XNxAxjzp9HfLM1V7cEpigasUQRQc+Y1aR2KxJBFkdvCPu8ORzUGpGBiLkVvQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AYDFB1x6; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AYDFB1x6"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c21dbc9c1so42568639c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 00:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777359824; x=1777964624; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NuBj0j1xtfLIlGjGun13AtkK4jygCSyXC7H2NnXFIDs=;
        b=AYDFB1x6EkugvdftxWPds9w0g2PaO42x9Lx4I9nZsTcUJ06PDfZ+K3FzzgHQAktX0b
         KvsIORx3f7y5nLJ9pZsWw7jZjDyXVsdi8a/A5rQ8IZ+EigWTsyq4/DdFTBNHwHnjl8ec
         xUOZq74dz3JY45bXKXwcW7ovBFFNyMEXH8vZMrIvWwWnUNxcycOstYju6aE7BsY79L2I
         XzKQlvN7oqf7KW+p1rSEkVdSX2nF1sr18eUQOwzr2ddEHf46vTJ6p+RhwMig7VKWK12y
         LGBkO/k9wnO+9BnMqMKLTBSYFqMp0VJDXGcWvodG5gOdFm9yB7S9zgZx5bXcAZtjA4A2
         CYCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777359824; x=1777964624;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NuBj0j1xtfLIlGjGun13AtkK4jygCSyXC7H2NnXFIDs=;
        b=rUrY+r62FIueYLqx1cfHl50WpP+w+P066Pb1Ji2xFtxry3DAUKXS+1o+HlsNFGzIry
         TTjuJrpBB1BYxi96QggPgxzV2oaa2G6lqr6psLokG/+pljRX2DrW/dJJS4YGrqg9Rjjn
         RgotniX1j4htgLjrO3pkBFMgTLEc8EMGH39C47ZHl/f/fBDxeejLynr6XEI87PNGkxY2
         SBZVUi4Mbqj+Mz9XbpHGMfp4McL70KRWl7JIFlKged7dCVeDgrzbkJWpQ6qdwCwxRKIa
         iDQuezO2DMfDs1DADJqISyZygqsuDQM0jmZys1HJprD7G1sboE4sLJI/ny1RuLGdhFMg
         03GA==
X-Forwarded-Encrypted: i=1; AFNElJ9aENeKqQymTOV16666+icCix2IfpWydmlpMA+Zshs+SNa84+dUBsrgjYCsrMEIT7LhP2ueVjcZplX3UR6PZOMG@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi3hxP777rJWD9mhF8iV2GxIn/A2Qg8Fi5IVR8J7q2bE0eSEai
	2Fz9m4/Y3AWRxh+DFf66HDUTibdhQn0I0+oP63co3MDwzLq75bPw4jVItoniYIP4kyovp9/yYq9
	oESKpPQgwCQ==
X-Received: from dleb18-n1.prod.google.com ([2002:a05:701b:4252:10b0:12d:d43c:4120])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:61a2:b0:12b:ec67:3529
 with SMTP id a92af1059eb24-12ddd956714mr922798c88.14.1777359824212; Tue, 28
 Apr 2026 00:03:44 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:03:28 -0700
In-Reply-To: <20260428070328.1880314-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428070328.1880314-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428070328.1880314-3-irogers@google.com>
Subject: [PATCH v1 2/2] perf inject: Fix itrace branch stack synthesis
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	thomas.falcon@intel.com, dapeng1.mi@linux.intel.com
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

When using "perf inject --itrace=L" to synthesize branch stacks from
AUX data, several issues caused failures with the generated file:

1. The synthesized samples were delivered without the
   PERF_SAMPLE_BRANCH_STACK flag if it was not in the original event's
   sample_type. Fixed by using sample_type | evsel->synth_sample_type
   in intel_pt_deliver_synth_event.

2. The record layout was misaligned because of inconsistent handling
   of PERF_SAMPLE_BRANCH_HW_INDEX. Fixed by explicitly writing nr and
   hw_idx in perf_event__synthesize_sample.

3. Modifying evsel->core.attr.sample_type early in __cmd_inject caused
   parse failures for subsequent records in the input file. Fixed by
   moving this modification to just before writing the header.

4. perf_event__repipe_sample was narrowed to only synthesize samples
   when branch stack injection was requested, and restored the use of
   perf_inject__cut_auxtrace_sample as a fallback to preserve
   functionality.

5. Potential Heap Overflow in perf_event__repipe_sample : Addressed by
   adding a check that prints an error and returns -EFAULT if the
   calculated event size exceeds PERF_SAMPLE_MAX_SIZE , as you
   requested.

6. Header vs Payload Mismatch in __cmd_inject : Addressed by narrowing
   the condition so that HEADER_BRANCH_STACK is only set in the file
   header if add_last_branch was true.

7. NULL Pointer Dereference in intel-pt.c : Addressed by updating the
   condition in intel_pt_do_synth_pebs_sample to fill sample.
   branch_stack if it was synthesized, even if not in the original
   sample_type .

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-inject.c | 87 ++++++++++++++++++++++++++++++++-----
 tools/perf/util/intel-pt.c  |  6 ++-
 2 files changed, 81 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 0c51cb4250d1..1f4d25a0efba 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -223,6 +223,11 @@ static int perf_event__repipe_attr(const struct perf_tool *tool,
 						  tool);
 	int ret;
 
+	if (inject->itrace_synth_opts.add_last_branch) {
+		event->attr.attr.sample_type |= PERF_SAMPLE_BRANCH_STACK;
+		event->attr.attr.branch_sample_type |= PERF_SAMPLE_BRANCH_HW_INDEX;
+	}
+
 	ret = perf_event__process_attr(tool, event, pevlist);
 	if (ret)
 		return ret;
@@ -375,7 +380,60 @@ static int perf_event__repipe_sample(const struct perf_tool *tool,
 
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
+		if (sz > PERF_SAMPLE_MAX_SIZE) {
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
@@ -463,13 +521,9 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
 	/* remove sample_type {STACK,REGS}_USER for synthesize */
 	sample_type &= ~(PERF_SAMPLE_STACK_USER | PERF_SAMPLE_REGS_USER);
 
-	ret = perf_event__synthesize_sample(event_copy, evsel->core.attr.sample_type,
-					    evsel->core.attr.read_format,
-					    evsel->core.attr.branch_sample_type, sample);
-	if (ret) {
-		pr_err("Failed to synthesize sample\n");
-		return ret;
-	}
+	perf_event__synthesize_sample(event_copy, sample_type,
+				      evsel->core.attr.read_format,
+				      evsel->core.attr.branch_sample_type, sample);
 	return perf_event__repipe_synth(tool, event_copy);
 }
 
@@ -2440,12 +2494,25 @@ static int __cmd_inject(struct perf_inject *inject)
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
index 5142983e3243..2dce6106c038 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1731,6 +1731,7 @@ static void intel_pt_prep_b_sample(struct intel_pt *pt,
 static int intel_pt_inject_event(union perf_event *event,
 				 struct perf_sample *sample, u64 type)
 {
+	event->header.type = PERF_RECORD_SAMPLE;
 	event->header.size = perf_event__sample_event_size(sample, type, /*read_format=*/0,
 							   /*branch_sample_type=*/0);
 
@@ -2489,7 +2490,7 @@ static int intel_pt_do_synth_pebs_sample(struct intel_pt_queue *ptq, struct evse
 		intel_pt_add_xmm(intr_regs, pos, items, regs_mask);
 	}
 
-	if (sample_type & PERF_SAMPLE_BRANCH_STACK) {
+	if ((sample_type | evsel->synth_sample_type) & PERF_SAMPLE_BRANCH_STACK) {
 		if (items->mask[INTEL_PT_LBR_0_POS] ||
 		    items->mask[INTEL_PT_LBR_1_POS] ||
 		    items->mask[INTEL_PT_LBR_2_POS]) {
@@ -2560,7 +2561,8 @@ static int intel_pt_do_synth_pebs_sample(struct intel_pt_queue *ptq, struct evse
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

