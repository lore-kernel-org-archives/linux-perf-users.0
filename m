Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D02C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB35361505
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240008AbhKHNnG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:43:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49088 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237219AbhKHNnG (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:43:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/8DeqnBwO8AHReKrYN5Ps8UragNY3ZdcxpCMwEeIq0Y=;
        b=QQbR9lYOqlU76spm2WgmKhaQcOgiTPsnL0TPzOa+Dly9ahv2rx0x5qtwY3empuwUNkuSgY
        ICm7I+oknwfN19hcOyzCtHU6YyibSKhtBHtpxy6/1K8Ns2T66DESsklitCXJsGK+MH2q3y
        FFRdHYhvetMCPzwEorUzXYfp5dBd+aY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-q7jFZ8wYPsiFmqHL-YrKtA-1; Mon, 08 Nov 2021 08:40:20 -0500
X-MC-Unique: q7jFZ8wYPsiFmqHL-YrKtA-1
Received: by mail-wm1-f69.google.com with SMTP id j25-20020a05600c1c1900b00332372c252dso5793680wms.1
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:40:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/8DeqnBwO8AHReKrYN5Ps8UragNY3ZdcxpCMwEeIq0Y=;
        b=IEbuCu4g2CyZIU6wMwSgxhqa/utJ9qnKJ4ZipDR6mv2uNT5Q3ycf751MYe/jnBxe+P
         4DwjgLUdmUpZad5JpFGNqi30BQZeD+nq4RN4Kr9JT6LWo9MfXtZY8peGtfBVuN/7XapS
         jRWa4MjGFMN6V/KoiEIcYWWCBxHz8YWX+OqQ5pW398ybcHRq1vgE9b8SYyIs53w9jp5K
         tlefd1KSWgYT80GL+wZoySq7UPLjcs89z4nOiZUFVN1gxX7LURtPSN2U3WVxKJ0nRlQR
         TQ3t7fs8WZxMKZGMJtuF1v6kTkgMVUWU1Or8CWFvmFhWF/RpXL6pN3IvmLRc0bhcnJYc
         L1kA==
X-Gm-Message-State: AOAM532piz2ujya8xJEPFq6As/GcOhEMKCRQtw5yrx79Hurfm2iOfP9U
        UlcIVlHQ3tHA5uMb1t0GUN3r61FwduNsemPWxoAKPQEVww9rSlkc89vetS323CNSEj7Q+3YmgvL
        pvbgh1ohHuEjMDUObKhND+1PfKDN/Dw==
X-Received: by 2002:a05:600c:3227:: with SMTP id r39mr54741576wmp.120.1636378819541;
        Mon, 08 Nov 2021 05:40:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhYC49EIfG3SGAIKSmwrOAwTbRsDUWmWDQPvz+H9JIPxXwtg05Xp+tKBGhHUlyGw5RfZym8A==
X-Received: by 2002:a05:600c:3227:: with SMTP id r39mr54741564wmp.120.1636378819410;
        Mon, 08 Nov 2021 05:40:19 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id v191sm16161627wme.36.2021.11.08.05.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:40:19 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 30/59] libperf: Move in struct parse_events_state
Date:   Mon,  8 Nov 2021 14:36:41 +0100
Message-Id: <20211108133710.1352822-31-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving in struct parse_events_state to libperf
together with related structs.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 .../lib/perf/include/internal/parse-events.h  | 29 +++++++++++++++++++
 tools/perf/util/parse-events.h                | 28 ------------------
 2 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/tools/lib/perf/include/internal/parse-events.h b/tools/lib/perf/include/internal/parse-events.h
index 46f632efd71b..aff13afa08e1 100644
--- a/tools/lib/perf/include/internal/parse-events.h
+++ b/tools/lib/perf/include/internal/parse-events.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/list.h>
 #include <unistd.h>
+#include <linux/perf_event.h>
 
 struct event_symbol {
 	const char	*symbol;
@@ -74,6 +75,34 @@ struct parse_events_term {
 	bool weak;
 };
 
+struct parse_events_error {
+	int   num_errors;       /* number of errors encountered */
+	int   idx;	/* index in the parsed string */
+	char *str;      /* string to display at the index */
+	char *help;	/* optional help string */
+	int   first_idx;/* as above, but for the first encountered error */
+	char *first_str;
+	char *first_help;
+};
+
+struct parse_events_ops {
+	struct perf_evsel* (*perf_evsel__new)(struct perf_event_attr *attr, int idx);
+	struct perf_evsel* (*perf_evsel__new_tp)(const char *sys, const char *name, int idx);
+};
+
+struct parse_events_state {
+	struct list_head	   list;
+	int			   idx;
+	int			   nr_groups;
+	struct parse_events_error *error;
+	struct perf_evlist	  *evlist;
+	struct list_head	  *terms;
+	int			   stoken;
+	struct perf_pmu		  *fake_pmu;
+	char			  *hybrid_pmu_name;
+	struct parse_events_ops	  *ops;
+};
+
 int parse_events_term__num(struct parse_events_term **term,
 			   int type_term, char *config, u64 num,
 			   bool novalue,
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 2f75e823124f..057b92778d17 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -61,34 +61,6 @@ struct perf_pmu_event_symbol {
 	enum perf_pmu_event_symbol_type	type;
 };
 
-struct parse_events_error {
-	int   num_errors;       /* number of errors encountered */
-	int   idx;	/* index in the parsed string */
-	char *str;      /* string to display at the index */
-	char *help;	/* optional help string */
-	int   first_idx;/* as above, but for the first encountered error */
-	char *first_str;
-	char *first_help;
-};
-
-struct parse_events_ops {
-	struct perf_evsel* (*perf_evsel__new)(struct perf_event_attr *attr, int idx);
-	struct perf_evsel* (*perf_evsel__new_tp)(const char *sys, const char *name, int idx);
-};
-
-struct parse_events_state {
-	struct list_head	   list;
-	int			   idx;
-	int			   nr_groups;
-	struct parse_events_error *error;
-	struct perf_evlist	  *evlist;
-	struct list_head	  *terms;
-	int			   stoken;
-	struct perf_pmu		  *fake_pmu;
-	char			  *hybrid_pmu_name;
-	struct parse_events_ops	  *ops;
-};
-
 void parse_events__handle_error(struct parse_events_error *err, int idx,
 				char *str, char *help);
 void parse_events__shrink_config_terms(void);
-- 
2.31.1

