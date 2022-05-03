Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD4EC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 May 2022 04:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiECEVr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 May 2022 00:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbiECEVl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 May 2022 00:21:41 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5953CA4C
        for <linux-perf-users@vger.kernel.org>; Mon,  2 May 2022 21:18:10 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d7eaa730d9so152254497b3.13
        for <linux-perf-users@vger.kernel.org>; Mon, 02 May 2022 21:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ylADTrsJ6wiLUYsMxUfv5wTGPsw8bfvmV1tE6kxgk9c=;
        b=Q420HA5+e4YUXnBw0wYuoypr1QivktDnGGhQ7w4Z4sP6i4mW2dFHRT5/AYIx/FNAre
         /+0noaBCbkUNRm3jlp7LW63K5hEdi6jLSShCREkUKipd3lNd/fO4Moe9qXO5/9fLk1Rc
         lJ/0CfIJL7U9KMZOmUgCQhF3PZrbmSeO/HtdTQFSFFkpsN9josCbuiCREy7T0zpnn7rF
         xnSgxieL1+zDlu5jt8cv66hzWA8qQI3RSaIKbmbmI0iLByiBUPgH4wgE9ALXcZ1Ykggo
         zxPzFr/4dhV9zAN/XARbMyWS9xS+MpgR6ki8I7iCXEDd86urxYCMBx5e18KAadlq+EVq
         Onfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ylADTrsJ6wiLUYsMxUfv5wTGPsw8bfvmV1tE6kxgk9c=;
        b=N7i/djbvRPQxvIzMaGtpprdU9nGBt72/Ixloy/ulsXpnq28vpHBCziQALONKY9MXP0
         KQOUCMq+zIq5iAJYNb5N0/KEJz43N80Z3cJrLuz1PL/rhVNJ1wGfkwDWtiLGXvzeYulV
         F37c/9R4nzroaj1PUMc+xO4fqDJ33+tbM/y051GdyQnhaU5aeH7wPBaxn2cE9eYIjbDs
         pMmO0H5lcHF3XGAaux5tPL/h2GkrRPaNXQM+A3QuyYTmfuKC4g0Cq5SAnTC679u5uyNE
         ob/rLwGP9nipY0nX6fVEnZqPeKmDz/LCXImDBN/s4RuckHZdbvF48pTL1Dv4SdhNMuOg
         nFGQ==
X-Gm-Message-State: AOAM5328yjAWdiTQWyhTobm1Kv1wD2SsDVEy/SLq8Q4IxVyaCqDkQ7+V
        uBJ4DWz1wT3CXaMrfu910cCYaiEQYeYa
X-Google-Smtp-Source: ABdhPJxd67nRJPH+qie23bqG5YLJVJJaTjfosAGibjZUM+HmIUkuw5cVpuRlHQWC1JKopkXEnBO+ZdDTxw4F
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dd4b:52bb:771d:7bb4])
 (user=irogers job=sendgmr) by 2002:a25:488a:0:b0:648:cfd4:8044 with SMTP id
 v132-20020a25488a000000b00648cfd48044mr12279689yba.555.1651551489576; Mon, 02
 May 2022 21:18:09 -0700 (PDT)
Date:   Mon,  2 May 2022 21:17:54 -0700
In-Reply-To: <20220503041757.2365696-1-irogers@google.com>
Message-Id: <20220503041757.2365696-4-irogers@google.com>
Mime-Version: 1.0
References: <20220503041757.2365696-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v5 3/6] perf stat: Avoid printing cpus with no counters
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf_evlist's user_requested_cpus can contain CPUs not present in any
evsel's cpus, for example uncore counters. Avoid printing the prefix and
trailing \n until the first valid counter is encountered.

Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index d9629a83aa78..13f705737367 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -948,8 +948,6 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 		struct evsel *counter;
 		bool first = true;
 
-		if (prefix)
-			fputs(prefix, config->output);
 		evlist__for_each_entry(evlist, counter) {
 			u64 ena, run, val;
 			double uval;
@@ -961,6 +959,8 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 
 			id = aggr_cpu_id__cpu(cpu, /*data=*/NULL);
 			if (first) {
+				if (prefix)
+					fputs(prefix, config->output);
 				aggr_printout(config, counter, id, 0);
 				first = false;
 			}
@@ -972,7 +972,8 @@ static void print_no_aggr_metric(struct perf_stat_config *config,
 			printout(config, id, 0, counter, uval, prefix,
 				 run, ena, 1.0, &rt_stat);
 		}
-		fputc('\n', config->output);
+		if (!first)
+			fputc('\n', config->output);
 	}
 }
 
-- 
2.36.0.464.gb9c8b46e94-goog

