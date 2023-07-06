Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA23EB64DC
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Jul 2023 18:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjGFShP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Jul 2023 14:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjGFShO (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Jul 2023 14:37:14 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CEA1B6
        for <linux-perf-users@vger.kernel.org>; Thu,  6 Jul 2023 11:37:13 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5706641dda9so10929247b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Jul 2023 11:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688668632; x=1691260632;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7MRMdDfASgdQVFZKFC0mj0ss5l0jIJbSRXAS1vl4O8=;
        b=ssjat/MYqjJksqOAsZIX7PVwvikH5SIV2z2beuABtq/OtTjR7uCIPB95LZn0A470Y+
         Og5PbzGxOdwZ8FEzoszjXYuGhKolgXqDhwyzO6OuPdntHx87HwCocwwYHTEjvp5J9u5O
         EL2tgawKw9rWq8uW3ODqmw39wiZWPdRr8nNcslTNrqO6tvRoaks6h3uL4KdlYAPhryNq
         jlSmWuAUWflUEUKmpDabBqcKzmy/FWculvU4CUde/eA23kaFneCPJwasJ8wpscRrSHX9
         6qNXCqrSqNj8wBhsh+dECFzRDV5pwKKLs/YYVXqCCrzAos8jOMjja2gfK5CKEwIZwe01
         hJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688668632; x=1691260632;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7MRMdDfASgdQVFZKFC0mj0ss5l0jIJbSRXAS1vl4O8=;
        b=l6RgevInHB6FQgxMQ8OzTb4XtqlV6SPZCv22E3NSG6ViXRmCLyLUHdVY/9Iw4FJ10G
         sOBWfSaq4zYUV7Eb0jmx9VXDAxrtJ+e6a1S8flcIQn/VXo176eVSQdchvLnQV+ZausG2
         6M1WmiDxbkxiPKH3rHGuNB3WKKOKUSByK3eS+gp/mnhp1jmlORcK3dO7OWyJHg1toF+2
         ApUpSyo896pEvU5JYv0L7vyamCEi9A3iLCCZGMfaQPvYyQtN6A4M4yxU1V7Bu9gbxE9w
         Q/Kr6fmbu2xkRv31+ZiV4n5D29J6/T6944+HSJThiOWZhUqCLI1MANXSRsDbESEeKp7j
         uNlQ==
X-Gm-Message-State: ABy/qLZFyFGHFmsn5a9zRAHRaZBxl1yKpZ+QxnMK6J8k4Q7JNqeiZdaP
        3S16LZOZNMhXUbIfSEHFO3Dax4NZeMRm
X-Google-Smtp-Source: APBJJlHBup16B5eKqoLH9MfrWrLq+Wd9HigK12juzHfL68ZkqousJLj6uiLtl12WabOt48z6Ny7Vx0rjKEX1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a5e8:77df:2300:8f74])
 (user=irogers job=sendgmr) by 2002:a81:ac56:0:b0:57a:e0b:f62 with SMTP id
 z22-20020a81ac56000000b0057a0e0b0f62mr19101ywj.9.1688668632680; Thu, 06 Jul
 2023 11:37:12 -0700 (PDT)
Date:   Thu,  6 Jul 2023 11:37:05 -0700
In-Reply-To: <20230706183705.601412-1-irogers@google.com>
Message-Id: <20230706183705.601412-2-irogers@google.com>
Mime-Version: 1.0
References: <20230706183705.601412-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.390.g38632f3daf-goog
Subject: [PATCH v1 2/2] perf test parse-events: Test complex name has required
 event format
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

test__checkevent_complex_name will use an "event" format which if not
present, such as with a placeholder PMU, will cause test
failures. Skip the test in this case to avoid failures in restricted
environments.

Add perf_pmu__has_format utility as a general PMU utility.

Fixes: 628eaa4e877a ("perf pmus: Add placeholder core PMU")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/parse-events.c | 12 +++++++++++-
 tools/perf/util/pmu.c           | 11 +++++++++++
 tools/perf/util/pmu.h           |  1 +
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index b2f82847e4c3..658fb9599d95 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1631,6 +1631,16 @@ static bool test__pmu_cpu_valid(void)
 	return !!perf_pmus__find("cpu");
 }
 
+static bool test__pmu_cpu_event_valid(void)
+{
+	struct perf_pmu *pmu = perf_pmus__find("cpu");
+
+	if (!pmu)
+		return false;
+
+	return perf_pmu__has_format(pmu, "event");
+}
+
 static bool test__intel_pt_valid(void)
 {
 	return !!perf_pmus__find("intel_pt");
@@ -2179,7 +2189,7 @@ static const struct evlist_test test__events_pmu[] = {
 	},
 	{
 		.name  = "cpu/name='COMPLEX_CYCLES_NAME:orig=cycles,desc=chip-clock-ticks',period=0x1,event=0x2/ukp",
-		.valid = test__pmu_cpu_valid,
+		.valid = test__pmu_cpu_event_valid,
 		.check = test__checkevent_complex_name,
 		/* 3 */
 	},
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7f984a7f16ca..28380e7aa8d0 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1440,6 +1440,17 @@ void perf_pmu__del_formats(struct list_head *formats)
 	}
 }
 
+bool perf_pmu__has_format(const struct perf_pmu *pmu, const char *name)
+{
+	struct perf_pmu_format *format;
+
+	list_for_each_entry(format, &pmu->format, list) {
+		if (!strcmp(format->name, name))
+			return true;
+	}
+	return false;
+}
+
 bool is_pmu_core(const char *name)
 {
 	return !strcmp(name, "cpu") || !strcmp(name, "cpum_cf") || is_sysfs_pmu_core(name);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 203b92860e3c..6b414cecbad2 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -234,6 +234,7 @@ int perf_pmu__new_format(struct list_head *list, char *name,
 void perf_pmu__set_format(unsigned long *bits, long from, long to);
 int perf_pmu__format_parse(int dirfd, struct list_head *head);
 void perf_pmu__del_formats(struct list_head *formats);
+bool perf_pmu__has_format(const struct perf_pmu *pmu, const char *name);
 
 bool is_pmu_core(const char *name);
 bool perf_pmu__supports_legacy_cache(const struct perf_pmu *pmu);
-- 
2.41.0.390.g38632f3daf-goog

