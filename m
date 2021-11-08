Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DB4C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 947DD61177
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240040AbhKHNpl (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:45:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41430 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240034AbhKHNpk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ca+A2uwQhZ3Z75pgRPF/8bW4tJBRkzq3E2gPmfUckbo=;
        b=bCpTA33yum0HbYDVemOPseOcp6SFex/qJ1MmUCyXbVcOXJy5T82g/ANKxAoaV1p1ga+59E
        iESovqThT7vcUEeF74ylW/V2WEDnPpIcEfNk9NuwvJEQilCcNpmQ4NswDrqk6oiatzkyjn
        o3ySs3ZwAQcIl7YccUjfNNOhlp+hfKw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-7uNzGKLwOvqvm-ZBRchtdg-1; Mon, 08 Nov 2021 08:42:54 -0500
X-MC-Unique: 7uNzGKLwOvqvm-ZBRchtdg-1
Received: by mail-wr1-f70.google.com with SMTP id r12-20020adfdc8c000000b0017d703c07c0so4067516wrj.0
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:42:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ca+A2uwQhZ3Z75pgRPF/8bW4tJBRkzq3E2gPmfUckbo=;
        b=fZ/qhlXPanyGtA+rQ17ygM1CTXo+ONipG7r4V7VMvTO+nf4qJ1Ad3msXrdfAtw8v9b
         o165/+YhQILg3vjihmOdqYii5XZn7y3sI5Om6RQQhse0mNzTlB2ZwPFARdu8n3aDZMDB
         rH2Ek+HMtsfNOBA3kSVaoCFH2mvhJzY+0/DeqJOUHaLhqe5pGWO9fD1sfHoXvf+Ajd3M
         WVMICgmmT4ruZy+ljZj9gywibvl3xHYGOpSkNzmmaKrhCTt8++1TSa9oGyJWWtUVUyCE
         Vs6RjeK2SeY2dtKhLIq4wGdb8o6x5eQbUd3Z1UvRKJaUQvp0LFqlTxJQFpD1p4nR36hw
         KjiQ==
X-Gm-Message-State: AOAM5333hc6wGVtlL4o/a2J2G/gVOvxgujjdJW/LyHcvZzK/t+U0tg8j
        7R/aflsGKj67QAd64SykkkAeoKEj5DvE2EU6CXLUvvOI0Et/OOD1lSM8w9bZyHxoI9cH0PeDGqQ
        HxmuTfOACyQunvT2KSV2yotW2Vjw5fQ==
X-Received: by 2002:a1c:20cc:: with SMTP id g195mr53123996wmg.42.1636378973545;
        Mon, 08 Nov 2021 05:42:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJlj2KnVwHykyhrRovjoysj1heBh7JoNsOWXrimblcurVJEreDqVKpeb5ZxVD3TWccRcNGgw==
X-Received: by 2002:a1c:20cc:: with SMTP id g195mr53123974wmg.42.1636378973401;
        Mon, 08 Nov 2021 05:42:53 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id u2sm17762439wrs.17.2021.11.08.05.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:42:53 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 56/59] libperf: Move in parse_events_add_breakpoint function
Date:   Mon,  8 Nov 2021 14:37:07 +0100
Message-Id: <20211108133710.1352822-57-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving parse_events_add_breakpoint function to libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../lib/perf/include/internal/parse-events.h  |  3 +
 tools/lib/perf/parse-events.c                 | 72 +++++++++++++++++++
 tools/perf/util/parse-events.c                | 70 ------------------
 3 files changed, 75 insertions(+), 70 deletions(-)

diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index 5020a1b2bff2..e6af1ad6e7ac 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -197,4 +197,7 @@ int parse_events_name(struct list_head *list, const char *name);
 int parse_events__scanner(const char *str,
 			  struct parse_events_state *parse_state,
 			  bool terms);
+int parse_events_add_breakpoint(struct parse_events_state *parse_state,
+				struct list_head *list,
+				u64 addr, char *type, u64 len);
 #endif /* __LIBPERF_PARSE_EVENTS_H */
diff --git a/tools/lib/perf/parse-events.c b/tools/lib/perf/parse-events.c
index da684023b273..1c1fbbeb7182 100644
--- a/tools/lib/perf/parse-events.c
+++ b/tools/lib/perf/parse-events.c
@@ -2,6 +2,7 @@
 
 #include <internal/parse-events.h>
 #include <linux/perf_event.h>
+#include <linux/hw_breakpoint.h>
 #include <linux/zalloc.h>
 #include <string.h>
 #include <internal/parse-events.h>
