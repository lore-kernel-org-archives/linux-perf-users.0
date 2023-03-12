Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CD1C61DA4
	for <linux-perf-users@archiver.kernel.org>; Sun, 12 Mar 2023 02:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjCLCQF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 11 Mar 2023 21:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjCLCQE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 11 Mar 2023 21:16:04 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AD03CE05
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Mar 2023 18:16:03 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536c6ce8d74so95474807b3.9
        for <linux-perf-users@vger.kernel.org>; Sat, 11 Mar 2023 18:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678587362;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LkP3cjlyFBuY4lwBhuPasBEAZ8EXgvKaf+XTugs0ORk=;
        b=dl6rB5hFHv9SCNUubl2rtwaN/dDMjOatwZ3MmZLo5IRBFOs7mnSBoXwIjFci/ORyq7
         5RQDqJSUEQtUyt43HW3aGm/afwWgmb9tIv1ebmxPD92DsCu+t1Lru/Mc9sQ7wVk6Mulk
         wW/FmCvesK1PQRyVj6vqPrK3lUB3IvkDYwYN9iZthvBapK8LsBFRQ3YM/UJflOZGpTZj
         8kT0qzU063vz5qPgqwQvW25/25DUN6fImshKtoY1/uXNE9slZ/+IOO42iNSaBzxzcyYL
         xV46aDRjr2Hi4tp6bOxFo7QUpVxrATRB32IpvrhXbR+Ic+JzsSKRtbIVp+Kk3DCYptdN
         wwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678587362;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LkP3cjlyFBuY4lwBhuPasBEAZ8EXgvKaf+XTugs0ORk=;
        b=aXxiOqpkmDnzTYagXZSX9fzsBi3HgP6X1X6J8+0ys5fIEkgYayaylQ5BAmYz6UJK1d
         i/iTzk5Bee/AVsnhPYVIPVPmooRUQiJwXz+jCh2Yvgu8yiN7BV7oFOM0OdZgJIJCfivA
         72aWse+A0yyFb8cS7Xxg9DpNqNh8txwpydpBSEr1lt0spyQydwpR1XxUaeuvE5eEPbiB
         PCEVb0Cowx4/1YhDRhPV97F1dYcd8ca+Yb+d8zoJf/6MMsZSIrZMWoV2AeRQV6IU9Abb
         FRpJeYsC2DD8cMjZgx4dP7ggngTizbD4XE2LlAYECjke7lBPRJ38uPH3yPd/h3XlbTRq
         obdA==
X-Gm-Message-State: AO0yUKX4HLNsf1dJZnxpnd4HwuB4+sAmyTFMjyOQd7ZO35mRXTgKHO0i
        Wmlrlbi7MW1A6Eg4W3+tRFDGPRdNyX5H
X-Google-Smtp-Source: AK7set/kJBuEV+mbqnhAi0kuxu/g23f1XpN6oLJWkygemzlOuHhNBjhSuYPUA/SjPgoLxUZazwSQajtgf15R
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b42b:2e07:afb:877e])
 (user=irogers job=sendgmr) by 2002:a81:b286:0:b0:533:9185:fc2c with SMTP id
 q128-20020a81b286000000b005339185fc2cmr20162639ywh.7.1678587362660; Sat, 11
 Mar 2023 18:16:02 -0800 (PST)
Date:   Sat, 11 Mar 2023 18:15:33 -0800
In-Reply-To: <20230312021543.3060328-1-irogers@google.com>
Message-Id: <20230312021543.3060328-2-irogers@google.com>
Mime-Version: 1.0
References: <20230312021543.3060328-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 01/11] libperf evlist: Avoid a use of evsel idx
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
2.40.0.rc1.284.g88254d51c5-goog

