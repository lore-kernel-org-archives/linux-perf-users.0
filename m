Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFA33DDDC0
	for <linux-perf-users@vger.kernel.org>; Mon, 18 May 2026 06:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779084760; cv=none; b=NgFr/h2FrHFGwkEMRxOr+Y3TI5PzisjQXgBHDX7XKgGELvq+a5S6gLZOqGxckwW3UVhuVK10Vqxr6w/HjZWM09EzGXz3Qnal58HBxFU4RSakJza8MD+3Yai0y2UyeP6wjXjZmiMXyk/J0Eu4gykPGvoxuK8l9Kt5klhSnLDR0Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779084760; c=relaxed/simple;
	bh=t1xA1oOzRed5qyfw/o1o+9bnNunmSCoAOQFrUNCe8V4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=o0aiYXfuuLMgwN5Z7XfqmZxdHG7REmPVKatCsK9Uys4aUHnlYNcVeh5VdksXQv9hDNYm2phlDf+GjmfHZpydiOkxepdhwyIm3exYAdzmAwC1ZDiV91cWoi15UVYyf7Ktjk2M7vhPL8mw3UZRm4DI7Y6u64The4fUbNgU4yS4iA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kEJzcfkx; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kEJzcfkx"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c802545ae0eso1097162a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 17 May 2026 23:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779084754; x=1779689554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6hapgdaRAda/5QKty040+9pXNWo3Ui9Y/ui1YKD7mjs=;
        b=kEJzcfkxxFTN1NdWiBpm7mMnUo28OtYTMQ3fpOmRKg4hNOJ5l02koEQ/OOI/Bx4gZk
         46ttDEiMZGh6344R1Nx6WrEjL7wARdADuHyxHTKIZD1nKgpA1aZPRhp9vnRjC8nJf6G9
         rwPcH1MyP0xwolVpbtcPdrWk229N1UMQv9sUoo/6AD7BU9YW6gsiO0cbDu68rj4CzEs2
         ZxEwpvgDWj5rx6YF7nj50iC7IYWZAPdBonh71Bi0E+j7xbaN942HtKydnTCKV8vMi+zb
         QAdUmCAMijVBiEkvgshOjF2MOZxFU2qHo5FQhMh2EpCjTRLpgxnz/VUmMxD1tAPklNHn
         gGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779084754; x=1779689554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hapgdaRAda/5QKty040+9pXNWo3Ui9Y/ui1YKD7mjs=;
        b=W9dZgB88d3KdzWblae57nblhIbTNg14D+dPp9izz12xJye8QlllFHXFqugbpxuaoHN
         S4c6BmYdwL8lzZhqpejm739/KSLp7oU+YKa3vm5BsDGfO+JscjbE1zEiAlzFLyuW1V1l
         P3S9HexMO5vOI/qXbE3dwEmbSEg4HJDCLVenc86VAuutd5DRnbEe8yjhuTt2CqVi/SoI
         uNUUFyG+4stx6KabHWbEJ72XoL0C8BpP/Cf+Dqdnm3GpF1IfYh4R1nnZVOK4S4wWzlj3
         hsCreR64WQqj70LJfoxwqKDFjCLfBG+n9rqvui7zoupga13b9L6TN9FlUdpfztmk0r2M
         +Nfg==
X-Forwarded-Encrypted: i=1; AFNElJ9PY6Y615+4GSxyHjD+LRBHZpokQNfZvIahUSOC39T0rKjLAMdeEnGSxsWzQ2BvxjkTgcU6a2T13YB9yeSMWtdP@vger.kernel.org
X-Gm-Message-State: AOJu0YyLnxd+aAt412Sgij4rGzx2rnFAs6MGnkQ+CKG+vDGPEHmx88ro
	H8m9rGClvAi4N15QMrVsuPFmCBGdvQyTf+NNttBI4e3flI8Oz09g3Zjwp3wJdqnvY2vzLWmUwVA
	74ps19Plwlw==
