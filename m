Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75862C433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Dec 2021 02:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243712AbhLHCus (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 7 Dec 2021 21:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243549AbhLHCud (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 7 Dec 2021 21:50:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F531C061D72
        for <linux-perf-users@vger.kernel.org>; Tue,  7 Dec 2021 18:47:01 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g25-20020a25b119000000b005c5e52a0574so2148229ybj.5
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Dec 2021 18:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1Q+fR+dwg/H4WwN6K7F+f4dnQV1rO5+y5/1HnCJA9YI=;
        b=Tq57yUqxqzsTnfHy69cRgj7WPbRWbhORq01ib3E/8l4haWXRw4XJ0O7hPSnZh0ebpF
         wwB2yvEWiRKuz7MyjyUHRx8fss5D3A43ci4tZngK7bDGZAqU+jFqLH0nVYfn3o52zWSb
         FqvBqb8mQAjsbN2VenfengCFFpg9jSLGzzO3Jcy5As0zQtPg/fls1dbN3iEYG7OKmu0D
         e7cjYG2AuW8BMSrvDB0B6Qf9UlBLSkk9tWfIqECzGLliyZQ5o7FA74JDl/SE/R7Sn5MD
         ERqaC9pqphDdtTzZgli01HDQZ8/PpSBrurYC9ytIV2h067jiLZucT+4jts2Ee/vXTyC3
         l/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1Q+fR+dwg/H4WwN6K7F+f4dnQV1rO5+y5/1HnCJA9YI=;
        b=SCrrmq2stxQT0H2ADy8LBRc6xjQfPPmOsQXZzncbE1fWdG2hFYxxXExj+hPyJrZ2NQ
         9B838A7anJCKaCZhm5anWbPCUHjA5zvUechKgzboFswfMfZjJxN9uJ0e6I2ZvT0g/zNV
         oNSp4EMqUBib9z6g5bGSZBKd7ELvRhKYaoqqei2kW+dgfY8ipRmGFWo6jxmkAIQg1o0M
         PCfdY7rssBBIuzmqNRZAPkQiVdjLowD6JyCRParjROxN+tJzlhapKfqm7OGfoUMVsIb8
         Ey+u/BE0dxabGDJhRrwnPeBCX9JIIhxtROoDABdMJXSy5wkCkGkka9PlQ5pMODyJlA0e
         rMow==
X-Gm-Message-State: AOAM533ruF2t4EhFnstuYE3LLqlihEPBnbxnTNdZOGlnIeSvJ3DZqr/e
        mw6kS0qp/9WM+rUSwAZnORVB+1AHgKSZ
X-Google-Smtp-Source: ABdhPJwmCpy85KFCAgIHdaCfJeQTKmUW7WcGyj3my5IAiR51pn6j2dVANCI+U57vpj/0konDph5UdaC8B/U2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:57e:1dbb:34b4:8257])
 (user=irogers job=sendgmr) by 2002:a25:ada5:: with SMTP id
 z37mr54331518ybi.93.1638931620488; Tue, 07 Dec 2021 18:47:00 -0800 (PST)
Date:   Tue,  7 Dec 2021 18:46:05 -0800
In-Reply-To: <20211208024607.1784932-1-irogers@google.com>
Message-Id: <20211208024607.1784932-21-irogers@google.com>
Mime-Version: 1.0
References: <20211208024607.1784932-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
Subject: [PATCH 20/22] perf cpumap: Add some comments to cpu_aggr_map
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
        linux-arm-kernel@lists.infradead.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Move cpu_aggr_map__empty_new to be with other cpu_aggr_map function.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cpumap.h b/tools/perf/util/cpumap.h
index 832fc53f3c11..8acef8ff8753 100644
--- a/tools/perf/util/cpumap.h
+++ b/tools/perf/util/cpumap.h
@@ -24,16 +24,18 @@ struct aggr_cpu_id {
 	int core;
 };
 
+/** A collection of aggr_cpu_id values, the "built" version is sorted and uniqued. */
 struct cpu_aggr_map {
 	refcount_t refcnt;
+	/** Number of valid entries. */
 	int nr;
+	/** The entries. */
 	struct aggr_cpu_id map[];
 };
 
 struct perf_record_cpu_map_data;
 
 struct perf_cpu_map *perf_cpu_map__empty_new(int nr);
-struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr);
 
 struct perf_cpu_map *cpu_map__new_data(struct perf_record_cpu_map_data *data);
 size_t cpu_map__snprint(struct perf_cpu_map *map, char *buf, size_t size);
@@ -67,6 +69,12 @@ int cpu__get_die_id(int cpu);
  */
 int cpu__get_core_id(int cpu);
 
+/**
+ * cpu_aggr_map__empty_new - Create a cpu_aggr_map of size nr with every entry
+ * being empty.
+ */
+struct cpu_aggr_map *cpu_aggr_map__empty_new(int nr);
+
 typedef struct aggr_cpu_id (*aggr_cpu_id_get_t)(int cpu, void *data);
 
 /**
-- 
2.34.1.400.ga245620fadb-goog

