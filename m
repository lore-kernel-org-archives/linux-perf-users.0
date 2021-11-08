Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 260A5C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F79961406
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238677AbhKHNmo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:42:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44872 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238641AbhKHNmn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:42:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YkYaHDMvVxV3csCa/7K94EwJILtJssXKQPTtFh6EJUM=;
        b=VGzsFPAPiI7V2bGT6VyPbhyZ9igH6fUjvE99b7UzhrAnI9eyZAT8mdStvMEPU9aVea5/Y5
        JFxBC99JgylblsruA2FD9V4iBCbz2JNMgw74kNqIlijV7eQg6aB6cRsV4a1hgRT89JXCqY
        lghSOi0h4a2cPOAjNwbjr2CfEhJBiJI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-600-jHxTbu-tNkebHX8gv4W8WQ-1; Mon, 08 Nov 2021 08:39:57 -0500
X-MC-Unique: jHxTbu-tNkebHX8gv4W8WQ-1
Received: by mail-wm1-f71.google.com with SMTP id l6-20020a05600c4f0600b0033321934a39so2036395wmq.9
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YkYaHDMvVxV3csCa/7K94EwJILtJssXKQPTtFh6EJUM=;
        b=e0ovnjuV1ncUiTpKh48I9GtBiDYRHu5QMGAaRl05h+1NgE5o67UVZODuqIDba9AnKq
         q7tqqgw1Sj6QzyghAlYiKW0AvrmgiYQA72+6IO4WEht4P+db4tGJU5hAHStY7wvxKby/
         Xo4x7+cJS/j6EE7uP9/hOLaRMXMY6HRbkKl9gH3ThDvgK7ZpJ1YiXwrBghDxmcUk21/i
         c+/BjdqqI/1cfQZxhUW7CDa+oNazzgwpefOCUZy/IbW/4XUT2ibjuVW9KxkAUDeHyo0/
         xcJjCDxP/AYLqxR4zgMwFoWQQZlOGD8VzbwZUxpT/0xKjG7gcljFUPIqUM6/64+hd3oH
         03vw==
X-Gm-Message-State: AOAM530tCu/WmPRZ6/fexz65u6YrdFbeqDKCl5T+toag4Z5z3OKLwvTR
        fls9xGHbfZ7r0YsgLCEwvQUgjdFPWucky6W0nlLg1F1VOt0/jVzcaMijC9dQcx2CJJpe4mH8DcP
        KcbLKio41yMan8d9hgremvr9MxG0r5A==
X-Received: by 2002:a5d:508d:: with SMTP id a13mr55671804wrt.41.1636378796165;
        Mon, 08 Nov 2021 05:39:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgoy+W7AnADvGdlYSsaXVVAXiUVBUgeuaHXgzWUHOx0Z0Ms0RbWAq/IBta/pW8ngJ1/yqNeA==
X-Received: by 2002:a5d:508d:: with SMTP id a13mr55671788wrt.41.1636378795977;
        Mon, 08 Nov 2021 05:39:55 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id z6sm19847736wmp.1.2021.11.08.05.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:39:55 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 26/59] libperf: Move in the event_symbols_hw/event_symbols_sw
Date:   Mon,  8 Nov 2021 14:36:37 +0100
Message-Id: <20211108133710.1352822-27-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving event_symbols_hw/event_symbols_sw to libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/Build                          |  1 +
 .../lib/perf/include/internal/parse-events.h  | 12 +++
 tools/lib/perf/parse-events.c                 | 99 +++++++++++++++++++
 tools/perf/util/parse-events.c                | 94 ------------------
 tools/perf/util/parse-events.h                |  6 --
 5 files changed, 112 insertions(+), 100 deletions(-)
 create mode 100644 tools/lib/perf/include/internal/parse-events.h
 create mode 100644 tools/lib/perf/parse-events.c

