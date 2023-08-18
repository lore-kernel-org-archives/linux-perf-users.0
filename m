Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A53EE4980
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Aug 2023 17:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378927AbjHRRUD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 18 Aug 2023 13:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378923AbjHRRT6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Aug 2023 13:19:58 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C477C4210
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Aug 2023 10:19:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-58daaa2ba65so14717747b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Aug 2023 10:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692379196; x=1692983996;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C88yoZ/6ZItf49caBe3kpaia+5Rtg28dk/8WphFe0UE=;
        b=kzOAAW+bH/P/jXgYgurMNurhrMHYNJ6xVcZLGuxm2srgiJHcPBc94SuTwmnTPHbh6h
         CghnDjnA1oOcvO6fLtD5Igg6SZds2jEy2yUnkeOlFHosAp3JofvGYFMcSlPfH1V2Ojf/
         Xu+HgLwzaSdnJ0EAkYgCWlcaJSAQz3j/CbaSZipA2krxRb0/8hJXOVBHFKg3ggIjbj4K
         5XIbtKs7GFRWz3ODRHfVx45CCHV81DeJAvuxvSndbuCYQuq+YyvvPEeCbhrCyrIAPGTY
         3mvIWNsBc5DFR+kymlutZjOWH9wvRxYr7zXjYaLeKyO4QWzJ6Vn36t7hn5VUfvRFxUX1
         04YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692379196; x=1692983996;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C88yoZ/6ZItf49caBe3kpaia+5Rtg28dk/8WphFe0UE=;
        b=kio4xRLtp/ADtWwEtNGUw3+rcFQjhId3n/sMBHlVQbEbV2cvmJyKWb/DDueEAnXZcY
         84EbgB/0BqNn8D1BdCTk2sTHWO7TcdciZqOs0DvtEM+NuZYf8faPN3Lc937DTQY5G5Oh
         hXsenSGEY/5WRcDClJQo38uTUPJGzWKatOX00qj9lUCw+t8bNjpnazQLA96p/NbrINyU
         R4Mg4DTW4vz6hKQ3j3UsXvEQuhFLJfJGDJTJ8gL0A3CMdffy96HR07ufce+0DcDa1cXB
         7H6yJNXTGtnIG35kIVM9OeSaozdW6svBK5dpcoJXKDqcHZayR2Jhk1bXjCn4JN1yK3uE
         IDGA==
X-Gm-Message-State: AOJu0YxJk+uOBhPgxyncq2SekwhByEEb2j1SjmJOQggpEOxJ0IGEvRkD
        0arbzgm/BDfLp+VvlJ84CUAu8fT7JpOx
X-Google-Smtp-Source: AGHT+IH/cwGQQXBuGtb+eTWAc/SHyLXhNoaVa6UZHzDS9Y1Y4xq/wGSp5SXrG2C0pMPd0s4kQhH/6jLdIERj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:5c87:ff9a:b64c:ee])
 (user=irogers job=sendgmr) by 2002:a25:393:0:b0:d4a:7656:a680 with SMTP id
 141-20020a250393000000b00d4a7656a680mr42236ybd.2.1692379196087; Fri, 18 Aug
 2023 10:19:56 -0700 (PDT)
Date:   Fri, 18 Aug 2023 10:19:52 -0700
Message-Id: <20230818171952.3719251-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1] perf header: Fix missing PMU caps
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        liwei <liwei391@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

PMU caps are written as HEADER_PMU_CAPS or for the special case of the
PMU "cpu" as HEADER_CPU_PMU_CAPS. As the PMU "cpu" is special, and not
any "core" PMU, the logic had become broken and core PMUs not called
"cpu" were not having their caps written. This affects ARM and s390
non-hybrid PMUs.

Simplify the PMU caps writing logic to scan one fewer time and to be
more explicit in its behavior.

Reported-by: Wei Li <liwei391@huawei.com>
Fixes: 178ddf3bad98 ("perf header: Avoid hybrid PMU list in write_pmu_caps")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 52fbf526fe74..13c71d28e0eb 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1605,8 +1605,15 @@ static int write_pmu_caps(struct feat_fd *ff,
 	int ret;
 
 	while ((pmu = perf_pmus__scan(pmu))) {
-		if (!pmu->name || !strcmp(pmu->name, "cpu") ||
-		    perf_pmu__caps_parse(pmu) <= 0)
+		if (!strcmp(pmu->name, "cpu")) {
+			/*
+			 * The "cpu" PMU is special and covered by
+			 * HEADER_CPU_PMU_CAPS. Note, core PMUs are
+			 * counted/written here for ARM, s390 and Intel hybrid.
+			 */
+			continue;
+		}
+		if (perf_pmu__caps_parse(pmu) <= 0)
 			continue;
 		nr_pmu++;
 	}
@@ -1619,23 +1626,17 @@ static int write_pmu_caps(struct feat_fd *ff,
 		return 0;
 
 	/*
-	 * Write hybrid pmu caps first to maintain compatibility with
-	 * older perf tool.
+	 * Note older perf tools assume core PMUs come first, this is a property
+	 * of perf_pmus__scan.
 	 */
-	if (perf_pmus__num_core_pmus() > 1) {
-		pmu = NULL;
-		while ((pmu = perf_pmus__scan_core(pmu))) {
-			ret = __write_pmu_caps(ff, pmu, true);
-			if (ret < 0)
-				return ret;
-		}
-	}
-
 	pmu = NULL;
 	while ((pmu = perf_pmus__scan(pmu))) {
-		if (pmu->is_core || !pmu->nr_caps)
+		if (!strcmp(pmu->name, "cpu")) {
+			/* Skip as above. */
+			continue;
+		}
+		if (perf_pmu__caps_parse(pmu) <= 0)
 			continue;
-
 		ret = __write_pmu_caps(ff, pmu, true);
 		if (ret < 0)
 			return ret;
-- 
2.42.0.rc1.204.g551eb34607-goog

