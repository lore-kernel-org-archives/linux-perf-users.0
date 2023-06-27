Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8C5EB64D9
	for <linux-perf-users@archiver.kernel.org>; Tue, 27 Jun 2023 04:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjF0Efw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 27 Jun 2023 00:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjF0Efl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 27 Jun 2023 00:35:41 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E38D1734
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 21:35:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57003dac4a8so106053377b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jun 2023 21:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687840531; x=1690432531;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hfYhuJ0XDyvK4n4WNbDnoJ3i1epMtBqut75yAMaV+gY=;
        b=R/IL8Qtvta8I6gMtIPvKZfXLn9VTYmA587Tv+dTHUirDNSkyXVLPZDiit2FitWHr99
         lSTKLBRUrUspIpM71s788To4ybkNzZcGq9YzFT9kE1p7MbjjgHr9LJ82k7aqtE3GoLIq
         R46s5zrBO6zVKG+m1aJEdeDABQ9+C+Be9j3PAJCNfLhzZ70P9nZBBgtZCzLSOcQ9ELEU
         cTvehHTyprk4jPGIO/4xLBH86Fo7sqz64NRvm76MTdKX9y3ASFdsxxmyae+SpEg8JnrB
         VN4wAEtCrlRcMTDG/CNpA+q5UBt3cNAMBDDt/fbhIXmuBgKyeblyG5LJw+IlY8hPzjrR
         iFnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687840531; x=1690432531;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hfYhuJ0XDyvK4n4WNbDnoJ3i1epMtBqut75yAMaV+gY=;
        b=awNT7T4+MCy1hQ7nu4a1vertLJcqu8JrDAkaFbILasyAWt4jXIUAQthCWRidfPMlxi
         eekE1cJjucY5KEnQ0FyAWn1GgAl0WOHRnKK16kRlEiBU3Tnq747ZXhShjyDK2xyy8+3I
         foz94HNRUkAFZyCmCP2L1mkR7dqD2VaUz7SYvnHfKpymQzp/iQ2fMruSrneANmK7T3qZ
         JEov7pH/3EfOT6jI4Dafj04fGpROAKWpZDmTM9T+mfL/lv3DQq5obsV6oIF0vrxH7u9E
         dgSSlz+rIw+k1CMWfdrklMB1UCL07R3d87CQINqFCAF3K3SWD1Z+uzxnCzSDAZ2dcV0n
         1swQ==
X-Gm-Message-State: AC+VfDzgDjIawFUURJnirlJoI56yHp8oqDCveRqRhxO/0QbOrIRZWjJB
        2s28hH88C1lOBuPkqivHjgXFSiGDhkXi
X-Google-Smtp-Source: ACHHUZ6Hjnmam6yC5miKWuIWrL/VYqDWBxDrW14sUhpNBhQvwwGI3NXEDUbrFE3QZqDy02Mt5nZYzLYamadv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:497e:a125:3cde:94f])
 (user=irogers job=sendgmr) by 2002:a81:a988:0:b0:568:ed75:8b2f with SMTP id
 g130-20020a81a988000000b00568ed758b2fmr14576278ywh.0.1687840531455; Mon, 26
 Jun 2023 21:35:31 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:34:51 -0700
In-Reply-To: <20230627043458.662048-1-irogers@google.com>
Message-Id: <20230627043458.662048-7-irogers@google.com>
Mime-Version: 1.0
References: <20230627043458.662048-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v1 06/13] perf parse-event: Add memory allocation test for
 name terms
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
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

If the name memory allocation fails then propagate to the parser.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 5 ++++-
 tools/perf/util/parse-events.y | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0aa4308edb6c..f31f233e395f 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1965,8 +1965,11 @@ int parse_events_name(struct list_head *list, const char *name)
 	struct evsel *evsel;
 
 	__evlist__for_each_entry(list, evsel) {
-		if (!evsel->name)
+		if (!evsel->name) {
 			evsel->name = strdup(name);
+			if (!evsel->name)
+				return -ENOMEM;
+		}
 	}
 
 	return 0;
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index b09a5fa92144..3ee351768433 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -263,7 +263,7 @@ PE_EVENT_NAME event_def
 	free($1);
 	if (err) {
 		free_list_evsel($2);
-		YYABORT;
+		YYNOMEM;
 	}
 	$$ = $2;
 }
-- 
2.41.0.162.gfafddb0af9-goog

