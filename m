Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E80C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Dec 2021 07:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347376AbhLWHsR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 02:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347114AbhLWHrl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:41 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24981C0613B5
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:25 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id d27-20020a25addb000000b005c2355d9052so8657650ybe.3
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hkPo8liTuI9h6KOorTG0Q0VnFokCocOgWRmiktw00dU=;
        b=Xcj0ee+hgy+nDCYG/rsM91+FuuqQSJiMSCzMOM5SkpY53T4DzkFC3flZLbcPQJ0xOW
         ucf2StOzgxlmQWFBtpk07akH+Ih91uqwgd1SMQCB2yVnBLHsYRa+avn6wgPFt0kjsNpr
         YwbBXIrJUuKVqeYyf/FM/YHOI0xj9btID3ki+m/EGWmg+sNQYCI07g79MZCdpOAU/BVP
         7xrCMsCuo94Fz14MPRqjNXM3IgUKSoibZqYXoQlX7f4LfI/d9uARzppArHlhFKv0NNPP
         godVNKuyjvowcHh5mfHlqzEk2VHtLkw1SGFdfboDj6XRovc2Lq4bIDiSIU5UWJUDkBe0
         Qlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hkPo8liTuI9h6KOorTG0Q0VnFokCocOgWRmiktw00dU=;
        b=iHkeT6Ek/IOBgVfwg7uUyhP36g2fXnCyOvVrPUpLHL8AYtAaA1mvxRpdz8npeNRoGv
         2dzScEtrO5RgW4OFy7If3Ynz9RVcRK58f4WBUJx2aGHZeHqWFA63ncOF87xeWkFqWHHb
         396RyIqxtIUAGEhgFiwlLqUE7eAN7OHdOXx3syxalDSpw575dWtJtwt3nGz7WbF6jOS0
         KZSu3IiLQ0cjIUeNbXy1wDxlAah+7XJXhWiyxrYMJvRC64Z411sQHjJzklGIqXVaIs9/
         0nZvP9WSuBDcumPeuChMjIEvOr8lZ+nyNBDWf8z9g+Wumynk1xYOnJxY3KYvesRC8sud
         8uiQ==
X-Gm-Message-State: AOAM531cWYIQ1pFDib2VGINcD/TkozDU9Op1tkQoPcdbTwsi2KorVwvP
        69sParTzRub075c9oNXpklklaLJlqjvz
X-Google-Smtp-Source: ABdhPJxp6t3w/qnJ+v3zw2zyM1duZWB+B4DWIZtTNpflJlX6sZOLZwc2wLe7o4mryuVEonh3x19x1ZBXjNXr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:50cf:: with SMTP id
 e198mr1803293ybb.508.1640245644353; Wed, 22 Dec 2021 23:47:24 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:23 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-31-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 30/48] perf stat: Rename aggr_data cpu to imply it's an index
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

Trying to make cpu maps less error prone.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/python.c       |  2 +-
 tools/perf/util/stat-display.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 563a9ba8954f..4b510a1f27d4 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -1057,7 +1057,7 @@ static struct mmap *get_md(struct evlist *evlist, int cpu)
 	for (i = 0; i < evlist->core.nr_mmaps; i++) {
 		struct mmap *md = &evlist->mmap[i];
 
-		if (md->core.cpu == cpu)
+		if (md->core.cpu_map_idx == cpu)
 			return md;
 	}
 
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index 821511ba22cc..4f93591aaa76 100644
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
2.34.1.307.g9b7440fafd-goog

