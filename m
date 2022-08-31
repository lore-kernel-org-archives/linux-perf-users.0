Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05E4ECAAD4
	for <linux-perf-users@archiver.kernel.org>; Wed, 31 Aug 2022 17:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiHaRvF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 31 Aug 2022 13:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiHaRuk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 31 Aug 2022 13:50:40 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B714F1AA
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Aug 2022 10:50:38 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d62-20020a621d41000000b00537e06bf5e8so5563794pfd.10
        for <linux-perf-users@vger.kernel.org>; Wed, 31 Aug 2022 10:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=hBJ0yO7Shj4BOGRLl4iwSJQIsSnhkgtQ+YJ6SsJa66s=;
        b=EUrxwLovkSwJ6TvkQKG8Klcqc7EZ7RVJLb38iq+CvHU+quWu0R9+NfCH0WIn1OAuXI
         QRKBYrqgM7LtbjAKMeZvYVvDy6Z6J6NC+DUpXkVeSXi/+lMIa2o9SH549yRhIUWuXV3X
         MQfiqxR7PSeFNuz10ifbhUSKXJpdvxhWjfp3aogg9kq/EpMa3irR/9l5vRDDzaOxP/P/
         XbnWvNZFTSMgt6WFc6SOQEh9AgmxisyNF/AzIVHfCiWJ6ffdNyeD90ZZKfM+g2rbzPI1
         FLkiDoJ1A9ru709SSUUm8CibNMQQ2NgSy1eIedsr/e8TMWU+ZUGpRH2HfNfD6NpuFj40
         uJKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=hBJ0yO7Shj4BOGRLl4iwSJQIsSnhkgtQ+YJ6SsJa66s=;
        b=NmGEtcrpzXwwxVuD4GQZNgpreFILlmOIoP8RokW0rjdbymCx6IucaZoS516KjbCZHj
         dCUT5fJiKAY77e2EJY3gmDE7gCARYv8VR60K1R5Um9nljuD/wy50wkL95haNld8LoW1l
         fqDHktOwfHSdwJDEQWvhd048xYLMuBkqbudiXZYfMspdlkfl9YB8SH/YH0Jp1cs8eU1P
         3uI0GA10Jj8Sv8ezR3e9JPaYvSSmnHaaBZFOWYd4Ci0OeajVM5nj8PEAwwmHwIgNuAK6
         T6iZXkHUz4wNz9bDs/xJ93puY1GdoFT8mZ9Ghl9A/dxcaW9JgpzXahggv/B+gT8Bpgjt
         5/pA==
X-Gm-Message-State: ACgBeo1bOmfosvuVziHqz7vO9Zn7ETk+uNKbOO7NeZIuGUkLRnjnhwKa
        1bbk0P6aEWdYzN6k3IfWx/+5Pp7p+diu
X-Google-Smtp-Source: AA6agR6KUXTyj1DNwsbVD0rQVcRjyBpcT5UUV8Q3uxsgGqjxyGpUlPH3TVslv1iig/sms+GEgtrglNC5U5Tv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:c8e4:a3e5:9d09:d3d4])
 (user=irogers job=sendgmr) by 2002:a17:90a:e558:b0:1fb:c4b7:1a24 with SMTP id
 ei24-20020a17090ae55800b001fbc4b71a24mr254671pjb.1.1661968237443; Wed, 31 Aug
 2022 10:50:37 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:49:26 -0700
In-Reply-To: <20220831174926.579643-1-irogers@google.com>
Message-Id: <20220831174926.579643-8-irogers@google.com>
Mime-Version: 1.0
References: <20220831174926.579643-1-irogers@google.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Subject: [PATCH v2 7/7] perf test: Add basic core_wide expression test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Miaoqian Lin <linmq006@gmail.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com, ahmad.yasin@intel.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add basic test for coverage, similar to #smt_on.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/expr.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index db736ed49556..8bd719766814 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -158,6 +158,9 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 	{
 		struct cpu_topology *topology = cpu_topology__new();
 		bool smton = smt_on(topology);
+		bool corewide = core_wide(/*system_wide=*/false,
+					  /*user_requested_cpus=*/false,
+					  topology);
 
 		cpu_topology__delete(topology);
 		expr__ctx_clear(ctx);
@@ -168,6 +171,16 @@ static int test__expr(struct test_suite *t __maybe_unused, int subtest __maybe_u
 		TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
 							  smton ? "EVENT1" : "EVENT2",
 							  (void **)&val_ptr));
+
+		expr__ctx_clear(ctx);
+		TEST_ASSERT_VAL("find ids",
+				expr__find_ids("EVENT1 if #core_wide else EVENT2",
+					NULL, ctx) == 0);
+		TEST_ASSERT_VAL("find ids", hashmap__size(ctx->ids) == 1);
+		TEST_ASSERT_VAL("find ids", hashmap__find(ctx->ids,
+							  corewide ? "EVENT1" : "EVENT2",
+							  (void **)&val_ptr));
+
 	}
 	/* The expression is a constant 1.0 without needing to evaluate EVENT1. */
 	expr__ctx_clear(ctx);
-- 
2.37.2.672.g94769d06f0-goog

