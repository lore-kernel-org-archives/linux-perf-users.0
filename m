Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3CF22D4E9
	for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 16:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747846423; cv=none; b=IoymwUhyFczhI05RDSHwHm/5zsBvsV11frx4u0UbOckk1p+PSAOIDjiiIObHyIMV7Ei7eFrsRi13eL1lQtjKUDjn+PoEOB//8y77od/H9oK6YBBjz2UOD29Gd7zAWaAxQnL1GYYeTP6C+VIwq/XVXgAcjZydVfKT77lSxtAMQVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747846423; c=relaxed/simple;
	bh=XGPnGgzCBUsqTQTUzIHZ9j9u9Mt0ozvJZArXBtpblcc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=i76uVgGfEu08HH4LwIzZO3KajjuEQqIhjp9L1X1L4nVSeiNfTrkPP8y4dJHgi6/qvYrHHiIv43K/JctSk3K7rIO5/rjIu7g8i20viZDQlrMK6ewxXbm1aVAg790izUt4YFB7oB06t0OaUPjLBLcpP5MRiJySnOJA5DHCt0by3P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TdanxflY; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TdanxflY"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-70dda56ad2aso44417997b3.2
        for <linux-perf-users@vger.kernel.org>; Wed, 21 May 2025 09:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747846420; x=1748451220; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V6jIFAo/Ym8I0roK+l5+209TEMREdGCxwReloglOFUY=;
        b=TdanxflYbld8zU8HWu4j8ypcVIUBDj9vqx+MRj8HhegWwK+vlTupfAod5viBNsoG9O
         PyTtkvC5WfGngaGD7zG5ITPlchqKypKLeNjxWyCeleQNE1gVYC8T5u2qbyXNL5rze3zW
         kXHEWm+ESo8PoHntLu5arG8+xjWy+4uXzwxdmYLOLRbQE1bLggmw1bT6nP1/kQ0wExYj
         4vR3Uu8A21x5QzMwwnlCzmesItq83hZMhk0Hu9TQ2Fa7cvaPF4XLpjdjr7w2bsWwfO2d
         SSgd7hUR+rF7OxGk+OX0t6MjGnSIjuA1JDZk/gcdWtcKO9hGliQMT6QeQBuTlxBwW7I9
         Ooig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747846420; x=1748451220;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6jIFAo/Ym8I0roK+l5+209TEMREdGCxwReloglOFUY=;
        b=XHWeleEpTa+GxKindEvCK97GtO0Ybl7Gv+VYSXfwZUTBeZbQ2RhLc7OgJrLLwOCjud
         IKuHEe6ANgiAUISINo9PfCwExXv8XAgDcBQMfUBwojFgpyGzBCmUEOw6xJ/gi8U3VI2c
         6r2rqqyJ/njxR+OIGMvCu2Zyc/9JiIgfbkTKqVhgR30kdti8ZdaTc+gcrCYFD/pE0YmD
         hF1Guc1/MF5xpRnNZuIkRTN4a2XRwnnEEmm3j/SCPOOUnPjqKkdxOMu1e345FSpU5QyV
         HsC7NzlmeUQFvNA2p9kzkuizXYCvA1OAZ6ynyz69mVQjmHu208YIkUIl/bdTBFKL2qWx
         8qYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+YWNCLySlbBNWqg16Rz+Y0MEUawgz1tGfbIlevmwIMRkwYhCaT3GcAvQYqFUtts3Eh5kXp+aCLQelbYOJdoVu@vger.kernel.org
X-Gm-Message-State: AOJu0YyWmBJnZB4GbudVDhv9okHAzGY2BpyVVZUrgUuffnQeHcqW++Rx
	hH/5DNBKnu4819PEOOER3SsWikfNaHQ81EnWlamdcRQW8dB1F317P8nzxrm5EVVKZrynngC49D2
	LhwiHEoDNBA==
X-Google-Smtp-Source: AGHT+IEsYj9g5QxD5eYiCDUk4cYJXic6Qj/oeDQ3BWSp+W1h7XlPqeb3muzqTjw7McJTCRv/dxJqkA7lCTKN
X-Received: from ywbck27.prod.google.com ([2002:a05:690c:b9b:b0:70c:b7e9:7995])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:690c:14:b0:6fb:b1dd:a00d
 with SMTP id 00721157ae682-70ca7b8eb55mr273363127b3.30.1747846419645; Wed, 21
 May 2025 09:53:39 -0700 (PDT)
