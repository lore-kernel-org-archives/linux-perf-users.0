Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84501388E6C
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 22:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779144213; cv=none; b=Gkivnq5DIU0GT7dn2pDRx44Z5XBtRwJ7ecTnjg4wxCPuY9OohAB0Ni2e6mgByHKxQ5jrhTXeN7ZRTUWZcTRPFNSOqBkXPS410rkugNRynRGh/8DJJsw6KWwE7vj6byXrJ+v+cHHGuG/jXYmxE2tZ3Ht+YiE+BLs7goLiTNvgkVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779144213; c=relaxed/simple;
	bh=XC4fMTsGdk1JztdyyKzSEMGeqKnDzi+Nfb9ZoOo5HFc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YC6oKsroHol37Gl7mFCUvDhvFlNGzDiG0QfOYVy1w94h9g6j5dDyoz3ieOewWf51/wNapIJ5d71vAL5TkJbFj19cofhomKzc6osps67pgoU+O4QoApYI9D8FoKezcMRFN308zjz+tgUy67KeU6qrdOqNgQOVPD33xicJvcJGXBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dzz/kowo; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzz/kowo"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1353bfdbf99so643761c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 15:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779144211; x=1779749011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m9cZgG5XMktoBNuhN5wGXs6d6FURKoW94bCnI/zbzTw=;
        b=dzz/kowobIWY0H8P1WqkQeb3sYKwd5BcMtd/vJPq69DHMMBY/KvWXOG/FFbaDd7Aop
         i+T8Gfl+8rBGrDmutyi39Y/GJ8q4ZjGchVya+ihlhoGq5SZml4yMiYDDWrpW6Vy8KhMs
         g3a+bGH4Xiw0WNPFquqSitSgGHsZkkc/8uiRzI0M8gs95/q2/giXFwQ1HZWdutUJ6iFH
         WZhQ7SZlxS2Qp16TqViSpyvC6E/vlTR8uKFP2cSmPBCuEb2EKmhzaDB55WzN/17xIiEk
         W/yyW7x445x90ludFyE1UgoGF9Dz43wBfXj8KgpSPUNZT1XFCo+eoDeAXxFki2dbAjNf
         Ob4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779144211; x=1779749011;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m9cZgG5XMktoBNuhN5wGXs6d6FURKoW94bCnI/zbzTw=;
        b=AQW9Il9db3M9q1trk64VcqhT7Zs8k1RHb5YSKgldKVu78EQLjrKcVzypH2hlDO77WU
         nPYWTlsHQOI1GjJ9wSDMQ36yqedsVPo98nOs4eITqc/aq+6qpW2dqlDkWwzOuvcLhWR/
         u3sJY3nxwcO3e5SLP09m6vR9cho3AbZ2a5U2V2RoBWZGeGOVuo1W+FB2GmYTBYueDCDL
         3DaxcOa88G9CWSOJwqgO4DWwdQ/mJczF15jkLcAXrh9qJ7XSSMZxM0dCKK6swxKgnP0z
         TJM9dykWIMlnWYB9679Vi6i0toWMvP6hww0WymL5T3Lt8V0BVL0D7LyR7UMfUNeqVCnj
         BKzw==
X-Forwarded-Encrypted: i=1; AFNElJ+f94elLvpapYWPRpnbH7bIudPcHJT3ZWHvmzpSUPS9oDp2CWZG51maZOO+1WdI4fVDfS9Tt99Vaid2y1TFDSIS@vger.kernel.org
X-Gm-Message-State: AOJu0YxNLH9kxcWUA8G+4x93pP454oZ9bvkWn5x4b8z14Bjc1zPxtWtp
	4oP0FReVjgB+adwYULpmWBTpqQQFRIHR1nbJCEl8ezGSNpC7mRd5NN2G5pA4hdvA9VtXT8NF5pA
	5xKZSmN6Hvw==