diff --git a/tools/lib/perf/Build b/tools/lib/perf/Build
index 006a9bef9566..af4663e4421f 100644
--- a/tools/lib/perf/Build
+++ b/tools/lib/perf/Build
@@ -11,6 +11,7 @@ libperf-y += pmu-flex.o
 libperf-y += pmu-bison.o
 libperf-y += pmu.o
 libperf-y += pmu-hybrid.o
+libperf-y += parse-events.o
 
 $(OUTPUT)zalloc.o: ../../lib/zalloc.c FORCE
 	$(call rule_mkdir)
diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
new file mode 100644
index 000000000000..cf7cc117c497
--- /dev/null
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LIBPERF_PARSE_EVENTS_H
+#define __LIBPERF_PARSE_EVENTS_H
+
+struct event_symbol {
+	const char	*symbol;
+	const char	*alias;
+};
+extern struct event_symbol event_symbols_hw[];
+extern struct event_symbol event_symbols_sw[];
+
+#endif /* __LIBPERF_PARSE_EVENTS_H */
diff --git a/tools/lib/perf/parse-events.c b/tools/lib/perf/parse-events.c
new file mode 100644
index 000000000000..92b552b0a91a
--- /dev/null
+++ b/tools/lib/perf/parse-events.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <internal/parse-events.h>
+#include <linux/perf_event.h>
+
+struct event_symbol event_symbols_hw[PERF_COUNT_HW_MAX] = {
+	[PERF_COUNT_HW_CPU_CYCLES] = {
+		.symbol = "cpu-cycles",
+		.alias  = "cycles",
+	},
+	[PERF_COUNT_HW_INSTRUCTIONS] = {
+		.symbol = "instructions",
+		.alias  = "",
+	},
+	[PERF_COUNT_HW_CACHE_REFERENCES] = {
+		.symbol = "cache-references",
+		.alias  = "",
+	},
+	[PERF_COUNT_HW_CACHE_MISSES] = {
+		.symbol = "cache-misses",
+		.alias  = "",
+	},
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = {
+		.symbol = "branch-instructions",
+		.alias  = "branches",
+	},
+	[PERF_COUNT_HW_BRANCH_MISSES] = {
+		.symbol = "branch-misses",
+		.alias  = "",
+	},
+	[PERF_COUNT_HW_BUS_CYCLES] = {
+		.symbol = "bus-cycles",
+		.alias  = "",
+	},
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = {
+		.symbol = "stalled-cycles-frontend",
+		.alias  = "idle-cycles-frontend",
+	},
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = {
+		.symbol = "stalled-cycles-backend",
+		.alias  = "idle-cycles-backend",
+	},
+	[PERF_COUNT_HW_REF_CPU_CYCLES] = {
+		.symbol = "ref-cycles",
+		.alias  = "",
+	},
+};
+
+struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
+	[PERF_COUNT_SW_CPU_CLOCK] = {
+		.symbol = "cpu-clock",
+		.alias  = "",
+	},
+	[PERF_COUNT_SW_TASK_CLOCK] = {
+		.symbol = "task-clock",
+		.alias  = "",
+	},
+	[PERF_COUNT_SW_PAGE_FAULTS] = {
+		.symbol = "page-faults",
+		.alias  = "faults",
+	},
+	[PERF_COUNT_SW_CONTEXT_SWITCHES] = {
+		.symbol = "context-switches",
+		.alias  = "cs",
+	},
+	[PERF_COUNT_SW_CPU_MIGRATIONS] = {
+		.symbol = "cpu-migrations",
+		.alias  = "migrations",
+	},
+	[PERF_COUNT_SW_PAGE_FAULTS_MIN] = {
+		.symbol = "minor-faults",
+		.alias  = "",
+	},
+	[PERF_COUNT_SW_PAGE_FAULTS_MAJ] = {
+		.symbol = "major-faults",
+		.alias  = "",
+	},
+	[PERF_COUNT_SW_ALIGNMENT_FAULTS] = {
+		.symbol = "alignment-faults",
+		.alias  = "",
+	},
+	[PERF_COUNT_SW_EMULATION_FAULTS] = {
+		.symbol = "emulation-faults",
+		.alias  = "",
+	},
+	[PERF_COUNT_SW_DUMMY] = {
+		.symbol = "dummy",
+		.alias  = "",
+	},
+	[PERF_COUNT_SW_BPF_OUTPUT] = {
+		.symbol = "bpf-output",
+		.alias  = "",
+	},
+	[PERF_COUNT_SW_CGROUP_SWITCHES] = {
+		.symbol = "cgroup-switches",
+		.alias  = "",
+	},
+};
+
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c36657d906ce..1c62b2c31832 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -60,100 +60,6 @@ static struct perf_pmu_event_symbol *perf_pmu_events_list;
  */
 static int perf_pmu_events_list_num;
 
