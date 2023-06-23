Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D26DEB64D7
	for <linux-perf-users@archiver.kernel.org>; Fri, 23 Jun 2023 04:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbjFWEit (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 23 Jun 2023 00:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFWEis (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 23 Jun 2023 00:38:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1202126
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 21:38:47 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bd69ee0edacso364116276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jun 2023 21:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687495126; x=1690087126;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VHB+5unyEfm7Ig6VLTzEIvUbjT+9ACzOcRF8S8mRQls=;
        b=38jRhWEZWPmIwDRThyEn18yUpThwawsbXdeNAodETQgG/ffxHd2j9WTopC2bd+K9zV
         cYmOZbEcLSK5ScUsDUKZ82t7Xpsod1Tl3ulx4pX+tUgtm4mRzKRA4npnTR5ma9xwACHz
         tkZUdWw4w8H1XTp1oGm0kcFUpBYBliQ/GPIgCYGIZ8+xc1keUzf0vAmygmRDpuZa5zNi
         Mj3GXZVG1ooX+6VvFPrFAW7ta81uskkl5jaIeddWMl/swe8dOst15OT1XuDjk9eCTqxe
         FJGfP1VhjCasMyJ5OCE7kW0pbUDJ3Y1dO1P44qe5ZblbqVvs4VFjSdsbttcFZFG3mgZg
         lhPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687495126; x=1690087126;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VHB+5unyEfm7Ig6VLTzEIvUbjT+9ACzOcRF8S8mRQls=;
        b=ebh9JHuFTfERiCJfNArTcFg0ccz9NauZJVr5cd9EVsgifiQvy4MMIOTDaDe4rykk1j
         n8N14yQkVAWGo5S5yoKOXhKjw/yODsgI8DFJ257D4Y+yXJ+95RIpSgBlu6+nBRreiZ7O
         P23d4ZdKnP4QuBrEB05tkee8/f6nLTMYSnr7c029ByM/kTaDB8VRtD2zqAfJVQq5yobL
         WmRk61dSeM5dUlKRXvCkuHZA72IyIT4ObVcXuLizzBZSpcwcrZKFClvs6eHya/Rl7hBj
         97rJPQGk0LeYxfsKolPvOFEdqBU6uw+l9Nlr6X3RhaC8RNqzBKCecfEsDC2OilueRgdW
         nnbA==
X-Gm-Message-State: AC+VfDwse4vs9IKT8uzBdWnUrVFZ7Zg+e69CHfn0WQKNvJxSNbmf8Ea+
        QS4Ww2HNnnKG7FbzC2dXpNY4XT0cbBvZ
X-Google-Smtp-Source: ACHHUZ4iR5iHIKt4T9w3pn8rs4NlJDKLNeEritoHOPXkEvPe7cSqXT15MBqO9D58MC6EAheteg0vhHZy+eD0
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6559:8968:cdfe:35b6])
 (user=irogers job=sendgmr) by 2002:a25:ab4e:0:b0:bff:1bc3:c12c with SMTP id
 u72-20020a25ab4e000000b00bff1bc3c12cmr3599524ybi.7.1687495126798; Thu, 22 Jun
 2023 21:38:46 -0700 (PDT)
Date:   Thu, 22 Jun 2023 21:38:42 -0700
Message-Id: <20230623043843.4080180-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Subject: [PATCH v2 1/2] perf pmus: Add notion of default PMU for JSON events
From:   Ian Rogers <irogers@google.com>
To:     Thomas Richter <tmricht@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

JSON events created in pmu-events.c by jevents.py may not specify a
PMU they are associated with, in which case it is implied that it is
the first core PMU. Care is needed to select this for regular 'cpu',
s390 'cpum_cf' and ARMs many names as at the point the name is first
needed the core PMUs list hasn't been initialized. Add a helper in
perf_pmus to create this value, in the worst case by scanning sysfs.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>

v2. Add missing close if fdopendir fails.
---
 tools/perf/util/pmu.c  | 35 ++++++++++++++++-------------------
 tools/perf/util/pmus.c | 37 ++++++++++++++++++++++++++++++++++++-
 tools/perf/util/pmus.h |  1 +
 3 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6142e4710a2f..963c12f910c5 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -741,9 +741,11 @@ static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
 }
 
 struct pmu_add_cpu_aliases_map_data {
+	/* List being added to. */
 	struct list_head *head;
-	const char *name;
-	const char *cpu_name;
+	/* If a pmu_event lacks a given PMU the default used. */
+	char *default_pmu_name;
+	/* The PMU that we're searching for events for. */
 	struct perf_pmu *pmu;
 };
 