Date: Wed, 21 May 2025 09:53:15 -0700
In-Reply-To: <20250521165317.713463-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250521165317.713463-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1143.g0be31eac6b-goog
Message-ID: <20250521165317.713463-2-irogers@google.com>
Subject: [PATCH v3 1/3] perf sample: Remove arch notion of sample parsing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, Leo Yan <leo.yan@arm.com>, 
	Yujie Liu <yujie.liu@intel.com>, Graham Woodward <graham.woodward@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Chun-Tse Shao <ctshao@google.com>, Ben Gainey <ben.gainey@arm.com>, Song Liu <song@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"

By definition arch sample parsing and synthesis will inhibit certain
kinds of cross-platform record then analysis (report, script,
etc.). Remove arch_perf_parse_sample_weight and
arch_perf_synthesize_sample_weight replacing with a common
implementation. Combine perf_sample p_stage_cyc and retire_lat to
capture the differing uses regardless of compiled for architecture.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/powerpc/util/event.c       | 26 ---------------------
 tools/perf/arch/x86/tests/sample-parsing.c |  4 ++--
 tools/perf/arch/x86/util/event.c           | 27 ----------------------
 tools/perf/builtin-script.c                |  2 +-
 tools/perf/util/dlfilter.c                 |  2 +-
 tools/perf/util/event.h                    |  2 --
 tools/perf/util/evsel.c                    | 17 ++++++++++----
 tools/perf/util/hist.c                     |  4 ++--
 tools/perf/util/hist.h                     |  2 +-
 tools/perf/util/intel-tpebs.c              |  4 ++--
 tools/perf/util/sample.h                   |  5 +---
 tools/perf/util/session.c                  |  2 +-
 tools/perf/util/sort.c                     |  6 ++---
 tools/perf/util/synthetic-events.c         | 10 ++++++--
 14 files changed, 34 insertions(+), 79 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/event.c b/tools/perf/arch/powerpc/util/event.c
index 77d8cc2b5691..024ac8b54c33 100644
--- a/tools/perf/arch/powerpc/util/event.c
+++ b/tools/perf/arch/powerpc/util/event.c
@@ -11,32 +11,6 @@
 #include "../../../util/debug.h"
 #include "../../../util/sample.h"
 
