Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABF4C4332F
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Dec 2021 07:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347213AbhLWHsR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 02:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242781AbhLWHri (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:38 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E71C06175D
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:22 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q123-20020a252a81000000b00609e97bb74bso8696625ybq.5
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9MlO9Oc0ygtrZ/h2HPcbPSvrjEKGPTLy8AFmEb58PdQ=;
        b=QRvmyQ7dNLCCzxTek5kADkOOAY1TOzPPY4YUro9+3bnIA71ybO6VL5mpwQ6+/AL4L+
         +zMCRVNebJJT5zqf6Yhn8uShyaZQ/cxf/tPjzhJW+Wdzf2pPo4NoDt5YepVxJVilRkrR
         ZHs5n+0bWa1l44WmXtzMjOlnGG5QGZnZIoD78fi5t1pgjG5BJWi2UU/no+TZAkOrLJ6B
         FuNamVbKccv1PslUXtsBRmAN/MlvwCWvfCQV6aqkZk5l47leYhjWcHwpqnFpq/o6MIOk
         OJn51HpK8ss0QhHvm4As8UTzqJJmykWjG7nWNwHZ8kCqRihirym89DRfneUF43B15U5M
         gY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9MlO9Oc0ygtrZ/h2HPcbPSvrjEKGPTLy8AFmEb58PdQ=;
        b=tb6xmT4R0IedICTnzAMORtVOjX5Qss2MtjRmsqslN6OABl4HlJ0zcLpVc09bBPpEZp
         v7CqTHpRl8Tme6n9etnIIUCdf2hTBe6yntUX1ig+wOWARLm6nG312/Qc417Db2/482/R
         bBjE86xcr1WIYAcuHt/rw+N7uAnjcL9p+cvIwpDsembJCrp+mUrTP1otmz+vvQ6kD+kw
         GzdWol5AIIkvMr6jRzKwkIOTAnol9xAccwnOfz7HisGp1TeVqU4w8wapxQpQ0cDCMKNV
         OYO07OobzvtVhwIdZqXFGdQtyrU89jI+7BOcd2PN1vfDNnrBSbbIg3QQej3cMhupmBCv
         4DUQ==
X-Gm-Message-State: AOAM530rBKgVxSXUK1TAQXpPhlTVNbj6uzvxiv+A/VSb1Wr3T5ijWquu
        7Z5Pyr+7SSnbO3a6DoJVdKLwbuXSRiSH
X-Google-Smtp-Source: ABdhPJw+xZ/j9KPjaoan9KyhnSh4c7HwSNgk0Z8l1o/khlbiifft972N8n40w8o6xk7NCchdOZ7J2Vjb8AI2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:aaaa:: with SMTP id
 t39mr1542314ybi.201.1640245641771; Wed, 22 Dec 2021 23:47:21 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:22 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-30-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 29/48] perf counts: Switch name cpu to cpu_map_idx
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
2.34.1.307.g9b7440fafd-goog

