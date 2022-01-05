Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980B8C433FE
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Jan 2022 06:15:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237909AbiAEGPN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Jan 2022 01:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237733AbiAEGPA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jan 2022 01:15:00 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BF0C061399
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Jan 2022 22:15:00 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e2-20020a25d302000000b0060c57942183so50884957ybf.18
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jan 2022 22:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MyX41obsfTbklj5mP7URo6KOdoHhcEiYJDRkMl7AGdI=;
        b=jEuPSgJL9JSgjNKG0RChwu9xGaqg1t/hIA+Sdzpvmd8lrbqtts928yn4ZLM23kTb0Z
         RFq/Z9q94n/9EqpLfoJVB0iXZA61XZ5391QZ547a/eIpIZqDbpRcWX7+TQG25cX91Thc
         sUdye69R+aw1ihrti0jPd8Bs+5el1eDNhPbvU8xvECm2jT66i7UZp2K1MUHltIdS2Z/r
         4ar0HWvw3g4kD6x55DCTloQK5Tm9GfTW+3dxPVeLcTt7z/7Yf0ktlJtjtrZMjgrxnylF
         LkDsVba9cmmK7VSh2IWv1di1xYKz8VaTOZpifterm5w2k53KtmgAAQTDbTBFSAtIz0kb
         eenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MyX41obsfTbklj5mP7URo6KOdoHhcEiYJDRkMl7AGdI=;
        b=dfiJYjb8tKQgzFDR8qgNwUzwiGR1iY3jd6tglYZzgsXHdLcVjpVXgUgoiQ7Lm1pRvk
         X3+ocXHtZtIlDhvpSTknbawNUEfi4D/xIRF3B0/y3zC+NlUfg+u9ucoIOfKMz6ZegScz
         axmXjr7PB5a8HxHOWno+wIV/d7azfi+jS4vyjQhoZRx1BpuWbFjOH3FkK2VLp4ngE3nF
         DpKaiegbncQTDuMuMfVBQyun/SEMZEwkCPnA7z0C7zg1N419y62Yo+h6/mK5hxekfqdd
         /chgpwEJGQ30qb2Vuclm4YJx+fxj0doN/yduV3utA71FFmnUyl2/HeislkRzI5KCh0UU
         zw8A==
X-Gm-Message-State: AOAM532h500DQ5u2Whhr8fIhVCF2+n+GyMd8PKDb09s8FDHU2eDnnIEw
        8fYuUlHnK6GAULQOFrwWSwG5i2Q23qAU
X-Google-Smtp-Source: ABdhPJzeYuauxHIdcoVuJQH3u1AjHhrA8OEagRyvRcGzYdtQhltyyIQxFOOWe8cuNjLWj5riqHFL3uHXggR6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:c753:: with SMTP id
 w80mr52281820ybe.567.1641363299859; Tue, 04 Jan 2022 22:14:59 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:28 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-26-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 25/48] perf stat-display: Avoid use of core for CPU.
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Correct use of cpumap index in print_no_aggr_metric.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 45 +++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 870b1db71fbc..f48d1678861c 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -120,11 +120,10 @@ static void aggr_printout(struct perf_stat_config *config,
 				id.die,
 				config->csv_output ? 0 : -3,
 				id.core, config->csv_sep);
-		} else if (id.core > -1) {
+		} else if (id.cpu > -1) {
 			fprintf(config->output, "CPU%*d%s",
 				config->csv_output ? 0 : -7,
-				evsel__cpus(evsel)->map[id.core],
-				config->csv_sep);
+				id.cpu, config->csv_sep);
 		}
 		break;
 	case AGGR_THREAD:
@@ -334,7 +333,7 @@ static int first_shadow_cpu(struct perf_stat_config *config,
 	int cpu, idx;
 
 	if (config->aggr_mode == AGGR_NONE)
-		return id->core;
+		return id->cpu;
 
 	if (!config->aggr_get_id)
 		return 0;
@@ -697,10 +696,9 @@ static void print_counter_aggrdata(struct perf_stat_config *config,
 		fprintf(output, "%s", prefix);
 
 	uval = val * counter->scale;
-	if (cpu != -1) {
-		id = aggr_cpu_id__empty();
-		id.core = cpu;
-	}
+	if (cpu != -1)
+		id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
+
 	printout(config, id, nr, counter, uval,
 		 prefix, run, ena, 1.0, &rt_stat);
 	if (!metric_only)
@@ -911,8 +909,7 @@ static void print_counter(struct perf_stat_config *config,
 			fprintf(output, "%s", prefix);
 
 		uval = val * counter->scale;
-		id = aggr_cpu_id__empty();
-		id.core = cpu;
+		id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
 		printout(config, id, 0, counter, uval, prefix,
 			 run, ena, 1.0, &rt_stat);
 
@@ -924,29 +921,31 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 				 struct evlist *evlist,
 				 char *prefix)
 {
-	int cpu;
-	int nrcpus = 0;
-	struct evsel *counter;
-	u64 ena, run, val;
-	double uval;
-	struct aggr_cpu_id id;
+	int all_idx, cpu;
 
-	nrcpus = evlist->core.cpus->nr;
-	for (cpu = 0; cpu < nrcpus; cpu++) {
+	perf_cpu_map__for_each_cpu(cpu, all_idx, evlist->core.cpus) {
+		struct evsel *counter;
 		bool first = true;
 
 		if (prefix)
 			fputs(prefix, config->output);
 		evlist__for_each_entry(evlist, counter) {
-			id = aggr_cpu_id__empty();
-			id.core = cpu;
+			u64 ena, run, val;
+			double uval;
+			struct aggr_cpu_id id;
+			int counter_idx = perf_cpu_map__idx(evsel__cpus(counter), cpu);
+
+			if (counter_idx < 0)
+				continue;
+
+			id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
 			if (first) {
 				aggr_printout(config, counter, id, 0);
 				first = false;
 			}
-			val = perf_counts(counter->counts, cpu, 0)->val;
-			ena = perf_counts(counter->counts, cpu, 0)->ena;
-			run = perf_counts(counter->counts, cpu, 0)->run;
+			val = perf_counts(counter->counts, counter_idx, 0)->val;
+			ena = perf_counts(counter->counts, counter_idx, 0)->ena;
+			run = perf_counts(counter->counts, counter_idx, 0)->run;
 
 			uval = val * counter->scale;
 			printout(config, id, 0, counter, uval, prefix,
-- 
2.34.1.448.ga2b2bfdf31-goog

