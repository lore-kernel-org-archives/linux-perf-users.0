Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7207EC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 May 2022 04:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiECEVl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 May 2022 00:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiECEVh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 May 2022 00:21:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B766838BFC
        for <linux-perf-users@vger.kernel.org>; Mon,  2 May 2022 21:18:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g26-20020a25b11a000000b0064984a4ffb7so3704421ybj.7
        for <linux-perf-users@vger.kernel.org>; Mon, 02 May 2022 21:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QD3DUc26sP7ykTIj1yIZzampBuXqJbDmnGb6bGuMDs8=;
        b=NokXk5/xkNo3NQGuTnByEoO+krhLeXfq6JfjcXwcJSXmHhFSlGr5vRf/0GOE4udOzy
         4RYauE/Js0/9tqje5oT7v/+DN6B6Xl92kuCM2uE+HkPHs7a6czXX0Dsix0YBr2SQcS/p
         jsY2zfQ2xqQcLNpIMzKxTNlXx5berGEtzw/44QEhwX2e+EKNK53Ru8GD5Io2fU6rXyXG
         DSlVLV0BXwhk1HmhOmfPz1cmG1pfNMxwyeiNLztlR0wcfmyBTmUc6XoTTdjzQZqKlF/H
         /kmwY7mJjAub22Ax0TLQ8nRtmnVZYw6YxcRwqEf0PGJUe8StZ/OaYjjk3bWVU49oluZC
         EQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QD3DUc26sP7ykTIj1yIZzampBuXqJbDmnGb6bGuMDs8=;
        b=4Yu+F+QeGiK717JlJE76mJKA8XOWZTG8196+LO6gGudbFOnibIo82D3VxFpWSpeNKH
         /gttCz5EGF0fkPyYwfaIFLpUI2ip2oc/AfVQrUgt0TPRE60z/RdH6nhp5Ez9VKY9JRNk
         QwLGPAaSvDPJRcLZtGkT8MT7y9qpDHlwHSABeBfmbWbTattAE2tvJbWd2i/DInGuAEAa
         xYtUP92XAzFrCpDlAG7fbmVTTkOg7gZtwi+ne9e2uQoAXxzCCKJzWidkKwS2zWOihZo1
         aCxuaHxwKovl+Q6sFsQRcRbGGVINUvIO9LHi2UDXnERx3rQIRjMiL+yGGUVGHfAlIdSu
         01Yg==
X-Gm-Message-State: AOAM530n8QqteJkMMs3966HKB+988UofJyJvtPx47Jok4cu3AVmRHMwF
        ItTO1vhaEpZiOyPSUQOIyy3T3tyEeviQ
X-Google-Smtp-Source: ABdhPJxkQdAYSGlIDwzPRvybZXRBQfHSLeYfhwbH5tnTdrY6mFM6YP9HOoQphYHoVoYVEF02TWVPNs9nvaBl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dd4b:52bb:771d:7bb4])
 (user=irogers job=sendgmr) by 2002:a05:6902:725:b0:649:68fd:6d85 with SMTP id
 l5-20020a056902072500b0064968fd6d85mr7546725ybt.11.1651551484866; Mon, 02 May
 2022 21:18:04 -0700 (PDT)