-void arch_perf_parse_sample_weight(struct perf_sample *data,
-				   const __u64 *array, u64 type)
-{
-	union perf_sample_weight weight;
-
-	weight.full = *array;
-	if (type & PERF_SAMPLE_WEIGHT)
-		data->weight = weight.full;
-	else {
-		data->weight = weight.var1_dw;
-		data->ins_lat = weight.var2_w;
-		data->p_stage_cyc = weight.var3_w;
-	}
-}
-
-void arch_perf_synthesize_sample_weight(const struct perf_sample *data,
-					__u64 *array, u64 type)
-{
-	*array = data->weight;
-
-	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
-		*array &= 0xffffffff;
-		*array |= ((u64)data->ins_lat << 32);
-	}
-}
-
 const char *arch_perf_header_entry(const char *se_header)
 {
 	if (!strcmp(se_header, "Local INSTR Latency"))
diff --git a/tools/perf/arch/x86/tests/sample-parsing.c b/tools/perf/arch/x86/tests/sample-parsing.c
index a061e8619267..95d8f7f1d2fb 100644
--- a/tools/perf/arch/x86/tests/sample-parsing.c
+++ b/tools/perf/arch/x86/tests/sample-parsing.c
@@ -29,7 +29,7 @@ static bool samples_same(const struct perf_sample *s1,
 {
 	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
 		COMP(ins_lat);
-		COMP(retire_lat);
+		COMP(p_stage_cyc_or_retire_lat);
 	}
 
 	return true;
@@ -50,7 +50,7 @@ static int do_test(u64 sample_type)
 	struct perf_sample sample = {
 		.weight		= 101,
 		.ins_lat        = 102,
-		.retire_lat     = 103,
+		.p_stage_cyc_or_retire_lat = 103,
 	};
 	struct perf_sample sample_out;
 	size_t i, sz, bufsz;
diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
index a0400707180c..576c1c36046c 100644
--- a/tools/perf/arch/x86/util/event.c
+++ b/tools/perf/arch/x86/util/event.c
@@ -92,33 +92,6 @@ int perf_event__synthesize_extra_kmaps(const struct perf_tool *tool,
 
 #endif
 
-void arch_perf_parse_sample_weight(struct perf_sample *data,
-				   const __u64 *array, u64 type)
-{
-	union perf_sample_weight weight;
-
-	weight.full = *array;
-	if (type & PERF_SAMPLE_WEIGHT)
-		data->weight = weight.full;
-	else {
-		data->weight = weight.var1_dw;
-		data->ins_lat = weight.var2_w;
-		data->retire_lat = weight.var3_w;
-	}
-}
-
-void arch_perf_synthesize_sample_weight(const struct perf_sample *data,
-					__u64 *array, u64 type)
-{
-	*array = data->weight;
-
-	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
-		*array &= 0xffffffff;
-		*array |= ((u64)data->ins_lat << 32);
-		*array |= ((u64)data->retire_lat << 48);
-	}
-}
-
 const char *arch_perf_header_entry(const char *se_header)
 {
 	if (!strcmp(se_header, "Local Pipeline Stage Cycle"))
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 6c3bf74dd78c..c02c435e0f0b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2251,7 +2251,7 @@ static void process_event(struct perf_script *script,
 		fprintf(fp, "%16" PRIu16, sample->ins_lat);
 
 	if (PRINT_FIELD(RETIRE_LAT))
-		fprintf(fp, "%16" PRIu16, sample->retire_lat);
+		fprintf(fp, "%16" PRIu16, sample->p_stage_cyc_or_retire_lat);
 
 	if (PRINT_FIELD(CGROUP)) {
 		const char *cgrp_name;
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index ddacef881af2..d5fd6d34a17c 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -513,6 +513,7 @@ int dlfilter__do_filter_event(struct dlfilter *d,
 	d->d_addr_al   = &d_addr_al;
 
 	d_sample.size  = sizeof(d_sample);
+	d_sample.p_stage_cyc = sample->p_stage_cyc_or_retire_lat;
 	d_ip_al.size   = 0; /* To indicate d_ip_al is not initialized */
 	d_addr_al.size = 0; /* To indicate d_addr_al is not initialized */
 
@@ -526,7 +527,6 @@ int dlfilter__do_filter_event(struct dlfilter *d,
 	ASSIGN(period);
 	ASSIGN(weight);
 	ASSIGN(ins_lat);
-	ASSIGN(p_stage_cyc);
 	ASSIGN(transaction);
 	ASSIGN(insn_cnt);
 	ASSIGN(cyc_cnt);
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 664bf39567ce..119bce37f4fd 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -390,8 +390,6 @@ extern unsigned int proc_map_timeout;
 #define PAGE_SIZE_NAME_LEN	32
 char *get_page_size_name(u64 size, char *str);
 
-void arch_perf_parse_sample_weight(struct perf_sample *data, const __u64 *array, u64 type);
-void arch_perf_synthesize_sample_weight(const struct perf_sample *data, __u64 *array, u64 type);
 const char *arch_perf_header_entry(const char *se_header);
 int arch_support_sort_key(const char *sort_key);
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d55482f094bf..27de167855ee 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2846,11 +2846,18 @@ perf_event__check_size(union perf_event *event, unsigned int sample_size)
 	return 0;
 }
 
-void __weak arch_perf_parse_sample_weight(struct perf_sample *data,
-					  const __u64 *array,
-					  u64 type __maybe_unused)
+static void perf_parse_sample_weight(struct perf_sample *data, const __u64 *array, u64 type)
 {
-	data->weight = *array;
+	union perf_sample_weight weight;
+
+	weight.full = *array;
+	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
+		data->weight = weight.var1_dw;
+		data->ins_lat = weight.var2_w;
+		data->p_stage_cyc_or_retire_lat = weight.var3_w;
+	} else {
+		data->weight = weight.full;
+	}
 }
 
 u64 evsel__bitfield_swap_branch_flags(u64 value)
@@ -3236,7 +3243,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 
 	if (type & PERF_SAMPLE_WEIGHT_TYPE) {
 		OVERFLOW_CHECK_u64(array);
-		arch_perf_parse_sample_weight(data, array, type);
+		perf_parse_sample_weight(data, array, type);
 		array++;
 	}
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index afc6855327ab..ae9803dca0b1 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -829,7 +829,7 @@ __hists__add_entry(struct hists *hists,
 			.period	= sample->period,
 			.weight1 = sample->weight,
 			.weight2 = sample->ins_lat,
-			.weight3 = sample->p_stage_cyc,
+			.weight3 = sample->p_stage_cyc_or_retire_lat,
 			.latency = al->latency,
 		},
 		.parent = sym_parent,
@@ -846,7 +846,7 @@ __hists__add_entry(struct hists *hists,
 		.time = hist_time(sample->time),
 		.weight = sample->weight,
 		.ins_lat = sample->ins_lat,
-		.p_stage_cyc = sample->p_stage_cyc,
+		.p_stage_cyc_or_retire_lat = sample->p_stage_cyc_or_retire_lat,
 		.simd_flags = sample->simd_flags,
 	}, *he = hists__findnew_entry(hists, &entry, al, sample_self);
 
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index c64254088fc7..67033bdabcf4 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -255,7 +255,7 @@ struct hist_entry {
 	u64			code_page_size;
 	u64			weight;
 	u64			ins_lat;
-	u64			p_stage_cyc;
+	u64			p_stage_cyc_or_retire_lat;
 	s32			socket;
 	s32			cpu;
 	int			parallelism;
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 4ad4bc118ea5..ec2f3ecf1e1c 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -202,8 +202,8 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	 * latency value will be used. Save the number of samples and the sum of
 	 * retire latency value for each event.
 	 */
-	t->last = sample->retire_lat;
-	update_stats(&t->stats, sample->retire_lat);
+	t->last = sample->p_stage_cyc_or_retire_lat;
+	update_stats(&t->stats, sample->p_stage_cyc_or_retire_lat);
 	mutex_unlock(tpebs_mtx_get());
 	return 0;
 }
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 0e96240052e9..3330d18fb5fd 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -104,10 +104,7 @@ struct perf_sample {
 	u8  cpumode;
 	u16 misc;
 	u16 ins_lat;
-	union {
-		u16 p_stage_cyc;
-		u16 retire_lat;
-	};
+	u16 p_stage_cyc_or_retire_lat;
 	bool no_hw_idx;		/* No hw_idx collected in branch_stack */
 	char insn[MAX_INSN];
 	void *raw_data;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a320672c264e..451bc24ccfba 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1094,7 +1094,7 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 		printf("... weight: %" PRIu64 "", sample->weight);
 			if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
 				printf(",0x%"PRIx16"", sample->ins_lat);
-				printf(",0x%"PRIx16"", sample->p_stage_cyc);
+				printf(",0x%"PRIx16"", sample->p_stage_cyc_or_retire_lat);
 			}
 		printf("\n");
 	}
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 45e654653960..dda4ef0b5a73 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1879,21 +1879,21 @@ struct sort_entry sort_global_ins_lat = {
 static int64_t
 sort__p_stage_cyc_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	return left->p_stage_cyc - right->p_stage_cyc;
+	return left->p_stage_cyc_or_retire_lat - right->p_stage_cyc_or_retire_lat;
 }
 
 static int hist_entry__global_p_stage_cyc_snprintf(struct hist_entry *he, char *bf,
 					size_t size, unsigned int width)
 {
 	return repsep_snprintf(bf, size, "%-*u", width,
-			he->p_stage_cyc * he->stat.nr_events);
+			he->p_stage_cyc_or_retire_lat * he->stat.nr_events);
 }
 
 
 static int hist_entry__p_stage_cyc_snprintf(struct hist_entry *he, char *bf,
 					size_t size, unsigned int width)
 {
-	return repsep_snprintf(bf, size, "%-*u", width, he->p_stage_cyc);
+	return repsep_snprintf(bf, size, "%-*u", width, he->p_stage_cyc_or_retire_lat);
 }
 
 struct sort_entry sort_local_p_stage_cyc = {
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 2fc4d0537840..449a41900fc4 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1567,10 +1567,16 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 	return result;
 }
 
-void __weak arch_perf_synthesize_sample_weight(const struct perf_sample *data,
+static void perf_synthesize_sample_weight(const struct perf_sample *data,
 					       __u64 *array, u64 type __maybe_unused)
 {
 	*array = data->weight;
+
+	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
+		*array &= 0xffffffff;
+		*array |= ((u64)data->ins_lat << 32);
+		*array |= ((u64)data->p_stage_cyc_or_retire_lat << 48);
+	}
 }
 
 static __u64 *copy_read_group_values(__u64 *array, __u64 read_format,
@@ -1730,7 +1736,7 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 	}
 
 	if (type & PERF_SAMPLE_WEIGHT_TYPE) {
-		arch_perf_synthesize_sample_weight(sample, array, type);
+		perf_synthesize_sample_weight(sample, array, type);
 		array++;
 	}
 
-- 
2.49.0.1143.g0be31eac6b-goog

