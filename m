Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160F3C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Dec 2021 07:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237180AbhL3HWb (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Dec 2021 02:22:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237495AbhL3HWC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:02 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E41DC06137A
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:21:54 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id 35-20020a17090a0fa600b001b160e1ecffso15226871pjz.9
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ewN6TgeYhi7NNspT4fCbrjPDfPPrcTRTO0RxDMRaTEI=;
        b=INzSbn3pkxSj2o5rY/D2ZDHKiMG80XuFQV1LdJh951/si0ZNvb2AQ/U8J01hhPUcip
         O4YIgbs5JOUpysdzNjoTE+e1bYWE0QhhGSrmhekuQLSyeuXFeLNHRXgLI6z5rORfe5rL
         /JvOaK/8/+nxPMe0QcNX43yTndBbtabg8tnrfCR/xKmAEjc7/ntldHYPidBQCpYhqt9W
         eVMXK0k8df5ymmhFgydv9CnHZlVm96sEswqhFAkTfdlbT0ZrUgJjDaNfKoGWhUEMcjDK
         KNPzlUm1D0bTZFwRjNxXU4vt3u9OIFi+YN5QgSJFbl/uEQRFxIH4JUviryG9zXNqoalp
         /1BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ewN6TgeYhi7NNspT4fCbrjPDfPPrcTRTO0RxDMRaTEI=;
        b=ZtUX7OeOLDX6WNpbFy7akzhkPRLePDJpB/vCng2fNY1W4O+HsMu7TXwRl3vZqDyfdJ
         WkmU4LI/4n9+d4jvYLVBO6hYWXyisni32l9BP5dgv1a6tjF5Ht6WQqqYf0njR90gNCmC
         pXo0SLrehoeqwlTecvipQKzKL0Vme9Yv+UTCISWqrSjFUIwUPdZ/6JzUz8A/9vHSdGbQ
         zjkjte00ugNxPCIJC50TsYTkfSM4P75fy8cYRmdHoE/LUL5q22R9Cqc+P1xAFFzcrMWe
         ydjU5UX1zdaVvFicCQcXQFJYI9yl4bSEMxNp5GmGhmNDr1JlQdIoPuzY4JoK2KNr2T8I
         nfdQ==
X-Gm-Message-State: AOAM532DFSpQggNr7WKZng8YJolvgnFOPgRcn0VPqcGGRyXz4wMdOUeN
        IL0Y8+MHdgCjo0FQJwKI4dJsCMtQRfBt
X-Google-Smtp-Source: ABdhPJxwC04VkqtH3R7KdDCbDUTQi3SLQnP/SiPOIZUMZfH2icNrN1mdP2zY7pRXNCkZkVNGG4IDRp1xSH3H
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a17:90a:638a:: with SMTP id
 f10mr36302623pjj.187.1640848913549; Wed, 29 Dec 2021 23:21:53 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:12 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-32-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 30/48] perf stat: Rename aggr_data cpu to imply it's an index
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

Trying to make cpu maps less error prone.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index f48d1678861c..7e933a8fee68 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -626,7 +626,7 @@ struct aggr_data {
 	u64 ena, run, val;
 	struct aggr_cpu_id id;
 	int nr;
-	int cpu;
+	int cpu_map_idx;
 };
 
 static void aggr_cb(struct perf_stat_config *config,
@@ -878,9 +878,9 @@ static void counter_cb(struct perf_stat_config *config __maybe_unused,
 {
 	struct aggr_data *ad = data;
 
-	ad->val += perf_counts(counter->counts, ad->cpu, 0)->val;
-	ad->ena += perf_counts(counter->counts, ad->cpu, 0)->ena;
-	ad->run += perf_counts(counter->counts, ad->cpu, 0)->run;
+	ad->val += perf_counts(counter->counts, ad->cpu_map_idx, 0)->val;
+	ad->ena += perf_counts(counter->counts, ad->cpu_map_idx, 0)->ena;
+	ad->run += perf_counts(counter->counts, ad->cpu_map_idx, 0)->run;
 }
 
 /*
@@ -897,7 +897,7 @@ static void print_counter(struct perf_stat_config *config,
 	struct aggr_cpu_id id;
 
 	for (cpu = 0; cpu < evsel__nr_cpus(counter); cpu++) {
-		struct aggr_data ad = { .cpu = cpu };
+		struct aggr_data ad = { .cpu_map_idx = cpu };
 
 		if (!collect_data(config, counter, counter_cb, &ad))
 			return;
-- 
2.34.1.448.ga2b2bfdf31-goog

