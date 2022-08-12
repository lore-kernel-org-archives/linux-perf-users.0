Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AC2C25B0F
	for <linux-perf-users@archiver.kernel.org>; Fri, 12 Aug 2022 23:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236897AbiHLXKK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 12 Aug 2022 19:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbiHLXKE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 12 Aug 2022 19:10:04 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AFC9BB7F
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Aug 2022 16:10:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3225b644be1so18497577b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Aug 2022 16:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=YiyvC5KcLJL9/nnX+SFeTIrRtpkkdHYbCWBdgzmu8kY=;
        b=Da16TEv/4coRpuTFpJa27ZXTP77mj0yprgQil4DtOi02L2ulStByB/BXJn1UgSQSt2
         ijc4vnzrQBDCVUlDRA6+lVypjyyZzeJqPXE+CyLmPMyLq00MgQM2ZrG4SYrw3I4Tr9Kg
         SF7DXRuh2OEB3Xwd9ZbjQhQYZsIosAlNNfpIesLnV6z6D/kOhbFp1j2t1H+UmtK2z6e5
         ffyNv5Slc693/I/rscqd/qOlaGRqqONonCgtcvoinKGuoE4W0Jr4gyc8MhPJv4/jQ7fD
         Kzz2xVxdwSZqU9Un0j3QpcETvKwqaEdQYXMMzieTf9FuHf7WoMcIvEFQ4KCWCZ5T7TqW
         sdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=YiyvC5KcLJL9/nnX+SFeTIrRtpkkdHYbCWBdgzmu8kY=;
        b=Po1QLje6zvGmGOUKCGvMYZk6Q+8bJ58iVTy/ztLj4eDyCHhXxsbNKGKG2AegwpIq2k
         V4krySMkOr1SVXieE9iULPivIeR8k/4qlCR1Vux5z2QhnjkJAQ5w2TRR2pP0q9qHdtk7
         FCrQW06XXsHMa0izF5W6PFwo4DzrEIsii7RZzBDOslWID7DP59LyJ9jcH8NRgZRiS6h7
         xHDqAM2xOFTGav+BRhDK6Nb8lvqYN9wPUzguBH+2zRwZW1AX8Dl0g6rrN3amRYCE8xAy
         3BIX2ye6sXqNvx/zh3JhdoLZ7DlpA9Upu3Bzb3lStVWGBXngZ/CUX3Vuht+nnB2XK0Zo
         +K+Q==
X-Gm-Message-State: ACgBeo1RrG8599PaqGMBHPWSp+D4VnLGLAAzGRxDjEKCuL8DKCzsJZj5
        5OPykMI2t4a0mheZeCLmnTX07BYqp4Dt
X-Google-Smtp-Source: AA6agR5gweXDu/o9LyYcK9Rge043hhUd0+JgvYx1OMtiTLDz0icypzu5szu4NIxcrgHjRFsQXIapBAxkT+5f
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:d668:2937:8218:c5ec])
 (user=irogers job=sendgmr) by 2002:a81:144f:0:b0:31f:43ce:de37 with SMTP id
 76-20020a81144f000000b0031f43cede37mr5830739ywu.142.1660345799751; Fri, 12
 Aug 2022 16:09:59 -0700 (PDT)
Date:   Fri, 12 Aug 2022 16:09:37 -0700
In-Reply-To: <20220812230949.683239-1-irogers@google.com>
Message-Id: <20220812230949.683239-3-irogers@google.com>
Mime-Version: 1.0
References: <20220812230949.683239-1-irogers@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v5 02/14] perf jevents: Remove the type/version variables
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
index b49a0dd946b7..8e8462cb359b 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -313,8 +313,6 @@ def print_mapping_table(archs: Sequence[str]) -> None:
       _args.output_file.write("""{
 \t.arch = "testarch",
 \t.cpuid = "testcpu",
-\t.version = "v1",
-\t.type = "core",
 \t.table = pme_test_soc_cpu,
 },
 """)
@@ -330,8 +328,6 @@ def print_mapping_table(archs: Sequence[str]) -> None:
             _args.output_file.write(f"""{{
 \t.arch = "{arch}",
 \t.cpuid = "{cpuid}",
-\t.version = "{row[1]}",
-\t.type = "{row[3]}",
 \t.table = {tblname}
 }},
 """)
@@ -340,8 +336,6 @@ def print_mapping_table(archs: Sequence[str]) -> None:
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
2.37.1.595.g718a3a8f04-goog

