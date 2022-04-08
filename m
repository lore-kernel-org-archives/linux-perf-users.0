Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF38C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri,  8 Apr 2022 03:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbiDHD6m (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 7 Apr 2022 23:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbiDHD6b (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Apr 2022 23:58:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A16DD94B
        for <linux-perf-users@vger.kernel.org>; Thu,  7 Apr 2022 20:56:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k206-20020a2524d7000000b0063db1bacae1so5751227ybk.4
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Apr 2022 20:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l17qIMDJgHlHJkmXqdwNhErpsnzRSh+81icGNnMQVKs=;
        b=CDF0VWxYUKfVOpEvH57Wcg+2Ht824//X9lGhIknOL9VIIF+EdYpmgeX3CHwN9sHeAT
         u9PeKn+tbOApjUseyK1kOHNHVP2i7a3oY6N/aX/r+Oqy5v3/FNPZf7VsQl77EpKtFjXz
         x0JMAMOcie6hoUXElxRbsp2ogGcKFaa+jDBwAQLG/kcORFBLquHUEfyiXtVheFEeeW8I
         inJLEZUd53sSTeyezcwzA/kev6gYerwGABOZqnuIZb8SbdZ2hfZ0ujxMuq3R1R3/r14V
         FxilRM0ZPu80qsZ1UH7WmH9ceYh4ckUANkk5Vjg8tXV2FCorud/XocnxT0G86KTWcY/I
         mlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l17qIMDJgHlHJkmXqdwNhErpsnzRSh+81icGNnMQVKs=;
        b=e4qQSaVNzn1BbhqDIZ1Guw1EY3xWS4xKTwSazvJltV24mLLfPsMtVf7jdUnBrAuFIc
         ElO4UMMEUNCudftOVokVBzJ4jogMaVdAHq1zeK//3TPbnF6jBBvWdDeSWFWXYVKIXJjc
         oMhxexUgJk1zFrgJyqyOUCKrwwlf+XSfWuaMEmWC1wzZCX59lvF+kZG37AtRasjiv5ob
         ouhkIYmLk0+gT/Qp0VNAKSJvCYjthirbBEKiNFIO6QV1YVmPd+rfFvGTRWy4r3r+rArB
         Cyl98+ybHrYDx+Ve9csD5fhsk+r/+yf0iSen7EKsJvKiv14HcF/QIFlz/JJgd5PP5SRY
         9Eqg==
X-Gm-Message-State: AOAM533UIsnMGT3uIT7EaqwCGA18RSfLMV5zMegzLwe6RRi64yDcfq1g
        Rs8gEZK8srbDqg7olvQ7UVfjyaGDnOAp
X-Google-Smtp-Source: ABdhPJx0t6TUTcHjyQ+6Q0vxZrojw0BDHuxcmQSgV2WmscSbmIhwWv3XjfnNAnYb/FSu9l7V1FRxddn/jSqN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:560:aa27:649e:a07d])
 (user=irogers job=sendgmr) by 2002:a25:e30a:0:b0:625:3d53:91b7 with SMTP id
 z10-20020a25e30a000000b006253d5391b7mr12600758ybd.499.1649390186782; Thu, 07
 Apr 2022 20:56:26 -0700 (PDT)
Date:   Thu,  7 Apr 2022 20:56:13 -0700
In-Reply-To: <20220408035616.1356953-1-irogers@google.com>
Message-Id: <20220408035616.1356953-3-irogers@google.com>
Mime-Version: 1.0
References: <20220408035616.1356953-1-irogers@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH v3 2/5] perf tests: Additional cpumap merge tests
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
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Cover cases where one cpu map is a subset of the other.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/cpumap.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/tools/perf/tests/cpumap.c b/tools/perf/tests/cpumap.c
index cf205ed6b158..3b9fc549d30b 100644
--- a/tools/perf/tests/cpumap.c
+++ b/tools/perf/tests/cpumap.c
@@ -123,22 +123,36 @@ static int test__cpu_map_print(struct test_suite *test __maybe_unused, int subte
 	return 0;
 }
 
-static int test__cpu_map_merge(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+static int __test__cpu_map_merge(const char *lhs, const char *rhs, int nr, const char *expected)
 {
-	struct perf_cpu_map *a = perf_cpu_map__new("4,2,1");
-	struct perf_cpu_map *b = perf_cpu_map__new("4,5,7");
+	struct perf_cpu_map *a = perf_cpu_map__new(lhs);
+	struct perf_cpu_map *b = perf_cpu_map__new(rhs);
 	struct perf_cpu_map *c = perf_cpu_map__merge(a, b);
 	char buf[100];
 
-	TEST_ASSERT_VAL("failed to merge map: bad nr", perf_cpu_map__nr(c) == 5);
+	TEST_ASSERT_EQUAL("failed to merge map: bad nr", perf_cpu_map__nr(c), nr);
 	cpu_map__snprint(c, buf, sizeof(buf));
-	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, "1-2,4-5,7"));
+	TEST_ASSERT_VAL("failed to merge map: bad result", !strcmp(buf, expected));
 	perf_cpu_map__put(a);
 	perf_cpu_map__put(b);
 	perf_cpu_map__put(c);
 	return 0;
 }
 
+static int test__cpu_map_merge(struct test_suite *test __maybe_unused, int subtest __maybe_unused)
+{
+	int ret;
+
+	ret = __test__cpu_map_merge("4,2,1", "4,5,7", 5, "1-2,4-5,7");
+	if (ret) return ret;
+	ret = __test__cpu_map_merge("4,2,1", "1", 3, "1-2,4");
+	if (ret) return ret;
+	ret = __test__cpu_map_merge("1", "4,2,1", 3, "1-2,4");
+	if (ret) return ret;
+	ret = __test__cpu_map_merge("1", "1", 1, "1");
+	return ret;
+}
+
 DEFINE_SUITE("Synthesize cpu map", cpu_map_synthesize);
 DEFINE_SUITE("Print cpu map", cpu_map_print);
 DEFINE_SUITE("Merge cpu map", cpu_map_merge);
-- 
2.35.1.1178.g4f1659d476-goog

