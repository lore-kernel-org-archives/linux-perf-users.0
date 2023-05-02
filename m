Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A8EC19F20
	for <linux-perf-users@archiver.kernel.org>; Tue,  2 May 2023 22:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjEBWqy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 2 May 2023 18:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjEBWqa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 2 May 2023 18:46:30 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EE710E5
        for <linux-perf-users@vger.kernel.org>; Tue,  2 May 2023 15:45:57 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-55a04468981so75142757b3.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 May 2023 15:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683067466; x=1685659466;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vEgpbeTkYS2FHMjnmLxMSY6ngIlZOzdEJwjzo/4s4WU=;
        b=zDU+pSASufVWghTYSMWfCyp/NuoaY2uQPb+xbqo7jEZTf7q7rUzRObbNa7nozh1B2D
         pkt/qAks76U+MY4r6KseH/YAc5wsapS3QnBAN4/TSloJEvXH89nfsvdX/4lU2T3xwWcE
         1i901RXh6ZFLx1iieyfVXKQA0ZgaSlU8Cjb92d+HGxt4a/Jm8GRu5DeGoLEoeDFmF1Vb
         GHL64DQ+m7S1qh+hTiwZGSvl8AW0BnM6n8eFJ6fe4m/wlCbI8Q1TCLutM327SU0r3Uac
         X+SFjSRfSlvPBypkPBxqVP/6qqxDOGN1mhkOicx1Gx1DcJzzaZ5GwpxkMNxDppnjLBvE
         81oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683067466; x=1685659466;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEgpbeTkYS2FHMjnmLxMSY6ngIlZOzdEJwjzo/4s4WU=;
        b=BCcHzr7uTPWwxqKEj098POWGlVSXPSzNT5agYDj2a0Y3IwmYzqNsk+d774V7f6i0uj
         +wYqikeeMkYVZosi4DsvC4HehTSseMrr6MOnLo3qxjs9x/AbCV6uXOvO2bX5MBqpnqHz
         tkxL560DDwjZvZUqRI2dBppocSUXQhrLFP1zzdh4jPAyyMGqV8dQFqc3mdVbs7QiGzOK
         PHS6zfoFSnNmILbQIcMieBtheZbFo5Vn14nEcYvKem4yuTcgKdgIYJf/qIDv4HyIoYZj
         utm8JUj+RlJZpbl3VVTSVa7F5/lvi5qzYx3K62pl6iSvCY2lzp0lk8xTMXeu6aAg1Ioo
         RW6w==
X-Gm-Message-State: AC+VfDyMfX/VDRI2kdu6/cB+Fr9vKeAlSVAAiZeZjK0y6dAQoVVArmw7
        YT4deDkCVlEBNYswWTiAXGUSTWPcAH+H
X-Google-Smtp-Source: ACHHUZ7iAK7rWgSBX+DL5Qb5w89koRRW8YSxJzIwr8QMxTu7l35yOhMQy7ytDbOexlY9ioNBFJwmz0SHhJO1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e70c:446b:d23b:982e])
 (user=irogers job=sendgmr) by 2002:a81:a745:0:b0:545:f7cc:f30 with SMTP id
 e66-20020a81a745000000b00545f7cc0f30mr11393988ywh.0.1683067466155; Tue, 02
 May 2023 15:44:26 -0700 (PDT)
Date:   Tue,  2 May 2023 15:38:51 -0700
In-Reply-To: <20230502223851.2234828-1-irogers@google.com>
Message-Id: <20230502223851.2234828-45-irogers@google.com>
Mime-Version: 1.0
References: <20230502223851.2234828-1-irogers@google.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Subject: [PATCH v4 44/44] perf parse-events: Reduce scope of is_event_supported
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ahmad Yasin <ahmad.yasin@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Weilin Wang <weilin.wang@intel.com>,
        Edward Baker <edward.baker@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Kang Minchul <tegongkang@gmail.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Move to print-events.c and make static.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.c | 39 ----------------------------------
 tools/perf/util/parse-events.h |  2 --
 tools/perf/util/print-events.c | 39 ++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 41 deletions(-)

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 2dad88a6bf19..b93264f8a37c 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -28,7 +28,6 @@
 #include "util/bpf-filter.h"
 #include "util/util.h"
 #include "tracepoint.h"
