Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC5EC433FE
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 May 2022 04:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiECEVq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 May 2022 00:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiECEVn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 May 2022 00:21:43 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792373CA71
        for <linux-perf-users@vger.kernel.org>; Mon,  2 May 2022 21:18:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f8398e99dcso152320567b3.9
        for <linux-perf-users@vger.kernel.org>; Mon, 02 May 2022 21:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qZYkK0QiKq2QKPszwBBc5ZNarCxrPY8dG8RgsS3qw5I=;
        b=fz9PewPyxjyTQCArVvRbymNYsWXATr1fj+gd6LaOOTRE5kG4bgI8Lf2sJ+gw0H38Wv
         /6tKf7w0KAU0cFq6Z8ZHgpfq57G0ENDBSTS2QnNY1FGoWVqNRKYiN2InHXvgYHuZmdXY
         R8+OtNyphACNsriRlxgKJJgY2acJJPQf7jlXveW8ycK1LfsjSBCtLM+pMBU7kS7mKu7x
         bmBf3wDsYFw+BVfNud9SoRSUH7GTOSFQg5MjRcLgpGA1psmuKLn/wiUdZwRmlLK+ap78
         KJrIc2WDt5JJBcBvk3n48RiFgW7vGkEpJml7ltCRl6tUOst4RJGtMTPnvHmLj62p2APD
         aa0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qZYkK0QiKq2QKPszwBBc5ZNarCxrPY8dG8RgsS3qw5I=;
        b=bFSet7of8izM0ovpFYxKY4d10tZJ6MagPAEVW0WwaLKn9QD8ckOU25LkMKfWxndSgi
         +/xBNf4AocI5hopE+OgBXEp19Bk6BnS211riyPN7M0TQ0w3gGpMRF+soJbp193aawVRi
         PokGaVE26+zzTb8iEMJvBuqkgE9RvY1QPOqbN9TYG8hJ7U6cKV2WIquMZrM0oUOt3uAd
         rsKNRMet83917f1sNly479D3KhWpcO25MtS21v+uEsKdQFutdeiDq7YDtT2nQfae8+CR
         SR/b3w99wKgV6AiKbZRoDiGWmtWAvrP3ikYK0OkFAAd1vMte2JgTXwOnWjokyszYQUD6
         MCMA==
X-Gm-Message-State: AOAM532O/E+jlQQbY3pn/PHgOLsTp/52OnhBi3PQE/vZRZcik1CITSSa
        WN3Uv7fOlsfMTD0mz/Q9ENVwkKpAtUV9
X-Google-Smtp-Source: ABdhPJx077Sx6pfDuCYkY9uKRPc4HO/I1fDmQkMxNFkxBO6TpMeXvcgzxUzF4eAREwfCmgFo6NmMk9+B9O/+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dd4b:52bb:771d:7bb4])
 (user=irogers job=sendgmr) by 2002:a81:1107:0:b0:2f7:cf9a:bd7 with SMTP id
 7-20020a811107000000b002f7cf9a0bd7mr13980584ywr.482.1651551491508; Mon, 02
 May 2022 21:18:11 -0700 (PDT)
Date:   Mon,  2 May 2022 21:17:55 -0700
In-Reply-To: <20220503041757.2365696-1-irogers@google.com>
Message-Id: <20220503041757.2365696-5-irogers@google.com>
Mime-Version: 1.0
References: <20220503041757.2365696-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH v5 4/6] perf cpumap: Handle dummy maps as empty in subset
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

