Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD12552925
	for <linux-perf-users@vger.kernel.org>; Tue,  8 Sep 2026 14:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877672; cv=none; b=nB3/hx3xDJZOHiYkZ8zjjMzziLfKIVjLa/oPYW7OYp7VXfe+6JDKCDzIXirmSOzIT51kr6VSRrprnIndrZDOSXtzIJ7nMvzcliX5WFoYTceu6qyt1Rc3dBG0rDvZZo7BWmKerb4FKt/jCzjwaQGw2X1GZJFckpRG2A9DA7qaNT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877672; c=relaxed/simple;
	bh=ylJicH1a0G2qTlq5ZUtMqKWIxILTNpSxDjkrw1RjPuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Muf1h8Pq0WVq7E3cCKafOKTdR0y6bN+z+SC7cBh9rpsc9DQg/dKVgMAQOTpu/vbDob/SqMdJ2D+VY1IpmXVWddGVRw7c9lw+6cRKuj60W/dvv+hHMJJN0iEdJIYjOUDEiW+1edksqEtiYBbon34FTandMvm6p9rVEtI26JYz5pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6ZSCP9F; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6ZSCP9F"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7f4df360cc9so5205676a34.1
        for <linux-perf-users@vger.kernel.org>; Tue, 08 Sep 2026 07:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788877661; x=1789482461; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZvpP6HuJ+u+IqaXVv4pippmZNZNmLsTFjITz+cfMzuk=;
        b=N6ZSCP9FZpmGKAfIDOluCDNZqzPt+ZXuvfvgcD1/cibPz3pkXdCKYPdvDjHmJVaxrJ
         D7gk6ograRNae//7FKvxbWtqq0Ej7fD9UAp2kvWBDAleLD19bKBzBp8Tbhtt05rAwLwy
         kkhd4OuITP8Tambk5obi4PDZlorSnRN9fsm3JWwtnwAgRXg414dVVg9NICvw35DlNvUh
         9r1UIVWtD1LCDfF27kKsurVwnN7Tn1DEGtjc3l5zXrEpHdDV2bGBkYxaAEAVVf5t0lLW
         E7t4kov11zxLqTr11dKivDDKU245Q7uPAyn/V7klVipRvNr/9XjaOO5nBt1PW5MVKeX/
         D95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788877661; x=1789482461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZvpP6HuJ+u+IqaXVv4pippmZNZNmLsTFjITz+cfMzuk=;
        b=c8CNJDq2KCLb/BJokPXf0V3ViRADSJ2ltTkg2/KkmMLsq5VxBPZUgFECskads4NSON
         EPFb+0d2D6viE/yH+PeSEDvnUsefbnYjv5yAnCOx36amtsZcBwevTh7urOp4RTjNhXKS
         P0+PWop0afF/yZO9PseKSkjuv7n8mj8IzULAnKY8x9w/D6FCPVE/9tigMr2DV1gBqg5D
         d8CrOJja4ip7MktT/uHIdYVMaogdjayJrPm626iKplQqPTtXdk+rkTWnwq6xbYKYuPSl
         1zvtjifmPNSYjLBymsKAc+4vwoGzeqh2oiHGkLnsVMDswPdMlPew190PYNgfZnTsMV6l
         mV/A==
X-Forwarded-Encrypted: i=1; AKwUvBxlqbYkoDqF5G3AzTqltDlkmSBqygLreMJnAqdImOij9KGoxuKQEKfV/7saBJRH05ikllsGkm2LAp81xN8toISH@vger.kernel.org
X-Gm-Message-State: AFuF++mlv9Rj4ZCua2mHTun4dg5Mj8tUtre8A+LT2i0hDIoqIRmHmjQ3
	dRrvC3jwmzJCycmoB5zuhbwIU2oHt0GFonpWDcjl16RoYfbZRqH3k+rj
