Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E92C7EE23
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 May 2023 18:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238207AbjEWSiU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 May 2023 14:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238193AbjEWSiM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 May 2023 14:38:12 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AB4E64
        for <linux-perf-users@vger.kernel.org>; Tue, 23 May 2023 11:37:48 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1afa6afcef4so16343075ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 May 2023 11:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684867065; x=1687459065;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kT8nh0a8qE7iApgG/WqGXKFWbJPIePlSK9niqbotYPE=;
        b=aTpW5smB5TQGvTi6WvjyPhcuRFe3gsUBAmXHCfFrOJukCc2WCwDjdSj06tUVnj0xPp
         +AwJ9LJ6GAwJJtOmqtxZ6sZetREqspqTjeOhQTX3NbsoLYT4TnVL0yUY70Fwi1Gq2AjA
         xqom3x6gBKPyJ7oRJ4reQ0X6Iq7zMqWUp6Gm3NZW3jiHHCvABt66ZonA0cy/zxqJ2hf8
         Vnm4Cbq0UcBoAiTCmmKEDAnV8553Z///RH6nG56mWcL3f9Lg7eJW4X/QWbaoqOqVreO1
         oHOg/GAbsLkGpRtD9F6T3GC61Y9XiU3OXDIWHQBQzEwvKn098cd94aeAYwXF3gZXiHhL
         +AKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684867065; x=1687459065;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kT8nh0a8qE7iApgG/WqGXKFWbJPIePlSK9niqbotYPE=;
        b=A5VAPcKJEhVCKBQO1omTL53kdGbe5vZu/63Dy8+BB6m2S02Ql6FFjvWLUzLcE6wvqI
         Ofkku1xcnPkKWhG89V9VB3Ap20bt607YC+XxSE8fDQJTdc32UcrOnmPfn9enwmXmve1E
         mQYdUC9YH7JJHZayHorItMWj7ivnu/pQw5X787+ypvFoFLY0H299UQ0WPS7Zbw8r8kbF
         CEucgWXUYWbDY/3r/ECDg76BwWWWcuRixU9nVSulGGJpFqmAe8ZPYz9qNj0uXEtJvF/s
         f0I93tx3/b20n0BitQ/2NSrF5V2uv8FyF5Pku5TKO48KeyEECcUHtCeMVIglrSZ9qdy+
         ry8Q==
X-Gm-Message-State: AC+VfDy7eNmIJRKK48vIplr82+m/hAKqZyV7kvlQJnBSz51yILn13bwN
        OvVKyA2ggVdf2x/ezSfvBHzLsbB5cs9W
X-Google-Smtp-Source: ACHHUZ4PQFKtv729+iCwOEUgki+Ep3H2gS/hh1ENMY3MysqOnf+Gwmo96GodgAsnd6U7LzPdmk8gBPJmpRcJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:235b:5195:e7b8:a5c2])
 (user=irogers job=sendgmr) by 2002:a17:902:eb11:b0:1a1:b318:2776 with SMTP id
 l17-20020a170902eb1100b001a1b3182776mr3599522plb.0.1684867065225; Tue, 23 May
 2023 11:37:45 -0700 (PDT)
Date:   Tue, 23 May 2023 11:36:20 -0700
In-Reply-To: <20230523183620.1147607-1-irogers@google.com>
Message-Id: <20230523183620.1147607-3-irogers@google.com>
Mime-Version: 1.0
References: <20230523183620.1147607-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v2 2/2] perf evsel: for_each_group fixes
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
        Sandipan Das <sandipan.das@amd.com>,
        James Clark <james.clark@arm.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Changbin Du <changbin.du@huawei.com>,
        Rob Herring <robh@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Address/memory sanitizer was reporting issues in evsel__group_pmu_name
because the for_each_group_evsel loop didn't terminate when the head
was reached, the head would then be cast and accessed as an evsel
leading to invalid memory accesses. Fix for_each_group_member and
for_each_group_evsel to terminate at the list head. Note,
evsel__group_pmu_name no longer iterates the group, but the problem is
present regardless.

Fixes: 717e263fc354 ("perf report: Show group description when event group is enabled")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.h         | 24 ++++++++++++++++--------
 tools/perf/util/evsel_fprintf.c |  1 +
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 820771a649b2..b3ed360194a1 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -462,16 +462,24 @@ static inline int evsel__group_idx(struct evsel *evsel)
 }
 
 /* Iterates group WITHOUT the leader. */
-#define for_each_group_member(_evsel, _leader) 					\
-for ((_evsel) = list_entry((_leader)->core.node.next, struct evsel, core.node); \
-     (_evsel) && (_evsel)->core.leader == (&_leader->core);					\
-     (_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
+#define for_each_group_member_head(_evsel, _leader, _head)				\
+for ((_evsel) = list_entry((_leader)->core.node.next, struct evsel, core.node);		\
+	(_evsel) && &(_evsel)->core.node != (_head) &&					\
+	(_evsel)->core.leader == &(_leader)->core;					\
+	(_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
+
+#define for_each_group_member(_evsel, _leader)				\
+	for_each_group_member_head(_evsel, _leader, &(_leader)->evlist->core.entries)
 
 /* Iterates group WITH the leader. */
-#define for_each_group_evsel(_evsel, _leader) 					\
-for ((_evsel) = _leader; 							\
-     (_evsel) && (_evsel)->core.leader == (&_leader->core);					\
-     (_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
+#define for_each_group_evsel_head(_evsel, _leader, _head)				\
+for ((_evsel) = _leader;								\
+	(_evsel) && &(_evsel)->core.node != (_head) &&					\
+	(_evsel)->core.leader == &(_leader)->core;					\
+	(_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
+
+#define for_each_group_evsel(_evsel, _leader)				\
+	for_each_group_evsel_head(_evsel, _leader, &(_leader)->evlist->core.entries)
 
 static inline bool evsel__has_branch_callstack(const struct evsel *evsel)
 {
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index cc80ec554c0a..036a2171dc1c 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -2,6 +2,7 @@
 #include <inttypes.h>
 #include <stdio.h>
 #include <stdbool.h>
+#include "util/evlist.h"
 #include "evsel.h"
 #include "util/evsel_fprintf.h"
 #include "util/event.h"
-- 
2.40.1.698.g37aff9b760-goog

