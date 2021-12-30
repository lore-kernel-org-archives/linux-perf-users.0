Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D09C433EF
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Dec 2021 07:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbhL3HWP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Dec 2021 02:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbhL3HVe (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Dec 2021 02:21:34 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22273C061401
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:21:34 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k130-20020a255688000000b0060c3dcae580so22464493ybb.6
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ue3Sc4M2PULu8G7idSi+UKsFDq60wD74fexukfC/fcc=;
        b=RgPIJ3CxdVKGxX2ivNN+mgiAZhGMJAf1uHegdL57m4nmFBiLW3Qn3c+ZILE9tq9Air
         xst/+qnStFVCVDhPXd/IPYhpO6+twqIagXmvBSogWBbWSATGCxRP/c6vJZ1On8xt67+M
         +feHKWUZtWQ7d4J3af5NGYMfnl/axYLQ+162n+io4k8+8CF32Ehr/wotZ/Gff/l695X4
         8GVqDKz3Q968rvD/nBwJc9Lr5yg0ntqZwjoxXGuzSSU3X4iuwOdjxDlRRaGT16cF47Wd
         z1CaKAW6EtsSkJrW0ulwWiq0ciymoN6H0bwPRV+Dar41+Vf1FDKvAXg1SQTcz5aLCSfj
         kf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ue3Sc4M2PULu8G7idSi+UKsFDq60wD74fexukfC/fcc=;
        b=yG8HnqLxrQzokMby0xyK+m7NwsbdMcZHwBJOA4PEpgVfpiQBgHgFbaK3vJcYwwm6Nl
         XS0PKMooSnVbqVG6qntsiqydqH3xIbEfz1byj1K6uom8M7YoSoXfLt0fPlomf9O4dWu5
         kJ31QezRBqlvqaGOEQMk4XKxhDDSoIDBhdPge6WrQ4HsBUhrEIV/XS7MVSPaMCo+9LEE
         rEKKydrYN+nieSeyzEninZKHaMBmvdJDFYEjmifJ+elH1qBJmSWNKOOw0RW7oU4yjVpo
         zV+CFSd5Ptgc+mqR5i1o2lvTWij1iEQDUJYWCcuaG4xv9SGPDu15I7AL2Euc96vbiSwb
         Br+A==
X-Gm-Message-State: AOAM5326Sv7TX5FEZeuucd1OVAyv4qrkth0RqI5EOen3N9tRvnKuiYfr
        ycNMwHFlH5C1Epm0Qbtw4DQkrOMHkMEI
X-Google-Smtp-Source: ABdhPJyIaLxKF2hCbxmhSNGy06maxPg4IbLH5POO5tfbw+284KED4uP0dg5+jywJRRp01yc2Rq36s6WeqcaB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a05:6902:702:: with SMTP id
 k2mr470352ybt.66.1640848893417; Wed, 29 Dec 2021 23:21:33 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:04 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-24-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 22/48] perf cpumap: Trim the cpu_aggr_map
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

cpu_aggr_map__new removes duplicates, when this happens shrink the
array.

Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/cpumap.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
index 8a72ee996722..3061b4369ab5 100644
--- a/tools/perf/util/cpumap.c
+++ b/tools/perf/util/cpumap.c
@@ -185,7 +185,15 @@ struct cpu_aggr_map *cpu_aggr_map__new(const struct perf_cpu_map *cpus,
 			c->nr++;
 		}
 	}
-
+	/* Trim. */
+	if (c->nr != cpus->nr) {
+		struct cpu_aggr_map *trimmed_c =
+			realloc(c,
+				sizeof(struct cpu_aggr_map) + sizeof(struct aggr_cpu_id) * c->nr);
+
+		if (trimmed_c)
+			c = trimmed_c;
+	}
 	/* ensure we process id in increasing order */
 	qsort(c->map, c->nr, sizeof(struct aggr_cpu_id), aggr_cpu_id__cmp);
 
-- 
2.34.1.448.ga2b2bfdf31-goog