X-Gm-Gg: AYBFou1Bj8RcL92hn6Z1IpS9SvQJuwUu5G0GkC6YNCcC0WLjFtKMWFYXomeWFe1FCDv
	KPHffdPaLOc6ukuF/yZT4UGs6LYb1+Y5MJqn//Zc7iWrmoU6hMgcfa31+xWrdocpZWtCSHfaapQ
	vd9snEAuwy69EhDkZeHQluOmOk00O7CgWIYbqnL1/aUON0VuBo9+hlYARaOgbk24WlKqZC8EEgp
	FUFbuVmOH2+Dzd5SMY5KL7aOC2lcyXM63vPts9MvMNFWF/RoqzftP810/N9HT5wfhMILuce+vXT
	ypYZ0ICMCzKe/95G/I7HlyYcX4ygRQIZ8TFHOj3gT7GylRiqbSfP8YPKaZi1fLcDyJkZyP/Wp3j
	lLQ6X6yciStL1zD8kg+IZYjzeF3xWkmrd5asic1H2bHihmRqyCT8c7BbipA3wtmJ+ouFcNQQzBk
	I3A7cO852/TD60MLV5m3P0jSa3jlS7qqZg39bsEpQJQR372I1d9g==
X-Received: by 2002:a05:6830:1303:b0:7f9:5a3:c243 with SMTP id 46e09a7af769-7f905a3c495mr10222266a34.26.1788877660597;
        Tue, 08 Sep 2026 07:27:40 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7fe72977c16sm4978268a34.10.2026.09.08.07.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 07:27:39 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Tue, 08 Sep 2026 07:27:12 -0700
Subject: [PATCH bpf-next v3 3/3] bpftool: Scale counters and report cycles
 per run
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-bpftool_cyles_per_run-v3-3-60e86f325c35@meta.com>
References: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com>
In-Reply-To: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com, qmo@kernel.org, linux-perf-users@vger.kernel.org, 
 acme@kernel.org, namhyung@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788877648; l=11029;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=SlEK4miKlOUeo8TQ+fVSOkrbLvY65GOJacD5H6FbqrA=;
 b=4iglO5MttlebanKPr17Ibqv+yb2fL3ovdZNfXDsRNxBOkN+ZqGJNOaHio+lPXwbJlE4HJx5tv
 umtv9KPA4glDaI69hvMFdGP37TmfEXB5at5IJHA6N8GgFvwW/MPF9u0
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

Perf counters can report too few events when the PMU multiplexes them.
Scale each per-CPU value before aggregation.

Use the same CPU set for derived ratios. Report cycles per included
program run, and preserve the total run count in JSON.

