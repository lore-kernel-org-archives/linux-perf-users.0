Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF8E25EFB6
	for <linux-perf-users@vger.kernel.org>; Thu, 29 May 2025 04:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748493653; cv=none; b=dtd+g/v/hYIXan1cmCfGzhdAWi017q8g6Een1RcbCPFvPEQLBe9lY/xg6d94MC+Pd4OAItRI+lgTN6vlLxOSQOAqKWQToPaCQmr53SDQy7Unb632u+e2wyo7nQHbR+VhiZwA1okY/sAEzQg9RMHO0QaFmSdwTEK4mGM7rh+nXms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748493653; c=relaxed/simple;
	bh=Kw1h3zbcO0+nbNVZ4xRKQB7TXsrfeOqnRRvda6og5T0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kaNoyQtBUftMFs+qCFpZ2fqu3YA+pvlZctOFPAo/ToaaDkZJ4AjX2neZgIuq0mR4yqzlGyjfHJxe8pjVA/3qaCaTfbH0B0Ypno5IyJMk1cKY8ZbWTTOPVb0zeEWZhjOmfXk3m7y86eXopa+PtRmp2iNlxHR9d7oCEbxc6lYLjo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AnNqYodd; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AnNqYodd"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c3e576201so1420896a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 28 May 2025 21:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748493651; x=1749098451; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NckW1LGcEQkasG851ugyz/vuJiSbVnljXnZdECeSHa8=;
        b=AnNqYoddPANTi/AGn/aTDkEVR+rVtCDBB9u5DmIcHC2sx3OQcuBsXDQLsMYQw955XS
         tROpHUSqoiBwljb5sXmlOEZ80JbitvZJ9l1UrWstag8LLb7OYbpAJVT0S+9Tdv5m9+ns
         iIYy1m5ORuZCbHAhNDqKUaVYWt/3Nmp3qx/hZz8eAbRs9k7kXPUyUgwpcQnWAKvp9PK+
         UNn1Eif99+BqviFfKyE/T7nfoUKAIsZwBebG70zfD1Jy/d42SAoQVae/MObAUDp2/2LI
         l8FR1PProKRBwY8MBfcdtLYelEwXQTISyQ2zlGwTuE6ISZ23ZEpKwF9NHMCrrsAXya79
         HnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748493651; x=1749098451;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NckW1LGcEQkasG851ugyz/vuJiSbVnljXnZdECeSHa8=;
        b=t3LvZj4spT4rDJW2YZiqk/ITN642zjtdA1zF/OZ35W+wsyn5iC9+BKOu/+yqwHP/HZ
         IKH4evGMK2rRcjvjtc3sVF1f5SfUk6dluCRJwv9OYfy3RYRoODaW3ZrrCfTzNiPOquQz
         xGCNbAj56spK8lnV+OEKChMNbvgDZPbJaWqIWPlLPI7WmN12CxR36yDZMxnl02pnSBDB
         CI25UEUk2RiQBQ88cfmY+CC31sG7EvafCDILEdlQ3g3fVlR34Q1VAXnEDLXKKinW9hYv
         l7GzJxkvCCE2ym1PwcF9N1+WMODrIF+jEI/4P21/mJQSbb+5pjdb42Ni+tbNIZ+Nsbbg
         7VpA==
X-Forwarded-Encrypted: i=1; AJvYcCUbP1b9ceg/uwLvUN4txbmNQedPV85Pfh8n19jGdsxcqMB9tMJU/W1aOF08ttWUXnzX0MxgXC1IHK36/Hyo5Vft@vger.kernel.org
X-Gm-Message-State: AOJu0YyBdOESlFv9pgXCnVssMOkz+bqztFN9J3FxwlHdGco4Y1SFl5s4
	mZEjDl5It/Kd7lCnisFCoax4awTfB0p1uKkPi0lufdL0mScVlT2+C7iQZIK7Q7D9gNiyB05lpM+
	9gcq1xs9D7g==
X-Google-Smtp-Source: AGHT+IFSmPOlM8GyBfmuiSFawgCN+6AyecpP7u+Q6vxtBq9lbBJt8pNCfZ4EmKNpJ6P55/zpi9xcHUDKwNuJ
X-Received: from pjbsi16.prod.google.com ([2002:a17:90b:5290:b0:311:b365:7e83])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:164b:b0:310:8d4a:4a97
 with SMTP id 98e67ed59e1d1-31214ee68f2mr3156851a91.15.1748493650804; Wed, 28
 May 2025 21:40:50 -0700 (PDT)
