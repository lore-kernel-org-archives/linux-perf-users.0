Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5BCC433EF
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Jan 2022 06:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237817AbiAEGRU (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Jan 2022 01:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237946AbiAEGQN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jan 2022 01:16:13 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11AC9C061394
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Jan 2022 22:15:53 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b144-20020a253496000000b0060bddc72114so53309689yba.4
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jan 2022 22:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qtV1zFQM1oC6nqS9kOztDQtUXtSA1ZGHj+U+RoiLGco=;
        b=TF44h6bDW9ENH23eEmW9TItbeR7WjGNdvIzxU07LPcU/fVFvC13Vxf5hnb0t5zIi4L
         oQOsDHElQSTh7S/mT70nFE9Nm1VBwAMt/kptivfrpfiQcaVutbvK6eWOKyfKHoA516Sh
         fG7HiIp6e2uUFA5bMd41QW17SW9ctaigu70CBjtliIpF02yXP2lR8lz52KHEIPO5rMmG
         PbLPzLWCUxoqFVUPbOuCFCi3gOry2BVMXOH8Xikg93oG6BA5f9c4Si3CgfS4/KJ1Petv
         +1uM7MVZf3RS5Gqe5kw7Jyvq3SSZykfThKQyvxGZWuPZUReoQhTeEbSEOCIUPbrSK/VT
         sVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qtV1zFQM1oC6nqS9kOztDQtUXtSA1ZGHj+U+RoiLGco=;
        b=Z2l3Uylz5CJqSTzjVVX77XKae3IIYdcOpcUzR5TU4nHgkGn791ldrOZcqwMIiUpfJL
         f+hPcQ+sBLx7eFLrpXVJyCw6ST4zejS1+r9/WoFhtHqiG5PPInNVySeEpxGlp/geNESr
         onleyUgitUBetED5ij1xwUfzU5jXKbUcooFL4Y8oL/N9/2bmoRbRDUejRBLjGrvQjjPe
         oSVdvQ9LBs+XJTQJJME5rkU6Lbs72skGtVhNc4al8L8GO1y+2VApQHguMvQ5G9Ky43jy
         mgW3LjAx9GJNhxJOkT6gU8VjCZ8gFpsny7Kx9CvxekcHxRd3XEjvwepTYxQtX203rF5U
         p/Mg==
X-Gm-Message-State: AOAM5311JlhZ9Y7oYPQ6hPfGxix1USh7YxVXKhEVd4HNYzrlZgw8oMMr
        ly95wo+rkbLewY+znwC+Nqr0aTJv2HSx
X-Google-Smtp-Source: ABdhPJyO0RjQjjaLRZAsFsRj64Vi//uVlLSevrlUFyHAY3W0w1VhoNId3q47hdhQc3dTyIvu2xlWIy9+gchN
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:aacd:: with SMTP id
 t71mr49891988ybi.542.1641363352306; Tue, 04 Jan 2022 22:15:52 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:49 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-47-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 46/48] perf script: Fix flipped index and cpu
From:   Ian Rogers <irogers@google.com>
To:     Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Singh <vineet.singh@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, zhengjun.xing@intel.com
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf_counts are accessed by the densely packed index.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-script.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index f40319144856..bb43529618b3 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2131,7 +2131,7 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
 		perf_cpu_map__for_each_cpu(cpu, idx, evsel__cpus(counter)) {
 			struct perf_counts_values *counts;
 
-			counts = perf_counts(counter->counts, cpu, thread);
+			counts = perf_counts(counter->counts, idx, thread);
 
 			printf("%3d %8d %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %15" PRIu64 " %s\n",
 				cpu,
-- 
2.34.1.448.ga2b2bfdf31-goog

