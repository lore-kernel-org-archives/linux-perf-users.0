Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90102C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E1F6115A
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240015AbhKHNoS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:44:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31861 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240036AbhKHNoR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sLHdwI6aRS5+OsYg6n/ciz89T1xalYY0rhVDigJgVvs=;
        b=YTYK7+JUTlheKZWLHnjrt+15cJzTKzKk6Gy4R5Lzv4krCjsIZPHLFjlRqQBYTxXyBCGjkX
        kUv38KJYVG/HnXmB+KQfEPRax5PWR2z0jq9hGbWps/fvm+09DLacJtnYJAaEqketVwbQiN
        s9w4aSC7sLdXlk5wNN0UQxW4FQjm24s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-b4KwqelYPReNOCcKvnEhTA-1; Mon, 08 Nov 2021 08:41:32 -0500
X-MC-Unique: b4KwqelYPReNOCcKvnEhTA-1
Received: by mail-wm1-f71.google.com with SMTP id k25-20020a05600c1c9900b00332f798ba1dso10172228wms.4
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:41:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sLHdwI6aRS5+OsYg6n/ciz89T1xalYY0rhVDigJgVvs=;
        b=P301NuNQIkxrB/QgigZ5BSXSsJBC06LheosuQPlbUAVHdKtH/PnL2CXPTp+kITMVXA
         PQGxA18vTFNfdHLCDrC/RSQES2KrmTo6Y+LPehc5EmsBnKKf5JHAxKHjms1AlSjZ4Rgo
         wFdxHD36Xby//MYD09GaohTvJkg4DkXg3qeCxaBJTH+WPbNM4AagOxVOJJ9ZxAcYQUt4
         F9rvXZKdYh0yJZNk54qFELNOcS4aUh8nwFdhx+E/A7xAMNVFTi7WxAvZhsPld2+OOnoQ
         PYn0rU/M+VZe2rwAno+mmqdiuPiKYStu+gts1FccEv3295+Hx5p9wmPz5KcufhZHl5dl
         7fBA==
X-Gm-Message-State: AOAM530B4T7IZU+ToX6llSV9KDktMqXrKu+27weJa5fd+01bRNrl8DR4
        rPzlqyusB4OmtZy/m68tE95FcdCbIFD9jQQdHhAZfs4b8HsSRw682lNUw82yFy1aGVlYQPS0Uul
        KKTbPGtAZwPgSLz87cXGHtbWiHHPnMg==
X-Received: by 2002:adf:a1d4:: with SMTP id v20mr58478754wrv.190.1636378890587;
        Mon, 08 Nov 2021 05:41:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLHSDhXHwv0y0dEttMH9QMMmduTkK12ArHpj3h8NeJBmaz9+0uHnb0QSRWob4IGK9SB/BkPg==
X-Received: by 2002:adf:a1d4:: with SMTP id v20mr58478742wrv.190.1636378890432;
        Mon, 08 Nov 2021 05:41:30 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id k21sm15987801wmj.45.2021.11.08.05.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:41:30 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 42/59] libperf: Move in parse_events_name function
Date:   Mon,  8 Nov 2021 14:36:53 +0100
Message-Id: <20211108133710.1352822-43-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving parse_events_name function to libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/parse-events.h |  1 +
 tools/lib/perf/parse-events.c                  | 12 ++++++++++++
 tools/perf/util/parse-events.c                 | 12 ------------
 tools/perf/util/parse-events.h                 |  1 -
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index 1d7ee03b8a80..11a85a118480 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -137,4 +137,5 @@ void parse_events__handle_error(struct parse_events_error *err, int idx,
 				char *str, char *help);
 void parse_events_evlist_error(struct parse_events_state *parse_state,
 			       int idx, const char *str);
+int parse_events_name(struct list_head *list, const char *name);
 #endif /* __LIBPERF_PARSE_EVENTS_H */
diff --git a/tools/lib/perf/parse-events.c b/tools/lib/perf/parse-events.c
index 07c89a3601b1..6efc2bb73cdf 100644
--- a/tools/lib/perf/parse-events.c
+++ b/tools/lib/perf/parse-events.c
@@ -580,3 +580,15 @@ void parse_events_evlist_error(struct parse_events_state *parse_state,
 
 	parse_events__handle_error(parse_state->error, idx, strdup(str), NULL);
 }
+
+int parse_events_name(struct list_head *list, const char *name)
+{
+	struct perf_evsel *evsel;
+
+	__perf_evlist__for_each_entry(list, evsel) {
+		if (!evsel->name)
+			evsel->name = strdup(name);
+	}
+
+	return 0;
+}
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0f2bf2b48888..1469bdf88f2b 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -1721,18 +1721,6 @@ void parse_events__set_leader(char *name, struct list_head *list,
 	leader->core.group_name = name ? strdup(name) : NULL;
 }
 
-int parse_events_name(struct list_head *list, const char *name)
-{
-	struct evsel *evsel;
-
-	__evlist__for_each_entry(list, evsel) {
-		if (!evsel->core.name)
-			evsel->core.name = strdup(name);
-	}
-
-	return 0;
-}
-
 static int
 comp_pmu(const void *p1, const void *p2)
 {
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index cc7c6449d423..5530614e7a10 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -63,7 +63,6 @@ struct perf_pmu_event_symbol {
 
 void parse_events__shrink_config_terms(void);
 void parse_events__clear_array(struct parse_events_array *a);
-int parse_events_name(struct list_head *list, const char *name);
 int parse_events_add_tracepoint(struct parse_events_state *parse_state,
 				struct list_head *list,
 				const char *sys, const char *event,
-- 
2.31.1

