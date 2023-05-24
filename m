Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317CDC77B7C
	for <linux-perf-users@archiver.kernel.org>; Wed, 24 May 2023 22:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbjEXWSz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 24 May 2023 18:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbjEXWSs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 24 May 2023 18:18:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A794C183
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:18:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ba8b0fc0d35so2902834276.0
        for <linux-perf-users@vger.kernel.org>; Wed, 24 May 2023 15:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684966722; x=1687558722;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xAoaFyBJOeyjHfZvGABM9yDThQmXliV0lqnBHOLa6q0=;
        b=zlbh0StDHb0NXfGfXg/X3LfsmeDzOHLH1YC1qEfX6cRN7wrLa7RBRNYltOVYHQZznF
         Qj6tcRduEffZVSuvM+NkKpIzs2/Yn/1/v2OXQHBbzm/KyggfjUhzB3z07p5R7onauVA4
         BzzwVCRgEtBeKzsW7mXUpaSM5tYjehgTBXO+RvfETWvvcrWvHyiCk1xmfjFA4tG9OXVy
         vqnu09Hp/mrjZd+mt28IXuvqkdyd+8dV2AlzFpGd4QAToETp/lnxRQrJ3dkeh5sSJRG6
         pOrHodyD/8xM3NQnw0fnY6Ff97Ye2bV9guPTrRxmve80oAhJLFbO/Iao7HNgd2Gi80I0
         y4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684966722; x=1687558722;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xAoaFyBJOeyjHfZvGABM9yDThQmXliV0lqnBHOLa6q0=;
        b=GD/UD0wVgQ/iVT0D3hKw7FIFAv7qIqObsicaOgEsHg8Lw0p642wpZa3+ZF20KdTYUj
         RfF7KNNTSSZnxR7QFIp0jYb1mW32JvEaN+4GOIDM8GjERgGuAfhiYtFXA4C0r2YrLdJ3
         VbCKXDJND2ZfHsR6CQFgJynJVihOWE5OuaiGNDk6Ijcro4MuNst7cDort/0bQX7e6P+O
         YJ3+lhV/wHYEo3AdrF60i6aUsc2LzB4v4B5jHuPGHIFAChhHdtkmvVvtz9wcXuHhHgFX
         5VbAqlE0R+I+xLWW+Pasqp/TQXRfgrLRbpoWGZccqcjN4x7ssaprzE9MKmKrmbGJ4RRN
         vEgw==
X-Gm-Message-State: AC+VfDxmDabxiVCrd6tJpt7QXmOwjXviyc/5V/oTD7sDUKvPmlNIAPbb
        Nfc/8XpHw4DLEf3O3mcxoJbXz49YY4bB
X-Google-Smtp-Source: ACHHUZ67iw6irCTpD7UvqWqkTdeLj7Zvgy/Do6A19KOegEO5oEs6WH6+/P6qeq5gp6xRG1thiKj91Wt3B8s7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:7aa7:3d2d:76ae:8e96])
 (user=irogers job=sendgmr) by 2002:a25:3256:0:b0:b8f:53e1:64b with SMTP id
 y83-20020a253256000000b00b8f53e1064bmr570703yby.13.1684966721885; Wed, 24 May
 2023 15:18:41 -0700 (PDT)
Date:   Wed, 24 May 2023 15:17:59 -0700
In-Reply-To: <20230524221831.1741381-1-irogers@google.com>
Message-Id: <20230524221831.1741381-4-irogers@google.com>
Mime-Version: 1.0
References: <20230524221831.1741381-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.698.g37aff9b760-goog
Subject: [PATCH v3 03/35] perf cpumap: Add equal function
From:   Ian Rogers <irogers@google.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ming Wang <wangming01@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Ali Saidi <alisaidi@amazon.com>, Rob Herring <robh@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Equality is a useful property to compare after merging and
intersecting maps.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c              | 21 ++++++++++++++++
 tools/lib/perf/include/perf/cpumap.h |  2 ++
 tools/perf/tests/cpumap.c            | 37 ++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index d4f3a1a12522..48595a3ad69c 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -321,6 +321,27 @@ bool perf_cpu_map__has(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
 	return perf_cpu_map__idx(cpus, cpu) != -1;
 }
 
