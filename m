Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45BCC433F5
	for <linux-perf-users@archiver.kernel.org>; Sat, 30 Apr 2022 06:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382180AbiD3G1G (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 30 Apr 2022 02:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbiD3G1E (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 30 Apr 2022 02:27:04 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17646CFE57
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Apr 2022 23:23:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f8398e99dcso94003087b3.9
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Apr 2022 23:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qZYkK0QiKq2QKPszwBBc5ZNarCxrPY8dG8RgsS3qw5I=;
        b=fRsyW6GbkMphhji6HkWrwSTwBAXGNvOlpnZsEL3PdGLSZJ1r7S1xYRjtrLOozK6mWl
         3qX3nxKGG2OnhVNIR+ZBXx1evctirZeziZih4gSH/j41Wikg/rbabyFZNsS/NSiOeJyy
         3ELoH1FKtB09fYuffeKdXu387tSyafRzaWMlEDjNWA8W6e+zvA7Hum8uO5Ejk0ayaTI5
         9NJQk9nM9n7AIYvrQKhRVbp7rzsc0+0lRzwekIYGw03prwRWy7pQqVxyVg/EWQkMWh88
         bmnnuvX4EC5Rfnr4firZh3dLp30gU8kumxP8KLeKzbd1R7U2Spu/q8Q2ZbG9CoqheSgA
         XO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qZYkK0QiKq2QKPszwBBc5ZNarCxrPY8dG8RgsS3qw5I=;
        b=0sLfkyj6E3Uj177aWMRd2484QVNG9US7S6IjAT6upjzDRB3W0j04OL1H1XT4UQ0Ivg
         xjHktqIk+7xFTaUui14Y+gDjaXiXSFFOPc5R25wSN8VGURg9odmW2Jay9nr+axHuOT7O
         W0eIdn6BzSjeiYthLSssSHR9en9EPXqMTs21NP6sNSf9Tw2glphIDPH3mRU+vMgyHziz
         M3niua2EoxqP7OlHXJn4/0Ee8rXSZfOY+UqVttdy69aj2zt4njTHbQuM1lQjbUIyNCXj
         rhIjtKOcZuILHpKK5qvyGT5rRdXWTmnRoD7rK2WAwyBToboewMIUmc9YBbdJ5O3VTRL+
         +duw==
X-Gm-Message-State: AOAM531WCyXoakBJE6SAI/c7nZ/xsCgOfqzDDabGoYo23yXxQ+FRJUB6
        Q2qriQ+bc02ONihds/MwtY1sY2XOwxCJ
X-Google-Smtp-Source: ABdhPJxSNfQpR1Zv3c0Oz3hL/CjnVXqYxzCUyoTub6sZuefdc82ZfacJXBoI0or/vNiIC4+++3Egz2cSgZ1n
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2481:caab:4fd5:232b])
 (user=irogers job=sendgmr) by 2002:a25:4944:0:b0:648:a796:a2 with SMTP id
 w65-20020a254944000000b00648a79600a2mr2761055yba.123.1651299820173; Fri, 29
 Apr 2022 23:23:40 -0700 (PDT)
Date:   Fri, 29 Apr 2022 23:23:22 -0700
In-Reply-To: <20220430062324.1565215-1-irogers@google.com>
Message-Id: <20220430062324.1565215-5-irogers@google.com>
Mime-Version: 1.0
References: <20220430062324.1565215-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v4 4/6] perf cpumap: Handle dummy maps as empty in subset
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        German Gomez <german.gomez@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf_cpu_map__empty is true for empty and dummy maps. Make is_subset
respect that.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c   |  4 ++--
 tools/perf/tests/cpumap.c | 10 +++++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 384d5e076ee4..9c83675788c2 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -322,9 +322,9 @@ struct perf_cpu perf_cpu_map__max(struct perf_cpu_map *map)
 /** Is 'b' a subset of 'a'. */
 bool perf_cpu_map__is_subset(const struct perf_cpu_map *a, const struct perf_cpu_map *b)
 {
-	if (a == b || !b)
+	if (a == b || perf_cpu_map__empty(b))
 		return true;
-	if (!a || b->nr > a->nr)
+	if (perf_cpu_map__empty(a) || b->nr > a->nr)
 		return false;
 
 	for (int i = 0, j = 0; i < a->nr; i++) {
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index f94929ebb54b..d52b58395385 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -128,13 +128,21 @@ static int test__cpu_map_merge(struct test_suite *test __maybe_unused, int subte
 	struct perf_cpu_map *a = perf_cpu_map__new("4,2,1");
 	struct perf_cpu_map *b = perf_cpu_map__new("4,5,7");
 	struct perf_cpu_map *c = perf_cpu_map__merge(a, b);
+	struct perf_cpu_map *d = perf_cpu_map__dummy_new();
+	struct perf_cpu_map *e = perf_cpu_map__merge(b, d);
 	char buf[100];
 
 	TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(c) == 5);
 	cpu_map__snprint(c, buf, sizeof(buf));
 	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
-	perf_cpu_map__put(b);
+
+	TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(e) == 3);
+	cpu_map__snprint(e, buf, sizeof(buf));
+	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "4-5,7"));
+
 	perf_cpu_map__put(c);
+	perf_cpu_map__put(d);
+	perf_cpu_map__put(e);
 	return 0;
 }
 
-- 
2.36.0.464.gb9c8b46e94-goog

