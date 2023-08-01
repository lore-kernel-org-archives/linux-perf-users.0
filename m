Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF361C0015E
	for <linux-perf-users@archiver.kernel.org>; Tue,  1 Aug 2023 05:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjHAFhF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 1 Aug 2023 01:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjHAFg7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 1 Aug 2023 01:36:59 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9927C8F
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jul 2023 22:36:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-585f254c41aso37747967b3.1
        for <linux-perf-users@vger.kernel.org>; Mon, 31 Jul 2023 22:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690868209; x=1691473009;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7cgKjdSs3G1HD7e5a1QJ2TPW0bOH8fEPCcMkC6M5juE=;
        b=vasKg5Ucb7s834gs6TqGgTHy3yn7y2I64AU1KlEXsVFglMHUYI3YWwtIeYmJvvv7r1
         J8h8xXYpI5jbWq2H53iOxymdAQ0Tbx2jcEvsDuO0ChxhooVaqtkxu4ir0iYA2vI/IYel
         NCGM+o+vdH8s/IVNwLS6M5MOulScPi4J5PmFQlGNoKkzIy9Es4XPEvD/Mpn927LiyRBz
         XHa0scMkWQc3+kY21TTAOfWtR2nFdnXSir3rgHtN2dcQHFN4PjhOz2j2T2XtsymDGMi2
         iiAfovKi/QYXaEo/A7iRqgnc8YuNWzlhxcTfcGZyYaOq2tklUNXoMNnuvEXy53HwRZiK
         Y1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690868209; x=1691473009;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7cgKjdSs3G1HD7e5a1QJ2TPW0bOH8fEPCcMkC6M5juE=;
        b=dSbZBR3ZVwaQYZ+09E/COFGEU2uQAZ2rfn4FlGxLODcFhX7KJmx3LwC7yrjQTRylZz
         SBIc16/LAO4Bb9NwOCjXqm+axNVBL6yqdWDHE1jCGi2CVjBWrWJNxEgsdmUtDmlUL8ct
         bU4rF7KJjkeRGdvxOU7KB18akILlf+H8feAymknmV5nwEYAT4l6WONrRY1ONlN7OFQx3
         u4TXFbYLIcOAIDmcS/927c8LbWn24Iw1LpE70MifI6cBGCxyuk705AgmokdTXs0GzDh+
         WIwGqDr4bseRM04FeF01HTrl5pW6cSGBMSNhWGzgq1hDM9JtC7HruKnXPOeRNqVegSdb
         AymA==
X-Gm-Message-State: ABy/qLbnrVmZZ7ARGoV/vMXHrXkWBYcUb7zCMouHbFHJsYfLx8SecgcB
        /5Ton584KI2L9HuC93dnYEP6Qmokm9iv
X-Google-Smtp-Source: APBJJlHy6JFYSb9M9Oh886GADCpFJqSyjGvQ5kdRzdU6QgUVE9MfCqO3B63MHXpf8WNkAXKF78c6grWhGTtr
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:dd0a:f4b:6531:d8dc])
 (user=irogers job=sendgmr) by 2002:a81:a789:0:b0:586:5388:82ba with SMTP id
 e131-20020a81a789000000b00586538882bamr12914ywh.6.1690868208792; Mon, 31 Jul
 2023 22:36:48 -0700 (PDT)
Date:   Mon, 31 Jul 2023 22:36:31 -0700
In-Reply-To: <20230801053634.1142634-1-irogers@google.com>
Message-Id: <20230801053634.1142634-2-irogers@google.com>
Mime-Version: 1.0
References: <20230801053634.1142634-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Subject: [PATCH v1 1/4] perf parse-events x86: Avoid sorting uops_retired.slots
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Weilin Wang <weilin.wang@intel.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

As topdown.slots may appear as slots it may get confused with
uops_retired.slots which is an invalid perf metric event group
leader. Special case uops_retired.slots to avoid this confusion.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/evlist.c | 7 ++++---
 tools/perf/arch/x86/util/evsel.c  | 7 +++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/perf/arch/x86/util/evlist.c b/tools/perf/arch/x86/util/evlist.c
index cbd582182932..b1ce0c52d88d 100644
--- a/tools/perf/arch/x86/util/evlist.c
+++ b/tools/perf/arch/x86/util/evlist.c
@@ -75,11 +75,12 @@ int arch_evlist__add_default_attrs(struct evlist *evlist,
 
 int arch_evlist__cmp(const struct evsel *lhs, const struct evsel *rhs)
 {
-	if (topdown_sys_has_perf_metrics() && evsel__sys_has_perf_metrics(lhs)) {
+	if (topdown_sys_has_perf_metrics() &&
+	    (arch_evsel__must_be_in_group(lhs) || arch_evsel__must_be_in_group(rhs))) {
 		/* Ensure the topdown slots comes first. */
-		if (strcasestr(lhs->name, "slots"))
+		if (strcasestr(lhs->name, "slots") && !strcasestr(lhs->name, "uops_retired.slots"))
 			return -1;
-		if (strcasestr(rhs->name, "slots"))
+		if (strcasestr(rhs->name, "slots") && !strcasestr(rhs->name, "uops_retired.slots"))
 			return 1;
 		/* Followed by topdown events. */
 		if (strcasestr(lhs->name, "topdown") && !strcasestr(rhs->name, "topdown"))
diff --git a/tools/perf/arch/x86/util/evsel.c b/tools/perf/arch/x86/util/evsel.c
index 81d22657922a..090d0f371891 100644
--- a/tools/perf/arch/x86/util/evsel.c
+++ b/tools/perf/arch/x86/util/evsel.c
@@ -40,12 +40,11 @@ bool evsel__sys_has_perf_metrics(const struct evsel *evsel)
 
 bool arch_evsel__must_be_in_group(const struct evsel *evsel)
 {
-	if (!evsel__sys_has_perf_metrics(evsel))
+	if (!evsel__sys_has_perf_metrics(evsel) || !evsel->name ||
+	    strcasestr(evsel->name, "uops_retired.slots"))
 		return false;
 
-	return evsel->name &&
-		(strcasestr(evsel->name, "slots") ||
-		 strcasestr(evsel->name, "topdown"));
+	return strcasestr(evsel->name, "topdown") || strcasestr(evsel->name, "slots");
 }
 
 int arch_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
-- 
2.41.0.585.gd2178a4bd4-goog

