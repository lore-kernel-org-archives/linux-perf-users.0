Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52604C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Dec 2021 07:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237205AbhL3HVa (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Dec 2021 02:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237482AbhL3HVS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Dec 2021 02:21:18 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB88C0617A0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:21:16 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b10-20020a251b0a000000b0060a7fbb7a64so31553066ybb.23
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:21:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=s2CIczuM8teFDrPnQG9a+NBNIXG/EojqlmU2x3Abtwk=;
        b=No5depfbeojoeyTjZ7X0jeZ5N60dgn1waIhAAPmxijSgjjvbmxpqrbNrUkAB3+Mr69
         D9/tyQ+u8+FsA37VLb8//fuHIgaidDofnkwF9plMWNjvW5eDyWJU4IYRgzqK5MzfHXbl
         DFD39l2AlagIiMWUgF6qC5WZ/PtkCs6uCh2iGeDvSlXlTIGUi+R18PzB1EGfafYHYoWl
         XD4d4tEj3reWUVc0ZK5+uwsh8k2vT9JMkHEFM23mPzxadL98HC1zIDPmSsNkUVq+Wxd3
         cnG+lqKAwTYrG2r8++ivvKdhpB5zQ1WaR8lFH1YePvjKfQFl8FQPs9YKMa0Jv0rxKFPS
         OE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=s2CIczuM8teFDrPnQG9a+NBNIXG/EojqlmU2x3Abtwk=;
        b=nzxFsY2h831t7h3kOnSo+YSgux3eC2Vvl5d+MYE7ge8yNyeD0AnEI+faudV9u1DJRX
         RUIDM5CQJDUlp41xFpW8wGQs1frpHRF5ob7qa37PMDR5WWH/7bw9v1GeFT/RErZrX2/t
         vY5dmA/b5Hlf7wWrcwuGgEIuRH1t9DeHJHjiZVfKgMEpX12B6/bxwy7gRjOr3RUg65+n
         u5LBavwqf0boiMNJqipJu/03OXGhf8EYIKCkheYuOAiyVkdfAaQ0XtunTFoUwUPxBL9P
         UzVaJmQYGUWFTZU2+xwCobwIX6mDRkC12nCQOnj+XR/Ot39STylMlVVCLXKWArATHzPM
         DGIQ==
X-Gm-Message-State: AOAM533+28fmeOulJMEU9diMZXHlnqz/xORVcmYF3KW1WCEx/oJTapjD
        ORjifC2wz0LPhxsHNbeAQVOSiqjxWPmm
X-Google-Smtp-Source: ABdhPJy7jq3i4MC7xvQckm3znGI61lzyO5NMel4adhTbckf7FGFpxr8wOmkVWD/Q6KjYeJJ1bXu47PO66c60
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:770f:: with SMTP id
 s15mr20081478ybc.751.1640848875983; Wed, 29 Dec 2021 23:21:15 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:19:57 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-17-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 15/48] perf cpumap: Document cpu__get_node and remove
 redundant function
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

cpu_map__get_node_id isn't used externally and merely delegates to
cpu__get_node.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.c | 11 +++++------
 tools/perf/util/cpumap.h |  5 ++++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index b3e1304aca0c..1626b0991408 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -16,6 +16,10 @@
 static int max_cpu_num;
 static int max_present_cpu_num;
 static int max_node_num;
+/**
+ * The numa node X as read from /sys/devices/system/node/nodeX indexed by the
+ * CPU number.
+ */
 static int *cpunode_map;
 
 static struct perf_cpu_map *cpu_map__from_entries(struct cpu_map_entries *cpus)
@@ -222,11 +226,6 @@ int cpu_map__get_core_id(int cpu)
 	return ret ?: value;
 }
 
-int cpu_map__get_node_id(int cpu)
-{
-	return cpu__get_node(cpu);
-}
-
 struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data)
 {
 	struct aggr_cpu_id id;
@@ -250,7 +249,7 @@ struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data __maybe_unu
 {
 	struct aggr_cpu_id id = aggr_cpu_id__empty();
 
-	id.node = cpu_map__get_node_id(cpu);
+	id.node = cpu__get_node(cpu);
 	return id;
 }
 
diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 9589b0001a28..f849f01c5860 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -45,7 +45,6 @@ int cpu_map__get_die_id(int cpu);
 struct aggr_cpu_id cpu_map__get_die_aggr_by_cpu(int cpu, void *data);
 int cpu_map__get_core_id(int cpu);
 struct aggr_cpu_id cpu_map__get_core_aggr_by_cpu(int cpu, void *data);
-int cpu_map__get_node_id(int cpu);
 struct aggr_cpu_id cpu_map__get_node_aggr_by_cpu(int cpu, void *data);
 int cpu_map__build_socket_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **sockp);
 int cpu_map__build_die_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **diep);
@@ -58,6 +57,10 @@ int cpu__setup_cpunode_map(void);
 int cpu__max_node(void);
 int cpu__max_cpu(void);
 int cpu__max_present_cpu(void);
+/**
+ * cpu__get_node - Returns the numa node X as read from
+ * /sys/devices/system/node/nodeX for the given CPU.
+ */
 int cpu__get_node(int cpu);
 
 int cpu_map__build_map(struct perf_cpu_map *cpus, struct cpu_aggr_map **res,
-- 
2.34.1.448.ga2b2bfdf31-goog

