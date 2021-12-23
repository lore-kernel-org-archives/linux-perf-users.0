Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CD5C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Dec 2021 07:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347101AbhLWHtF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 02:49:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347347AbhLWHsP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Dec 2021 02:48:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D60C0617A0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:58 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id t184-20020a2546c1000000b006008b13c80bso8749327yba.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=57/+4CL2ERGKB8wcFmTlsb9+ddyZs/YCDFj+XQK+r0Y=;
        b=Kmw2HMz8OnTT8+e6Av5zTsnabJHV8YuPlY4nBiiHSrQaqFlf8OO8BaE6JhznIb+SkY
         VbqZrgtC4iehGZ7B79QmLrZdOtspJq5LF9uzHuUOCAFNmOfeWXOL1obfpVpL699oH31r
         RMl4gBPGQa5La8+7Mb7usxHC/DEYrY3rgqrQ/8f1Js0gwjznxcIY/fwlRyNgnH2fPbKQ
         TXgOSJrulJ12P/58l9iRWaPGNYN7knQGXt4VJS/5PeyX3P28yZJyE6IdNO6uOr1Aka5L
         fXWzycF1yUW/PHYWg4mkth7nRHn4Qx4qFCwINtwn1FAmf6VVPFS+bEt+pEQTGGEvrMrm
         04eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=57/+4CL2ERGKB8wcFmTlsb9+ddyZs/YCDFj+XQK+r0Y=;
        b=hOzjiSP0x0ZKb9oJymfe/iWb97m0paWR8M8lVZzH4cph3TcxHkybwOswdoLehAARiz
         ZtfYfNx1kfHwPTi6gv1LHp0aTmeUBjy2j0QAi1DyCPqMAhNZNhCc7thBvfM896JHJ0Xw
         yvnbZKVRxFeE9c4Rn/JbpYEvFGCqRiJk0HouJGcFbJSAcE3b6WzoY/qd9P/a2/ilm4lP
         W4ykYEkxPk55nQb9sPK6D+tO2U0T8vqAtGXMgFQFpagNm0Gl7sFn3jbi6VEsxpxEKHH+
         i/JA25PAvB6vGOEXJeQPRCVkRa3BCOY68o48ovRy3zg2TPrGVI+xkaL3CHkmsjU5ICwO
         B5ag==
X-Gm-Message-State: AOAM531pLDALX2R/JI2vrbXbociytrAzBjZkFDDtsM+ogbZkIqwvX6mH
        nPcZGUZ24QJQWnPPt8+ifs6Sqeu3jt7m
X-Google-Smtp-Source: ABdhPJz7s6JPrDDNZF3on+3gorJfYhIFzNZiyO0pXViekCWuxfoR7TVmFQdx4NTB8GlHaIJ5D01ruOND6QQL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:516:: with SMTP id 22mr1724778ybf.294.1640245677712;
 Wed, 22 Dec 2021 23:47:57 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:36 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-44-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 43/48] libperf: Sync evsel documentation
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

cpu was renamed cpu_map_idx, for clarity.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/Documentation/libperf.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index 63ae5e0195ce..88a9335421ab 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -135,16 +135,16 @@ SYNOPSIS
   int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *cpus,
                        struct perf_thread_map *threads);
   void perf_evsel__close(struct perf_evsel *evsel);
-  void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
+  void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu_map_idx);
   int perf_evsel__mmap(struct perf_evsel *evsel, int pages);
   void perf_evsel__munmap(struct perf_evsel *evsel);
-  void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread);
-  int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
+  void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu_map_idx, int thread);
+  int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int thread,
                        struct perf_counts_values *count);
   int perf_evsel__enable(struct perf_evsel *evsel);
-  int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu);
+  int perf_evsel__enable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
   int perf_evsel__disable(struct perf_evsel *evsel);
-  int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu);
+  int perf_evsel__disable_cpu(struct perf_evsel *evsel, int cpu_map_idx);
   struct perf_cpu_map *perf_evsel__cpus(struct perf_evsel *evsel);
   struct perf_thread_map *perf_evsel__threads(struct perf_evsel *evsel);
   struct perf_event_attr *perf_evsel__attr(struct perf_evsel *evsel);
-- 
2.34.1.307.g9b7440fafd-goog