Date: Wed, 28 May 2025 21:39:58 -0700
In-Reply-To: <20250529044000.759937-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529044000.759937-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
Message-ID: <20250529044000.759937-23-irogers@google.com>
Subject: [PATCH v4 22/24] perf sample: Remove arch notion of sample parsing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Andi Kleen <ak@linux.intel.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Graham Woodward <graham.woodward@arm.com>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Li Huafei <lihuafei1@huawei.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, Chun-Tse Shao <ctshao@google.com>, 
	Yujie Liu <yujie.liu@intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, Levi Yun <yeoreum.yun@arm.com>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Matt Fleming <matt@readmodwrite.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Zixian Cai <fzczx123@gmail.com>, 
	Steve Clevenger <scclevenger@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, Martin Liska <martin.liska@hey.com>, 
	"=?UTF-8?q?Martin=20Li=C5=A1ka?=" <m.liska@foxlink.cz>, Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

By definition arch sample parsing and synthesis will inhibit certain
kinds of cross-platform record then analysis (report, script,
etc.). Remove arch_perf_parse_sample_weight and
arch_perf_synthesize_sample_weight replacing with a common
implementation. Combine perf_sample p_stage_cyc and retire_lat as
weight3 to capture the differing uses regardless of compiled for
architecture.

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
 tools/perf/util/hist.h                     |  3 ++-
 tools/perf/util/intel-tpebs.c              |  4 ++--
 tools/perf/util/sample.h                   |  6 ++---
 tools/perf/util/session.c                  |  2 +-
 tools/perf/util/sort.c                     |  7 +++---
 tools/perf/util/synthetic-events.c         | 10 ++++++--
 14 files changed, 36 insertions(+), 80 deletions(-)

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
index a061e8619267..22feec23e53d 100644
--- a/tools/perf/arch/x86/tests/sample-parsing.c
+++ b/tools/perf/arch/x86/tests/sample-parsing.c
@@ -29,7 +29,7 @@ static bool samples_same(const struct perf_sample *s1,
 {
 	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
 		COMP(ins_lat);
-		COMP(retire_lat);
+		COMP(weight3);
 	}
 
 	return true;
@@ -50,7 +50,7 @@ static int do_test(u64 sample_type)
 	struct perf_sample sample = {
 		.weight		= 101,
 		.ins_lat        = 102,
-		.retire_lat     = 103,
+		.weight3	= 103,
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
index 165668d67a6a..c6eb66dbf4b6 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2251,7 +2251,7 @@ static void process_event(struct perf_script *script,
 		fprintf(fp, "%16" PRIu16, sample->ins_lat);
 
 	if (PRINT_FIELD(RETIRE_LAT))
-		fprintf(fp, "%16" PRIu16, sample->retire_lat);
+		fprintf(fp, "%16" PRIu16, sample->weight3);
 
 	if (PRINT_FIELD(CGROUP)) {
 		const char *cgrp_name;
diff --git a/tools/perf/util/dlfilter.c b/tools/perf/util/dlfilter.c
index ddacef881af2..c0afcbd954f8 100644
--- a/tools/perf/util/dlfilter.c
+++ b/tools/perf/util/dlfilter.c
@@ -513,6 +513,7 @@ int dlfilter__do_filter_event(struct dlfilter *d,
 	d->d_addr_al   = &d_addr_al;
 
 	d_sample.size  = sizeof(d_sample);
+	d_sample.p_stage_cyc = sample->weight3;
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
index 988fe5c4137a..9f1d7ec0386f 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2847,11 +2847,18 @@ perf_event__check_size(union perf_event *event, unsigned int sample_size)
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
+		data->weight3 = weight.var3_w;
+	} else {
+		data->weight = weight.full;
+	}
 }
 
 u64 evsel__bitfield_swap_branch_flags(u64 value)
@@ -3237,7 +3244,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 
 	if (type & PERF_SAMPLE_WEIGHT_TYPE) {
 		OVERFLOW_CHECK_u64(array);
-		arch_perf_parse_sample_weight(data, array, type);
+		perf_parse_sample_weight(data, array, type);
 		array++;
 	}
 
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index afc6855327ab..64ff427040c3 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -829,7 +829,7 @@ __hists__add_entry(struct hists *hists,
 			.period	= sample->period,
 			.weight1 = sample->weight,
 			.weight2 = sample->ins_lat,
-			.weight3 = sample->p_stage_cyc,
+			.weight3 = sample->weight3,
 			.latency = al->latency,
 		},
 		.parent = sym_parent,
@@ -846,7 +846,7 @@ __hists__add_entry(struct hists *hists,
 		.time = hist_time(sample->time),
 		.weight = sample->weight,
 		.ins_lat = sample->ins_lat,
-		.p_stage_cyc = sample->p_stage_cyc,
+		.weight3 = sample->weight3,
 		.simd_flags = sample->simd_flags,
 	}, *he = hists__findnew_entry(hists, &entry, al, sample_self);
 
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index c64254088fc7..70438d03ca9c 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -255,7 +255,8 @@ struct hist_entry {
 	u64			code_page_size;
 	u64			weight;
 	u64			ins_lat;
-	u64			p_stage_cyc;
+	/** @weight3: On x86 holds retire_lat, on powerpc holds p_stage_cyc. */
+	u64			weight3;
 	s32			socket;
 	s32			cpu;
 	int			parallelism;
diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
index 4ad4bc118ea5..b8d6ed3ff3df 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -202,8 +202,8 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	 * latency value will be used. Save the number of samples and the sum of
 	 * retire latency value for each event.
 	 */
-	t->last = sample->retire_lat;
-	update_stats(&t->stats, sample->retire_lat);
+	t->last = sample->weight3;
+	update_stats(&t->stats, sample->weight3);
 	mutex_unlock(tpebs_mtx_get());
 	return 0;
 }
diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
index 0e96240052e9..fae834144ef4 100644
--- a/tools/perf/util/sample.h
+++ b/tools/perf/util/sample.h
@@ -104,10 +104,8 @@ struct perf_sample {
 	u8  cpumode;
 	u16 misc;
 	u16 ins_lat;
-	union {
-		u16 p_stage_cyc;
-		u16 retire_lat;
-	};
+	/** @weight3: On x86 holds retire_lat, on powerpc holds p_stage_cyc. */
+	u16 weight3;
 	bool no_hw_idx;		/* No hw_idx collected in branch_stack */
 	char insn[MAX_INSN];
 	void *raw_data;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 0fa17414432f..38e3d6262e8b 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1099,7 +1099,7 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 		printf("... weight: %" PRIu64 "", sample->weight);
 			if (sample_type & PERF_SAMPLE_WEIGHT_STRUCT) {
 				printf(",0x%"PRIx16"", sample->ins_lat);
-				printf(",0x%"PRIx16"", sample->p_stage_cyc);
+				printf(",0x%"PRIx16"", sample->weight3);
 			}
 		printf("\n");
 	}
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 7969d64a47bf..0ba2ce1b1c07 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -1884,21 +1884,20 @@ struct sort_entry sort_global_ins_lat = {
 static int64_t
 sort__p_stage_cyc_cmp(struct hist_entry *left, struct hist_entry *right)
 {
-	return left->p_stage_cyc - right->p_stage_cyc;
+	return left->weight3 - right->weight3;
 }
 
 static int hist_entry__global_p_stage_cyc_snprintf(struct hist_entry *he, char *bf,
 					size_t size, unsigned int width)
 {
-	return repsep_snprintf(bf, size, "%-*u", width,
-			he->p_stage_cyc * he->stat.nr_events);
+	return repsep_snprintf(bf, size, "%-*u", width, he->weight3 * he->stat.nr_events);
 }
 
 
 static int hist_entry__p_stage_cyc_snprintf(struct hist_entry *he, char *bf,
 					size_t size, unsigned int width)
 {
-	return repsep_snprintf(bf, size, "%-*u", width, he->p_stage_cyc);
+	return repsep_snprintf(bf, size, "%-*u", width, he->weight3);
 }
 
 struct sort_entry sort_local_p_stage_cyc = {
diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 638d7dd7fa4b..6afdcfd14224 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -1573,10 +1573,16 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
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
+		*array |= ((u64)data->weight3 << 48);
+	}
 }
 
 static __u64 *copy_read_group_values(__u64 *array, __u64 read_format,
@@ -1736,7 +1742,7 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
 	}
 
 	if (type & PERF_SAMPLE_WEIGHT_TYPE) {
-		arch_perf_synthesize_sample_weight(sample, array, type);
+		perf_synthesize_sample_weight(sample, array, type);
 		array++;
 	}
 
-- 
2.49.0.1204.g71687c7c1d-goog

