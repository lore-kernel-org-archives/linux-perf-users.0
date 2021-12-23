Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFEBC433F5
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Dec 2021 07:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347096AbhLWHsQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Dec 2021 02:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347207AbhLWHrg (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Dec 2021 02:47:36 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22043C06139B
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:20 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id j18-20020a258152000000b006000d292a42so8798103ybm.0
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Dec 2021 23:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ErABhHzBAdfT0a5ELxa3T/433q7mkoWRWaaPkr2zYLE=;
        b=h8ZCv5xpAMC9yF2kAMaxLxcymXWeg49EXaiL3OtamiPvT60DCEbRj+QLqM5moN4W8N
         cDtzztDAzcCThB3KlEz4R+jmMAHQWwC0HWP9jzLrXQeSgbrISK7vUtwmIT3hgpk8SnZf
         Ea9k4Vw/8Cu2Cdt9poAJAnCZzvqBtOEBBihTwocK1pOVbQEMqkL30NhY5x1b3qIvRjz4
         fZ/pakEDofR/HPl2V3MJr+X78TgyvuQt7Pnw0BdOGwBWbb1AwiQ5TqTdNRY8Ibpa4R9J
         QnytXVyIbzFHR52fV6mELViTABsYuN04e+hTtQnQ/bbrmoakuXNkJUX/vXlWQxbzo5zJ
         3Cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ErABhHzBAdfT0a5ELxa3T/433q7mkoWRWaaPkr2zYLE=;
        b=5FZV+ZhZRcQjEPkgI8gySZy0TdVuczVMEhHwccBFSmUIlVyUqQxjIilqkvXoIz12/a
         E+oP+Ca14zEdOl5I3Z+DYvN/X0T5wkyqXa20Ze+5+fRo1XaVFWbifjNZy0fCaeiuT20z
         jhuaKuiKVimkQwoM5bGqWirmNLUoC7w+fC1R8tct6/y0iIiXjFGXY1rBoX47j3RW50TD
         JV0znPo5MaPKKODW7Z+WUcdcKG5v02zMe2/hKW690p+bFtj8BGNMobci4tlEh1YU6CMC
         sR19OmTOmoV1UNB9nlSoyEJWSWpVnc2pQ4r5TBdtG7stmbif5KGg3Frn8rj49oP1EsIg
         xzaA==
X-Gm-Message-State: AOAM531IpFZ/KXQ97s64UnsfcF8a73heqpgmsf9atP0mkG4D5Ds7GIN/
        YQ4sKNbo/Ayr5DqglwVa9FsRInalvSuG
X-Google-Smtp-Source: ABdhPJwqZDzpHASDcXqKxGGvIcAj99RfagujZOxumPIiBCWlWRZFjRDOAtRAIxTsQbSB/e87K/O6PSKPvp4b
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:4fef:90ff:589d:24ca])
 (user=irogers job=sendgmr) by 2002:a25:238a:: with SMTP id
 j132mr1715031ybj.530.1640245639355; Wed, 22 Dec 2021 23:47:19 -0800 (PST)
Date:   Wed, 22 Dec 2021 23:45:21 -0800
In-Reply-To: <20211223074541.3318938-1-irogers@google.com>
Message-Id: <20211223074541.3318938-29-irogers@google.com>
Mime-Version: 1.0
References: <20211223074541.3318938-1-irogers@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v2 28/48] libperf: Use cpu not index for evsel mmap
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
        linux-arm-kernel@lists.infradead.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Fix issue where evsel's CPU map index was being used as the mmap cpu.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/evsel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 8028b5a4da69..f1e1665ef4bd 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -252,6 +252,7 @@ int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
 		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
 			int *fd = FD(evsel, idx, thread);
 			struct perf_mmap *map;
+			int cpu = perf_cpu_map__cpu(evsel->cpus, idx);
 
 			if (fd == NULL || *fd < 0)
 				continue;
@@ -259,7 +260,7 @@ int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
 			map = MMAP(evsel, idx, thread);
 			perf_mmap__init(map, NULL, false, NULL);
 
-			ret = perf_mmap__mmap(map, &mp, *fd, idx);
+			ret = perf_mmap__mmap(map, &mp, *fd, cpu);
 			if (ret) {
 				perf_evsel__munmap(evsel);
 				return ret;
-- 
2.34.1.307.g9b7440fafd-goog

