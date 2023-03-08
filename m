Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D0FC64EC4
	for <linux-perf-users@archiver.kernel.org>; Wed,  8 Mar 2023 22:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjCHW7f (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Mar 2023 17:59:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjCHW7c (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Mar 2023 17:59:32 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E584CD13DC
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Mar 2023 14:59:31 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536c039f859so303497b3.21
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Mar 2023 14:59:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678316371;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ywTh5n03SqFTSvl6jepwvheFrqPaSHAy7v4KxsLV2lY=;
        b=szI/v2kSJ1UzVtvNqdIiPV2xdcpUV7T27NeWsV2CESv02Nv1QVxVRzRb1BiSs1xFxz
         KRteNhiXld4XZkmdW+A0ojwllhTIWO8yc4PUenXBk+QEkqbDUMchTAb51E6ZATiuekAW
         iW8wSIMLkJG+K2ZAhk2ap8XAg50gkJ22oLDrW3EpWwdf4HCvQdaOgF8bE3ScP7Cxar8J
         CjZyAKRXQa65gEb9FYBc8PJX1NbQGDNVLYcjwtaOibGEr84RLAUO+ESsEMKxF1s1f1IV
         p9/oujXwZOtsZLhdakEZ+QUcZ4K3xeza1sWd1j+Jfc7ruxLu13N+ZfamtXvQMCBreKpx
         1pYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678316371;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywTh5n03SqFTSvl6jepwvheFrqPaSHAy7v4KxsLV2lY=;
        b=D68Bb9dDJFyd8t/IJ4rcSsZoCErFTUKrJndtIzHG+gkBkn8XkhXq69JHrSbCJb1uBB
         qcY88Nr45NYqncJyAnM18CCem1CXrquYeMSB5+RxtDsvDvCoEzcIavYvO7MfLWtIMCHm
         v0ALMmi7tXhm7H58rUEotzkGd8IZkOienzcDp3AgYgyVpaVftP5siXnzInmYO1pfn8Gd
         dv7e1RvRzKjf/EReeOj7+/e11i+gAKUAtHdRkJP/wpJQ12gTl7IRTjbZ1JmhkG9NB0m1
         8HZ68kJgHVRJ/yFjnHmA3NTATg+xmAYG+3ZYEDvKXkuqojVYeDeXkQy8u98sjSRfx5Ho
         4HNA==
X-Gm-Message-State: AO0yUKXtRqGFQ2eP9VZLErOlxKEaeTaowf/dKh4X99JWbmx0GCMa8hU/
        WG1MzXocjiRm/L9oHHmxf1r0ZWSMOwvh
X-Google-Smtp-Source: AK7set/oaA1PDJqRwnr+9ddJ9Fn3gvAQRJiV5UvQklYIxlrEO+ozSV0fVXlHnRhiSKPq6ZJbqww4VbtQuk6g
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5292:ba14:c261:246a])
 (user=irogers job=sendgmr) by 2002:a05:6902:185:b0:acd:7374:f15b with SMTP id
 t5-20020a056902018500b00acd7374f15bmr12051059ybh.13.1678316371198; Wed, 08
 Mar 2023 14:59:31 -0800 (PST)
Date:   Wed,  8 Mar 2023 14:59:02 -0800
In-Reply-To: <20230308225912.1960990-1-irogers@google.com>
Message-Id: <20230308225912.1960990-2-irogers@google.com>
Mime-Version: 1.0
References: <20230308225912.1960990-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v4 01/11] libperf evlist: Avoid a use of evsel idx
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Setting the leader iterates the list, so rather than use idx (which
may be changed through list reordering) just count the elements and
set afterwards.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evlist.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index 61b637f29b82..2d6121e89ccb 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -687,15 +687,14 @@ perf_evlist__next_mmap(struct perf_evlist *evlist, struct perf_mmap *map,
 
 void __perf_evlist__set_leader(struct list_head *list, struct perf_evsel *leader)
 {
-	struct perf_evsel *first, *last, *evsel;
-
-	first = list_first_entry(list, struct perf_evsel, node);
-	last = list_last_entry(list, struct perf_evsel, node);
-
-	leader->nr_members = last->idx - first->idx + 1;
+	struct perf_evsel *evsel;
+	int n = 0;
 
-	__perf_evlist__for_each_entry(list, evsel)
+	__perf_evlist__for_each_entry(list, evsel) {
 		evsel->leader = leader;
+		n++;
+	}
+	leader->nr_members = n;
 }
 
 void perf_evlist__set_leader(struct perf_evlist *evlist)
-- 
2.40.0.rc0.216.gc4246ad0f0-goog

