Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACF0C433F5
	for <linux-perf-users@archiver.kernel.org>; Wed,  5 Jan 2022 06:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238195AbiAEGRW (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 5 Jan 2022 01:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237739AbiAEGQM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 5 Jan 2022 01:16:12 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E25CC0698D6
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Jan 2022 22:15:50 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s127-20020a252c85000000b0060be2b7b8e9so53251842ybs.8
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Jan 2022 22:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l4aITqAr4kAWUMdh1BRMLGLBNjKWhPafS6IoiJKe+3o=;
        b=oq4qaiIdVmKbNmPSmU1ee7EYSBOWVUs0qBp1DNmNPiE1i6LOTJgd4U49eU8Qud+eAF
         BK9YPVFgysNVn0Jm0gzZFN+8U+8/pwXJB5sDD7nPgk/0MX309k1smI8yLpMytm2wK2G8
         jLg7oTVi0CiVtoZgHy1xC/sT6JbceUZ9QjAARlngFZklHrkJTRLucA4QxGBgamZoYfjh
         qB50KKL9C5/cjkAx+UNaSgDC1VX/tQ9Vqg2DtKfJ8MNPRa4D9fbpZ8crbtlOj79WX5qG
         xqCVMQokJemgqj7YoOC/pIJCI+MPyNWib/3uJMLOGnZcfzdt8LP1eJPEdtPS+eYN9P/b
         TsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l4aITqAr4kAWUMdh1BRMLGLBNjKWhPafS6IoiJKe+3o=;
        b=6yMDWZubqhQ+vTKxuIjpGkOG+Oe1UMrAogVxiwRUyMBtXI+gnYl76cccmmWfxUtOGt
         jtIwbiiCZDt374PTO4s0lE6Z//LJGhS6ztJfksEm6QLdRSVQOQpaq4VASdJmGK/iqk1K
         77K2mcsncPuI2GTGcQUfBcmemXLPBHYdaK4CJlRyuDn0m6Or2bbw1zaZVPwvDmoUHLbW
         M044rtnq5zbTG1vnS6IYusvpMithGphYV6U7Eo/vGUJzuCJn2HQUTmUfdGPaR+XOVKvS
         ZaNgxQXClvvv9GR1uHfht+UGY5GElT+V4N3zT2mt0rKzt0/k15KGxVQcrUtAG1pUbmKp
         C4DQ==
X-Gm-Message-State: AOAM5328gLbNHiOoAv4yVpYgzaayIbJpfm4wcFZS/4GToiOZEOIAhcho
        CMSyvUGQmAZfX8tGGaKayj3JYerlmS9B
X-Google-Smtp-Source: ABdhPJyPnXyAbZfjaFcz67v+Kw7nE2hg5GCzoqNQvaO7noAreCoYlyuiuJVgyHV9sb+ADV8pJ+AK+odgpgfW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3af1:caef:2937:5d2b])
 (user=irogers job=sendgmr) by 2002:a25:40ca:: with SMTP id
 n193mr64096091yba.683.1641363349798; Tue, 04 Jan 2022 22:15:49 -0800 (PST)
Date:   Tue,  4 Jan 2022 22:13:48 -0800
In-Reply-To: <20220105061351.120843-1-irogers@google.com>
Message-Id: <20220105061351.120843-46-irogers@google.com>
Mime-Version: 1.0
References: <20220105061351.120843-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v4 45/48] perf c2c: Use more intention revealing iterator
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

Use perf_cpu_map__for_each_cpu in setup_nodes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-c2c.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index b5c67ef73862..ad1fbeafc93d 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2015,7 +2015,7 @@ static int setup_nodes(struct perf_session *session)
 {
 	struct numa_node *n;
 	unsigned long **nodes;
-	int node, cpu;
+	int node, cpu, idx;
 	int *cpu2node;
 
 	if (c2c.node_info > 2)
@@ -2057,13 +2057,13 @@ static int setup_nodes(struct perf_session *session)
 		if (perf_cpu_map__empty(map))
 			continue;
 
-		for (cpu = 0; cpu < map->nr; cpu++) {
-			set_bit(map->map[cpu], set);
+		perf_cpu_map__for_each_cpu(cpu, idx, map) {
+			set_bit(cpu, set);
 
-			if (WARN_ONCE(cpu2node[map->map[cpu]] != -1, "node/cpu topology bug"))
+			if (WARN_ONCE(cpu2node[cpu] != -1, "node/cpu topology bug"))
 				return -EINVAL;
 
-			cpu2node[map->map[cpu]] = node;
+			cpu2node[cpu] = node;
 		}
 	}
 
-- 
2.34.1.448.ga2b2bfdf31-goog

