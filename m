Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E070CC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF64C6115A
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbhKHNoA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:44:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37365 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240015AbhKHNoA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3cS/cNCM/nYCOs3WlNMMi5gEDj1Lxyb8XgdkgsihzPw=;
        b=iSy7TifKUrMR+i5AaDc2pFcgBwvJZrJjQc5CNDRtMUvSv55rzaGW+p3XSc3i4xezpLZwkh
        hccC60DK95dlUBlMqd+U4FYrGfnt61gsI+nEfQz4tLrgtjbKYVv0Opjn6RIEFIuf7Xo+tX
        agRiCD6qjOiQ73JfS/SqxscF50qjtyI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-5rhKHs5YMm-2vspdcxQJHw-1; Mon, 08 Nov 2021 08:41:14 -0500
X-MC-Unique: 5rhKHs5YMm-2vspdcxQJHw-1
Received: by mail-wm1-f72.google.com with SMTP id v10-20020a1cf70a000000b00318203a6bd1so5770820wmh.6
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:41:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3cS/cNCM/nYCOs3WlNMMi5gEDj1Lxyb8XgdkgsihzPw=;
        b=wbIy9ZkbJGJZgUHV5N/HZcJhkqNi5tXn4/LbqwoY+kOUS/iJTjhPizNxVgh9viLcJO
         DsTt8/5u/AJqk1Modbs769s9Oh+ywxlrDsETYKycaJQBsW2LLsfwLWO/wLTBuxDCL+bT
         dffDt8YX/nLLInZIIi2oWX4kMTEFEDlxI52FlsHk0A85Rd3gt9gex6CvBakD5hRgE3OR
         JtNFFc/WS4YfcLRnTG9123Kx83DHUK/jF68CPeP3acDoX/paFTnPe9ZeB+NM1e2/Ol8y
         F/Smn1Bf51vHgpNGcFDtQ8oLgUXADpAS1sg1nkfkKBJzS+nhICviKySmu35fRb+dZtNi
         y2ZQ==
X-Gm-Message-State: AOAM530RGGgdiMfVlt7ozkKUBvc3VLut2ZCwXk4BgYcRf0SxI5WhwUeo
        eI4nZ5fTO7oc3vIKOZOvRyWM/jmAJ66Y5hb+SzzJ+wGEwxScvHywcwKsVmgl7vQLzqYpRa5wZbW
        uQel9tpFt5o4fw21X/cSt6MtSDSmqxA==
X-Received: by 2002:adf:f90a:: with SMTP id b10mr5136367wrr.255.1636378872878;
        Mon, 08 Nov 2021 05:41:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxe7HitAPdRHrgBTXqXGZLxz5mUULDmOWI99/zR3BTF67xhdAyXuJVs5WJuh6MdpLExWUndSQ==
X-Received: by 2002:adf:f90a:: with SMTP id b10mr5136343wrr.255.1636378872722;
        Mon, 08 Nov 2021 05:41:12 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id p19sm11379075wmq.4.2021.11.08.05.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:41:12 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 39/59] libperf: Move in parse_events__handle_error function
Date:   Mon,  8 Nov 2021 14:36:50 +0100
Message-Id: <20211108133710.1352822-40-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving parse_events__handle_error function to libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../lib/perf/include/internal/parse-events.h  |  2 ++
 tools/lib/perf/parse-events.c                 | 35 +++++++++++++++++++
 tools/perf/util/parse-events.c                | 33 -----------------
 tools/perf/util/parse-events.h                |  2 --
 4 files changed, 37 insertions(+), 35 deletions(-)

diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index 88195ae2eb10..9706ce11e2fd 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -132,4 +132,6 @@ perf_evsel__add_event(struct parse_events_state *parse_state,
 		      const char *cpu_list);
 int parse_events__modifier_event(struct list_head *list, char *str, bool add, bool guest);
 int parse_events__modifier_group(struct list_head *list, char *event_mod, bool guest);
+void parse_events__handle_error(struct parse_events_error *err, int idx,
+				char *str, char *help);
 #endif /* __LIBPERF_PARSE_EVENTS_H */
diff --git a/tools/lib/perf/parse-events.c b/tools/lib/perf/parse-events.c
index 3b93528f4569..d2d538f89ff9 100644
--- a/tools/lib/perf/parse-events.c
+++ b/tools/lib/perf/parse-events.c
@@ -11,6 +11,8 @@
 #include <perf/cpumap.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <asm/bug.h>
+#include "internal.h"
 
 struct event_symbol event_symbols_hw[PERF_COUNT_HW_MAX] = {
 	[PERF_COUNT_HW_CPU_CYCLES] = {
@@ -536,3 +538,36 @@ int parse_events__modifier_group(struct list_head *list,
 {
 	return parse_events__modifier_event(list, event_mod, true, guest);
 }
+
+void parse_events__handle_error(struct parse_events_error *err, int idx,
+				char *str, char *help)
+{
+	if (WARN(!str, "WARNING: failed to provide error string\n")) {
+		free(help);
+		return;
+	}
+	switch (err->num_errors) {
+	case 0:
+		err->idx = idx;
+		err->str = str;
+		err->help = help;
+		break;
+	case 1:
+		err->first_idx = err->idx;
+		err->idx = idx;
+		err->first_str = err->str;
+		err->str = str;
+		err->first_help = err->help;
+		err->help = help;
+		break;
+	default:
+		pr_debug("Multiple errors dropping message: %s (%s)\n",
+			err->str, err->help);
+		free(err->str);
+		err->str = str;
+		free(err->help);
+		err->help = help;
+		break;
+	}
+	err->num_errors++;
+}
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index ecbb7f284158..8cc29dd8743a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -116,39 +116,6 @@ static int tp_event_has_id(const char *dir_path, struct dirent *evt_dir)
 
 #define MAX_EVENT_LENGTH 512
 
-void parse_events__handle_error(struct parse_events_error *err, int idx,
-				char *str, char *help)
-{
-	if (WARN(!str, "WARNING: failed to provide error string\n")) {
-		free(help);
-		return;
-	}
-	switch (err->num_errors) {
-	case 0:
-		err->idx = idx;
-		err->str = str;
-		err->help = help;
-		break;
-	case 1:
-		err->first_idx = err->idx;
-		err->idx = idx;
-		err->first_str = err->str;
-		err->str = str;
-		err->first_help = err->help;
-		err->help = help;
-		break;
-	default:
-		pr_debug("Multiple errors dropping message: %s (%s)\n",
-			err->str, err->help);
-		free(err->str);
-		err->str = str;
-		free(err->help);
-		err->help = help;
-		break;
-	}
-	err->num_errors++;
-}
-
 struct tracepoint_path *tracepoint_id_to_path(u64 config)
 {
 	struct tracepoint_path *path = NULL;
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 78a8fa799b09..c058488ef8e2 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -61,8 +61,6 @@ struct perf_pmu_event_symbol {
 	enum perf_pmu_event_symbol_type	type;
 };
 
-void parse_events__handle_error(struct parse_events_error *err, int idx,
-				char *str, char *help);
 void parse_events__shrink_config_terms(void);
 void parse_events__clear_array(struct parse_events_array *a);
 int parse_events_name(struct list_head *list, const char *name);
-- 
2.31.1

