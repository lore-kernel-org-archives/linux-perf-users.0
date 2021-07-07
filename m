Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57153C07E95
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 14:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C58361CC0
	for <linux-perf-users@archiver.kernel.org>; Wed,  7 Jul 2021 14:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhGGOx3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 7 Jul 2021 10:53:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:59042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232173AbhGGOwU (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 7 Jul 2021 10:52:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0194561130;
        Wed,  7 Jul 2021 14:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625669346;
        bh=2l1DsW7j//O3bGpUL301v9hbe8B6HM3Efos7O31i39o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gq5ACYBGMma7Lb74GDWvKTCL21pqYIezTZRs7rBbfwd9CHM0HHz457obLrobmC6Vp
         /T3/j0vqiqUowMmPDjlsOSkuH/QYZUtI6T4UVaP9doQrUmuJWNwl0iqTPIe2HiyYnR
         tspGBLy7vfddKCw3cv6iyth47hlVbNzJhJiTOVSXGTIkiME8mOs/HlsINYnCy5qEvN
         ScDrk5Zhe6ffrQhyj8Hwf5nS3OnzCi2yHuuJI3oT9Lg4kpxS9GgOq/sFKOAKEbvdyO
         bshke1mu7EyDrwDTP88BAMuvScthrshhRGeD/6N8dkCm6fUDnm22OqhRrizw8grcsJ
         kQkSBr54ztfvQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D213C40B1A; Wed,  7 Jul 2021 11:49:03 -0300 (-03)
Date:   Wed, 7 Jul 2021 11:49:03 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, nakamura.shun@fujitsu.com,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/7] libperf: Move idx to perf_evsel::idx
Message-ID: <YOW+3yhgNgMOrE99@kernel.org>
References: <20210706151704.73662-1-jolsa@kernel.org>
 <20210706151704.73662-3-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706151704.73662-3-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Jul 06, 2021 at 05:16:59PM +0200, Jiri Olsa escreveu:
> Moving evsel::idx to perf_evsel::idx, so we can move
> the group interface to libperf.

I fixed up this, that appearead on my tree after you cooked up this
patch:

diff --git a/tools/perf/util/bpf_counter_cgroup.c b/tools/perf/util/bpf_counter_cgroup.c
index 21261f1a05011d62..89aa5e71db1a9a23 100644
--- a/tools/perf/util/bpf_counter_cgroup.c
+++ b/tools/perf/util/bpf_counter_cgroup.c
@@ -124,7 +124,7 @@ static int bperf_load_program(struct evlist *evlist)
 			map_fd = bpf_map__fd(skel->maps.events);
 			for (cpu = 0; cpu < nr_cpus; cpu++) {
 				int fd = FD(evsel, cpu);
-				__u32 idx = evsel->idx * total_cpus +
+				__u32 idx = evsel->core.idx * total_cpus +
 					evlist->core.all_cpus->map[cpu];
 
 				err = bpf_map_update_elem(map_fd, &idx, &fd,
@@ -221,7 +221,7 @@ static int bperf_cgrp__sync_counters(struct evlist *evlist)
 
 static int bperf_cgrp__enable(struct evsel *evsel)
 {
-	if (evsel->idx)
+	if (evsel->core.idx)
 		return 0;
 
 	bperf_cgrp__sync_counters(evsel->evlist);
@@ -232,7 +232,7 @@ static int bperf_cgrp__enable(struct evsel *evsel)
 
 static int bperf_cgrp__disable(struct evsel *evsel)
 {
-	if (evsel->idx)
+	if (evsel->core.idx)
 		return 0;
 
 	bperf_cgrp__sync_counters(evsel->evlist);
@@ -251,7 +251,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
 	int reading_map_fd, err = 0;
 	__u32 idx;
 
-	if (evsel->idx)
+	if (evsel->core.idx)
 		return 0;
 
 	bperf_cgrp__sync_counters(evsel->evlist);
@@ -263,7 +263,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
 	reading_map_fd = bpf_map__fd(skel->maps.cgrp_readings);
 
 	evlist__for_each_entry(evlist, evsel) {
-		idx = evsel->idx;
+		idx = evsel->core.idx;
 		err = bpf_map_lookup_elem(reading_map_fd, &idx, values);
 		if (err) {
 			pr_err("bpf map lookup falied: idx=%u, event=%s, cgrp=%s\n",
@@ -288,7 +288,7 @@ static int bperf_cgrp__read(struct evsel *evsel)
 
 static int bperf_cgrp__destroy(struct evsel *evsel)
 {
-	if (evsel->idx)
+	if (evsel->core.idx)
 		return 0;
 
 	bperf_cgroup_bpf__destroy(skel);

