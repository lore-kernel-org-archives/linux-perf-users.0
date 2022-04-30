Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5FEFC433FE
	for <linux-perf-users@archiver.kernel.org>; Sat, 30 Apr 2022 06:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382181AbiD3G1J (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 30 Apr 2022 02:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382204AbiD3G1G (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 30 Apr 2022 02:27:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA9CCFE41
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Apr 2022 23:23:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 7-20020a250c07000000b0064137917a4eso9166470ybm.12
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Apr 2022 23:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=q3eYGfM76QKHgEVCmlimxa1q1+ls75+CcUBEqRt2248=;
        b=ptYYGqJWHOX4CODWcwor5qnwKhVEGFTrduWyiC+2YvEyUqTi/yNMPAOfd1zzRYDA6G
         U+BSOFARw1/GQ8y3pSn67WQU0O2e+DTSb8SbKBOL0+pYBS1yTeMlTJe8VPh308/l9aDc
         l4jEvhmZb26OeOE6pl1otQWa2UX5gnZNRimWDQ1GpDaJTTh4HtYk8voqkRelrs2NQf/k
         9Y26hRFkIObqiHN1otJNHoKQiwLvfSH6Hf7i5RCFR5S+4/r/w+bkzBrvyR8lsdQgmtEU
         pOFuxkDphKQNzN6Ld0ZgYV3w8jq7mypBXMcSZn9aJZheaEkvxgSUwPoaAAGuqLWn9oUz
         TuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=q3eYGfM76QKHgEVCmlimxa1q1+ls75+CcUBEqRt2248=;
        b=mxHCSzgKS4/5+BsBruOJ/U+Ao0jjwOD9j5DPslxkYuXT3Qowbpc/7dKm7MyLHvTCLm
         hscJQG5QSvPw9C6ngSDsOzYhjLLuguJgTh3/xoAtM67hW/5uvnp2H36nbQdoz7BnyYr9
         6akCeow+Swnh2MqFX0WfdvY+rCwTrSoVJxXtgTqiAczsBeYVSitsfIsVcZiT7pcmyaAe
         hWrLyBNocFVInzFLCaibrWdYp39EVkCfiNWICV3vVmTRuiKCUB9R/54cjfCPMoERckph
         y73rUvf5TYWKUXnbQ1VEaJN/CPMiGm2gLBPeX2UtTxMW4f2nrp5KVFthiIQj88KT0els
         xwUw==
X-Gm-Message-State: AOAM532/UibLtq5g4XuwnE4N6zzMX3UHf7X+srW6igAgC0FtxhmdC5uf
        XiRx/Xbw539Sj8Q60/OQmXovuXyiZ5Jp
X-Google-Smtp-Source: ABdhPJzEEiG4DHzJkhoc5aJb5CrqIVnK1IgaIiTz6LbTY6tX1Pocer4suNX20yTlkyaLjtNNjC/Y1IFlKse5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2481:caab:4fd5:232b])
 (user=irogers job=sendgmr) by 2002:a25:dc5:0:b0:648:f7b4:7cb6 with SMTP id
 188-20020a250dc5000000b00648f7b47cb6mr2667075ybn.379.1651299824700; Fri, 29
 Apr 2022 23:23:44 -0700 (PDT)
Date:   Fri, 29 Apr 2022 23:23:24 -0700
In-Reply-To: <20220430062324.1565215-1-irogers@google.com>
Message-Id: <20220430062324.1565215-7-irogers@google.com>
Mime-Version: 1.0
References: <20220430062324.1565215-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v4 6/6] perf evlist: Rename all_cpus
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