X-Received: from pfwp44.prod.google.com ([2002:a05:6a00:26ec:b0:83f:75b6:75ac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1904:b0:839:12a7:70f7
 with SMTP id d2e1a72fcca58-83f33d94ce8mr14046177b3a.31.1779084753680; Sun, 17
 May 2026 23:12:33 -0700 (PDT)
Date: Sun, 17 May 2026 23:12:27 -0700
In-Reply-To: <20260518061228.2582860-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260429181136.2712655-1-irogers@google.com> <20260518061228.2582860-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518061228.2582860-2-irogers@google.com>
Subject: [PATCH v3 1/2] perf event: Fix size of synthesized sample with branch stacks
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	thomas.falcon@intel.com
Content-Type: text/plain; charset="UTF-8"

Synthesizing branch stacks for Intel-PT highlighted an issue where
PERF_SAMPLE_BRANCH_HW_INDEX was assumed to always be set in the
perf_event_attr branch_sample_type. This caused an incorrect size
calculation.

Fix the writing of the nr and hw_idx values during sample event
synthesis.

Fixes: d3f85437ad6a ("perf evsel: Support PERF_SAMPLE_BRANCH_HW_INDEX")
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/bench/inject-buildid.c  |  9 ++++++---
 tools/perf/builtin-inject.c        | 12 +++++++++---
 tools/perf/tests/dlfilter-test.c   |  8 ++++++--
 tools/perf/tests/sample-parsing.c  |  5 +++--
 tools/perf/util/arm-spe.c          |  7 +++++--
 tools/perf/util/cs-etm.c           |  6 ++++--
 tools/perf/util/intel-bts.c        |  3 ++-
 tools/perf/util/intel-pt.c         |  7 +++++--
 tools/perf/util/synthetic-events.c | 25 ++++++++++++++++++-------
 tools/perf/util/synthetic-events.h |  6 ++++--
 10 files changed, 62 insertions(+), 26 deletions(-)

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
index a2493f1097df..6bde3cc173b2 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -465,8 +465,13 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
 	/* remove sample_type {STACK,REGS}_USER for synthesize */
 	sample_type &= ~(PERF_SAMPLE_STACK_USER | PERF_SAMPLE_REGS_USER);
 
-	perf_event__synthesize_sample(event_copy, sample_type,
-				      evsel->core.attr.read_format, sample);
+	ret = perf_event__synthesize_sample(event_copy, evsel->core.attr.sample_type,
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
index 2b31da231ef3..24714f516856 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -489,8 +489,11 @@ static void arm_spe__prep_branch_stack(struct arm_spe_queue *speq)
 
 static int arm_spe__inject_event(union perf_event *event, struct perf_sample *sample, u64 type)
 {
-	event->header.size = perf_event__sample_event_size(sample, type, 0);
-	return perf_event__synthesize_sample(event, type, 0, sample);
+	event->header.type = PERF_RECORD_SAMPLE;
+	event->header.size = perf_event__sample_event_size(sample, type, /*read_format=*/0,
+							   /*branch_sample_type=*/0);
+	return perf_event__synthesize_sample(event, type, /*read_format=*/0,
+					     /*branch_sample_type=*/0, sample);
 }
 
 static inline int
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 8a639d2e51a4..1ebc1a6a5e75 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1425,8 +1425,10 @@ static void cs_etm__update_last_branch_rb(struct cs_etm_queue *etmq,
 static int cs_etm__inject_event(union perf_event *event,
 			       struct perf_sample *sample, u64 type)
 {
-	event->header.size = perf_event__sample_event_size(sample, type, 0);
-	return perf_event__synthesize_sample(event, type, 0, sample);
+	event->header.size = perf_event__sample_event_size(sample, type, /*read_format=*/0,
+							   /*branch_sample_type=*/0);
+	return perf_event__synthesize_sample(event, type, /*read_format=*/0,
+					     /*branch_sample_type=*/0, sample);
 }
 
 
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
index fc9eec8b54b8..5142983e3243 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -1731,8 +1731,11 @@ static void intel_pt_prep_b_sample(struct intel_pt *pt,
 static int intel_pt_inject_event(union perf_event *event,
 				 struct perf_sample *sample, u64 type)
 {
-	event->header.size = perf_event__sample_event_size(sample, type, 0);
-	return perf_event__synthesize_sample(event, type, 0, sample);
+	event->header.size = perf_event__sample_event_size(sample, type, /*read_format=*/0,
+							   /*branch_sample_type=*/0);
+
+	return perf_event__synthesize_sample(event, type, /*read_format=*/0,
+					     /*branch_sample_type=*/0, sample);
 }
 
 static inline int intel_pt_opt_inject(struct intel_pt *pt,
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
2.54.0.563.g4f69b47b94-goog

