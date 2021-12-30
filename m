Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2DFC433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 30 Dec 2021 07:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbhL3HWe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 30 Dec 2021 02:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237900AbhL3HWD (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Dec 2021 02:22:03 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B432C0619D8
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:22:01 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i65-20020a252244000000b0060b2e5fd54cso27649198ybi.13
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Dec 2021 23:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zx3eoMgk2E9Q1m2Vv8UqlZ4wRR3W4iMt/10PWukXDj0=;
        b=gd7scXcBk1yTnVwoiPe+9oH6SNITUOkpUrx9WTCnO9LW819DoLCEjIc4CjYDRfgbW8
         kpIcIaA0WXGx0A1JkH3+CNaDGqB3LbKNQy/dC69uwrapr1aB0K7K+nY8k+xsnN6eF4lR
         /nyWdqgi8c2eNr7SAmJDNL7ryVZ8uPy9AsDhfVRqK6mGUAbGuF5gKBfiymoyOc/lCu7g
         ZsKeKPIcAATBQs1wSFE96jQMWMX35qGZpKg86Ex1PLsLGuQ6bIj5+xVqZF25J4HmYKNJ
         9nc93dAkDv96SzZ07Mn1s0PVaixDu0PPpFVxb1RLChglabm5T7WAiOU71z4oo0XVwMfL
         9YlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zx3eoMgk2E9Q1m2Vv8UqlZ4wRR3W4iMt/10PWukXDj0=;
        b=7fSLWpLvlyzlfORCKzLnsJ2Iz3X+1chn6/uxwiwtUdlV6xsaEhESBcA9iQvF2dt0ov
         bG0lNHkS2q8G3zo5/dJOpyyNhZJ/FwkH8fEqG22/zoOJn9WeLh3tpgNM6zseQ2llkIV1
         /6i9c1Ls22X9PAgmGsuR9ikvo5X9TPSPzo8CZPW2PCfTtI9M5yCujKrk1xGFHVsy9Z7U
         DTd9I0BeoKVbJGqb35vNarrMlANyZqq2J79iyjALeJcgMVQm0qEBQd3QYZ6cKdwx99R9
         BRgKPnsLXdw+ccQ34h6BOEwIvfjuz8Rk8NbAWRCyMNfdpqaSnNU2haigBdzPVBfnUeml
         ekeQ==
X-Gm-Message-State: AOAM532ZdZ9HJZhvxko5/Y1/ZXn679asQwHdUX518oP5AWcriVlmXnUP
        dcoTwVPAb1IZ7kFJgR1hMW18kn3SDVMF
X-Google-Smtp-Source: ABdhPJzroPIw7lL2p5xUk8nN/ROAI6MwcBgq9IhE3TcIDiuJTiQS4g8XAkhZduxh5XtQBLj5zuKGhd8qgHpF
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:31c4:9539:dba1:a82b])
 (user=irogers job=sendgmr) by 2002:a25:7b41:: with SMTP id
 w62mr37995471ybc.164.1640848920800; Wed, 29 Dec 2021 23:22:00 -0800 (PST)
Date:   Wed, 29 Dec 2021 23:20:15 -0800
In-Reply-To: <20211230072030.302559-1-irogers@google.com>
Message-Id: <20211230072030.302559-35-irogers@google.com>
Mime-Version: 1.0
References: <20211230072030.302559-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
Subject: [PATCH v3 33/48] libperf: Allow NULL in perf_cpu_map__idx
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

Return -1, not found, if NULL is passed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index 3c36a06771af..eacea3ab965a 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -270,8 +270,13 @@ bool perf_cpu_map__empty(const struct perf_cpu_map *map)
 
 int perf_cpu_map__idx(const struct perf_cpu_map *cpus, int cpu)
 {
-	int low = 0, high = cpus->nr;
+	int low, high;
 
+	if (!cpus)
+		return -1;
+
+	low = 0;
+	high = cpus->nr;
 	while (low < high) {
 		int idx = (low + high) / 2,
 		    cpu_at_idx = cpus->map[idx];
-- 
2.34.1.448.ga2b2bfdf31-goog

