Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A927C433EF
	for <linux-perf-users@archiver.kernel.org>; Sat, 15 Jan 2022 06:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbiAOG27 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 15 Jan 2022 01:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiAOG27 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 15 Jan 2022 01:28:59 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34BBC061574
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Jan 2022 22:28:58 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id s7-20020a5b0447000000b005fb83901511so22662617ybp.11
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Jan 2022 22:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tSKICKJrt+U5UYOu3+Czuc1qmSwf4+cybGZYMKDol10=;
        b=ddWQuHrvTyXIwBH5Q+uLHmBs0WGQSGIrf7HbIGOA+G55UhZGWFM3tYcaaOufad74UV
         0Un8DSd6sMh8N0SG4Ibnyhg8RrziD3/juIbH1yelqBL0FNeFuc7y6bTQLWjIKttYayOs
         lTzlHegjzMEsFfaKPBjcQKq488zXABFp9oIOWmCtjdwCWX4ubi4wVok44McDcBYs3/5R
         XyhMWJCqU+SeB1TLA0bjQtLrU4EKEeHVvRYe5ZrsnCI9DPxI3b8E0DrpZtNYArDpCKaq
         ArsPzwgcRuOLm3XliB5x3au7YX/Tah1rdbjAULaYB8GYIcfwALiSLGu/fmuT9NVEb/DM
         CAhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tSKICKJrt+U5UYOu3+Czuc1qmSwf4+cybGZYMKDol10=;
        b=kQJZ76w0fmcRfe8Rmtn/fLQSRj0kMMqwQIjgLKC43KemFX2cd341y49m6ruPShzM+O
         p9L+MC9UP+CtO5UbubXnuBkueuL2Vj8/u2dUXUJVqIV1wvfBj1DjibErBWaQ3V52N731
         FfBsTfsNVfyG7Yj0bE85eroi29n4pQlRBvvz7qD4LUuHslwGubGumnnGVF2WeVZNcPMA
         3Js3SF54Ie1jlpCw8DrKkHabIZPMjt/0p5RQHU08mQO3RP3Rd3NGZ3//0XgSUr+Rql12
         n4tiUfHtFPn3mq4gxXlGTa8THdMYCMYwWP9a3/sJf6zZDrK4UEXlSi3jar/yV8aRJr5+
         meNw==
X-Gm-Message-State: AOAM532QU6X5mKwdWlnXrMvd63jobrvcjGC/7k/g6sSlf5oshkMbIGro
        gMziv9+TvrewHNJF0hxxnpfyQP4piRYj
X-Google-Smtp-Source: ABdhPJw0fXapST8UL5JX0n7j/P1M6Qk7s6FDrI0ZkVXLrLIi8kAJtZ6zPfT9neXgoKchHXLBIOWhuoTMQEwd
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:aa1d:122f:a9ca:f279])
 (user=irogers job=sendgmr) by 2002:a25:bb93:: with SMTP id
 y19mr16819618ybg.466.1642228138225; Fri, 14 Jan 2022 22:28:58 -0800 (PST)
Date:   Fri, 14 Jan 2022 22:28:52 -0800
Message-Id: <20220115062852.1959424-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH] perf metric: Fix metric_leader
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Multiple events may have a metric_leader to aggregate into. This happens
for uncore events where, for example, uncore_imc is expanded into
uncore_imc_0, uncore_imc_1, etc. Such events all have the same metric_id
and should aggregate into the first event. The change introducing
metric_ids had a bug where the metric_id was compared to itself,
creating an always true condition. Correct this by comparing the
event in the metric_evlist and the metric_leader.

Fixes: ec5c5b3d2c21 ("perf metric: Encode and use metric-id as qualifier")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 51c99cb08abf..1f1b78b0388f 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -314,7 +314,7 @@ static int setup_metric_events(struct hashmap *ids,
 		 */
 		metric_id = evsel__metric_id(ev);
 		evlist__for_each_entry_continue(metric_evlist, ev) {
-			if (!strcmp(evsel__metric_id(metric_events[i]), metric_id))
+			if (!strcmp(evsel__metric_id(ev), metric_id))
 				ev->metric_leader = metric_events[i];
 		}
 	}
-- 
2.34.1.703.g22d0c6ccf7-goog

