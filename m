Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E932C7619A
	for <linux-perf-users@archiver.kernel.org>; Mon, 20 Mar 2023 21:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjCTVY6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 20 Mar 2023 17:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbjCTVYr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 20 Mar 2023 17:24:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC79239BB4
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Mar 2023 14:24:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w5-20020a253005000000b00aedd4305ff2so14392487ybw.13
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Mar 2023 14:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679347455;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Py8U8PqFwPIRVvHHDItGJJ+sTjfy4CxHiyg06BPRgeo=;
        b=NyJCJ9tnHk0O3+MXWps8O+w+74dT2N/H35s635JnpB+eKAu4PfsVf+9YZe/UgUidZo
         GmwwSaiyfMqeQsT/VjFcQH80sF2Jb0/+SrOUwr9lXuc8dcA2/tKkp81NIl9fKuOuTLKy
         96eX3gJxEslHw1/sSTg+yXMDXtdjq1AUbvKr4Gpd+6TcxSxpCYmuT1noXj2jY1bwDFqZ
         1N5n7hYx8XHIY/vWbtq3YzmEzVyTcsp3S6blSxAKukRl9TT9NmKMlrT7ogXRGgcWGOGC
         Ca0iFy3liB7qq87YOP573sINyPrUg8HcOrHLoo0gz+C5vvnmf4omOIvLo1sCLu+VPcUd
         Dw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679347455;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Py8U8PqFwPIRVvHHDItGJJ+sTjfy4CxHiyg06BPRgeo=;
        b=3I0LTAvyLBped2pOU1/aZzUG7RhVoiEHPbEM9CDfcQ5S4YYz+nw25RVIhPrn4mNBNM
         28vEMxJVoEzStyAu0pZtQ5yLrVzoyYDv4ywI/fp1tkvBBkEEGNmCl1Q7vFGKrQAw/2WH
         aID2xUgQJxYuUkBZU5bpx+jmIfyi4a0TELbKnO400imA4fhTdfbJXbARo6ZO2U+uuvrk
         zn9ditiseqIHVM6a84sU96u5zbuqc8xEEdRWsDAtnnSka0FGKQZMoOKvR4OzRWKnNcHU
         SDqkOnspXx2JU3Cr/LCfXBxWuHXQVhENl8W2HTq6FtbxNaMZW7Kzd2jgduQZAOTD8EzI
         T6+g==
X-Gm-Message-State: AAQBX9d2luRA9nFLc8tJ5khKva2lIDO8zKL7qMDz+RHH2H25i848D4Nv
        Bw1eMW1apvUK5mhKgbl9qfkDop7y1LVy
X-Google-Smtp-Source: AKy350Zh2/MbdZG8/LZzSAvOCJQEKf8aNlP302UyKhH88CujQvetA0j/fm+vFy4HgPJrvqGVtr9YvsEeG0ma
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a30f:d1e2:fcd8:aa4d])
 (user=irogers job=sendgmr) by 2002:a05:6902:703:b0:b6a:3632:12fd with SMTP id
 k3-20020a056902070300b00b6a363212fdmr20168ybt.2.1679347455142; Mon, 20 Mar
 2023 14:24:15 -0700 (PDT)
Date:   Mon, 20 Mar 2023 14:22:41 -0700
In-Reply-To: <20230320212248.1175731-1-irogers@google.com>
Message-Id: <20230320212248.1175731-11-irogers@google.com>
Mime-Version: 1.0
References: <20230320212248.1175731-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
Subject: [PATCH v5 10/17] perf test: Add extra diagnostics to maps test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Dump the resultant and comparison maps on failure.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/maps.c | 51 +++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 15 deletions(-)

diff --git a/tools/perf/tests/maps.c b/tools/perf/tests/maps.c
index fd0c464fcf95..1c7293476aca 100644
--- a/tools/perf/tests/maps.c
+++ b/tools/perf/tests/maps.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <inttypes.h>
 #include <linux/compiler.h>
 #include <linux/kernel.h>
 #include "tests.h"
@@ -17,22 +18,42 @@ static int check_maps(struct map_def *merged, unsigned int size, struct maps *ma
 {
 	struct map_rb_node *rb_node;
 	unsigned int i = 0;
-
-	maps__for_each_entry(maps, rb_node) {
-		struct map *map = rb_node->map;
-
-		if (i > 0)
-			TEST_ASSERT_VAL("less maps expected", (map && i < size) || (!map && i == size));
-
-		TEST_ASSERT_VAL("wrong map start",  map__start(map) == merged[i].start);
-		TEST_ASSERT_VAL("wrong map end",    map__end(map) == merged[i].end);
-		TEST_ASSERT_VAL("wrong map name",  !strcmp(map__dso(map)->name, merged[i].name));
-		TEST_ASSERT_VAL("wrong map refcnt", refcount_read(&map->refcnt) == 1);
-
-		i++;
+	bool failed = false;
+
+	if (maps__nr_maps(maps) != size) {
+		pr_debug("Expected %d maps, got %d", size, maps__nr_maps(maps));
+		failed = true;
+	} else {
+		maps__for_each_entry(maps, rb_node) {
+			struct map *map = rb_node->map;
+
+			if (map__start(map) != merged[i].start ||
+			    map__end(map) != merged[i].end ||
+			    strcmp(map__dso(map)->name, merged[i].name) ||
+			    refcount_read(&map->refcnt) != 1) {
+				failed = true;
+			}
+			i++;
+		}
 	}
-
-	return TEST_OK;
+	if (failed) {
+		pr_debug("Expected:\n");
+		for (i = 0; i < size; i++) {
+			pr_debug("\tstart: %" PRIu64 " end: %" PRIu64 " name: '%s' refcnt: 1\n",
+				merged[i].start, merged[i].end, merged[i].name);
+		}
+		pr_debug("Got:\n");
+		maps__for_each_entry(maps, rb_node) {
+			struct map *map = rb_node->map;
+
+			pr_debug("\tstart: %" PRIu64 " end: %" PRIu64 " name: '%s' refcnt: %d\n",
+				map__start(map),
+				map__end(map),
+				map__dso(map)->name,
+				refcount_read(&map->refcnt));
+		}
+	}
+	return failed ? TEST_FAIL : TEST_OK;
 }
 
 static int test__maps__merge_in(struct test_suite *t __maybe_unused, int subtest __maybe_unused)
-- 
2.40.0.rc1.284.g88254d51c5-goog

