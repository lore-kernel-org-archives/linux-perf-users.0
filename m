Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A17C25B07
	for <linux-perf-users@archiver.kernel.org>; Thu,  4 Aug 2022 22:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239997AbiHDWSx (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 4 Aug 2022 18:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240007AbiHDWSr (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 4 Aug 2022 18:18:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5801F71705
        for <linux-perf-users@vger.kernel.org>; Thu,  4 Aug 2022 15:18:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m11-20020a5b040b000000b0066fcc60d1a0so577023ybp.19
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Aug 2022 15:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=d4S39rJSe47z417XxG+is96I4EdHbooIiUz1AHwuMQI=;
        b=lSo6uideD/pCPYRfvu0tpkQMCVlc2ZxYoP9NmxZ8rF/ZVtN4va0vH86E4HEUu82bW2
         rXBHtbcpvl3zOMajesJtRy8rE6dpdiCDyPX2wuxm7b0B4csQWtWeanre7pcD1EdjwPyb
         ei9SrOirY4ZdK/HBopHsY3UNM0PgpT1A+znEmLGCTzWV+jm3pd4zTCqCcgFb9a9x6+eq
         5e9QatfFOrGuMxHd1AzOp3pqK587ueystY3xh2zYbEunYUPPI5tBA5B6043ZiWBm5oEB
         /0i+9pAvAwv8TjByTblaHKWm631XrHo6KsVN4F4S3MDJzGBfRv5hzboem6sbvdyo7Gvj
         LhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=d4S39rJSe47z417XxG+is96I4EdHbooIiUz1AHwuMQI=;
        b=Amvp0tYMHBWSPNwIPwyaCoCPVASa6YNQ8WXJjVlJVXA77p0Nd7rJkoHmZfxX91yDbV
         NZeWUXKkqXncDGAwt2KWP0Dy59h+sdteHYwP+xKm6Thzb2xo6Pcuf1U1I4Pm9lcmz/Bx
         clfI22v3R4Q+x21N08bqPziYFXDoko36NrJOK08/Vad4lKmjfH+1u9sx7by2SK6rjlcK
         MyV4A4x8k/yJXmNL9Z/VGpHh/mQc25A6tZmxeVx4x9hUWIcSnZs8xciMeOfTeyCA/jGJ
         oAnoqoHiUFI2X2EBOKJHfodNTdQI4kHOLzqcZfnv6FihqrVb86OuGr+und2PNv/ynLAL
         6TeA==
X-Gm-Message-State: ACgBeo27a3xDVYWU3rLHSK69zvrmrATUUW0jIsaQ+1VlX8Rf3k8nbbcH
        vB4X0dlfLlCnheo6LXaITNbHeap6/Qvf
X-Google-Smtp-Source: AA6agR65w87f1sbFT8cO2GlzK8buMgzpA2ioJgHp4z/4uUNcj6GOgy/McAVYE5+48rDu8lIkhosVqS10395v
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5e1:5bc5:7dab:2b7c])
 (user=irogers job=sendgmr) by 2002:a25:3d45:0:b0:670:b35f:e4b1 with SMTP id
 k66-20020a253d45000000b00670b35fe4b1mr3120277yba.38.1659651516189; Thu, 04
 Aug 2022 15:18:36 -0700 (PDT)
Date:   Thu,  4 Aug 2022 15:18:04 -0700
In-Reply-To: <20220804221816.1802790-1-irogers@google.com>
Message-Id: <20220804221816.1802790-6-irogers@google.com>
Mime-Version: 1.0
References: <20220804221816.1802790-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.559.g78731f0fdb-goog
Subject: [PATCH v4 05/17] perf jevents: Remove the type/version variables
From:   Ian Rogers <irogers@google.com>
To:     John Garry <john.garry@huawei.com>, Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

pmu_events_map has a type variable that is always initialized to "core"
and a version variable that is never read. Remove these from the API as
it is straightforward to add them back when necessary.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/empty-pmu-events.c | 4 ----
 tools/perf/pmu-events/jevents.py         | 6 ------
 tools/perf/pmu-events/pmu-events.h       | 2 --
 tools/perf/tests/expand-cgroup.c         | 2 --
 tools/perf/tests/parse-metric.c          | 2 --
 5 files changed, 16 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index d8cf9283e486..4182a986f505 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -112,15 +112,11 @@ const struct pmu_events_map pmu_events_map[] = {
 	{
 		.arch = "testarch",
 		.cpuid = "testcpu",
-		.version = "v1",
-		.type = "core",
 		.table = pme_test_soc_cpu,
 	},
 	{
 		.arch = 0,
 		.cpuid = 0,
-		.version = 0,
-		.type = 0,
 		.table = 0,
 	},
 };
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index e6e6c42c3f8a..98d18d5c3830 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -312,8 +312,6 @@ def print_mapping_table(archs: Sequence[str]) -> None:
       _args.output_file.write("""{
 \t.arch = "testarch",
 \t.cpuid = "testcpu",
-\t.version = "v1",
-\t.type = "core",
 \t.table = pme_test_soc_cpu,
 },
 """)
@@ -329,8 +327,6 @@ def print_mapping_table(archs: Sequence[str]) -> None:
             _args.output_file.write(f"""{{
 \t.arch = "{arch}",
 \t.cpuid = "{cpuid}",
-\t.version = "{row[1]}",
-\t.type = "{row[3]}",
 \t.table = {tblname}
 }},
 """)
@@ -339,8 +335,6 @@ def print_mapping_table(archs: Sequence[str]) -> None:
   _args.output_file.write("""{
 \t.arch = 0,
 \t.cpuid = 0,
-\t.version = 0,
-\t.type = 0,
 \t.table = 0,
 }
 };
diff --git a/tools/perf/pmu-events/pmu-events.h b/tools/perf/pmu-events/pmu-events.h
index 7a360792635f..a491b117c8ac 100644
--- a/tools/perf/pmu-events/pmu-events.h
+++ b/tools/perf/pmu-events/pmu-events.h
@@ -40,8 +40,6 @@ struct pmu_event {
 struct pmu_events_map {
 	const char *arch;
 	const char *cpuid;
-	const char *version;
-	const char *type;		/* core, uncore etc */
 	const struct pmu_event *table;
 };
 
diff --git a/tools/perf/tests/expand-cgroup.c b/tools/perf/tests/expand-cgroup.c
index dfefe5b60eb2..dc4038f997d7 100644
--- a/tools/perf/tests/expand-cgroup.c
+++ b/tools/perf/tests/expand-cgroup.c
@@ -197,8 +197,6 @@ static int expand_metric_events(void)
 	};
 	const struct pmu_events_map ev_map = {
 		.cpuid		= "test",
-		.version	= "1",
-		.type		= "core",
 		.table		= pme_test,
 	};
 
diff --git a/tools/perf/tests/parse-metric.c b/tools/perf/tests/parse-metric.c
index 07b6f4ec024f..1b811a26f4ee 100644
--- a/tools/perf/tests/parse-metric.c
+++ b/tools/perf/tests/parse-metric.c
@@ -81,8 +81,6 @@ static struct pmu_event pme_test[] = {
 
 static const struct pmu_events_map map = {
 	.cpuid		= "test",
-	.version	= "1",
-	.type		= "core",
 	.table		= pme_test,
 };
 
-- 
2.37.1.559.g78731f0fdb-goog

