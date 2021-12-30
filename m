Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262FDC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Dec 2021 07:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237886AbhL3HWC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Dec 2021 02:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237645AbhL3HVb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Dec 2021 02:21:31 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9801EC06179E
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:21:31 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id u130-20020a254788000000b0060a9645f781so30254382yba.19
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qNKIUlySFfRYFL3LsJVvo5UF9vFYVSjFaW2mryRhEhE=;
        b=gHS0SjBZ6BRQWd+TXVtPnKnWfJcnbY9nHdxIBK+Z7QvS0Q95E+qgPT9Ya5sOks/WiY
         4Zem4Fto7v+P7JwneQD9j1lXQ1LbUplJc3+2O8g7ONNy81WKHt6g4Ml2Xs6SkZX025Z8
         iDaQa1a1oP6oKjK3egsAXlt8/rJJBzky6vTRmNPGr87FjpRJRfHd7Vw8b0rPq6C+Um49
         gbfuwDDOX85qnbbek6UG5obuNQVIjsV0KggtY7T91qLF3UQqN2wlemYjCnF94P7r25UG
         J1D0DqMFHrItaIXAV0wQ5/imijprO7coWMKhIMUA/pLbQUWgXl1bEwwvk7ZoGd/ysO4o
         rk6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qNKIUlySFfRYFL3LsJVvo5UF9vFYVSjFaW2mryRhEhE=;
        b=7SQt6ZPT4uHFqSrAybhmXdRQLYz+e9zBXmWQITHq6ZlwNOzl6FRDsq900qEP/UiHFp
         fmGvuXtb2TAS/dNtI8HNMxTSgvi/fHJWvLD6dY+j9E/sfvm7tkRUPw9fxn7pzvGm8tJz
         mCmT/dWPKX3QJ2wU7mEZWMUU0+UkXSUhWCjdXSGq2goeWYQBuKy1JVgtldP9AA8T1M/R
         29RChJVSZ/4jFY/dU1oOW6SNgtRLPYolmAudKHSiO5rVySc1fJOH6yW6ItRNU9WXbGmd
         CsMz6w+qFp8N/IcEzvQlmAO1pZAuuVCxKbAdPbAId0pyzkHmYSNzhrL3DqxuLWGHMOm1
         Tz3A==
X-Gm-Message-State: AOAM530a0ZOse5R+iUNz/i1qwEKXvGBeRidvwsp63PwD8UHvsVJJejXz
        XexfpYayNz5TB2Oh6LEKlmZUKytN1NC8
X-Google-Smtp-Source: ABdhPJx57wn5jbgLGLHvQD+JHSSIIVUaMPZPQ5HbrR5jNwrjUX9bWwqhME1VrhI9+q+Qzab4hM5N5+dYdEIJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:abc7:: with SMTP id
 v65mr13083631ybi.280.1640848890846; Wed, 29 Dec 2021 23:21:30 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:03 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-23-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 21/48] perf cpumap: Add some comments to cpu_aggr_map
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

Move cpu_aggr_map__empty_new to be with other cpu_aggr_map function.

Reviewed-by: James Clark <james.clark@arm.com>
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
2.34.1.448.ga2b2bfdf31-goog

