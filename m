Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D806C61DA4
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Feb 2023 06:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjBIGpC (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Feb 2023 01:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBIGpB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Feb 2023 01:45:01 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB2D6E9C
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Feb 2023 22:45:00 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e21-20020a253715000000b008b2fd4ebbfcso1113185yba.3
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Feb 2023 22:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aYA62UM7iNvAalHymUv4OGhwL/goVRk/xLdwvIuRrY8=;
        b=MMP6r2RdnTh69WtQF55ZH+zjroKR30J8jZ5jVsIaMXCX4TG2ndbpu4toNWm+rH2Inu
         H3mZtvfKGcZi+1JGFSWKamBVthAdjtyzSdscxxzUni0071VP9Dw96QV8Up8jRPxkBTGQ
         f3kWHgkdVMWOmzbZNLWmiy3ThzdasvoZ53qRcF3S7FGq1RUjJmIkdMCWKnGygZjcfNXL
         ZCoBxKNsIvQR/JKFP08PfSb2ldoZyv/ALjGWkkMWNUdVdbnGFgL7rTP7dTzXYFNQMWiq
         wY2/ze/L4lq6MYAN0rcLVR7tYQbn/7R8dEM5hnPa8WGki3tQZSQpd2aQ5CP6OlPZdHmj
         PsuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aYA62UM7iNvAalHymUv4OGhwL/goVRk/xLdwvIuRrY8=;
        b=hPq/SmWKDunaWXrQjyNurxiUIgD49bvbt4kr5daE44UkS8yJsSP3i1DRdvXgDb/MGo
         4g7ycgR5Ro+/VFa0XkBnMlKhPY67Oswzw8GG5k1adf5xOH1Qu2r2EEdPH8md0FQbvBZ7
         bfLffpUvEVEoPOMuvt+qGiq2BV3t0iaxTg51F2aguaRSpo+AXkju8/RM5iGlDaSvQ8u2
         9rNyPpE6I82uU306MskWIcEMXKIAk/E79cRJxgrDZ+dUHyl7Z3lbzr1svgw0YD6bYrjy
         /K4Gs9K1kF2c6TmyglcN7a9BqEASJj4FoLWHYw7/zR+YOCqd8NC/7zVlT25vI6EPLB5g
         F/mA==
X-Gm-Message-State: AO0yUKU8ECripDsMN4Ift6JeEP1CYLgkZcaffD8ovy9sL9ERGyHbJSko
        vy5QMUKlkIFVcB0tSs7VPBhorZCGRzkc
X-Google-Smtp-Source: AK7set+bdzgZW3i0eyMzB8UjNs16FKUeVxGDvyk0dGd+ARkOzBPZZasiKBTZiO1/t6ZzZbNQOMhtazbI6C6L
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:d338:d214:571:e56b])
 (user=irogers job=sendgmr) by 2002:a05:6902:54a:b0:8bb:dfe8:a33b with SMTP id
 z10-20020a056902054a00b008bbdfe8a33bmr22ybs.9.1675925099446; Wed, 08 Feb 2023
 22:44:59 -0800 (PST)
Date:   Wed,  8 Feb 2023 22:44:47 -0800
Message-Id: <20230209064447.83733-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
Subject: [PATCH v1] perf stat: Avoid merging/aggregating metric counts twice
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        James Clark <james.clark@arm.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The added perf_stat_merge_counters combines uncore counters. When
metrics are enabled, the counts are merged into a metric_leader
via the stat-shadow saved_value logic. As the leader now is
passed an aggregated count, it leads to all counters being added
together twice and counts appearing approximately doubled in
metrics.

This change disables the saved_value merging of counts for evsels
that are merged. It is recommended that later changes remove the
saved_value entirely as the two layers of aggregation in the code
is confusing.

Fixes: 942c5593393d ("perf stat: Add perf_stat_merge_counters()")
Reported-by: Perry Taylor <perry.taylor@intel.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index cadb2df23c87..4cd05d9205e3 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -311,7 +311,7 @@ void perf_stat__update_shadow_stats(struct evsel *counter, u64 count,
 		update_stats(&v->stats, count);
 		if (counter->metric_leader)
 			v->metric_total += count;
-	} else if (counter->metric_leader) {
+	} else if (counter->metric_leader && !counter->merged_stat) {
 		v = saved_value_lookup(counter->metric_leader,
 				       map_idx, true, STAT_NONE, 0, st, rsd.cgrp);
 		v->metric_total += count;
-- 
2.39.1.519.gcb327c4b5f-goog