Date:   Mon,  2 May 2022 21:17:52 -0700
In-Reply-To: <20220503041757.2365696-1-irogers@google.com>
Message-Id: <20220503041757.2365696-2-irogers@google.com>
Mime-Version: 1.0
References: <20220503041757.2365696-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v5 1/6] perf cpumap: Switch to using perf_cpu_map API
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Switch some raw accesses to the cpu map to using the library API. This
can help with reference count checking. Some BPF cases switch from index
to CPU for consistency, this shouldn't matter as the CPU map is full.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c          | 13 +++++----
 tools/perf/util/bpf_counter_cgroup.c | 42 +++++++++++++---------------
 2 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 069825c48d40..a5cf6a99d67f 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1011,7 +1011,7 @@ static int record__thread_data_init_maps(struct record_thread *thread_data, stru
 
 	for (m = 0, tm = 0; m < nr_mmaps && tm < thread_data->nr_mmaps; m++) {
 		if (cpu_map__is_dummy(cpus) ||
-		    test_bit(cpus->map[m].cpu, thread_data->mask->maps.bits)) {
+		    test_bit(perf_cpu_map__cpu(cpus, m).cpu, thread_data->mask->maps.bits)) {
 			if (thread_data->maps) {
 				thread_data->maps[tm] = &mmap[m];
 				pr_debug2("thread_data[%p]: cpu%d: maps[%d] -> mmap[%d]\n",
@@ -3331,13 +3331,14 @@ struct option *record_options = __record_options;
 
 static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cpu_map *cpus)
 {
-	int c;
+	struct perf_cpu cpu;
+	int idx;
 
 	if (cpu_map__is_dummy(cpus))
 		return;
 
-	for (c = 0; c < cpus->nr; c++)
-		set_bit(cpus->map[c].cpu, mask->bits);
+	perf_cpu_map__for_each_cpu(cpu, idx, cpus)
+		set_bit(cpu.cpu, mask->bits);
 }
 
 static int record__mmap_cpu_mask_init_spec(struct mmap_cpu_mask *mask, const char *mask_spec)
@@ -3404,8 +3405,8 @@ static int record__init_thread_cpu_masks(struct record *rec, struct perf_cpu_map
 	pr_debug("nr_threads: %d\n", rec->nr_threads);
 
 	for (t = 0; t < rec->nr_threads; t++) {
-		set_bit(cpus->map[t].cpu, rec->thread_masks[t].maps.bits);
-		set_bit(cpus->map[t].cpu, rec->thread_masks[t].affinity.bits);
+		set_bit(perf_cpu_map__cpu(cpus, t).cpu, rec->thread_masks[t].maps.bits);
+		set_bit(perf_cpu_map__cpu(cpus, t).cpu, rec->thread_masks[t].affinity.bits);
 		if (verbose) {
 			pr_debug("thread_masks[%d]: ", t);
 			mmap_cpu_mask__scnprintf(&rec->thread_masks[t].maps, "maps");
diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index ac60c08e8e2a..63b9db657442 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -46,8 +46,8 @@ static int bperf_load_program(struct evlist *evlist)
 	struct bpf_link *link;
 	struct evsel *evsel;
 	struct cgroup *cgrp, *leader_cgrp;
-	__u32 i, cpu;
-	__u32 nr_cpus = evlist->core.all_cpus->nr;
+	int i, j;
+	struct perf_cpu cpu;
 	int total_cpus = cpu__max_cpu().cpu;
 	int map_size, map_fd;
 	int prog_fd, err;
@@ -93,9 +93,9 @@ static int bperf_load_program(struct evlist *evlist)
 		goto out;
 	}
 
-	for (i = 0; i < nr_cpus; i++) {
+	perf_cpu_map__for_each_cpu(cpu, i, evlist->core.all_cpus) {
 		link = bpf_program__attach_perf_event(skel->progs.on_cgrp_switch,
-						      FD(cgrp_switch, i));
+						      FD(cgrp_switch, cpu.cpu));
 		if (IS_ERR(link)) {
 			pr_err("Failed to attach cgroup program\n");
 			err = PTR_ERR(link);
@@ -122,10 +122,9 @@ static int bperf_load_program(struct evlist *evlist)
 			}
 
 			map_fd = bpf_map__fd(skel->maps.events);
-			for (cpu = 0; cpu < nr_cpus; cpu++) {
-				int fd = FD(evsel, cpu);
-				__u32 idx = evsel->core.idx * total_cpus +
-					evlist->core.all_cpus->map[cpu].cpu;
+			perf_cpu_map__for_each_cpu(cpu, j, evlist->core.all_cpus) {
+				int fd = FD(evsel, cpu.cpu);
+				__u32 idx = evsel->core.idx * total_cpus + cpu.cpu;
 
 				err = bpf_map_update_elem(map_fd, &idx, &fd,
 							  BPF_ANY);
@@ -207,14 +206,12 @@ static int bperf_cgrp__install_pe(struct evsel *evsel __maybe_unused,
  */
 static int bperf_cgrp__sync_counters(struct evlist *evlist)
 {
-	int i, cpu;
-	int nr_cpus = evlist->core.all_cpus->nr;
+	struct perf_cpu cpu;
+	int idx;
 	int prog_fd = bpf_program__fd(skel->progs.trigger_read);
 
-	for (i = 0; i < nr_cpus; i++) {
-		cpu = evlist->core.all_cpus->map[i].cpu;
-		bperf_trigger_reading(prog_fd, cpu);
-	}
+	perf_cpu_map__for_each_cpu(cpu, idx, evlist->core.all_cpus)
+		bperf_trigger_reading(prog_fd, cpu.cpu);
 
 	return 0;
 }
@@ -244,12 +241,10 @@ static int bperf_cgrp__disable(struct evsel *evsel)
 static int bperf_cgrp__read(struct evsel *evsel)
 {
 	struct evlist *evlist = evsel->evlist;
-	int i, cpu, nr_cpus = evlist->core.all_cpus->nr;
 	int total_cpus = cpu__max_cpu().cpu;
 	struct perf_counts_values *counts;
 	struct bpf_perf_event_value *values;
 	int reading_map_fd, err = 0;
-	__u32 idx;
 
 	if (evsel->core.idx)
 		return 0;
@@ -263,7 +258,10 @@ static int bperf_cgrp__read(struct evsel *evsel)
 	reading_map_fd = bpf_map__fd(skel->maps.cgrp_readings);
 
 	evlist__for_each_entry(evlist, evsel) {
-		idx = evsel->core.idx;
+		__u32 idx = evsel->core.idx;
+		int i;
+		struct perf_cpu cpu;
+
 		err = bpf_map_lookup_elem(reading_map_fd, &idx, values);
 		if (err) {
 			pr_err("bpf map lookup failed: idx=%u, event=%s, cgrp=%s\n",
@@ -271,13 +269,11 @@ static int bperf_cgrp__read(struct evsel *evsel)
 			goto out;
 		}
 
-		for (i = 0; i < nr_cpus; i++) {
-			cpu = evlist->core.all_cpus->map[i].cpu;
-
+		perf_cpu_map__for_each_cpu(cpu, i, evlist->core.all_cpus) {
 			counts = perf_counts(evsel->counts, i, 0);
-			counts->val = values[cpu].counter;
-			counts->ena = values[cpu].enabled;
-			counts->run = values[cpu].running;
+			counts->val = values[cpu.cpu].counter;
+			counts->ena = values[cpu.cpu].enabled;
+			counts->run = values[cpu.cpu].running;
 		}
 	}
 
-- 
2.36.0.464.gb9c8b46e94-goog