@@ -630,3 +631,74 @@ int parse_events__scanner(const char *str,
 	parse_events_lex_destroy(scanner);
 	return ret;
 }
+
+static int
+parse_breakpoint_type(const char *type, struct perf_event_attr *attr)
+{
+	int i;
+
+	for (i = 0; i < 3; i++) {
+		if (!type || !type[i])
+			break;
+
+#define CHECK_SET_TYPE(bit)		\
+do {					\
+	if (attr->bp_type & bit)	\
+		return -EINVAL;		\
+	else				\
+		attr->bp_type |= bit;	\
+} while (0)
+
+		switch (type[i]) {
+		case 'r':
+			CHECK_SET_TYPE(HW_BREAKPOINT_R);
+			break;
+		case 'w':
+			CHECK_SET_TYPE(HW_BREAKPOINT_W);
+			break;
+		case 'x':
+			CHECK_SET_TYPE(HW_BREAKPOINT_X);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+#undef CHECK_SET_TYPE
+
+	if (!attr->bp_type) /* Default */
+		attr->bp_type = HW_BREAKPOINT_R | HW_BREAKPOINT_W;
+
+	return 0;
+}
+
+int parse_events_add_breakpoint(struct parse_events_state *parse_state,
+				struct list_head *list,
+				u64 addr, char *type, u64 len)
+{
+	struct perf_event_attr attr;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.bp_addr = addr;
+
+	if (parse_breakpoint_type(type, &attr))
+		return -EINVAL;
+
+	/* Provide some defaults if len is not specified */
+	if (!len) {
+		if (attr.bp_type == HW_BREAKPOINT_X)
+			len = sizeof(long);
+		else
+			len = HW_BREAKPOINT_LEN_4;
+	}
+
+	attr.bp_len = len;
+
+	attr.type = PERF_TYPE_BREAKPOINT;
+	attr.sample_period = 1;
+
+	return perf_evsel__add_event(parse_state, list, &attr,
+				     /*init_attr*/true, /*name=*/NULL, /*mertic_id=*/NULL,
+				     /*pmu=*/NULL, /*config_terms=*/NULL,
+				     /*auto_merge_stats=*/false, /*cpu_list=*/NULL) ? 0 : -ENOENT;
+}
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 44980b34e367..02f46689f483 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -844,76 +844,6 @@ int parse_events_load_bpf(struct parse_events_state *parse_state,
 }
 #endif // HAVE_LIBBPF_SUPPORT
 
-static int
-parse_breakpoint_type(const char *type, struct perf_event_attr *attr)
-{
-	int i;
-
-	for (i = 0; i < 3; i++) {
-		if (!type || !type[i])
-			break;
-
-#define CHECK_SET_TYPE(bit)		\
-do {					\
-	if (attr->bp_type & bit)	\
-		return -EINVAL;		\
-	else				\
-		attr->bp_type |= bit;	\
-} while (0)
-
-		switch (type[i]) {
-		case 'r':
-			CHECK_SET_TYPE(HW_BREAKPOINT_R);
-			break;
-		case 'w':
-			CHECK_SET_TYPE(HW_BREAKPOINT_W);
-			break;
-		case 'x':
-			CHECK_SET_TYPE(HW_BREAKPOINT_X);
-			break;
-		default:
-			return -EINVAL;
-		}
-	}
-
-#undef CHECK_SET_TYPE
-
-	if (!attr->bp_type) /* Default */
-		attr->bp_type = HW_BREAKPOINT_R | HW_BREAKPOINT_W;
-
-	return 0;
-}
-
-static
-int parse_events_add_breakpoint(struct parse_events_state *parse_state,
-				struct list_head *list,
-				u64 addr, char *type, u64 len)
-{
-	struct perf_event_attr attr;
-
-	memset(&attr, 0, sizeof(attr));
-	attr.bp_addr = addr;
-
-	if (parse_breakpoint_type(type, &attr))
-		return -EINVAL;
-
-	/* Provide some defaults if len is not specified */
-	if (!len) {
-		if (attr.bp_type == HW_BREAKPOINT_X)
-			len = sizeof(long);
-		else
-			len = HW_BREAKPOINT_LEN_4;
-	}
-
-	attr.bp_len = len;
-
-	attr.type = PERF_TYPE_BREAKPOINT;
-	attr.sample_period = 1;
-
-	return add_event(parse_state, list, &attr, /*name=*/NULL, /*mertic_id=*/NULL,
-			 /*config_terms=*/NULL);
-}
-
 static int check_type_val(struct parse_events_term *term,
 			  struct parse_events_error *err,
 			  int type)
-- 
2.31.1