X-Received: from dyaw18-n1.prod.google.com ([2002:a05:693c:4152:10b0:2da:5e63:c8e4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7494:b0:2ef:1d11:18ae
 with SMTP id 5a478bee46e88-303986a1931mr7429227eec.28.1779144210347; Mon, 18
 May 2026 15:43:30 -0700 (PDT)
Date: Mon, 18 May 2026 15:43:24 -0700
In-Reply-To: <20260518224325.3037838-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260518203805.2955241-1-irogers@google.com> <20260518224325.3037838-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.631.ge1b05301d1-goog
Message-ID: <20260518224325.3037838-2-irogers@google.com>
Subject: [PATCH v8 1/2] perf event: Fix size of synthesized sample with branch stacks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, thomas.falcon@intel.com
Content-Type: text/plain; charset="UTF-8"

Synthesizing branch stacks for Intel-PT highlighted an issue where
PERF_SAMPLE_BRANCH_HW_INDEX was assumed to always be set in the
perf_event_attr branch_sample_type. This caused an incorrect size
calculation.

Fix the writing of the nr and hw_idx values during sample event
synthesis by passing the branch_sample_type into the sample size
and synthesis functions. Also update hardware tracers (Intel PT,
ARM SPE, CS-ETM) to retrieve and pass their branch_sample_type
dynamically to prevent payload misalignment.

Fixes: d3f85437ad6a ("perf evsel: Support PERF_SAMPLE_BRANCH_HW_INDEX")
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/bench/inject-buildid.c  |  9 ++++++---
 tools/perf/builtin-inject.c        | 12 +++++++++---
 tools/perf/tests/dlfilter-test.c   |  8 ++++++--
 tools/perf/tests/sample-parsing.c  |  5 +++--
 tools/perf/util/arm-spe.c          | 28 ++++++++++++++++++++++++----
 tools/perf/util/cs-etm.c           | 28 +++++++++++++++++++++++-----
 tools/perf/util/intel-bts.c        |  3 ++-
 tools/perf/util/intel-pt.c         | 27 +++++++++++++++++++++++----
 tools/perf/util/synthetic-events.c | 25 ++++++++++++++++++-------
 tools/perf/util/synthetic-events.h |  6 ++++--
 10 files changed, 118 insertions(+), 33 deletions(-)

diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
index aad572a78d7f..bfd2c5ec9488 100644
--- a/tools/perf/bench/inject-buildid.c
+++ b/tools/perf/bench/inject-buildid.c
@@ -228,9 +228,12 @@ static ssize_t synthesize_sample(struct bench_data *data, struct bench_dso *dso,
 
 	event.header.type = PERF_RECORD_SAMPLE;
 	event.header.misc = PERF_RECORD_MISC_USER;
-	event.header.size = perf_event__sample_event_size(&sample, bench_sample_type, 0);
-
-	perf_event__synthesize_sample(&event, bench_sample_type, 0, &sample);
+	event.header.size = perf_event__sample_event_size(&sample, bench_sample_type,
+							   /*read_format=*/0,
+							   /*branch_sample_type=*/0);
+	perf_event__synthesize_sample(&event, bench_sample_type,
+				      /*read_format=*/0,
+				      /*branch_sample_type=*/0, &sample);
 
 	return writen(data->input_pipe[1], &event, event.header.size);
 }
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index a2493f1097df..2f20e782c7f2 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -465,8 +465,13 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
 	/* remove sample_type {STACK,REGS}_USER for synthesize */
 	sample_type &= ~(PERF_SAMPLE_STACK_USER | PERF_SAMPLE_REGS_USER);
 
-	perf_event__synthesize_sample(event_copy, sample_type,
-				      evsel->core.attr.read_format, sample);
+	ret = perf_event__synthesize_sample(event_copy, sample_type,
+					    evsel->core.attr.read_format,
+					    evsel->core.attr.branch_sample_type, sample);
+	if (ret) {
+		pr_err("Failed to synthesize sample\n");
+		return ret;
+	}
 	return perf_event__repipe_synth(tool, event_copy);
 }
 
@@ -1102,7 +1107,8 @@ static int perf_inject__sched_stat(const struct perf_tool *tool,
 	sample_sw.period = sample->period;
 	sample_sw.time	 = sample->time;
 	perf_event__synthesize_sample(event_sw, evsel->core.attr.sample_type,
-				      evsel->core.attr.read_format, &sample_sw);
+				      evsel->core.attr.read_format,
+				      evsel->core.attr.branch_sample_type, &sample_sw);
 	build_id__mark_dso_hit(tool, event_sw, &sample_sw, evsel, machine);
 	ret = perf_event__repipe(tool, event_sw, &sample_sw, machine);
 	perf_sample__exit(&sample_sw);
diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-test.c
index e63790c61d53..204663571943 100644
--- a/tools/perf/tests/dlfilter-test.c
+++ b/tools/perf/tests/dlfilter-test.c
@@ -188,8 +188,12 @@ static int write_sample(struct test_data *td, u64 sample_type, u64 id, pid_t pid
 
 	event->header.type = PERF_RECORD_SAMPLE;
 	event->header.misc = PERF_RECORD_MISC_USER;
-	event->header.size = perf_event__sample_event_size(&sample, sample_type, 0);
-	err = perf_event__synthesize_sample(event, sample_type, 0, &sample);
+	event->header.size = perf_event__sample_event_size(&sample, sample_type,
+							   /*read_format=*/0,
+							   /*branch_sample_type=*/0);
+	err = perf_event__synthesize_sample(event, sample_type,
+					    /*read_format=*/0,
+					    /*branch_sample_type=*/0, &sample);
 	if (err)
 		return test_result("perf_event__synthesize_sample() failed", TEST_FAIL);
 
diff --git a/tools/perf/tests/sample-parsing.c b/tools/perf/tests/sample-parsing.c
index a7327c942ca2..55f0b73ca20e 100644
--- a/tools/perf/tests/sample-parsing.c
+++ b/tools/perf/tests/sample-parsing.c
@@ -310,7 +310,8 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 		sample.read.one.lost  = 1;
 	}
 
-	sz = perf_event__sample_event_size(&sample, sample_type, read_format);
+	sz = perf_event__sample_event_size(&sample, sample_type, read_format,
+					   evsel.core.attr.branch_sample_type);
 	bufsz = sz + 4096; /* Add a bit for overrun checking */
 	event = malloc(bufsz);
 	if (!event) {
@@ -324,7 +325,7 @@ static int do_test(u64 sample_type, u64 sample_regs, u64 read_format)
 	event->header.size = sz;
 
 	err = perf_event__synthesize_sample(event, sample_type, read_format,
-					    &sample);
+					    evsel.core.attr.branch_sample_type, &sample);
 	if (err) {
 		pr_debug("%s failed for sample_type %#"PRIx64", error %d\n",
 			 "perf_event__synthesize_sample", sample_type, err);
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 2b31da231ef3..31f05f467810 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -487,10 +487,30 @@ static void arm_spe__prep_branch_stack(struct arm_spe_queue *speq)
 	bstack->hw_idx = -1ULL;
 }
 
-static int arm_spe__inject_event(union perf_event *event, struct perf_sample *sample, u64 type)
+static int arm_spe__inject_event(struct arm_spe *spe, union perf_event *event,
+				 struct perf_sample *sample, u64 type)
 {
-	event->header.size = perf_event__sample_event_size(sample, type, 0);
-	return perf_event__synthesize_sample(event, type, 0, sample);
+	struct evsel *evsel = sample->evsel;
+	u64 branch_sample_type = 0;
+	size_t sz;
+
+	if (!evsel && spe->session && spe->session->evlist)
+		evsel = evlist__id2evsel(spe->session->evlist, sample->id);
+
+	if (evsel)
+		branch_sample_type = evsel->core.attr.branch_sample_type;
+
+	event->header.type = PERF_RECORD_SAMPLE;
+	sz = perf_event__sample_event_size(sample, type, /*read_format=*/0,
+					   branch_sample_type);
+	if (sz >= PERF_SAMPLE_MAX_SIZE) {
+		pr_err("Sample size %zu exceeds max size %d\n", sz, PERF_SAMPLE_MAX_SIZE);
+		return -EFAULT;
+	}
+	event->header.size = sz;
+
+	return perf_event__synthesize_sample(event, type, /*read_format=*/0,
+					     branch_sample_type, sample);
 }
 
 static inline int
@@ -502,7 +522,7 @@ arm_spe_deliver_synth_event(struct arm_spe *spe,
 	int ret;
 
 	if (spe->synth_opts.inject) {
-		ret = arm_spe__inject_event(event, sample, spe->sample_type);
+		ret = arm_spe__inject_event(spe, event, sample, spe->sample_type);
 		if (ret)
 			return ret;
 	}
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8a639d2e51a4..6ec48de29441 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1422,11 +1422,29 @@ static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq,
 		bs->nr += 1;
 }
 
-static int cs_etm__inject_event(union perf_event *event,
+static int cs_etm__inject_event(struct cs_etm_auxtrace *etm, union perf_event *event,
 			       struct perf_sample *sample, u64 type)
 {
-	event->header.size = perf_event__sample_event_size(sample, type, 0);
-	return perf_event__synthesize_sample(event, type, 0, sample);
+	struct evsel *evsel = sample->evsel;
+	u64 branch_sample_type = 0;
+	size_t sz;
+
+	if (!evsel && etm->session && etm->session->evlist)
+		evsel = evlist__id2evsel(etm->session->evlist, sample->id);
+
+	if (evsel)
+		branch_sample_type = evsel->core.attr.branch_sample_type;
+
+	sz = perf_event__sample_event_size(sample, type, /*read_format=*/0,
+					   branch_sample_type);
+	if (sz >= PERF_SAMPLE_MAX_SIZE) {
+		pr_err("Sample size %zu exceeds max size %d\n", sz, PERF_SAMPLE_MAX_SIZE);
+		return -EFAULT;
+	}
+	event->header.size = sz;
+
+	return perf_event__synthesize_sample(event, type, /*read_format=*/0,
+					     branch_sample_type, sample);
 }
 
 
@@ -1592,7 +1610,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 		sample.branch_stack = tidq->last_branch;
 
 	if (etm->synth_opts.inject) {
-		ret = cs_etm__inject_event(event, &sample,
+		ret = cs_etm__inject_event(etm, event, &sample,
 					   etm->instructions_sample_type);
 		if (ret)
 			return ret;
@@ -1667,7 +1685,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq,
 	}
 
 	if (etm->synth_opts.inject) {
-		ret = cs_etm__inject_event(event, &sample,
+		ret = cs_etm__inject_event(etm, event, &sample,
 					   etm->branches_sample_type);
 		if (ret)
 			return ret;
diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 382255393fb3..0b18ebd13f7c 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -303,7 +303,8 @@ static int intel_bts_synth_branch_sample(struct intel_bts_queue *btsq,
 		event.sample.header.size = bts->branches_event_size;
 		ret = perf_event__synthesize_sample(&event,
 						    bts->branches_sample_type,
-						    0, &sample);
+						    /*read_format=*/0, /*branch_sample_type=*/0,
+						    &sample);
 		if (ret)
 			return ret;
 	}
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index fc9eec8b54b8..dd2637678b40 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1728,11 +1728,30 @@ static void intel_pt_prep_b_sample(struct intel_pt *pt,
 	event->sample.header.misc = sample->cpumode;
 }
 
-static int intel_pt_inject_event(union perf_event *event,
+static int intel_pt_inject_event(struct intel_pt *pt, union perf_event *event,
 				 struct perf_sample *sample, u64 type)
 {
-	event->header.size = perf_event__sample_event_size(sample, type, 0);
-	return perf_event__synthesize_sample(event, type, 0, sample);
+	struct evsel *evsel = sample->evsel;
+	u64 branch_sample_type = 0;
+	size_t sz;
+
+	if (!evsel && pt->session && pt->session->evlist)
+		evsel = evlist__id2evsel(pt->session->evlist, sample->id);
+
+	if (evsel)
+		branch_sample_type = evsel->core.attr.branch_sample_type;
+
+	event->header.type = PERF_RECORD_SAMPLE;
+	sz = perf_event__sample_event_size(sample, type, /*read_format=*/0,
+					   branch_sample_type);
+	if (sz >= PERF_SAMPLE_MAX_SIZE) {
+		pr_err("Sample size %zu exceeds max size %d\n", sz, PERF_SAMPLE_MAX_SIZE);
+		return -EFAULT;
+	}
+	event->header.size = sz;
+
+	return perf_event__synthesize_sample(event, type, /*read_format=*/0,
+					     branch_sample_type, sample);
 }
 
 static inline int intel_pt_opt_inject(struct intel_pt *pt,
@@ -1742,7 +1761,7 @@ static inline int intel_pt_opt_inject(struct intel_pt *pt,
 	if (!pt->synth_opts.inject)
 		return 0;
 
-	return intel_pt_inject_event(event, sample, type);
+	return intel_pt_inject_event(pt, event, sample, type);
 }
 
 static int intel_pt_deliver_synth_event(struct intel_pt *pt,
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 85bee747f4cd..2461f25a4d7d 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1455,7 +1455,8 @@ int perf_event__synthesize_stat_round(const struct perf_tool *tool,
 	return process(tool, (union perf_event *) &event, NULL, machine);
 }
 
-size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type, u64 read_format)
+size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type, u64 read_format,
+				     u64 branch_sample_type)
 {
 	size_t sz, result = sizeof(struct perf_record_sample);
 
@@ -1515,8 +1516,10 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 
 	if (type & PERF_SAMPLE_BRANCH_STACK) {
 		sz = sample->branch_stack->nr * sizeof(struct branch_entry);
-		/* nr, hw_idx */
-		sz += 2 * sizeof(u64);
+		/* nr */
+		sz += sizeof(u64);
+		if (branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX)
+			sz += sizeof(u64);
 		result += sz;
 	}
 
@@ -1605,7 +1608,7 @@ static __u64 *copy_read_group_values(__u64 *array, __u64 read_format,
 }
 
 int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_format,
-				  const struct perf_sample *sample)
+				  u64 branch_sample_type, const struct perf_sample *sample)
 {
 	__u64 *array;
 	size_t sz;
@@ -1719,9 +1722,17 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 
 	if (type & PERF_SAMPLE_BRANCH_STACK) {
 		sz = sample->branch_stack->nr * sizeof(struct branch_entry);
-		/* nr, hw_idx */
-		sz += 2 * sizeof(u64);
-		memcpy(array, sample->branch_stack, sz);
+
+		*array++ = sample->branch_stack->nr;
+
+		if (branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX) {
+			if (sample->no_hw_idx)
+				*array++ = 0;
+			else
+				*array++ = sample->branch_stack->hw_idx;
+		}
+
+		memcpy(array, perf_sample__branch_entries((struct perf_sample *)sample), sz);
 		array = (void *)array + sz;
 	}
 
diff --git a/tools/perf/util/synthetic-events.h b/tools/perf/util/synthetic-events.h
index b0edad0c3100..8c7f49f9ccf5 100644
--- a/tools/perf/util/synthetic-events.h
+++ b/tools/perf/util/synthetic-events.h
@@ -81,7 +81,8 @@ int perf_event__synthesize_mmap_events(const struct perf_tool *tool, union perf_
 int perf_event__synthesize_modules(const struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_namespaces(const struct perf_tool *tool, union perf_event *event, pid_t pid, pid_t tgid, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_cgroups(const struct perf_tool *tool, perf_event__handler_t process, struct machine *machine);
-int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_format, const struct perf_sample *sample);
+int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_format,
+				  u64 branch_sample_type, const struct perf_sample *sample);
 int perf_event__synthesize_stat_config(const struct perf_tool *tool, struct perf_stat_config *config, perf_event__handler_t process, struct machine *machine);
 int perf_event__synthesize_stat_events(struct perf_stat_config *config, const struct perf_tool *tool, struct evlist *evlist, perf_event__handler_t process, bool attrs);
 int perf_event__synthesize_stat_round(const struct perf_tool *tool, u64 time, u64 type, perf_event__handler_t process, struct machine *machine);
@@ -97,7 +98,8 @@ void perf_event__synthesize_final_bpf_metadata(struct perf_session *session,
 
 int perf_tool__process_synth_event(const struct perf_tool *tool, union perf_event *event, struct machine *machine, perf_event__handler_t process);
 
-size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type, u64 read_format);
+size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
+				     u64 read_format, u64 branch_sample_type);
 
 int __machine__synthesize_threads(struct machine *machine, const struct perf_tool *tool,
 				  struct target *target, struct perf_thread_map *threads,
-- 
2.54.0.631.ge1b05301d1-goog

