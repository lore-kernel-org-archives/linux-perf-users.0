Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C93E230D2B
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Jun 2025 04:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751086287; cv=none; b=pUcPnSM7xyPWjctyfFvJqGDvV0fw/o6DvmqRg0qOGhThjJ+4vQRRwlr1LYxhDOLaujspnXdOQHTG5PDNLofkefXwLXJFe1Az6l4ze61Bl2h0nbC/8QKGkm8z9AwO5knMCu3EFp9uudlve9iBzAbqe1Ig7Adkx4qSbtflf3EPkjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751086287; c=relaxed/simple;
	bh=5FsDw48buAecwtMy/hBT70kgQGSy0inCH2lcTBltcL0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=lJIWjOE/yryFq1osTOVOl1O1weqd6+7wKbhRGO00uVqrK9ZjoEGwiTDd4MYQ46zVc2mhxJuG3tAyQxqd7u/MzKQ81oPFS9C4f35Nx1+4hRTA/fo9cjfrimqh6vAYni30oP0MErCs9U1ZBo7gdZnadgPhDZSvm1AoQPKmoIOyQpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KvV975Fd; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KvV975Fd"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748cf01de06so1350591b3a.3
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Jun 2025 21:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751086285; x=1751691085; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e+GqeQQJ4Z8sy69KHsPcUjo7exe6nixy2bC0Qa24k6A=;
        b=KvV975Fd27/rQGczOJoM7jWtLFpS4AJDOERgrMe1dSKEaJLMjPQVYhBcMq/kDRXhKX
         p3queUxdfldpDOenvsxG1XR+DP/95PqxMnTxpKfe5WGVaguHOIVcQgwXkAtNkFSOUw/7
         SpV95LSQEUaCRoOfW8z4cWqU4EKun8QfpVBaopFea8gkPfFD2atON2vpQr9nG7NvliGP
         4nHCdpQ4Jk6K8rLPmujuPx/nyQgS9ierjqyG+Rtj1J1Dmz4q9g3IqXpwAiJvu1mg7I/8
         1H+LT+Jba6rm1lX32SirdxBnW9x4s8LaToxH40ZgQSjUlHasw+ZYyes19uJhc+rK+eAJ
         Lseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751086285; x=1751691085;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+GqeQQJ4Z8sy69KHsPcUjo7exe6nixy2bC0Qa24k6A=;
        b=IwUpMhWxmgJxUm47Ci8qsXhJ6GtzFUgL4aOq9UDshJjVcObIiHqNmJRr5eoqBqTEBh
         to/BLNBUC54fIGBcsDBxRiJ+H35GgbLpsO9SH0TvCIWAQbbyAsy3JG+N/oA4qdhakFRD
         OfcEXnUm5XgNyI2OGtSW7zy2EjYGYDA10y2QMhfjjPv9xmK4OTH/XmtXCYL45xVxaYMV
         Y/Xv7aSWXlO99cGLcN4XxDhOs1RlMgWln94OeskTluF7Z2NHXzkF1OHTEUvVMejE4RLP
         HGa5vQV1WTfj2Kuhc1cTTV1QoC+vkORkeDS9BRsm8cvIaxrcsPywxIkXMYFqBEwE0B1V
         FeNA==
X-Forwarded-Encrypted: i=1; AJvYcCU64Pv5j0jWnv709gZw6wu6rrFp4O+cAkf7avL0k5H/cC2dssK9nTKwtBIkcJt/0H6SOgqfaH5f7Orl9YBhq18o@vger.kernel.org
X-Gm-Message-State: AOJu0YwlvFR+/y8AJKoucnlbfq2gPPKZGud52KAl2jm3vPOAgjtKJeZx
	CGPUqOPLrmQP2Em/mxefkX1135zkOyVDTzud/N0CKW8oX0C1syXawd32Y1ei7Lr1iM15ShZnm4A
	1u3s+gC6gLw==
X-Google-Smtp-Source: AGHT+IEDncTZQEra4dxJ5Mwi0TWitflYwn8HytTMEuDCmfO08N/8SUgMvb47GyTXjI3vLtSRlZrFJH0DFLZD
X-Received: from pgam16.prod.google.com ([2002:a05:6a02:2b50:b0:b2f:6348:f715])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9154:b0:21f:77e2:13a0
 with SMTP id adf61e73a8af0-220a113c18emr8586255637.5.1751086285071; Fri, 27
 Jun 2025 21:51:25 -0700 (PDT)
Date: Fri, 27 Jun 2025 21:50:15 -0700
In-Reply-To: <20250628045017.1361563-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250628045017.1361563-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250628045017.1361563-22-irogers@google.com>
Subject: [PATCH v5 21/23] perf sample: Remove arch notion of sample parsing
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
index 2c25eda4be26..f7bdf9a00d00 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2253,7 +2253,7 @@ static void process_event(struct perf_script *script,
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
index 67ad4a2014bc..b13385a6068b 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -391,8 +391,6 @@ extern unsigned int proc_map_timeout;
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
index 3b92ebf5c112..8c9aee157ec4 100644
--- a/tools/perf/util/intel-tpebs.c
+++ b/tools/perf/util/intel-tpebs.c
@@ -210,8 +210,8 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
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
index df03743ac2bf..daf72362d26a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1100,7 +1100,7 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
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
2.50.0.727.gbf7dc18ff4-goog

