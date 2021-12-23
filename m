Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17467C43219
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Dec 2021 07:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347221AbhLWHs0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 02:48:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347230AbhLWHrr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:47 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C012C061377
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:30 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id t24-20020a252d18000000b005c225ae9e16so8618835ybt.15
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gS702mZNdqaqGqsGN8/od6/9eJfsTdX5XaCwO/CHnxg=;
        b=ZAG5FsujH76QsBUz/tYbzeEG+GrdHE0RRbhUkLTKIjXs8evI8wAwEzY1h9EMDJqLnH
         hlWlHw8ziKRJadI9FWV7TXuil8dvJNhJdyncQg+B0ziD3qhSeeGq9zd8RStul7QZcUHP
         nLgq9PAndLX+i87S/32ECHBitev9Eh0Ep/uGVfLee+lL+BdKoKPAUlgUEFWZvOiIwJld
         9RGSqm7s322Kdx9GRuLW6iLuqNsN5wQqpiwwM2KspOhUZUSB0WHBTF0FV7MJMUm5PikU
         7a8JPVmxmEa9NuVRw/kcDPUHBeKeJE5lbmgn1WFsX9OJ5W6RcdOIsS2rG/xSt8AG48z3
         3XLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gS702mZNdqaqGqsGN8/od6/9eJfsTdX5XaCwO/CHnxg=;
        b=uaAfeJunkxi0Dvd1ahwEuU65Vs2D7GMzgEc+xaIsby2Izu05NpMWSsO9I5noExGm4W
         oQ9b9s9CxxzC1DnueA0c1IL2bSuTY3ozSAzV6yf4ja+4fjSo07XoIUllZWXjN7z6yRjm
         Jm5OT5xOD4HnoS7TcNRtSD1blZMoHURX9zs0oyc3UtJnnvFBzxiUgxGD7LZldVV2WHbJ
         E0wzoTZSr8VnBgMqhS1mQt1Kfd/MgLoAdyVsi/Z2f8IST+vbtTRb7AQQNAKY2rCifgD2
         aMGmSFk5AkTv13wF86NiT4Q32R0AftAsTU5WfOtqhYkpHsyzZnqj3+mjNSEwiynv6jfb
         jv3w==
X-Gm-Message-State: AOAM5331joeLdi+aVDh9+F1/SdcFd/THp8ppsTVHTPfNS9p6Z8/Jhh3h
        mZCLz5Hkhkv+bp/xc/1HC53r5DCPnOvU
X-Google-Smtp-Source: ABdhPJzky4057KHzG/tA4tur8qNXghY66f9kz+2zvw0XyPAyGCbP0JD3U0gIN/QaSj9xsR799MWG2pDgUs+J
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:258c:: with SMTP id
 l134mr1685364ybl.40.1640245649513; Wed, 22 Dec 2021 23:47:29 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:25 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-33-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 32/48] perf script: Use for each cpu to aid readability
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

Use perf_cpu_map__for_each_cpu to help with readability.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 9434367af166..af06fe1271cc 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2113,8 +2113,7 @@ static struct scripting_ops	*scripting_ops;
 static void __process_stat(struct evsel *counter, u64 tstamp)
 {
 	int nthreads = perf_thread_map__nr(counter->core.threads);
-	int ncpus = evsel__nr_cpus(counter);
-	int cpu, thread;
+	int idx, cpu, thread;
 	static int header_printed;
 
 	if (counter->core.system_wide)
@@ -2127,13 +2126,13 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
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
2.34.1.307.g9b7440fafd-goog

