Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198E3EB64D9
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Jul 2023 18:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjGFShM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Jul 2023 14:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjGFShM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Jul 2023 14:37:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 167EA1725
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Jul 2023 11:37:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-c5436388827so1041995276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Jul 2023 11:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688668630; x=1691260630;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GUs+YsIcHTrdEoY9pdDqoB0Eju/96GmQD5n4ikf5+Bs=;
        b=EZL2TqHu86+WyFUQAgF9/WWdmE7XUF8cYRSnAVU4tOGSEzRGltWbjf15Xg427IvkE2
         jAC9mqxGSChxSr5dQCdlD/93JvSt8C4sbwM1fQdoHWVmz6VzfQDEYTU5aSwo65LZ/xlY
         exnagXm+4y+Q1o1MWArpLpB+aMAHnoh68SZgkuK2FK9DF0v0RlOdOzE/V/DfIsJjlLks
         T9dmHf2MisuHtjHTW0/vjOh9vcT6qS0ZcMnYBg2B5LGAlmhWZbDOLker3cQJF37o+f/W
         Knuzx8StcX+QmOrbkJ+t1J9eF9v9WT0i6SGcZ+xbf/Duja1j90m1hoVlXuxVXknCM7YN
         uCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688668630; x=1691260630;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GUs+YsIcHTrdEoY9pdDqoB0Eju/96GmQD5n4ikf5+Bs=;
        b=lP4Iy04VL8WFWUjFJefafjRZL7vW6N1+FN/J8J5k8tYEg8PMQCRxbJtRf52CRVwNTz
         zcRCLUJYGajjBn3HEEo/ZyQSR/ajtUV9CrUFCeB53nJdnHdtt/ZIR+vC8uedAuY5SdAj
         xy0Lvfved6IVhWiHyKRE6PMVc12WwSnKEwW5xdHBOfWPi49PeX6ZJs/pI5aQuyvrJLri
         pXsB0ZOtY91upFWvzmUIraDFh71iZemfjr5mmoCNi26UyOhWNNBR9+MmIX/C/hZ0w5H5
         2RhnOPqfFhn+w0zD0ylF4a3ngTXx+TYCoCIw8n2RnjKClmhfcCXGPUd5PraqV+3+1i8o
         EUCA==
X-Gm-Message-State: ABy/qLbP6qz0ECu335J4t6Y+YTaJ5PsqAzvhmnzwkgUaqlpQElJHKxAO
        WW9ejis+FH1WTaWWpU8/4QsHw0G+hj+k
X-Google-Smtp-Source: APBJJlHv+Kvjg3nzOYF1oXAM8IzdP+YirUtiQnKVI2XCbAunSdtcNkZp0NgbfZhzzXqR9C8AY9XfY57yimg7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a5e8:77df:2300:8f74])
 (user=irogers job=sendgmr) by 2002:a25:6009:0:b0:c4d:1bc3:62c3 with SMTP id
 u9-20020a256009000000b00c4d1bc362c3mr15128ybb.4.1688668630212; Thu, 06 Jul
 2023 11:37:10 -0700 (PDT)
Date:   Thu,  6 Jul 2023 11:37:04 -0700
Message-Id: <20230706183705.601412-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Subject: [PATCH v1 1/2] perf pmus: Create placholder regardless of scanning core_only
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
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If scanning all PMUs the placeholder is still necessary if no core PMU
is found. This situation occurs in perf test's parse-events test,
when uncore events appear before core.

Fixes: 628eaa4e877a ("perf pmus: Add placeholder core PMU")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmus.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 3cd9de42139e..c58ba9fb6a36 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -152,16 +152,14 @@ static void pmu_read_sysfs(bool core_only)
 	}
 
 	closedir(dir);
-	if (core_only) {
-		if (!list_empty(&core_pmus))
-			read_sysfs_core_pmus = true;
-		else {
-			if (perf_pmu__create_placeholder_core_pmu(&core_pmus))
-				read_sysfs_core_pmus = true;
-		}
-	} else {
+	if (list_empty(&core_pmus)) {
+		if (!perf_pmu__create_placeholder_core_pmu(&core_pmus))
+			pr_err("Failure to set up any core PMUs\n");
+	}
+	if (!list_empty(&core_pmus)) {
 		read_sysfs_core_pmus = true;
-		read_sysfs_all_pmus = true;
+		if (!core_only)
+			read_sysfs_all_pmus = true;
 	}
 }
 
-- 
2.41.0.390.g38632f3daf-goog

