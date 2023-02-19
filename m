Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB90DC6379F
	for <linux-perf-users@archiver.kernel.org>; Sun, 19 Feb 2023 09:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjBSJiU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 19 Feb 2023 04:38:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjBSJiR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 19 Feb 2023 04:38:17 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4591C12580
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Feb 2023 01:37:25 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i11-20020a256d0b000000b0086349255277so234145ybc.8
        for <linux-perf-users@vger.kernel.org>; Sun, 19 Feb 2023 01:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V1c75G2QRp2XfNcd0fyJt7z2QBiUcClmUEJnZutpl3U=;
        b=lQc7DLqjY+G0h68iUyNnQt0s8JbFjdLvt6vUD0X3O7LQXsct1au6ugX7YKcPBS3UPJ
         AsAznm2proFWTuMGysZno/FG9nfkQj2SekacMWMc3JcdaBlyiBSXOGz0lhlEgLdgGAxp
         WDR9gSMRJuJm8sfYf4Js7MhM80qTW0YRs+7lkwr6P601fxAf4quXfIGXkK94Dp9yf7NJ
         VG/TQ0DMh2RX36SsfyliyUni4YrostDu/WgZ0dbrvUcDxYX103Xt5iUnMSJxA78X1q/J
         xUWr1XsXdm9DAOmntwU2JGUE0TJhIpozeTXHwgCbdlqWpR3m96Aghhr+kQKjI1/QS/RH
         /euQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1c75G2QRp2XfNcd0fyJt7z2QBiUcClmUEJnZutpl3U=;
        b=XF0GYRoPTn0rjvmerS1+5Y7SFDFU4jg1WOG65xA+RLCbIW9kI1TYM3OQVVIDz8Aq7t
         nmakv3HvFVXue5q5zlOD8EH81NE2966HYMiC+GXn40yul9lZHk7VO8oYqUe4XjJzjLIU
         NP5bPUDNXpaQLr6QmOyDK0r3AgIH5dCtbQT0FaMrxLkRdAW/O74laYldUy0IPeOyMkfO
         sMmKPnQTfTCCs0PSeQmPMzwU8xr8HCGhj68oVwqVg3zQBdnXNQU6o9AMmZbBM7VSWgyK
         Rih82mKPuS4aj9MyVamvBBJzTb5wBBsuaM5KVko3av+m3VyF3clQczPKON1s+mXIIKcb
         XGtg==
X-Gm-Message-State: AO0yUKUkupLxpqYQ2Nb1MvEOo1SaLGVQGAeMlsK/ZYscG2pk1TwFlw4X
        kDf5/UAs6aIGX5wzDj0bJw4xtyqjocno
X-Google-Smtp-Source: AK7set+0phLS9+KCkYB1hD6t9OHjqMNjyrH3Ll05ZAB31Ht5Vz9xAKErSbBOtdwOA5pdD6xB9HPX23EwfbRP
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cde9:3fbc:e1f1:6e3b])
 (user=irogers job=sendgmr) by 2002:a0d:d6c1:0:b0:514:dae0:21ef with SMTP id
 y184-20020a0dd6c1000000b00514dae021efmr2065215ywd.133.1676799319684; Sun, 19
 Feb 2023 01:35:19 -0800 (PST)
Date:   Sun, 19 Feb 2023 01:28:42 -0800
In-Reply-To: <20230219092848.639226-1-irogers@google.com>
Message-Id: <20230219092848.639226-46-irogers@google.com>
Mime-Version: 1.0
References: <20230219092848.639226-1-irogers@google.com>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Subject: [PATCH v1 45/51] perf stat: Remove perf_stat_evsel_id
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf_stat_evsel_id was used for hard coded metrics. These have now
migrated to json metrics and so the id values are no longer necessary.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat.c | 31 -------------------------------
 tools/perf/util/stat.h | 12 ------------
 2 files changed, 43 deletions(-)

diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index d51d7457f12d..8d83d2f4a082 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -77,36 +77,6 @@ double rel_stddev_stats(double stddev, double avg)
 	return pct;
 }
 
-bool __perf_stat_evsel__is(struct evsel *evsel, enum perf_stat_evsel_id id)
-{
-	struct perf_stat_evsel *ps = evsel->stats;
-
-	return ps->id == id;
-}
-
-#define ID(id, name) [PERF_STAT_EVSEL_ID__##id] = #name
-static const char *id_str[PERF_STAT_EVSEL_ID__MAX] = {
-	ID(NONE,		x),
-};
-#undef ID
-
-static void perf_stat_evsel_id_init(struct evsel *evsel)
-{
-	struct perf_stat_evsel *ps = evsel->stats;
-	int i;
-
-	/* ps->id is 0 hence PERF_STAT_EVSEL_ID__NONE by default */
-
-	for (i = 0; i < PERF_STAT_EVSEL_ID__MAX; i++) {
-		if (!strcmp(evsel__name(evsel), id_str[i]) ||
-		    (strstr(evsel__name(evsel), id_str[i]) && evsel->pmu_name
-		     && strstr(evsel__name(evsel), evsel->pmu_name))) {
-			ps->id = i;
-			break;
-		}
-	}
-}
-
 static void evsel__reset_aggr_stats(struct evsel *evsel)
 {
 	struct perf_stat_evsel *ps = evsel->stats;
@@ -166,7 +136,6 @@ static int evsel__alloc_stat_priv(struct evsel *evsel, int nr_aggr)
 		return -ENOMEM;
 	}
 
-	perf_stat_evsel_id_init(evsel);
 	evsel__reset_stat_priv(evsel);
 	return 0;
 }
diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
index 9af4af3bc3f2..df6068a3f7bb 100644
--- a/tools/perf/util/stat.h
+++ b/tools/perf/util/stat.h
@@ -19,11 +19,6 @@ struct stats {
 	u64 max, min;
 };
 
-enum perf_stat_evsel_id {
-	PERF_STAT_EVSEL_ID__NONE = 0,
-	PERF_STAT_EVSEL_ID__MAX,
-};
-
 /* hold aggregated event info */
 struct perf_stat_aggr {
 	/* aggregated values */
@@ -40,8 +35,6 @@ struct perf_stat_aggr {
 struct perf_stat_evsel {
 	/* used for repeated runs */
 	struct stats		 res_stats;
-	/* evsel id for quick check */
-	enum perf_stat_evsel_id	 id;
 	/* number of allocated 'aggr' */
 	int			 nr_aggr;
 	/* aggregated event values */
@@ -187,11 +180,6 @@ static inline void update_rusage_stats(struct rusage_stats *ru_stats, struct rus
 struct evsel;
 struct evlist;
 
-bool __perf_stat_evsel__is(struct evsel *evsel, enum perf_stat_evsel_id id);
-
-#define perf_stat_evsel__is(evsel, id) \
-	__perf_stat_evsel__is(evsel, PERF_STAT_EVSEL_ID__ ## id)
-
 extern struct runtime_stat rt_stat;
 extern struct stats walltime_nsecs_stats;
 extern struct rusage_stats ru_stats;
-- 
2.39.2.637.g21b0678d19-goog

