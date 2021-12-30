Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E8FC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Dec 2021 07:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237637AbhL3HWk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Dec 2021 02:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237623AbhL3HWC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:02 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7734FC06175F
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:21:51 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v189-20020a2561c6000000b0060b5814a17eso26925427ybb.22
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8kii3dU4XUig2NsMBYh2ztP77tNeRDKF26nqmJlinnw=;
        b=ZHSo2QogBeCKktE3N/YyE3guPCcf/h1gw/biq5AKmUg4GzLO2669grdN+V+1ag5H99
         c9w2XJWVYAwtx7P2SqJ/xO56ij3QK1S0NzXUvKQxC7XhO0N8O8RoNxGetqs7QkUqPHCS
         58pxmqY8UZUpFb60FfOhNHmDYw1EPGUdByWzIamAxyO6vJhLZzfilDHYwzNTxvAWvTGU
         UDtvUfmm4b5qWzn5oUT/eR9b83N4dQPJKT0Y+8xGxkXfU/neI2ieuSG8gfbE5zBocxK+
         PGOZ5+qDjoWM0lO2LiAZc0g6RjweagNlLMIsnjL49ujCCKDm/ZO79snV4QhczPjC3GaY
         yswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8kii3dU4XUig2NsMBYh2ztP77tNeRDKF26nqmJlinnw=;
        b=Q0y1pUv8Mo2uhYdFhPBwZqN9qrhSMsZvqIxIrDR8NXMJ02CKUTODCiPqS9pIa/kyKG
         Ar1CgzMILozRuDDmR6hBSpMtHSlWjeo2LmHbBAhrUveCBpvYMLHRi6pPS80vqhi7qQJW
         okYJrKeJhhXYpL5VG8QsE7Z9Zxt+35ilCoRAFlkr0vHQrRC+xtAT7h/Yn4jNRJsVJ15x
         IhGcOqsha7vNlsMPr0hxVJEnK6PvKc8/hPXKqCQ4lvgF3hScMv28bDr2J9B+Qqp0LRzC
         RkbCGFuSFOShP+X6aa2XbGpW9/MDk3Z90XSyy54O/dYiNLvZ6D+pCpxja/ADiekH/GS6
         NbZQ==
X-Gm-Message-State: AOAM5300/8RMPd4dnv/HvyqduIlFPM7c6MIz6nhtMBNtDo8RmTg7F8Fa
        0Baml6w2PQhAGsrPPIj4G9bpQb2ezlG2
X-Google-Smtp-Source: ABdhPJyMMa/s/OfZP2MysxB1hBFAyWLxl400jCqqJknIeMSBDfgAktkYlZ98Gg7nJoVPdSu9G6g8w6ryMdDj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:510:: with SMTP id 16mr24785663ybf.247.1640848910686;
 Wed, 29 Dec 2021 23:21:50 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:11 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-31-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 29/48] perf counts: Switch name cpu to cpu_map_idx
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

Try to reduce confusion in particular when the cpu map doesn't contain
an entry for every CPU.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/counts.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
index 3e275e9c60d1..5de275194f2b 100644
--- a/tools/perf/util/counts.h
+++ b/tools/perf/util/counts.h
@@ -18,21 +18,21 @@ struct perf_counts {
 
 
 static inline struct perf_counts_values*
-perf_counts(struct perf_counts *counts, int cpu, int thread)
+perf_counts(struct perf_counts *counts, int cpu_map_idx, int thread)
 {
-	return xyarray__entry(counts->values, cpu, thread);
+	return xyarray__entry(counts->values, cpu_map_idx, thread);
 }
 
 static inline bool
-perf_counts__is_loaded(struct perf_counts *counts, int cpu, int thread)
+perf_counts__is_loaded(struct perf_counts *counts, int cpu_map_idx, int thread)
 {
-	return *((bool *) xyarray__entry(counts->loaded, cpu, thread));
+	return *((bool *) xyarray__entry(counts->loaded, cpu_map_idx, thread));
 }
 
 static inline void
-perf_counts__set_loaded(struct perf_counts *counts, int cpu, int thread, bool loaded)
+perf_counts__set_loaded(struct perf_counts *counts, int cpu_map_idx, int thread, bool loaded)
 {
-	*((bool *) xyarray__entry(counts->loaded, cpu, thread)) = loaded;
+	*((bool *) xyarray__entry(counts->loaded, cpu_map_idx, thread)) = loaded;
 }
 
 struct perf_counts *perf_counts__new(int ncpus, int nthreads);
-- 
2.34.1.448.ga2b2bfdf31-goog

