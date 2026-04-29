Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D71541C2F5
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 18:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486333; cv=none; b=PEBJnbDkbqq1LFvAITI2wLaDO4kUOy5SBWzfi3Oh8sutrcS/wdFj5k9lccP9qmGXuNzMcANlGM5JgiIoMeQar0zAliqKc697Rrdx09uSBrtJgAc16KCSUI1bHfyUowTuxHrgWlERDibSFwjuByP4TwVrbYav0/m+SKJpT2pamsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486333; c=relaxed/simple;
	bh=lAl3czDkD/f+DrcoXOo6L7I6tPLct5f+0+ILlwcgu0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aovbKrDueX3TpSFJEO+19ujybj6z/ILGqtDbmIbk6D0w5kBpsGQleHiSPTMyxYQ3jCgG6Mv8kPim1S+8XHammPbnr1TISqhZ4WZ14Wnojfd26kJ3O672sU1NqJqgtRCLHYnsjmuZv6ta/sDGVBLpE609puRJlNFapWQNNySaQcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gLPm+enX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gLPm+enX"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-35fbaada2f3so82141a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 11:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777486330; x=1778091130; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d/8huAkyQztqOOP4DJuZU1ZW2j6w3MCnFzNy+nKN1Kk=;
        b=gLPm+enXcv3IW4C1QsFzTPHapcXz2u+dsfRlpBiTpOss/UFYSsw33vzY/UczUQCIpk
         +P6MKNjWx9Ep3Fnmve7fl7fDeVUsRHBucY9rOSd54+evITDCUoJwZnXk7A+aDScIyQad
         mUeY6tJWkEWZe0urATlZya+ewA1/V43NBw24UJcHn+d+H/538OBWA1nObzqQSGjicn8H
         CxEeyB0agi4yrWsThdvDh+DY80Cky7nU2Wbb8UO/c0ptKX4USymkmWMOLnkc1xvu/ucC
         zen9clr8Ob+YRoYshzpMfruo4NoIh4q6HCCzKjGdssW7lLYZw49FpUUa7bAg+ifr+bZC
         Bs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777486330; x=1778091130;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/8huAkyQztqOOP4DJuZU1ZW2j6w3MCnFzNy+nKN1Kk=;
        b=few2dLwFR/RsJvGgMZ3+EKbtGGYD4Q3xos10pmnKgcJneAkFu5O28BGQoeRR23mX0t
         d0fAyshrH2iRahwhFIsjS7MNeygRmwuXax0P8xQpN6PiC1nfv6/F7z0mgo1bTKxfEgEm
         ji8T5xYUxbOzg43jANA9qiqCAXF508oG1QJfdgB3/C+ggy9zIaruYE36uTLTE/GZV93I
         YStOkSilj5SY3J5ZWZ4e+BUUrlbRFkBmwyB/a5qcgP8dRyI0Tb5BJ5yQOxBXVOS4/vlG
         DKhLAFkA9PO4oAStWvC9ps4ZlqY/HfgcqLdCPXcjQvRrcrLwpWhSIE+ug8dWVnEpWWpW
         pl0w==
X-Forwarded-Encrypted: i=1; AFNElJ9l0LnIctiahGZtovOLuvbuTp2YD7YooCKrYreB7d0QUzW1QxuHG3LAx7ifVxYSJ4/qMH0tjPcAukxsQuFqRljH@vger.kernel.org
X-Gm-Message-State: AOJu0YzXKfC2NLLA7TtBwHWUQsXRpgxiXJmvxqlelD+/kghsnCmBwP//
	DFZtpFZxkjYQ1G9puzkPjRoLITjCYkXo8tLKKcNsJL6IalEToa4Mtliy8Iuj6O0GS85CdhylajF
	3I5Z+tqQOwQ==
X-Received: from pgam24.prod.google.com ([2002:a05:6a02:2b58:b0:c79:26bb:5541])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3d19:b0:3a2:e089:ae56
 with SMTP id adf61e73a8af0-3a39c2c28f2mr9579080637.52.1777486330077; Wed, 29
 Apr 2026 11:12:10 -0700 (PDT)
Date: Wed, 29 Apr 2026 11:11:35 -0700
In-Reply-To: <20260429181136.2712655-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428070328.1880314-1-irogers@google.com> <20260429181136.2712655-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260429181136.2712655-2-irogers@google.com>
Subject: [PATCH v2 1/2] perf event: Fix size of synthesized sample with branch stacks
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	namhyung@kernel.org, thomas.falcon@intel.com
Cc: james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Synthesizing branch stacks for Intel-PT highlighed an issue where
PERF_SAMPLE_BRANCH_HW_INDEX was assumed to always be set in the
perf_event_attr branch_sample_type. This caused an incorrect size
calculation.

Fix the writing of the nr and hw_idx values during sample event
synthesis.

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
index f174bc69cec4..0c51cb4250d1 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -463,8 +463,13 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
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
 
@@ -1100,7 +1105,8 @@ static int perf_inject__sched_stat(const struct perf_tool *tool,
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
index e5835042acdf..c4ed9f10e731 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -484,8 +484,11 @@ static void arm_spe__prep_branch_stack(struct arm_spe_queue *speq)
 
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
2.54.0.545.g6539524ca2-goog

