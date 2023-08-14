Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3FCDC04FDF
	for <linux-perf-users@archiver.kernel.org>; Mon, 14 Aug 2023 16:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjHNQiR (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 14 Aug 2023 12:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjHNQiI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 14 Aug 2023 12:38:08 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0234AA8
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2023 09:38:08 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d66d85403f5so4210815276.2
        for <linux-perf-users@vger.kernel.org>; Mon, 14 Aug 2023 09:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692031087; x=1692635887;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=igst4mk2Qe0yy+cOTE8q+SB7QjnlDxT/LagI8IxyHvs=;
        b=Cg7MCoQRuNdld7xCqa7bytZ8lmwbE26tEsLWyUL2QSRJC2JRmm5fWDi9RxftN4na0G
         thkDV/wLONNXNYcsp8QBsUiOr9w+ewWT2hEQkgOebp9Yl5ngIiB4tX+SRUarU0xTiSXZ
         1TjnzjbP0FELbaHdqCZ+RtYA3ufrMN3KULk3/cc05YTkUnWOeJ4LimKJxGftR01rdwZx
         VNbIJQq3bXpOVRecztpIED99ADOg+XULA4+sIIN2HQ2zQe5/kuBvzAWUyj4HpA23zoXN
         aCar0jwy9gQYWUyWs6Nd1nzWvJHr1RESaI/5mwrlzWx9iLwmGlF0Kg1JPIwQwgEET8iH
         0eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692031087; x=1692635887;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igst4mk2Qe0yy+cOTE8q+SB7QjnlDxT/LagI8IxyHvs=;
        b=RTY0SjNx8fDqIicsNdkbNMhWSFCe17CruyP/L63X4ZvLin1+DZ0RE5p5KzZd/beDA/
         pf5IKECst8eLFx1Ufl6WEmUJ8cmZfwq64a+8bvgcQRJPBuJ6HXTeRm+s2B3JZYBSC0SP
         BUsCOCl+24NybeQd1iie2GSW2Ppe9acehXC9B7pTl9V/TgnOlUrnEVXHC8RC1YB7V0vU
         5OBZjwjei17fBHL9qtdMY9PNaKv88CUiKu5eUii1sUdGWmqskMLfc+vaokjrJiiy5oLS
         GZMtu7gvMiwGkVNUZwDrXJQvz8Ssnh/h97lSkdYdNCSvwTAOyPMPLDrXlcGH0uNCfkEv
         atew==
X-Gm-Message-State: AOJu0YwQ+2L157n6duaurw9ouP2LzeP8H78NUogrwTrf99epQ5DM2RME
        UW6MFa2w3ipU1r/uvrjJ8taWkvIQ5zR7
X-Google-Smtp-Source: AGHT+IGY085eR7sAPeFw2Vv2wVsPZoEMHrzUEnpYB0pv6wew4vvJ+t0oIZrJHInKhW9izPUdoejmhtgVEAGj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a919:6125:510f:f0ef])
 (user=irogers job=sendgmr) by 2002:a25:abcf:0:b0:d45:1b81:1154 with SMTP id
 v73-20020a25abcf000000b00d451b811154mr133130ybi.2.1692031087237; Mon, 14 Aug
 2023 09:38:07 -0700 (PDT)
Date:   Mon, 14 Aug 2023 09:37:56 -0700
In-Reply-To: <20230814163757.3077138-1-irogers@google.com>
Message-Id: <20230814163757.3077138-3-irogers@google.com>
Mime-Version: 1.0
References: <20230814163757.3077138-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Subject: [PATCH v3 2/3] perf pmus: Add scan that ignores duplicates, use for
 perf list
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
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When there are multiple PMUs that differ only by suffix, by default
just list the first one and skip all others. As the PMUs are sorted,
the scan routine checks that the PMU names match and the numbers are
consecutive. If "-v" is passed to "perf list" then list all PMUs.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-list.c      |  8 +++++
 tools/perf/util/pmus.c         | 54 ++++++++++++++++++++++++++++++++--
 tools/perf/util/print-events.h |  1 +
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index 7fec2cca759f..8fe4ddf02c14 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -423,6 +423,13 @@ static void json_print_metric(void *ps __maybe_unused, const char *group,
 	strbuf_release(&buf);
 }
 