+bool perf_cpu_map__equal(const struct perf_cpu_map *lhs, const struct perf_cpu_map *rhs)
+{
+	int nr;
+
+	if (lhs == rhs)
+		return true;
+
+	if (!lhs || !rhs)
+		return false;
+
+	nr = perf_cpu_map__nr(lhs);
+	if (nr != perf_cpu_map__nr(rhs))
+		return false;
+
+	for (int idx = 0; idx < nr; idx++) {
+		if (RC_CHK_ACCESS(lhs)->map[idx].cpu != RC_CHK_ACCESS(rhs)->map[idx].cpu)
+			return false;
+	}
+	return true;
+}
+
 struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map)
 {
 	struct perf_cpu result = {
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index 0466c4216fbb..d0ae9552f8e2 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -28,6 +28,8 @@ LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
 LIBPERF_API bool perf_cpu_map__empty(const struct perf_cpu_map *map);
 LIBPERF_API struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map);
 LIBPERF_API bool perf_cpu_map__has(const struct perf_cpu_map *map, struct perf_cpu cpu);
+LIBPERF_API bool perf_cpu_map__equal(const struct perf_cpu_map *lhs,
+				     const struct perf_cpu_map *rhs);
 
 #define perf_cpu_map__for_each_cpu(cpu, idx, cpus)		\
 	for ((idx) = 0, (cpu) = perf_cpu_map__cpu(cpus, idx);	\
diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index 83805690c209..7730fc2ab40b 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -211,11 +211,48 @@ static int test__cpu_map_intersect(struct test_suite *test __maybe_unused,
 	return ret;
 }
 
+static int test__cpu_map_equal(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	struct perf_cpu_map *any = perf_cpu_map__dummy_new();
+	struct perf_cpu_map *one = perf_cpu_map__new("1");
+	struct perf_cpu_map *two = perf_cpu_map__new("2");
+	struct perf_cpu_map *empty = perf_cpu_map__intersect(one, two);
+	struct perf_cpu_map *pair = perf_cpu_map__new("1-2");
+	struct perf_cpu_map *tmp;
+	struct perf_cpu_map *maps[] = {empty, any, one, two, pair};
+
+	for (size_t i = 0; i < ARRAY_SIZE(maps); i++) {
+		/* Maps equal themself. */
+		TEST_ASSERT_VAL("equal", perf_cpu_map__equal(maps[i], maps[i]));
+		for (size_t j = 0; j < ARRAY_SIZE(maps); j++) {
+			/* Maps dont't equal each other. */
+			if (i == j)
+				continue;
+			TEST_ASSERT_VAL("not equal", !perf_cpu_map__equal(maps[i], maps[j]));
+		}
+	}
+
+	/* Maps equal made maps. */
+	tmp = perf_cpu_map__merge(perf_cpu_map__get(one), two);
+	TEST_ASSERT_VAL("pair", perf_cpu_map__equal(pair, tmp));
+	perf_cpu_map__put(tmp);
+
+	tmp = perf_cpu_map__intersect(pair, one);
+	TEST_ASSERT_VAL("one", perf_cpu_map__equal(one, tmp));
+	perf_cpu_map__put(tmp);
+
+	for (size_t i = 0; i < ARRAY_SIZE(maps); i++)
+		perf_cpu_map__put(maps[i]);
+
+	return TEST_OK;
+}
+
 static struct test_case tests__cpu_map[] = {
 	TEST_CASE("Synthesize cpu map", cpu_map_synthesize),
 	TEST_CASE("Print cpu map", cpu_map_print),
 	TEST_CASE("Merge cpu map", cpu_map_merge),
 	TEST_CASE("Intersect cpu map", cpu_map_intersect),
+	TEST_CASE("Equal cpu map", cpu_map_equal),
 	{	.name = NULL, }
 };
 
-- 
2.40.1.698.g37aff9b760-goog

