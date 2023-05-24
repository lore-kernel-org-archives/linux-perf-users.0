Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B9FC7EE2E
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 May 2023 22:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237399AbjEXWTS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 May 2023 18:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236996AbjEXWS6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 May 2023 18:18:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC1A1BB
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:18:51 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8bab3b392so822897276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966731; x=1687558731;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c2Fu8Hh2fRZjS6aZytO0Djl8Sie1Qlvn6RQorz5XdqQ=;
        b=Ev8OlsiXMdtu6FlOgdizkae87AqhWPM7LWi4Pz2YIJ9tsGVdgoW7Efn6yopiotMOXY
         /RzHMjyEcpMqh8gdAZoPRjXZ6DK/qlv1VuVe7isIGvvOybJCxWYpVXWkuT0FBTT52PEb
         x/nSvvHn9yhkumGCzrbVeGiuUQkTEcPjobeCv3i94Do/b5elK/+xAjXTZZNXH21uCVcU
         ginf8tZxLhE6DEWNa218qJT2oxUW+8GRyaMXpm0049KDScJYYQ577V76F5+IfOB80Bxh
         FTYnYBNxSKwNI+gj8ZnDRrLXuYoxoPnWrBLCVt13zTbkZIJWqRNV5S7FN8BKH5WFOlRR
         xnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966731; x=1687558731;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c2Fu8Hh2fRZjS6aZytO0Djl8Sie1Qlvn6RQorz5XdqQ=;
        b=AN0QuEMONcVR5b2xNf6BJkOQUIb+H7UpSn06PIkuVCk1CFCBUKV/qB1QQUJcx32ssc
         MqpitaOICj8ganojoGDCms/tA4PAQ6DdIYIiK5VUks7QQVmw1ctQZZWV2T1VYeZXJz6h
         da9VHxQ0u7ZjmoogYQQIgI90O8GSVO7I720mCC++MBmYYe72yPhulaUSOphSJXQjXQin
         gf27ThAvROjseNRGCU15F5yA3hFIHZIGgjwS0qGST85NCf2tvn6FT5eKBWlqpCqeM8uC
         DqiU6Epnit4ex3Sr4wiunt0s6jvuyFa6wztcjOiT5Yj2jIEjbPYQp0/5toQAuLwY/C7X
         7VJg==
X-Gm-Message-State: AC+VfDyprmpryDtNGg3KWAvM39H7BKyCGK74klWy4UqtqcFBjdEaPviO
        gNCriwedjdek+mvezkGKwLqBU4bGKf9x
X-Google-Smtp-Source: ACHHUZ7+88/7aU7x/bNjqJ77lAS3J/2553bHTBYqqnN3uD2LBkSyMbYgzljU/D8Sr5q/j4OyZ/8PyKJam29X
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a25:6612:0:b0:b94:6989:7fa6 with SMTP id
 a18-20020a256612000000b00b9469897fa6mr569267ybc.4.1684966731195; Wed, 24 May
 2023 15:18:51 -0700 (PDT)
Date:   Wed, 24 May 2023 15:18:03 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-8-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 07/35] perf evsel: Add is_pmu_core inorder to interpret own_cpus
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The behaviour of handling cpu maps varies for core and other PMUs. For
core PMUs the cpu map lists all valid CPUs, whereas for other PMUs the
map is the default CPU. Add a flag in the evsel to indicate if a PMU
is core to help with later interpreting of the cpu maps and populate
it when the evsel is created during parsing. When propagating cpu
maps, core PMUs should intersect the cpu map of the PMU with the user
requested one.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/include/internal/evsel.h | 9 +++++++++
 tools/perf/util/evsel.c                 | 1 +
 tools/perf/util/parse-events.c          | 1 +
 3 files changed, 11 insertions(+)

diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index a99a75d9e78f..4d6f2a032f45 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -41,7 +41,14 @@ struct perf_sample_id {
 struct perf_evsel {
 	struct list_head	 node;
 	struct perf_event_attr	 attr;
+	/** The commonly used cpu map of CPUs the event should be opened upon, etc. */
 	struct perf_cpu_map	*cpus;
+	/**
+	 * The cpu map read from the PMU. For core PMUs this is the list of all
+	 * CPUs the event can be opened upon. For other PMUs this is the default
+	 * cpu map for opening the event on, for example, the first CPU on a
+	 * socket for an uncore event.
+	 */
 	struct perf_cpu_map	*own_cpus;
 	struct perf_thread_map	*threads;
 	struct xyarray		*fd;
@@ -65,6 +72,8 @@ struct perf_evsel {
 	 * i.e. it cannot be the 'any CPU' value of -1.
 	 */
 	bool			 requires_cpu;
+	/** Is the PMU for the event a core one? Effects the handling of own_cpus. */
+	bool			 is_pmu_core;
 	int			 idx;
 };
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 2f5910b31fa9..8c8f371ea2b5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -415,6 +415,7 @@ struct evsel *evsel__clone(struct evsel *orig)
 	evsel->core.nr_members = orig->core.nr_members;
 	evsel->core.system_wide = orig->core.system_wide;
 	evsel->core.requires_cpu = orig->core.requires_cpu;
+	evsel->core.is_pmu_core = orig->core.is_pmu_core;
 
 	if (orig->name) {
 		evsel->name = strdup(orig->name);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index b93264f8a37c..1a0be395c887 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -260,6 +260,7 @@ __add_event(struct list_head *list, int *idx,
 	evsel->core.cpus = cpus;
 	evsel->core.own_cpus = perf_cpu_map__get(cpus);
 	evsel->core.requires_cpu = pmu ? pmu->is_uncore : false;
+	evsel->core.is_pmu_core = pmu ? pmu->is_core : false;
 	evsel->auto_merge_stats = auto_merge_stats;
 	evsel->pmu = pmu;
 	evsel->pmu_name = pmu && pmu->name ? strdup(pmu->name) : NULL;
-- 
2.40.1.698.g37aff9b760-goog

