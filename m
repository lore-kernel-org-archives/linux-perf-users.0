Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C496C7EE23
	for <linux-perf-users@archiver.kernel.org>; Sat, 27 May 2023 07:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjE0HWq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 27 May 2023 03:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjE0HWj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 27 May 2023 03:22:39 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D51E125
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:22:37 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-565c380565dso18757817b3.1
        for <linux-perf-users@vger.kernel.org>; Sat, 27 May 2023 00:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685172156; x=1687764156;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YmLTisiNizeIrXvrjhg9xDfBg2TQz5BFZHX1FeqqDUw=;
        b=EoBHDkjVPKfZAdSXiiUd20zvhFzUg/tYFH+HyrLhGVARc5vROiiqN1i4oWDPmXgi9j
         +0xs62mESMgE8b9umeAwcEnMYaxvZqa1biwzAQsrCrjmcDiGm+h6OZw+PVO3NOPBCzgC
         Zpn5UZhSUpR9C32IQtp2dppGevbqjx20YdLSe39shf36hi/Xg+4Me1yPB0VId66Yd+yq
         b92MyiGMgOr2Zm6SxW5z8lRxKKtAs8f6enyXr70EkxYwglAtBFWjgdh5nUpkorkK5rHV
         6K0a81BsEXF2u3Fiy8b/+0zOuJy1L5Q0ER2hC6nJeg84gjLA9rtvyqnYl3dPd7trlOYf
         AI8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685172156; x=1687764156;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmLTisiNizeIrXvrjhg9xDfBg2TQz5BFZHX1FeqqDUw=;
        b=Z9zefxX6AfCebWkM9ENKGLtW8FuJ2z/Y7ZNcGC/TLywZbWMjuC+XPB31JzWupEIZG8
         QkskrD8oBOpebkt0uBpQnSSQXQVSCFNKINKGEKWEvriLQ0NfVsdtCcRVj+HGMBi2iZD4
         ErS5ONztscxU591xF97QVlj1yayaSjw8mYit035tV/yUZ67/Osx2dwDnCiNoUAhvyV9m
         6MNCR1MJ9uxb1eBfOPdB0LKFG6xKQ7wV96m6tthIDA0yAsZoOChJeGA1ggiCkWSS1JNn
         FAQsOIO+WATis5Vknh7QJlEt/RrJhG9UQRXQXhIp85r+gtFiNit1kNOd5ufvUzCwxRNS
         w8mA==
X-Gm-Message-State: AC+VfDxD3sO9079UjMMZQKJ0K/6AUtpnnmPII9hEnAMa5yHDMD7uAyyc
        5i+QYwQBQRBFSSk6/UoOcR5sFnSYSFAu
X-Google-Smtp-Source: ACHHUZ7EF+v83A4j5vcqObk72beR2nK+Str1BgMDIl73nSTXjDZKqr4ZRkyKHLaCwRmwJSSDv+8LEYBz6T7r
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3b4e:312c:644:a642])
 (user=irogers job=sendgmr) by 2002:a81:4319:0:b0:55d:e173:8a73 with SMTP id
 q25-20020a814319000000b0055de1738a73mr1011285ywa.2.1685172156731; Sat, 27 May
 2023 00:22:36 -0700 (PDT)
Date:   Sat, 27 May 2023 00:21:38 -0700
In-Reply-To: <20230527072210.2900565-1-irogers@google.com>
Message-Id: <20230527072210.2900565-3-irogers@google.com>
Mime-Version: 1.0
References: <20230527072210.2900565-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Subject: [PATCH v5 02/34] perf cpumap: Add equal function
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
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/lib/perf/cpumap.c              | 21 ++++++++++++++++
 tools/lib/perf/include/perf/cpumap.h |  2 ++
 tools/perf/tests/cpumap.c            | 37 ++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index ec3f4ac8b1e2..98d7cb24a158 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -335,6 +335,27 @@ bool perf_cpu_map__has(const struct perf_cpu_map *cpus, struct perf_cpu cpu)
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
+	nr = __perf_cpu_map__nr(lhs);
+	if (nr != __perf_cpu_map__nr(rhs))
+		return false;
+
+	for (int idx = 0; idx < nr; idx++) {
+		if (__perf_cpu_map__cpu(lhs, idx).cpu != __perf_cpu_map__cpu(rhs, idx).cpu)
+			return false;
+	}
+	return true;
+}
+
 struct perf_cpu perf_cpu_map__max(const struct perf_cpu_map *map)
 {
 	struct perf_cpu result = {
diff --git a/tools/lib/perf/include/perf/cpumap.h b/tools/lib/perf/include/perf/cpumap.h
index b4c9a827a88a..cedfc26d944e 100644
--- a/tools/lib/perf/include/perf/cpumap.h
+++ b/tools/lib/perf/include/perf/cpumap.h
@@ -33,6 +33,8 @@ LIBPERF_API int perf_cpu_map__nr(const struct perf_cpu_map *cpus);
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
2.41.0.rc0.172.g3f132b7071-goog