Fixes: 47c09d6a9f67 ("bpftool: Introduce "prog profile" command")
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/bpf/bpftool/Documentation/bpftool-prog.rst |  13 +-
 tools/bpf/bpftool/prog.c                         | 159 +++++++++++++++++------
 2 files changed, 133 insertions(+), 39 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 90fa2a48cc26..0108a1c8be4d 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -217,7 +217,16 @@ bpftool prog run *PROG* data_in *FILE* [data_out *FILE* [data_size_out *L*]] [ct
 bpftool prog profile *PROG* [duration *DURATION*] *METRICs*
     Profile *METRICs* for bpf program *PROG* for *DURATION* seconds or until
     user hits <Ctrl+C>. *DURATION* is optional. If *DURATION* is not specified,
-    the profiling will run up to **UINT_MAX** seconds.
+    the profiling will run up to **UINT_MAX** seconds. Plain output scales each
+    per-CPU metric value to correct for perf event multiplexing. When
+    **cycles** is selected, it also reports cycles per included program run. If
+    a selected metric was not scheduled on a CPU, all metric values exclude
+    that CPU so that ratios use a consistent CPU set. The **run_cnt** value
+    still includes all recorded runs.
+
+    In JSON output, **value** is raw, **value_scaled** is scaled, **run_cnt**
+    includes all runs, and **run_cnt_valid** includes only runs used for metric
+    values.
 
 bpftool prog help
     Print short help message.
@@ -360,7 +369,7 @@ EXAMPLES
 ::
 
          51397 run_cnt
-      40176203 cycles                                                 (83.05%)
+      40176203 cycles          # 781.68 cycles per run                (83.05%)
       42518139 instructions    #   1.06 insns per cycle               (83.39%)
            123 llc_misses      #   2.89 LLC misses per million insns  (83.15%)
 
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 8c2f9255b36d..9e126f3823ad 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2062,37 +2062,52 @@ static int do_profile(int argc, char **argv)
 
 #include "profiler.skel.h"
 
+enum ratio_metric {
+	METRIC_NONE = -2,
+	METRIC_RUN_CNT = -1,
+	METRIC_CYCLES = 0,
+	METRIC_INSTRUCTIONS = 1,
+	METRIC_L1D_LOADS = 2,
+	METRIC_LLC_MISSES = 3,
+	METRIC_ITLB_MISSES = 4,
+	METRIC_DTLB_MISSES = 5,
+};
+
 struct profile_metric {
 	const char *name;
 	struct bpf_perf_event_value val;
+	__u64 scaled_val;
 	struct perf_event_attr attr;
 	bool selected;
 
 	/* calculate ratios like instructions per cycle */
-	const int ratio_metric; /* 0 for N/A, 1 for index 0 (cycles) */
+	const enum ratio_metric ratio_metric;
 	const char *ratio_desc;
 	const float ratio_mul;
 } metrics[] = {
-	{
+	[METRIC_CYCLES] = {
 		.name = "cycles",
 		.attr = {
 			.type = PERF_TYPE_HARDWARE,
 			.config = PERF_COUNT_HW_CPU_CYCLES,
 			.exclude_user = 1,
 		},
+		.ratio_metric = METRIC_RUN_CNT,
+		.ratio_desc = "cycles per run",
+		.ratio_mul = 1.0,
 	},
-	{
+	[METRIC_INSTRUCTIONS] = {
 		.name = "instructions",
 		.attr = {
 			.type = PERF_TYPE_HARDWARE,
 			.config = PERF_COUNT_HW_INSTRUCTIONS,
 			.exclude_user = 1,
 		},
-		.ratio_metric = 1,
+		.ratio_metric = METRIC_CYCLES,
 		.ratio_desc = "insns per cycle",
 		.ratio_mul = 1.0,
 	},
-	{
+	[METRIC_L1D_LOADS] = {
 		.name = "l1d_loads",
 		.attr = {
 			.type = PERF_TYPE_HW_CACHE,
@@ -2102,8 +2117,9 @@ struct profile_metric {
 				(PERF_COUNT_HW_CACHE_RESULT_ACCESS << 16),
 			.exclude_user = 1,
 		},
+		.ratio_metric = METRIC_NONE,
 	},
-	{
+	[METRIC_LLC_MISSES] = {
 		.name = "llc_misses",
 		.attr = {
 			.type = PERF_TYPE_HW_CACHE,
@@ -2113,11 +2129,11 @@ struct profile_metric {
 				(PERF_COUNT_HW_CACHE_RESULT_MISS << 16),
 			.exclude_user = 1
 		},
-		.ratio_metric = 2,
+		.ratio_metric = METRIC_INSTRUCTIONS,
 		.ratio_desc = "LLC misses per million insns",
 		.ratio_mul = 1e6,
 	},
-	{
+	[METRIC_ITLB_MISSES] = {
 		.name = "itlb_misses",
 		.attr = {
 			.type = PERF_TYPE_HW_CACHE,
@@ -2127,11 +2143,11 @@ struct profile_metric {
 				(PERF_COUNT_HW_CACHE_RESULT_MISS << 16),
 			.exclude_user = 1
 		},
-		.ratio_metric = 2,
+		.ratio_metric = METRIC_INSTRUCTIONS,
 		.ratio_desc = "itlb misses per million insns",
 		.ratio_mul = 1e6,
 	},
-	{
+	[METRIC_DTLB_MISSES] = {
 		.name = "dtlb_misses",
 		.attr = {
 			.type = PERF_TYPE_HW_CACHE,
@@ -2141,13 +2157,14 @@ struct profile_metric {
 				(PERF_COUNT_HW_CACHE_RESULT_MISS << 16),
 			.exclude_user = 1
 		},
-		.ratio_metric = 2,
+		.ratio_metric = METRIC_INSTRUCTIONS,
 		.ratio_desc = "dtlb misses per million insns",
 		.ratio_mul = 1e6,
 	},
 };
 
 static __u64 profile_total_count;
+static __u64 profile_valid_count;
 
 #define MAX_NUM_PROFILE_METRICS 4
 
@@ -2182,9 +2199,39 @@ static int profile_parse_metrics(int argc, char **argv)
 	return selected_cnt;
 }
 
-static void profile_read_values(struct profiler_bpf *obj)
+/*
+ * Filter out CPUs that have any selected metric not scheduled for them. This makes sure all
+ * metrics are using the same CPU set, as a result ratio metrics are consistent.
+ */
+static void profile_filter_cpus(__u32 num_cpu,
+				struct bpf_perf_event_value vals[MAX_NUM_PROFILE_METRICS][num_cpu],
+				__u64 *counts)
+{
+	__u32 m, cpu, key = 0;
+
+	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
+		if (!metrics[m].selected)
+			continue;
+
+		for (cpu = 0; cpu < num_cpu; cpu++) {
+			/*
+			 * CPU has hits, but this metric never scheduled, set counts[cpu] to 0
+			 * so other metrics ignore this CPU too
+			 */
+			if (counts[cpu] && !vals[key][cpu].running) {
+				p_info("%s not scheduled on CPU %u; excluding %llu runs from all metrics",
+				       metrics[m].name, cpu, counts[cpu]);
+				counts[cpu] = 0;
+			}
+		}
+		key++;
+	}
+}
+
+static int profile_read_values(struct profiler_bpf *obj)
 {
 	__u32 m, cpu, num_cpu = obj->rodata->num_cpu;
+	struct bpf_perf_event_value values[MAX_NUM_PROFILE_METRICS][num_cpu], *val;
 	int reading_map_fd, count_map_fd;
 	__u64 counts[num_cpu];
 	__u32 key = 0;
@@ -2194,38 +2241,61 @@ static void profile_read_values(struct profiler_bpf *obj)
 	count_map_fd = bpf_map__fd(obj->maps.counts);
 	if (reading_map_fd < 0 || count_map_fd < 0) {
 		p_err("failed to get fd for map");
-		return;
+		return min(reading_map_fd, count_map_fd);
 	}
 
 	err = bpf_map_lookup_elem(count_map_fd, &key, counts);
 	if (err) {
 		p_err("failed to read count_map: %s", strerror(errno));
-		return;
+		return err;
+	}
+
+	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
+		if (!metrics[m].selected)
+			continue;
+
+		err = bpf_map_lookup_elem(reading_map_fd, &key, values[key]);
+		if (err) {
+			p_err("failed to read reading_map: %s", strerror(errno));
+			return err;
+		}
+		key++;
 	}
 
 	profile_total_count = 0;
 	for (cpu = 0; cpu < num_cpu; cpu++)
 		profile_total_count += counts[cpu];
 
+	profile_filter_cpus(num_cpu, values, counts);
+
+	profile_valid_count = 0;
+	for (cpu = 0; cpu < num_cpu; cpu++)
+		profile_valid_count += counts[cpu];
+
+	key = 0;
 	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
-		struct bpf_perf_event_value values[num_cpu];
+		double scale;
 
 		if (!metrics[m].selected)
 			continue;
 
-		err = bpf_map_lookup_elem(reading_map_fd, &key, values);
-		if (err) {
-			p_err("failed to read reading_map: %s",
-			      strerror(errno));
-			return;
-		}
 		for (cpu = 0; cpu < num_cpu; cpu++) {
-			metrics[m].val.counter += values[cpu].counter;
-			metrics[m].val.enabled += values[cpu].enabled;
-			metrics[m].val.running += values[cpu].running;
+			/* Skip CPUs with no runs or with an unscheduled metric. */
+			if (!counts[cpu])
+				continue;
+
+			val = &values[key][cpu];
+
+			metrics[m].val.enabled += val->enabled;
+			metrics[m].val.running += val->running;
+			metrics[m].val.counter += val->counter;
+			/* Scale counter values to account for perf event multiplexing. */
+			scale = (double)val->enabled / val->running;
+			metrics[m].scaled_val += val->counter * scale;
 		}
 		key++;
 	}
+	return 0;
 }
 
 static void profile_print_readings_json(void)
@@ -2239,9 +2309,11 @@ static void profile_print_readings_json(void)
 		jsonw_start_object(json_wtr);
 		jsonw_string_field(json_wtr, "metric", metrics[m].name);
 		jsonw_lluint_field(json_wtr, "run_cnt", profile_total_count);
+		jsonw_lluint_field(json_wtr, "run_cnt_valid", profile_valid_count);
 		jsonw_lluint_field(json_wtr, "value", metrics[m].val.counter);
 		jsonw_lluint_field(json_wtr, "enabled", metrics[m].val.enabled);
 		jsonw_lluint_field(json_wtr, "running", metrics[m].val.running);
+		jsonw_lluint_field(json_wtr, "value_scaled", metrics[m].scaled_val);
 
 		jsonw_end_object(json_wtr);
 	}
@@ -2250,24 +2322,34 @@ static void profile_print_readings_json(void)
 
 static void profile_print_readings_plain(void)
 {
-	__u32 m;
+	__u32 i;
 
 	printf("\n%18llu %-20s\n", profile_total_count, "run_cnt");
-	for (m = 0; m < ARRAY_SIZE(metrics); m++) {
-		struct bpf_perf_event_value *val = &metrics[m].val;
+	for (i = 0; i < ARRAY_SIZE(metrics); i++) {
+		struct profile_metric *m = &metrics[i];
+		struct bpf_perf_event_value *val = &m->val;
 		int r;
+		__u64 ratio;
 
-		if (!metrics[m].selected)
+		if (!m->selected)
 			continue;
-		printf("%18llu %-20s", val->counter, metrics[m].name);
+		printf("%18llu %-20s", m->scaled_val, m->name);
 
-		r = metrics[m].ratio_metric - 1;
-		if (r >= 0 && metrics[r].selected &&
-		    metrics[r].val.counter > 0) {
+		r = m->ratio_metric;
+		switch (r) {
+		case METRIC_RUN_CNT:
+			ratio = profile_valid_count;
+			break;
+		case METRIC_NONE:
+			ratio = 0;
+			break;
+		default:
+			ratio = metrics[r].scaled_val;
+		}
+		if (ratio) {
 			printf("# %8.2f %-30s",
-			       val->counter * metrics[m].ratio_mul /
-			       metrics[r].val.counter,
-			       metrics[m].ratio_desc);
+			       m->scaled_val * m->ratio_mul / ratio,
+			       m->ratio_desc);
 		} else {
 			printf("%-41s", "");
 		}
@@ -2423,9 +2505,12 @@ static int profile_open_perf_events(struct profiler_bpf *obj)
 
 static void profile_print_and_cleanup(void)
 {
+	int err;
+
 	profile_close_perf_events(profile_obj);
-	profile_read_values(profile_obj);
-	profile_print_readings();
+	err = profile_read_values(profile_obj);
+	if (!err)
+		profile_print_readings();
 	profiler_bpf__destroy(profile_obj);
 
 	close(profile_tgt_fd);

-- 
2.53.0-Meta