+static bool default_skip_duplicate_pmus(void *ps)
+{
+	struct print_state *print_state = ps;
+
+	return !print_state->long_desc;
+}
+
 int cmd_list(int argc, const char **argv)
 {
 	int i, ret = 0;
@@ -434,6 +441,7 @@ int cmd_list(int argc, const char **argv)
 		.print_end = default_print_end,
 		.print_event = default_print_event,
 		.print_metric = default_print_metric,
+		.skip_duplicate_pmus = default_skip_duplicate_pmus,
 	};
 	const char *cputype = NULL;
 	const char *unit_name = NULL;
diff --git a/tools/perf/util/pmus.c b/tools/perf/util/pmus.c
index 3581710667b0..5073843aca19 100644
--- a/tools/perf/util/pmus.c
+++ b/tools/perf/util/pmus.c
@@ -275,6 +275,50 @@ struct perf_pmu *perf_pmus__scan_core(struct perf_pmu *pmu)
 	return NULL;
 }
 
+static struct perf_pmu *perf_pmus__scan_skip_duplicates(struct perf_pmu *pmu)
+{
+	bool use_core_pmus = !pmu || pmu->is_core;
+	int last_pmu_name_len = 0;
+	unsigned long last_pmu_num = 0;
+	const char *last_pmu_name = (pmu && pmu->name) ? pmu->name : "";
+
+	if (!pmu) {
+		pmu_read_sysfs(/*core_only=*/false);
+		pmu = list_prepare_entry(pmu, &core_pmus, list);
+	} else
+		last_pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", &last_pmu_num);
+
+	if (use_core_pmus) {
+		list_for_each_entry_continue(pmu, &core_pmus, list) {
+			unsigned long pmu_num = 0;
+			int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", &pmu_num);
+
+			if (last_pmu_name_len == pmu_name_len &&
+			    (last_pmu_num + 1 == pmu_num) &&
+			    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len)) {
+				last_pmu_num++;
+				continue;
+			}
+			return pmu;
+		}
+		pmu = NULL;
+		pmu = list_prepare_entry(pmu, &other_pmus, list);
+	}
+	list_for_each_entry_continue(pmu, &other_pmus, list) {
+		unsigned long pmu_num = 0;
+		int pmu_name_len = pmu_name_len_no_suffix(pmu->name ?: "", &pmu_num);
+
+		if (last_pmu_name_len == pmu_name_len &&
+		    (last_pmu_num + 1 == pmu_num) &&
+		    !strncmp(last_pmu_name, pmu->name ?: "", pmu_name_len)) {
+			last_pmu_num++;
+			continue;
+		}
+		return pmu;
+	}
+	return NULL;
+}
+
 const struct perf_pmu *perf_pmus__pmu_for_pmu_filter(const char *str)
 {
 	struct perf_pmu *pmu = NULL;
@@ -429,10 +473,16 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 	int printed = 0;
 	int len, j;
 	struct sevent *aliases;
+	struct perf_pmu *(*scan_fn)(struct perf_pmu *);
+
+	if (print_cb->skip_duplicate_pmus(print_state))
+		scan_fn = perf_pmus__scan_skip_duplicates;
+	else
+		scan_fn = perf_pmus__scan;
 
 	pmu = NULL;
 	len = 0;
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+	while ((pmu = scan_fn(pmu)) != NULL) {
 		list_for_each_entry(event, &pmu->aliases, list)
 			len++;
 		if (pmu->selectable)
@@ -445,7 +495,7 @@ void perf_pmus__print_pmu_events(const struct print_callbacks *print_cb, void *p
 	}
 	pmu = NULL;
 	j = 0;
-	while ((pmu = perf_pmus__scan(pmu)) != NULL) {
+	while ((pmu = scan_fn(pmu)) != NULL) {
 		bool is_cpu = pmu->is_core;
 
 		list_for_each_entry(event, &pmu->aliases, list) {
diff --git a/tools/perf/util/print-events.h b/tools/perf/util/print-events.h
index d7fab411e75c..bf4290bef0cd 100644
--- a/tools/perf/util/print-events.h
+++ b/tools/perf/util/print-events.h
@@ -26,6 +26,7 @@ struct print_callbacks {
 			const char *expr,
 			const char *threshold,
 			const char *unit);
+	bool (*skip_duplicate_pmus)(void *print_state);
 };
 
 /** Print all events, the default when no options are specified. */
-- 
2.41.0.640.ga95def55d0-goog

