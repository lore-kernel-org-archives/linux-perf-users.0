Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70133C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 13 May 2022 04:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376949AbiEMEFk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 13 May 2022 00:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376929AbiEMEFh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 13 May 2022 00:05:37 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EA929B01E
        for <linux-perf-users@vger.kernel.org>; Thu, 12 May 2022 21:05:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f4e17a5809so62564927b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 12 May 2022 21:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MAjYUcMF8cvSpD3IrXmmGZ0bseIJMHTYZTi0/EOkzbY=;
        b=DNyinQnf/GUhB5FLBjS/bka3DAXeZ27SjcHtaiafd1Qa3TdKFMJt+APa+eIJ94K/9c
         M2Kmp0d2XIqVr7OgZAk1uQ7LRJ8yfxqj0a/801WoLD14owWZO85tRgRSn9Ce+1KF9FN7
         S0jsg8y8RBplqLugtk2HKhLIpuHn0vlX53V0xyh0S4u81HTT6TFRwsKbjYZlbnYxNT7B
         SwvMHY4CmmZ2hJuhE8VVNH3UTeaHaOBzCIVRCdZMO6Yv9LRvV1dkV74szp0o9qf5cEkC
         PqRsbQjbtbMjq0xx5n0nYy0jOm7irRg2CsfHLBcwEhaxoKqhiViCwJb0EFIWdIOdAGrs
         fO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MAjYUcMF8cvSpD3IrXmmGZ0bseIJMHTYZTi0/EOkzbY=;
        b=itowFkFFUzbrW0TXNPPuY0i5DIJCpKWybihM3+dyw9mEy0UzQpcfbXKxH/66ACCbWE
         z9JF4QV2MEAailu4h4K3mxJZc3QZbzGigX3wbt3uBPyLcVj5zj1nSx1Yqd8Wms+N6oy1
         KJvk5OvcZrjRqV4GrbxoVsuAPQpFZ7+POKIK5ODPKLxWknMZtSUF/Xarrf4S+/o7xigY
         VmAuHxCZuQnrMEheL7YhdAXwnXQkEgx3jjj2cqnC3M8aSCFSySyL6praCcmbrrIC60QK
         FxDvvZSkPSwU5VZJJUkunCFvCGjaJt/rx2ia2Ck3TmaCR+mwoJTj9ENXQrkBK0BEnDzC
         +QGA==
X-Gm-Message-State: AOAM5320gleTmGR1BLXYiqIASp3AhWwydKJreGriwK9E6AWUfp/2Mf8v
        X16GTKo22a000sAA9d6y0pJ0m/X6om6A
X-Google-Smtp-Source: ABdhPJx7EU8oJlo555wKZBuqFQ51tkxeRs8J6Bf5Kloe7Bej4z8wYTVAiSh8jJYEqJ11bCd2O1L2U7vU3hkT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:9b61:c91f:ca29:ae54])
 (user=irogers job=sendgmr) by 2002:a25:dfc3:0:b0:64b:3228:73fc with SMTP id
 w186-20020a25dfc3000000b0064b322873fcmr2977029ybg.441.1652414736234; Thu, 12
 May 2022 21:05:36 -0700 (PDT)
Date:   Thu, 12 May 2022 21:05:17 -0700
In-Reply-To: <20220513040519.1499333-1-irogers@google.com>
Message-Id: <20220513040519.1499333-6-irogers@google.com>
Mime-Version: 1.0
References: <20220513040519.1499333-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH 5/7] perf test: Parse events tidy terms_test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Marco Elver <elver@google.com>,
        John Garry <john.garry@huawei.com>,
        Michael Petlan <mpetlan@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Remove an unused variables. Make structs const. Fix checkpatch issue wrt
unsigned not being with an int.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index e71efadb24f5..7e802666d2d5 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1980,11 +1980,10 @@ static struct evlist_test test__events_pmu[] = {
 
 struct terms_test {
 	const char *str;
-	__u32 type;
 	int (*check)(struct list_head *terms);
 };
 
-static struct terms_test test__terms[] = {
+static const struct terms_test test__terms[] = {
 	[0] = {
 		.str   = "config=10,config1,config2=3,umask=1,read,r0xead",
 		.check = test__checkterms_simple,
@@ -2112,7 +2111,7 @@ static int test_events(struct evlist_test *events, unsigned cnt)
 	return ret2;
 }
 
-static int test_term(struct terms_test *t)
+static int test_term(const struct terms_test *t)
 {
 	struct list_head terms;
 	int ret;
@@ -2139,13 +2138,12 @@ static int test_term(struct terms_test *t)
 	return ret;
 }
 
-static int test_terms(struct terms_test *terms, unsigned cnt)
+static int test_terms(const struct terms_test *terms, int cnt)
 {
 	int ret = 0;
-	unsigned i;
 
-	for (i = 0; i < cnt; i++) {
-		struct terms_test *t = &terms[i];
+	for (int i = 0; i < cnt; i++) {
+		const struct terms_test *t = &terms[i];
 
 		pr_debug("running test %d '%s'\n", i, t->str);
 		ret = test_term(t);
-- 
2.36.0.550.gb090851708-goog

