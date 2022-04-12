Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4888AC4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 12 Apr 2022 06:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiDLGYJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 12 Apr 2022 02:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348749AbiDLGYG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 12 Apr 2022 02:24:06 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1CF35841
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Apr 2022 23:21:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2ebef8022c7so79717157b3.11
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Apr 2022 23:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=lCABQyzHJT/ISdP8YDmXpsvTHbgEOLbL9CSBaFVjaOs=;
        b=kDZ46WMqrLdWbPncFikxpXWCD7kc3ht5crGZxvkUttBzplQnZxnBkiN8lqDP2QofPH
         Kk4wCpDt8L8fY5rPwSJbSGRLLtDIffRyEiIPWo1AdFWjVOVc5AFn7n3y1BIlpshI6xv+
         xXkE4j3Hx9ibFxm+s+gj6gPKyzBsUBLm3Auk5ZOnDI/M+2AZj5t6/1PmOXDnTNhrTtKo
         qHxAL4DjYy2RNc8By91LlktDxgMlie6bMr/itNca9stGMMYbvrR9z+iwFX8kEaVz5zN1
         A4RD7po1pt7DWMmZXp3dHSnS3Mifca8OE30C4ZgdJGbdzsdWIvbAvQWOqhCVFBvwS+Qf
         PgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=lCABQyzHJT/ISdP8YDmXpsvTHbgEOLbL9CSBaFVjaOs=;
        b=iHylfyyFaqgJB4I5WlN6dlOkd4XBMCS9GtlrBnUhu1AGnGIL0ji4uWFn0NgQumn/Ko
         5fZ8zpHyHY8Tdm0PeTxiksz85V9WUl+wj1ZPI6LUrEUgGVcwYwDJ1csg396x1epjNW7+
         Y0Skx6c+FUzD8YjrkyE5nR4pxe0X0OZNxxpvKsoBhA6DJV6vdW1Gyy1PenvKPRD95M8N
         LsSuDL+GGV/1LIPRq8QVNZo9va5W9471gmUZ+v4DkDy8YygnNh5sPsyH2Py6TbpGN5jY
         vOyXnFtIe5ZCAYeA6enqE63v39qpsWpA2ohoQdOEZ1repS6miNi3CVPR0bRBOwr60fe5
         aU4w==
X-Gm-Message-State: AOAM530mUv3U/+2KVdEz3lwhb5nX6GuGfg+87BWRlTJoPcvNXpIP61lx
        htgEpCy9URlwAbNZFwnILdwDWcS7iY64
X-Google-Smtp-Source: ABdhPJyKdjWotZoGcz8ZQF9MJUN6mDNyNXzjZ1dURNde9EfG8Phg1RyFRjhEi48faIVslqkE2zVfwPsfGQgO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:5f6f:a698:92a:5d45])
 (user=irogers job=sendgmr) by 2002:a25:312:0:b0:641:3cfa:372d with SMTP id
 18-20020a250312000000b006413cfa372dmr7158027ybd.580.1649744508955; Mon, 11
 Apr 2022 23:21:48 -0700 (PDT)
Date:   Mon, 11 Apr 2022 23:21:31 -0700
Message-Id: <20220412062133.2546080-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH 1/3] perf record: Fix per-thread option.
From:   Ian Rogers <irogers@google.com>
To:     Alexey Bayduraev <alexey.bayduraev@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

From: Alexey Bayduraev <alexey.bayduraev@gmail.com>

Per-thread mode doesn't have specific CPUs for events, add checks for
this case.

Minor fix to a pr_debug by Ian Rogers <irogers@google.com> to avoid an
out of bound array access.

Reported-by: Ian Rogers <irogers@google.com>
Fixes: 7954f71689f9 ("perf record: Introduce thread affinity and mmap masks")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ba74fab02e62..069825c48d40 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -989,8 +989,11 @@ static int record__thread_data_init_maps(struct record_thread *thread_data, stru
 	struct mmap *overwrite_mmap = evlist->overwrite_mmap;
 	struct perf_cpu_map *cpus = evlist->core.user_requested_cpus;
 
-	thread_data->nr_mmaps = bitmap_weight(thread_data->mask->maps.bits,
-					      thread_data->mask->maps.nbits);
+	if (cpu_map__is_dummy(cpus))
+		thread_data->nr_mmaps = nr_mmaps;
+	else
+		thread_data->nr_mmaps = bitmap_weight(thread_data->mask->maps.bits,
+						      thread_data->mask->maps.nbits);
 	if (mmap) {
 		thread_data->maps = zalloc(thread_data->nr_mmaps * sizeof(struct mmap *));
 		if (!thread_data->maps)
@@ -1007,16 +1010,17 @@ static int record__thread_data_init_maps(struct record_thread *thread_data, stru
 		 thread_data->nr_mmaps, thread_data->maps, thread_data->overwrite_maps);
 
 	for (m = 0, tm = 0; m < nr_mmaps && tm < thread_data->nr_mmaps; m++) {
-		if (test_bit(cpus->map[m].cpu, thread_data->mask->maps.bits)) {
+		if (cpu_map__is_dummy(cpus) ||
+		    test_bit(cpus->map[m].cpu, thread_data->mask->maps.bits)) {
 			if (thread_data->maps) {
 				thread_data->maps[tm] = &mmap[m];
 				pr_debug2("thread_data[%p]: cpu%d: maps[%d] -> mmap[%d]\n",
-					  thread_data, cpus->map[m].cpu, tm, m);
+					  thread_data, perf_cpu_map__cpu(cpus, m).cpu, tm, m);
 			}
 			if (thread_data->overwrite_maps) {
 				thread_data->overwrite_maps[tm] = &overwrite_mmap[m];
 				pr_debug2("thread_data[%p]: cpu%d: ow_maps[%d] -> ow_mmap[%d]\n",
-					  thread_data, cpus->map[m].cpu, tm, m);
+					  thread_data, perf_cpu_map__cpu(cpus, m).cpu, tm, m);
 			}
 			tm++;
 		}
@@ -3329,6 +3333,9 @@ static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_c
 {
 	int c;
 
+	if (cpu_map__is_dummy(cpus))
+		return;
+
 	for (c = 0; c < cpus->nr; c++)
 		set_bit(cpus->map[c].cpu, mask->bits);
 }
@@ -3680,6 +3687,11 @@ static int record__init_thread_masks(struct record *rec)
 	if (!record__threads_enabled(rec))
 		return record__init_thread_default_masks(rec, cpus);
 
+	if (cpu_map__is_dummy(cpus)) {
+		pr_err("--per-thread option is mutually exclusive to parallel streaming mode.\n");
+		return -EINVAL;
+	}
+
 	switch (rec->opts.threads_spec) {
 	case THREAD_SPEC__CPU:
 		ret = record__init_thread_cpu_masks(rec, cpus);
-- 
2.35.1.1178.g4f1659d476-goog