@@ -752,37 +754,32 @@ static int pmu_add_cpu_aliases_map_callback(const struct pmu_event *pe,
 					void *vdata)
 {
 	struct pmu_add_cpu_aliases_map_data *data = vdata;
-	const char *pname = pe->pmu ? pe->pmu : data->cpu_name;
+	const char *pname = pe->pmu ?: data->default_pmu_name;
 
-	if (data->pmu->is_uncore && pmu_uncore_alias_match(pname, data->name))
-		goto new_alias;
-
-	if (strcmp(pname, data->name))
-		return 0;
-
-new_alias:
-	/* need type casts to override 'const' */
-	__perf_pmu__new_alias(data->head, -1, (char *)pe->name, (char *)pe->desc,
-			      (char *)pe->event, pe);
+	if (!strcmp(pname, data->pmu->name) ||
+	    (data->pmu->is_uncore && pmu_uncore_alias_match(pname, data->pmu->name))) {
+		/* need type casts to override 'const' */
+		__perf_pmu__new_alias(data->head, -1, (char *)pe->name, (char *)pe->desc,
+				      (char *)pe->event, pe);
+	}
 	return 0;
 }
 
 /*
- * From the pmu_events_map, find the table of PMU events that corresponds
- * to the current running CPU. Then, add all PMU events from that table
- * as aliases.
+ * From the pmu_events_table, find the events that correspond to the given
+ * PMU and add them to the list 'head'.
  */
 void pmu_add_cpu_aliases_table(struct list_head *head, struct perf_pmu *pmu,
-			       const struct pmu_events_table *table)
+			const struct pmu_events_table *table)
 {
 	struct pmu_add_cpu_aliases_map_data data = {
 		.head = head,
-		.name = pmu->name,
-		.cpu_name = is_sysfs_pmu_core(pmu->name) ? pmu->name : "cpu",
+		.default_pmu_name = perf_pmus__default_pmu_name(),
 		.pmu = pmu,
 	};
 
 	pmu_events_table_for_each_event(table, pmu_add_cpu_aliases_map_callback, &data);
+	free(data.default_pmu_name);
 }
 
 static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index d891d72c824e..0866dee3fc62 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -137,8 +137,10 @@ static void pmu_read_sysfs(bool core_only)
 		return;
 
 	dir = fdopendir(fd);
-	if (!dir)
+	if (!dir) {
+		close(fd);
 		return;
+	}
 
 	while ((dent = readdir(dir))) {
 		if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
@@ -524,6 +526,39 @@ bool perf_pmus__supports_extended_type(void)
 	return perf_pmus__do_support_extended_type;
 }
 
+char *perf_pmus__default_pmu_name(void)
+{
+	int fd;
+	DIR *dir;
+	struct dirent *dent;
+	char *result = NULL;
+
+	if (!list_empty(&core_pmus))
+		return strdup(list_first_entry(&core_pmus, struct perf_pmu, list)->name);
+
+	fd = perf_pmu__event_source_devices_fd();
+	if (fd < 0)
+		return strdup("cpu");
+
+	dir = fdopendir(fd);
+	if (!dir) {
+		close(fd);
+		return strdup("cpu");
+	}
+
+	while ((dent = readdir(dir))) {
+		if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, ".."))
+			continue;
+		if (is_pmu_core(dent->d_name)) {
+			result = strdup(dent->d_name);
+			break;
+		}
+	}
+
+	closedir(dir);
+	return result ?: strdup("cpu");
+}
+
 struct perf_pmu *evsel__find_pmu(const struct evsel *evsel)
 {
 	struct perf_pmu *pmu = evsel->pmu;
diff --git a/tools/perf/util/pmus.h b/tools/perf/util/pmus.h
index d02ffea5d3a4..a21464432d0f 100644
--- a/tools/perf/util/pmus.h
+++ b/tools/perf/util/pmus.h
@@ -20,5 +20,6 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 bool perf_pmus__have_event(const char *pname, const char *name);
 int perf_pmus__num_core_pmus(void);
 bool perf_pmus__supports_extended_type(void);
+char *perf_pmus__default_pmu_name(void);
 
 #endif /* __PMUS_H */
-- 
2.41.0.162.gfafddb0af9-goog

