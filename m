Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B20C77B7A
	for <linux-perf-users@archiver.kernel.org>; Tue, 23 May 2023 04:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbjEWEo6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 23 May 2023 00:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232190AbjEWEo4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 May 2023 00:44:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864C410D
        for <linux-perf-users@vger.kernel.org>; Mon, 22 May 2023 21:44:55 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-564feceb97dso34497757b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 22 May 2023 21:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684817095; x=1687409095;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PNQjK0C7CzDtxLT/edfztnWdbqpt8ERQcxl1uZNZGK0=;
        b=e8QzE8UltmZwkjtKTRxMmtGAvMrcQxcEyiCuvqfUNbe6KywtyspLYMkvdilvoJt/vc
         goiF7PXLS5lCBqZUi2AhGIRpjmE5PsL8FE1nvqlmQAplEpn07k96iD4rzIlx/VcyTSfv
         GyU3hlV2U6CiclvAm6Qn2pU4HE6JPzOMjr3y3URHq8WKDKKzScHBmWw+GDaXkVkoarkQ
         I7vpa1VdXKJMSH7+V4o8MlrJ0xhqAY+N5HhReH1S8S1PzFewWw5BzHCUSW1rmGnKcZVP
         kKI34GrVvyv70+6oNIXdwvNXSbf4zM5ofqOHaRixHWj2mvkxENsZaOhTIIDwQs/Y7gf+
         cG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684817095; x=1687409095;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PNQjK0C7CzDtxLT/edfztnWdbqpt8ERQcxl1uZNZGK0=;
        b=K7XpHyI49Zv/7+3iKOoVYmOH6ijneMDhiWGEAOGFndML/IaiVk3bVUtDpmegPExdJy
         ajtbGFNs8fQw1ne1fImBW6W6+By1wLU93FA+QTtwVAi3O5IipTSo3nyzr2WynxDho+5O
         GKBlgNZYgDg43eXBvppc5TSdNN+iYSdzVDfxNTdTxBtVwtW2nWQA8g8KXp5s8XA3wwQY
         nNOdpTTOMiHre5Qgbk+CWGl8ToOPAMWW5afDPAy5eiqP+4eiMcib+dp0odS2vm2S945H
         xCIBqbUGVt6Q8OYMRJsmZm0IeasX8V2kAReOV5WMlbSnDKpDcRAJICDuBhjVGctkx5wa
         opIQ==
X-Gm-Message-State: AC+VfDxBqG5wfeUQARf3ws+vtWu7xBpGP3MAuOmceYkePulyBEZF/HFb
        UND5fdNM3qtnsGZCy9C8L49tFIP041UY
X-Google-Smtp-Source: ACHHUZ4kEhFS/JDgjsSFWpZGGfM74aZ55TFqJ1fMvTrE0JSsyc6lz0SHbiPu999cC/6CywnbsvuBjhKX1x79
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:33a6:6e42:aa97:9ab4])
 (user=irogers job=sendgmr) by 2002:a81:4503:0:b0:561:94a8:29c4 with SMTP id
 s3-20020a814503000000b0056194a829c4mr7322817ywa.2.1684817094805; Mon, 22 May
 2023 21:44:54 -0700 (PDT)
Date:   Mon, 22 May 2023 21:44:46 -0700
In-Reply-To: <20230523044446.1020769-1-irogers@google.com>
Message-Id: <20230523044446.1020769-2-irogers@google.com>
Mime-Version: 1.0
References: <20230523044446.1020769-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v1 2/2] perf evsel: for_each_group fixes
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
index 820771a649b2..6a64543c7612 100644
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
+	(_evsel) && (&(_evsel)->core.node != (_head)) &&				\
+	(_evsel)->core.leader == (&_leader->core);					\
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
+	(_evsel) && (&(_evsel)->core.node != (_head)) &&				\
+	(_evsel)->core.leader == (&_leader->core);					\
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