Try to make the struct variable clearer by renaming to
merged_evsel_cpus.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c                  | 16 ++++++++--------
 tools/lib/perf/include/internal/evlist.h |  2 +-
 tools/perf/util/bpf_counter_cgroup.c     | 10 +++++-----
 tools/perf/util/evlist.c                 |  6 +++---
 tools/perf/util/evlist.h                 |  4 ++--
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 974b4585f93e..5840a9377494 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -52,16 +52,16 @@ static void __perf_evlist__propagate_maps(struct perf_evlist *evlist,
 
 	perf_thread_map__put(evsel->threads);
 	evsel->threads = perf_thread_map__get(evlist->threads);
-	evlist->all_cpus = perf_cpu_map__merge(evlist->all_cpus, evsel->cpus);
+	evlist->merged_evsel_cpus = perf_cpu_map__merge(evlist->merged_evsel_cpus, evsel->cpus);
 }
 
 static void perf_evlist__propagate_maps(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel;
 
-	/* Recomputing all_cpus, so start with a blank slate. */
-	perf_cpu_map__put(evlist->all_cpus);
-	evlist->all_cpus = NULL;
+	/* Recomputing merged_evsel_cpus, so start with a blank slate. */
+	perf_cpu_map__put(evlist->merged_evsel_cpus);
+	evlist->merged_evsel_cpus = NULL;
 
 	perf_evlist__for_each_evsel(evlist, evsel)
 		__perf_evlist__propagate_maps(evlist, evsel);
@@ -128,10 +128,10 @@ static void perf_evlist__purge(struct perf_evlist *evlist)
 void perf_evlist__exit(struct perf_evlist *evlist)
 {
 	perf_cpu_map__put(evlist->user_requested_cpus);
-	perf_cpu_map__put(evlist->all_cpus);
+	perf_cpu_map__put(evlist->merged_evsel_cpus);
 	perf_thread_map__put(evlist->threads);
 	evlist->user_requested_cpus = NULL;
-	evlist->all_cpus = NULL;
+	evlist->merged_evsel_cpus = NULL;
 	evlist->threads = NULL;
 	fdarray__exit(&evlist->pollfd);
 }
@@ -169,8 +169,8 @@ void perf_evlist__set_maps(struct perf_evlist *evlist,
 		evlist->threads = perf_thread_map__get(threads);
 	}
 
-	if (!evlist->all_cpus && cpus)
-		evlist->all_cpus = perf_cpu_map__get(cpus);
+	if (!evlist->merged_evsel_cpus && cpus)
+		evlist->merged_evsel_cpus = perf_cpu_map__get(cpus);
 
 	perf_evlist__propagate_maps(evlist);
 }