-#include "thread_map.h"
 
 #define MAX_NAME_LEN 100
 
@@ -133,44 +132,6 @@ struct event_symbol event_symbols_sw[PERF_COUNT_SW_MAX] = {
 	},
 };
 
-bool is_event_supported(u8 type, u64 config)
-{
-	bool ret = true;
-	int open_return;
-	struct evsel *evsel;
-	struct perf_event_attr attr = {
-		.type = type,
-		.config = config,
-		.disabled = 1,
-	};
-	struct perf_thread_map *tmap = thread_map__new_by_tid(0);
-
-	if (tmap == NULL)
-		return false;
-
-	evsel = evsel__new(&attr);
-	if (evsel) {
-		open_return = evsel__open(evsel, NULL, tmap);
-		ret = open_return >= 0;
-
-		if (open_return == -EACCES) {
-			/*
-			 * This happens if the paranoid value
-			 * /proc/sys/kernel/perf_event_paranoid is set to 2
-			 * Re-run with exclude_kernel set; we don't do that
-			 * by default as some ARM machines do not support it.
-			 *
-			 */
-			evsel->core.attr.exclude_kernel = 1;
-			ret = evsel__open(evsel, NULL, tmap) >= 0;
-		}
-		evsel__delete(evsel);
-	}
-
-	perf_thread_map__put(tmap);
-	return ret;
-}
-
 const char *event_type(int type)
 {
 	switch (type) {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 2a8cafe0ee8f..2021fe145410 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -18,8 +18,6 @@ struct parse_events_error;
 struct option;
 struct perf_pmu;
 
-bool is_event_supported(u8 type, u64 config);
-
 const char *event_type(int type);
 
 /* Arguments encoded in opt->value. */
diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
index d148842b205a..69492cbd6921 100644
--- a/tools/perf/util/print-events.c
+++ b/tools/perf/util/print-events.c
@@ -27,6 +27,7 @@
 #include "tracepoint.h"
 #include "pfm.h"
 #include "pmu-hybrid.h"
+#include "thread_map.h"
 
 #define MAX_NAME_LEN 100
 
@@ -228,6 +229,44 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
 	strlist__delete(sdtlist);
 }
 
+static bool is_event_supported(u8 type, u64 config)
+{
+	bool ret = true;
+	int open_return;
+	struct evsel *evsel;
+	struct perf_event_attr attr = {
+		.type = type,
+		.config = config,
+		.disabled = 1,
+	};
+	struct perf_thread_map *tmap = thread_map__new_by_tid(0);
+
+	if (tmap == NULL)
+		return false;
+
+	evsel = evsel__new(&attr);
+	if (evsel) {
+		open_return = evsel__open(evsel, NULL, tmap);
+		ret = open_return >= 0;
+
+		if (open_return == -EACCES) {
+			/*
+			 * This happens if the paranoid value
+			 * /proc/sys/kernel/perf_event_paranoid is set to 2
+			 * Re-run with exclude_kernel set; we don't do that
+			 * by default as some ARM machines do not support it.
+			 *
+			 */
+			evsel->core.attr.exclude_kernel = 1;
+			ret = evsel__open(evsel, NULL, tmap) >= 0;
+		}
+		evsel__delete(evsel);
+	}
+
+	perf_thread_map__put(tmap);
+	return ret;
+}
+
 int print_hwcache_events(const struct print_callbacks *print_cb, void *print_state)
 {
 	struct perf_pmu *pmu = NULL;
-- 
2.40.1.495.gc816e09b53d-goog

