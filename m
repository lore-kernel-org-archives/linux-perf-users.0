Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C60EFC4332F
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Nov 2022 21:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbiKNVH5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Nov 2022 16:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237320AbiKNVH4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Nov 2022 16:07:56 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8EC95A5
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 13:07:48 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3697bd55974so115613837b3.15
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Nov 2022 13:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2OZhfmPm3XVkECYqwzYQM5F2KZdnyo2PlgH8Orm1zuI=;
        b=d03dpv19fKYHRy/o0sTKt3d1Ucz5gD7WCqPFOeFJ2EEnrgHjP1F7o+EV5XjAH7uKXx
         QlhalH9ep4BgRvy+zz8yAUsQpMYQICs3LDhHwH+q5UgWdAFRboeOgd3gMH2tYFWsbrir
         cG4OYvkuz0+LBYsnJca4j/6wqAc5/FoKYNwrRbFeCYbtO2extKFVChEEuuP97gu1F4fI
         YlTRuFCf+JNRttBeHgxKWCxX3NgIWs+sZqDWiZOUtj4kn2NerPrZJua9Y6GmjZVdtqBG
         N6lPgMczC485QLYAXnM1iuRs4lqjm3b/CbiA6x/obus990if35GiEg2TDCzz9DfLnPBR
         gVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2OZhfmPm3XVkECYqwzYQM5F2KZdnyo2PlgH8Orm1zuI=;
        b=DjGGpaRc7GaWPpv8IaNPRuWU+bmHxEyaz9JQcRu2Fya3RT/U+FfjuPeGG9/VfYV+Lk
         65Uf63OE4Ex+KPczabZpXUt0zUh22NJKCwgpztn7Lg0TeylaswIfLhqjiwXmOMmdVZso
         Qke+u8v/nq+foYnRi/D1V8/wi+3ALfj1bIF2dbteHCK3pNdrNRhbre2SDWLSRd3wrN86
         K+olm6QjNNptidHQoiKeHhUNsLQKZS5GIvHGB1gD5aX1IYhGRc5QjS6BA8Ia6Gd6ylG8
         gGgGp0nTw0UeHHB811qh1oaFqDiT2ZwwRA/nnbhccJ4u/ZpQkn0+/9ghqYQ4iUrE7RMt
         pIgg==
X-Gm-Message-State: ANoB5pkAcCAencsD1KWSA8/aB4Qm9Y2YoMPhkM3hHVUch20y3u4TlCn/
        6IhKm2qU3ZNe57bXsqHwvWONtqvkndg6
X-Google-Smtp-Source: AA0mqf4Ws5KvPAwDSph9djQ4ezg04RclKilEiUPYeGk3HFTdX0NZSHs9URIs8HQP7NTfkDCvXnCqycBcOqHm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:553:438f:b86a:87f])
 (user=irogers job=sendgmr) by 2002:a81:78ca:0:b0:381:22a0:d706 with SMTP id
 t193-20020a8178ca000000b0038122a0d706mr6329985ywc.440.1668460067934; Mon, 14
 Nov 2022 13:07:47 -0800 (PST)
Date:   Mon, 14 Nov 2022 13:07:14 -0800
In-Reply-To: <20221114210723.2749751-1-irogers@google.com>
Message-Id: <20221114210723.2749751-2-irogers@google.com>
Mime-Version: 1.0
References: <20221114210723.2749751-1-irogers@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Subject: [PATCH v3 01/10] perf pmu: Remove is_hybrid member
From:   Ian Rogers <irogers@google.com>
To:     Weilin Wang <weilin.wang@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xin Gao <gaoxin@cdjrlc.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Replace usage with perf_pmu__is_hybrid.

Suggested-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c |  5 +----
 tools/perf/util/evsel.h |  2 +-
 tools/perf/util/pmu.c   |  3 +--
 tools/perf/util/pmu.h   |  1 -
 tools/perf/util/stat.c  | 11 +++--------
 5 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index cdde5b5f8ad2..ca6abb64c91d 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -3124,11 +3124,8 @@ void evsel__zero_per_pkg(struct evsel *evsel)
 	}
 }
 
-bool evsel__is_hybrid(struct evsel *evsel)
+bool evsel__is_hybrid(const struct evsel *evsel)
 {
-	if (evsel->pmu)
-		return evsel->pmu->is_hybrid;
-
 	return evsel->pmu_name && perf_pmu__is_hybrid(evsel->pmu_name);
 }
 
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 989865e16aad..467bb0b32fef 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -498,7 +498,7 @@ struct perf_env *evsel__env(struct evsel *evsel);
 int evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
 
 void evsel__zero_per_pkg(struct evsel *evsel);
-bool evsel__is_hybrid(struct evsel *evsel);
+bool evsel__is_hybrid(const struct evsel *evsel);
 struct evsel *evsel__leader(struct evsel *evsel);
 bool evsel__has_leader(struct evsel *evsel, struct evsel *leader);
 bool evsel__is_leader(struct evsel *evsel);
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6a86e6af0903..48e7be6f3baa 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -980,7 +980,6 @@ static struct perf_pmu *pmu_lookup(const char *lookup_name)
 	pmu->is_uncore = pmu_is_uncore(name);
 	if (pmu->is_uncore)
 		pmu->id = pmu_id(name);
-	pmu->is_hybrid = is_hybrid;
 	pmu->max_precise = pmu_max_precise(name);
 	pmu_add_cpu_aliases(&aliases, pmu);
 	pmu_add_sys_aliases(&aliases, pmu);
@@ -992,7 +991,7 @@ static struct perf_pmu *pmu_lookup(const char *lookup_name)
 	list_splice(&aliases, &pmu->aliases);
 	list_add_tail(&pmu->list, &pmus);
 
-	if (pmu->is_hybrid)
+	if (is_hybrid)
 		list_add_tail(&pmu->hybrid_list, &perf_pmu__hybrid_pmus);
 
 	pmu->default_config = perf_pmu__get_default_config(pmu);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 68e15c38ae71..0d556d02ce52 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -40,7 +40,6 @@ struct perf_pmu {
 	__u32 type;
 	bool selectable;
 	bool is_uncore;
-	bool is_hybrid;
 	bool auxtrace;
 	int max_precise;
 	struct perf_event_attr *default_config;
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 3a432a949d46..acf0edf5fdd1 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -604,15 +604,10 @@ static void evsel__merge_aliases(struct evsel *evsel)
 	}
 }
 
-static bool evsel__should_merge_hybrid(struct evsel *evsel, struct perf_stat_config *config)
+static bool evsel__should_merge_hybrid(const struct evsel *evsel,
+				       const struct perf_stat_config *config)
 {
-	struct perf_pmu *pmu;
-
-	if (!config->hybrid_merge)
-		return false;
-
-	pmu = evsel__find_pmu(evsel);
-	return pmu && pmu->is_hybrid;
+	return config->hybrid_merge && evsel__is_hybrid(evsel);
 }
 
 static void evsel__merge_stats(struct evsel *evsel, struct perf_stat_config *config)
-- 
2.38.1.431.g37b22c650d-goog