-struct event_symbol event_symbols_hw[PERF_COUNT_HW_MAX] = {
-	[PERF_COUNT_HW_CPU_CYCLES] = {
-		.symbol = "cpu-cycles",
-		.alias  = "cycles",
-	},
-	[PERF_COUNT_HW_INSTRUCTIONS] = {
-		.symbol = "instructions",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_CACHE_REFERENCES] = {
-		.symbol = "cache-references",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_CACHE_MISSES] = {
-		.symbol = "cache-misses",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = {
-		.symbol = "branch-instructions",
-		.alias  = "branches",
-	},
-	[PERF_COUNT_HW_BRANCH_MISSES] = {
-		.symbol = "branch-misses",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_BUS_CYCLES] = {
-		.symbol = "bus-cycles",
-		.alias  = "",
-	},
-	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = {
-		.symbol = "stalled-cycles-frontend",
-		.alias  = "idle-cycles-frontend",
-	},
-	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = {
-		.symbol = "stalled-cycles-backend",
-		.alias  = "idle-cycles-backend",
-	},
-	[PERF_COUNT_HW_REF_CPU_CYCLES] = {
-		.symbol = "ref-cycles",
-		.alias  = "",
-	},
-};
-
-struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
-	[PERF_COUNT_SW_CPU_CLOCK] = {
-		.symbol = "cpu-clock",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_TASK_CLOCK] = {
-		.symbol = "task-clock",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_PAGE_FAULTS] = {
-		.symbol = "page-faults",
-		.alias  = "faults",
-	},
-	[PERF_COUNT_SW_CONTEXT_SWITCHES] = {
-		.symbol = "context-switches",
-		.alias  = "cs",
-	},
-	[PERF_COUNT_SW_CPU_MIGRATIONS] = {
-		.symbol = "cpu-migrations",
-		.alias  = "migrations",
-	},
-	[PERF_COUNT_SW_PAGE_FAULTS_MIN] = {
-		.symbol = "minor-faults",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_PAGE_FAULTS_MAJ] = {
-		.symbol = "major-faults",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_ALIGNMENT_FAULTS] = {
-		.symbol = "alignment-faults",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_EMULATION_FAULTS] = {
-		.symbol = "emulation-faults",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_DUMMY] = {
-		.symbol = "dummy",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_BPF_OUTPUT] = {
-		.symbol = "bpf-output",
-		.alias  = "",
-	},
-	[PERF_COUNT_SW_CGROUP_SWITCHES] = {
-		.symbol = "cgroup-switches",
-		.alias  = "",
-	},
-};
-
 static struct parse_events_ops parse_state_ops = {
 	.evsel__new    = evsel__new_idx,
 	.evsel__new_tp = evsel__newtp_idx,
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 29ea37808d32..181bd72ade6b 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -233,12 +233,6 @@ void print_events(const char *event_glob, bool name_only, bool quiet,
 		  bool long_desc, bool details_flag, bool deprecated,
 		  const char *pmu_name);
 
-struct event_symbol {
-	const char	*symbol;
-	const char	*alias;
-};
-extern struct event_symbol event_symbols_hw[];
-extern struct event_symbol event_symbols_sw[];
 void print_symbol_events(const char *event_glob, unsigned type,
 				struct event_symbol *syms, unsigned max,
 				bool name_only);
-- 
2.31.1

