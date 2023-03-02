Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F7E0C678D4
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Mar 2023 22:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjCBWbk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 2 Mar 2023 17:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjCBWbj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 2 Mar 2023 17:31:39 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4CB38B75
        for <linux-perf-users@vger.kernel.org>; Thu,  2 Mar 2023 14:31:29 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536a4eba107so4565867b3.19
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Mar 2023 14:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677796288;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ywTh5n03SqFTSvl6jepwvheFrqPaSHAy7v4KxsLV2lY=;
        b=KZeOwZXYee37dzbYMf4iMggugsWFiMzZDqVdLfBO/u08eS2aQbQUISTFjKIGawZzT7
         can1wKbIwWHQXX1L7RxZl8tlz6WFnyxhTCDQZ5a18QjqwD7sGrYjs723NYUNvZKmL48I
         wGY8EBOwd6yjvbiWGT+27y5JnEmcyc+mArskik0unNab4CzopUYDAlxoj7bWCbkeLwJn
         joLOp7Osm5CUDXpgatNs49zJeQtzc5NL24Fn2Kf8WurUCjHvrV8TvytJo272SbVTT9pD
         EKdSrXXzglN4nKhoxM7iOwRsFszCBOKRVbdGbGKf0qhr/dQleY6uDY0QReAX+BZHH6YH
         whXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677796288;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ywTh5n03SqFTSvl6jepwvheFrqPaSHAy7v4KxsLV2lY=;
        b=Oap9N4FgX99o8X2tMwDbZNXw1yj7tbtNOzauUKh9gtjDDdn6uyDUOdP4/qjcQkol5f
         1RqkbrQn5Mt186kI+HKPYcGamY5Sm1vDG6qUoI9EQ737oWg3D8wXVlpUmc6P7l4kjZN/
         X0dRZIfni1sOXqG599diPL5UBM3TM2cr+0SoUyK/nb46moVj+KEuB3XeZbKlVeY7HOx2
         atypK5AC0XCCXseUEZSzmJ13Tc4Zs3KJw+jWuZCIyFIWI7IWaJte4JyzJUm2U8N8afUW
         90/XpvY5w75BcRAiGYRFae2/sDyLQd5D9VClyx9kcsYGqzTS9YyaN/D8UjujqNcQEk8E
         4W/A==
X-Gm-Message-State: AO0yUKVS0drZEiMEWZ/6Fr5VZDE5UBES15fK8bVHP4cEmeEyuzo/Il6X
        nOUnq3Z8h163CYcuXUnUWMdtzrbXG9Yl
X-Google-Smtp-Source: AK7set+rCgX2CZtYsyNOpnPcTnPyatlq0OsTFID9T30qC/qUpHHpo3m0ptqs2gLK4HuXN1OA8yF0VE8ih5Ah
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:5f50:6ef4:b4d0:568e])
 (user=irogers job=sendgmr) by 2002:a81:8414:0:b0:52f:1c60:923 with SMTP id
 u20-20020a818414000000b0052f1c600923mr25ywf.149.1677792356226; Thu, 02 Mar
 2023 13:25:56 -0800 (PST)
Date:   Thu,  2 Mar 2023 13:25:22 -0800
In-Reply-To: <20230302212531.1043318-1-irogers@google.com>
Message-Id: <20230302212531.1043318-2-irogers@google.com>
Mime-Version: 1.0
References: <20230302212531.1043318-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc0.216.gc4246ad0f0-goog
Subject: [PATCH v2 01/10] libperf evlist: Avoid a use of evsel idx
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
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