diff --git a/tools/lib/perf/include/internal/evlist.h b/tools/lib/perf/include/internal/evlist.h
index 74541bd87aa9..3a0a47ba8c57 100644
--- a/tools/lib/perf/include/internal/evlist.h
+++ b/tools/lib/perf/include/internal/evlist.h
@@ -26,7 +26,7 @@ struct perf_evlist {
 	 */
 	struct perf_cpu_map	*user_requested_cpus;
 	/** The union of all evsel cpu maps. */
-	struct perf_cpu_map	*all_cpus;
+	struct perf_cpu_map	*merged_evsel_cpus;
 	struct perf_thread_map	*threads;
 	int			 nr_mmaps;
 	size_t			 mmap_len;
diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index a4b676920da0..521f1e2b1bce 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -47,7 +47,7 @@ static int bperf_load_program(struct evlist *evlist)
 	struct evsel *evsel;
 	struct cgroup *cgrp, *leader_cgrp;
 	__u32 i, cpu;
-	__u32 nr_cpus = perf_cpu_map__nr(evlist->core.all_cpus);
+	__u32 nr_cpus = perf_cpu_map__nr(evlist->core.merged_evsel_cpus);
 	int total_cpus = cpu__max_cpu().cpu;
 	int map_size, map_fd;
 	int prog_fd, err;
@@ -88,7 +88,7 @@ static int bperf_load_program(struct evlist *evlist)
 	err = -1;
 
 	cgrp_switch = evsel__new(&cgrp_switch_attr);
-	if (evsel__open_per_cpu(cgrp_switch, evlist->core.all_cpus, -1) < 0) {
+	if (evsel__open_per_cpu(cgrp_switch, evlist->core.merged_evsel_cpus, -1) < 0) {
 		pr_err("Failed to open cgroup switches event\n");
 		goto out;
 	}
@@ -115,7 +115,7 @@ static int bperf_load_program(struct evlist *evlist)
 			evsel->cgrp = NULL;
 
 			/* open single copy of the events w/o cgroup */
-			err = evsel__open_per_cpu(evsel, evlist->core.all_cpus, -1);
+			err = evsel__open_per_cpu(evsel, evlist->core.merged_evsel_cpus, -1);
 			if (err) {
 				pr_err("Failed to open first cgroup events\n");
 				goto out;
@@ -125,7 +125,7 @@ static int bperf_load_program(struct evlist *evlist)
 			for (cpu = 0; cpu < nr_cpus; cpu++) {
 				int fd = FD(evsel, cpu);
 				__u32 idx = evsel->core.idx * total_cpus +
-					perf_cpu_map__cpu(evlist->core.all_cpus, cpu).cpu;
+					perf_cpu_map__cpu(evlist->core.merged_evsel_cpus, cpu).cpu;
 
 				err = bpf_map_update_elem(map_fd, &idx, &fd,
 							  BPF_ANY);
@@ -212,7 +212,7 @@ static int bperf_cgrp__sync_counters(struct evlist *evlist)
 	int prog_fd = bpf_program__fd(skel->progs.trigger_read);
 
 	perf_cpu_map__for_each_cpu(cpu, idx, cpus) {
-		cpu = perf_cpu_map__cpu(evlist->core.all_cpus, i);
+		cpu = perf_cpu_map__cpu(evlist->core.merged_evsel_cpus, i);
 		bperf_trigger_reading(prog_fd, cpu.cpu);
 	}
 
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 52ea004ba01e..57ecd94e6f9e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -349,7 +349,7 @@ struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affin
 		.evsel = NULL,
 		.cpu_map_idx = 0,
 		.evlist_cpu_map_idx = 0,
-		.evlist_cpu_map_nr = perf_cpu_map__nr(evlist->core.all_cpus),
+		.evlist_cpu_map_nr = perf_cpu_map__nr(evlist->core.merged_evsel_cpus),
 		.cpu = (struct perf_cpu){ .cpu = -1},
 		.affinity = affinity,
 	};
@@ -360,7 +360,7 @@ struct evlist_cpu_iterator evlist__cpu_begin(struct evlist *evlist, struct affin
 	} else {
 		itr.evsel = evlist__first(evlist);
 		if (itr.affinity) {
-			itr.cpu = perf_cpu_map__cpu(evlist->core.all_cpus, 0);
+			itr.cpu = perf_cpu_map__cpu(evlist->core.merged_evsel_cpus, 0);
 			affinity__set(itr.affinity, itr.cpu.cpu);
 			itr.cpu_map_idx = perf_cpu_map__idx(itr.evsel->core.cpus, itr.cpu);
 			/*
@@ -388,7 +388,7 @@ void evlist_cpu_iterator__next(struct evlist_cpu_iterator *evlist_cpu_itr)
 	if (evlist_cpu_itr->evlist_cpu_map_idx < evlist_cpu_itr->evlist_cpu_map_nr) {
 		evlist_cpu_itr->evsel = evlist__first(evlist_cpu_itr->container);
 		evlist_cpu_itr->cpu =
-			perf_cpu_map__cpu(evlist_cpu_itr->container->core.all_cpus,
+			perf_cpu_map__cpu(evlist_cpu_itr->container->core.merged_evsel_cpus,
 					  evlist_cpu_itr->evlist_cpu_map_idx);
 		if (evlist_cpu_itr->affinity)
 			affinity__set(evlist_cpu_itr->affinity, evlist_cpu_itr->cpu.cpu);
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index a21daaa5fc1b..e2e68f988d26 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -336,12 +336,12 @@ struct evlist_cpu_iterator {
 	/** The CPU map index corresponding to the evsel->core.cpus for the current CPU. */
 	int cpu_map_idx;
 	/**
-	 * The CPU map index corresponding to evlist->core.all_cpus for the
+	 * The CPU map index corresponding to evlist->core.merged_evsel_cpus for the
 	 * current CPU.  Distinct from cpu_map_idx as the evsel's cpu map may
 	 * contain fewer entries.
 	 */
 	int evlist_cpu_map_idx;
-	/** The number of CPU map entries in evlist->core.all_cpus. */
+	/** The number of CPU map entries in evlist->core.merged_evsel_cpus. */
 	int evlist_cpu_map_nr;
 	/** The current CPU of the iterator. */
 	struct perf_cpu cpu;
-- 
2.36.0.464.gb9c8b46e94-goog

