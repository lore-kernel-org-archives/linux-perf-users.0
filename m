Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D527EE49AD
	for <linux-perf-users@archiver.kernel.org>; Fri, 25 Aug 2023 02:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240628AbjHYCkr (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 24 Aug 2023 22:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241793AbjHYCkd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 24 Aug 2023 22:40:33 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EE51BF1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 19:40:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7496b91389so3374249276.1
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Aug 2023 19:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692931230; x=1693536030;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gleOx1R6bSswKzh9EuhLGrWijl71cST/VqhPvXlvs9U=;
        b=Cqu+Mpf9iSpDeRLvOSI3IVWLQssJ9tYBK0e1ZWdNFAycIwrIj1MxpQ1quvIleMZJB6
         Drb5sCcEu+fxJtnG5dfoegKcS4mWhHZ523Dohm1QrgK8uHjNxutRRM2W/taS217gq+oI
         kHkSwnzlHIvea+nMmyhch28gwXtZtS4Q+i0/r1FVJ8rgPQ3Zgmo3DJUDTHva04iSuZ7j
         Pwog+gL+Ygwt5ML1nXOfFqaQvFCsUOw036pa3OrChBdWXOmot7F0ZhRNIpy1NkakWboa
         IV/zDZC3ynvtqUUfHShJiG/JbJzUmp13jVoZAVuTdnxcp6qj4ryVFvEGNKWJatT75FYw
         4IyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692931230; x=1693536030;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gleOx1R6bSswKzh9EuhLGrWijl71cST/VqhPvXlvs9U=;
        b=B03uHHxd4YUs7VhPs7GSywtnR5hu2g3Ig0SuTxD2mmwzv/klGjmwKx0HJTS3NGEavX
         uM9V3tlBlSTVxp37wXWZ9zJTrK1j/aRax+rrxG1RjH1otlFcuwsIv5AG/KuFuBwKXlyb
         uhBWnkBpxTcW5CZcn+7YlOyXUtKPTwSnNPcVCjHziRXcz6S0c5k422YEWv1o/6hu6J8L
         vTOYtSWvKAnxxdQ4RFWyNVomjiShU5xBkEZWmwPDCdAFMrCjDY6FLvmwqpvfwoq43w9A
         QoncO42mFsy8anM93K91tUzlqYDYql5MfR6Xc+b2gZCOkOQdST4vdlUaCWtz1EmjCYwT
         Jykw==
X-Gm-Message-State: AOJu0YwiEgRqwJlP1r3U01OqwKzFGSzb5kk21l40v2GTj3ncfprfoMgj
        Fj5v2OTijRsWcskvtWEmfkeVEmFPgw1c
X-Google-Smtp-Source: AGHT+IFi5wnjwMO3TOfHdkD/PK6fZ23/bjTAUd5coQ8Pvt3nE13DfLfuhsCiqnLwncG7b5sT0DyY9knVVA03
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:449e:d47b:bc6b:cb6b])
 (user=irogers job=sendgmr) by 2002:a05:6902:691:b0:bd5:dc2d:9d7f with SMTP id
 i17-20020a056902069100b00bd5dc2d9d7fmr410342ybt.4.1692931229945; Thu, 24 Aug
 2023 19:40:29 -0700 (PDT)
Date:   Thu, 24 Aug 2023 19:39:57 -0700
In-Reply-To: <20230825024002.801955-1-irogers@google.com>
Message-Id: <20230825024002.801955-2-irogers@google.com>
Mime-Version: 1.0
References: <20230825024002.801955-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
Subject: [PATCH v2 1/6] perf header: Fix missing PMU caps
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wei Li <liwei391@huawei.com>
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
2.42.0.rc2.253.gd59a3bf2b4-goog

