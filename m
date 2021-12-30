Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9937BC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Dec 2021 07:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237658AbhL3HWg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Dec 2021 02:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbhL3HWD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:03 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD48C061190
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:21:59 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id j18-20020a258152000000b006000d292a42so42358349ybm.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5E7qCmbhcG6PuyklpswsQQtsh3hwpY8VT2UNYS3McbM=;
        b=Gfhu9VtJeNHpp94ZAOP6BEURqOQ1GB6YOAeaR/IzzwZeyLURpqc67PaFFz/svrG/5W
         8YYk+r4TM/UIFsnt4bxDH4ndbwwA6Jj2rUeBY7fauHo5PJTQkQW7WZ2Dci8Tk5X04IAR
         qol/PwQ1QT54Q97bUMvleW+hsVQFCdokNqrNhowSMoC001DZ+wUBY8IpZE+LjSDt//NK
         wZo6RvyyUOOijFXYimwlA1kFDw8a/vPEsykmvv/4UjIBZzxQCtV3qsq6KWVQJMK33Lmn
         QaiUZCKcANuuBE134rv3z0y1/NmEwPn62XEYEP148inW2xo9A/pQfKz87qGfRLYvIGDB
         Z+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5E7qCmbhcG6PuyklpswsQQtsh3hwpY8VT2UNYS3McbM=;
        b=4Q1jMOE9lj7xenDlNAEKnzX8L62NOklEV6IvS0MlE17payVN4ghU3BpYAXsrezxgf7
         WvRaIELySHNfjvrgcNuOIqxh/bstzlGHBjUPC6tCU1orLWUAje1Ax4ObWrvDIEdfK5XI
         oHsklrNup6I/lhrpmyKXAvkRhxEnn1bjaItrdr+Bja0HFZas+7fIHc/dqgUETGaTRg79
         3oHpx3ssM6e7BpLcj9uJ+Lvv1znsiU5UOeAF3Z3R6E2f8uVFHMRvLtNYeUVX09TcN+/z
         K2ipTc0I2HpIC/DpTSpAe7G0ORvD0Ace0TNWeiW53F7BFD6inyxtSfcvg1J+jOLuVjRN
         38Ww==
X-Gm-Message-State: AOAM530hBbMRQLlxo51Hjou1+g6ZqeiWPfftOZk+JnH55GSraNYD79aZ
        LgM6Dgi5JMNne1MokjB8ptOpUX6r29y0
X-Google-Smtp-Source: ABdhPJxZFDLUd2Q0RsMuQCwod5Dec4u0Ta/2jbhXReC6ERU+A1dE0YVQIPPxEVw4ATvDX8Chh3lEQuWY5H0M
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:d914:: with SMTP id
 q20mr27808227ybg.140.1640848918378; Wed, 29 Dec 2021 23:21:58 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:14 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-34-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 32/48] perf script: Use for each cpu to aid readability
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

Use perf_cpu_map__for_each_cpu to help with readability.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index d308adfd1176..ce9c3c5d881d 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2115,8 +2115,7 @@ static struct scripting_ops	*scripting_ops;
 static void __process_stat(struct evsel *counter, u64 tstamp)
 {
 	int nthreads = perf_thread_map__nr(counter->core.threads);
-	int ncpus = evsel__nr_cpus(counter);
-	int cpu, thread;
+	int idx, cpu, thread;
 	static int header_printed;
 
 	if (counter->core.system_wide)
@@ -2129,13 +2128,13 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
 	}
 
 	for (thread = 0; thread < nthreads; thread++) {
-		for (cpu = 0; cpu < ncpus; cpu++) {
+		perf_cpu_map__for_each_cpu(cpu, idx, evsel__cpus(counter)) {
 			struct perf_counts_values *counts;
 
 			counts = perf_counts(counter->counts, cpu, thread);
 
 			printf("%3d %8d %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %s\n",
-				counter->core.cpus->map[cpu],
+				cpu,
 				perf_thread_map__pid(counter->core.threads, thread),
 				counts->val,
 				counts->ena,
-- 
2.34.1.448.ga2b2bfdf31-goog

