Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74A8C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 15 Jul 2022 06:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbiGOGhg (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 15 Jul 2022 02:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbiGOGh0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 15 Jul 2022 02:37:26 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6C747B93
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Jul 2022 23:37:24 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id t10-20020a5b07ca000000b0066ec1bb6e2cso3314835ybq.14
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Jul 2022 23:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iTECb6Mg2TpLhaSw4nsYf3B3pkIu1Oc8fpNqlu+eD8g=;
        b=EG3JmQlm7C4iHUe9v6uHAbu+lKQCnHxibfDJGoXHrJ++HtVCsacBt+Lcd4mKW45BxF
         2MkrPG2NZSlexuGFwkKoL2Ax8zodlRAP7WQQTujWZcHJS2tNn5KimMkkRIz9vo+MAl8t
         a6OXUdic+gZwgjuyx8raYNLJM1GYNeLqt+XkuDrw/gKiD25KSEHRXkMmV6ZsGGVgCjfp
         QKeidEDD5+T6eWqO+pnuUeAxBu2RTjmL0isTMW6urRJ65yXbGGCfYefiDBxMIwCR0+/u
         l0ywPiq3Cb1W2Ac8uazzJWq4/60oyCQWGOgpxpvjemC2rvMG1FZQ940LDMlSYvAtEAX4
         ww5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iTECb6Mg2TpLhaSw4nsYf3B3pkIu1Oc8fpNqlu+eD8g=;
        b=lnUyaD/0GNuyGw8LXSZP2vS6dgIYCRTapaajNCLSInSNL3kA1NQWbpt6nFdxVqUZRY
         h6U2tCZS1HYL1qvntO/AY3JxDdlY9pWKrKfY6UALz4UbgiJ11WpG0ZZHqGADrqbTFLCR
         GXuSlq1H1/gaEjSmKzdqiRfz+dTfvnV/SbrCVH2vvOJnkaxXvLtRt5Nq4a4hZHvDxJJ6
         uNP9Xla6w2drcaLHcFW7XslHI3b2OJKioiiNYwbIdyjnSkM4NtgVkJPZcJFG7QwkSo2s
         wWPzw0b/2RmbAwxGa9SgAFFt2aOlqh2wZAGVeGRK8hXFED+4xcnPpBl1tXAqhEFscMLN
         2Ilg==
X-Gm-Message-State: AJIora9p41ZniMweQ62PIkt9WbQT1gon9AXrvTqSY34+cV3/w7kawIVy
        ptmkk1lJsZvwotG03rKXciXw3lDWLCGy
X-Google-Smtp-Source: AGRyM1skxuFPbwf3y0CFyGreJp4mNzxjKkWHySbqDDCcd4FomQaZiqj9KHEgZcuOEpz/0oYUPjMgXACGAwZz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e8fe:2a8e:e0f6:318d])
 (user=irogers job=sendgmr) by 2002:a5b:24a:0:b0:66f:939c:a643 with SMTP id
 g10-20020a5b024a000000b0066f939ca643mr12579689ybp.415.1657867043840; Thu, 14
 Jul 2022 23:37:23 -0700 (PDT)
Date:   Thu, 14 Jul 2022 23:36:42 -0700
In-Reply-To: <20220715063653.3203761-1-irogers@google.com>
Message-Id: <20220715063653.3203761-5-irogers@google.com>
Mime-Version: 1.0
References: <20220715063653.3203761-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v1 04/15] perf jevents: Remove the type/version variables
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
 tools/perf/pmu-events/empty-pmu-events.c | 6 ++----
 tools/perf/pmu-events/jevents.py         | 6 ------
 tools/perf/pmu-events/pmu-events.h       | 2 --
 tools/perf/tests/expand-cgroup.c         | 2 --
 tools/perf/tests/parse-metric.c          | 2 --
 5 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
index 77e655c6f116..4182a986f505 100644
--- a/tools/perf/pmu-events/empty-pmu-events.c
+++ b/tools/perf/pmu-events/empty-pmu-events.c
@@ -110,15 +110,13 @@ static const struct pmu_event pme_test_soc_cpu[] = {
 
 const struct pmu_events_map pmu_events_map[] = {
 	{
+		.arch = "testarch",
 		.cpuid = "testcpu",
-		.version = "v1",
-		.type = "core",
 		.table = pme_test_soc_cpu,
 	},
 	{
+		.arch = 0,
 		.cpuid = 0,
-		.version = 0,
-		.type = 0,
 		.table = 0,
 	},
 };
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 2a9a1a086dee..c53c744da56b 100755
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
2.37.0.170.g444d1eabd0-goog

