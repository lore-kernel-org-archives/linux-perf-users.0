Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A10BC433EF
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22EE161506
	for <linux-perf-users@archiver.kernel.org>; Mon,  8 Nov 2021 13:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbhKHNnS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 8 Nov 2021 08:43:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240009AbhKHNnS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 Nov 2021 08:43:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636378833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOoSGrBN/5eAoFPiksW8rT1M2Zebu+aa4/RDbE6UZN4=;
        b=H2KGVYM0Q82n87RxnRrnHQGbrRbAD9V5jdwMJeOzmJG3kCBg9uSXcZ5iVnIJ4IOlNT5Hu3
        041p9J0Xk5L992tq/GwBMd1P7od6HKQTBVzn1OuQU9N2TH6XI4uXuWFIgF4Ivi+g91lg+e
        EPtUjwYPlksmhNbdixrDWhX9uHYPNOY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-DGg-PpCmMlGcCKrJEPSF8w-1; Mon, 08 Nov 2021 08:40:32 -0500
X-MC-Unique: DGg-PpCmMlGcCKrJEPSF8w-1
Received: by mail-wm1-f70.google.com with SMTP id z138-20020a1c7e90000000b003319c5f9164so10151754wmc.7
        for <linux-perf-users@vger.kernel.org>; Mon, 08 Nov 2021 05:40:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kOoSGrBN/5eAoFPiksW8rT1M2Zebu+aa4/RDbE6UZN4=;
        b=y0qY9F4Brs1gdxuuRlp4C6WFnBXUTD34dwjSwnvRK6+HqLtoMYz8ck1C/VAvISLXtI
         cyWBk8/AondzidH64HRJrNK/g+4LpdV0vCpPTl56Fpniw+Lh0jqklp4B4xbRt76StjNn
         XKJSdZOYfRRRloaGb6H1GKj3db8JfUjt0kpXxPkCtDuW2UfBkK5O8R9EGccBNxtFFLpf
         APNFGfg9MkKDJ3xL4qC69Oq5wEBg8ZpNYLBTYiwwuIhVqyoiu2mdkJeznAS5FeUa0Afy
         K38n9bewDqgeYjtsUIgS0Xy1tvgoPew7SZteE2ipaIi0Wr0jqpjmHyZJXuzg6HEIIRr8
         rGKw==
X-Gm-Message-State: AOAM531QxqE4ah7jM+lrVEln2OGhD3dq+Flqn03uumxDBCk3tFQNcaYH
        DPZ1gPw9A+QcWyaNQ9qg7Xo8N7F/BbKmE29G/gOw3fdyEnHlJoOMVJX/s3EYV813bDS1GRTcR7s
        l2jwvTm0ZkNb4tJfNESCntyzkOzREDw==
X-Received: by 2002:a5d:6347:: with SMTP id b7mr5916058wrw.36.1636378831343;
        Mon, 08 Nov 2021 05:40:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxOzJUhREE5mVJBZZi4KhnsiIv5OvntpUz+Z3808E1Ai9Ia2k3Y4rpr+xEoqUZKYzeJeCNNCg==
X-Received: by 2002:a5d:6347:: with SMTP id b7mr5916037wrw.36.1636378831207;
        Mon, 08 Nov 2021 05:40:31 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id o2sm17683447wrg.1.2021.11.08.05.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 05:40:30 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 32/59] libperf: Move in perf_pmu__warn_invalid_config function
Date:   Mon,  8 Nov 2021 14:36:43 +0100
Message-Id: <20211108133710.1352822-33-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211108133710.1352822-1-jolsa@kernel.org>
References: <20211108133710.1352822-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Moving perf_pmu__warn_invalid_config function to libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/internal/pmu.h |  2 ++
 tools/lib/perf/pmu.c                  | 34 +++++++++++++++++++++++++++
 tools/perf/util/pmu.c                 | 33 --------------------------
 tools/perf/util/pmu.h                 |  3 ---
 4 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/tools/lib/perf/include/internal/pmu.h b/tools/lib/perf/include/internal/pmu.h
index b8a78e024f6d..49ae6b3813e6 100644
--- a/tools/lib/perf/include/internal/pmu.h
+++ b/tools/lib/perf/include/internal/pmu.h
@@ -54,4 +54,6 @@ void perf_pmu__set_format(unsigned long *bits, long from, long to);
 void perf_pmu_error(struct list_head *list, char *name, char const *msg);
 int perf_pmu__format_parse(char *dir, struct list_head *head);
 
+void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
+				   const char *name);
 #endif /* __LIBPERF_INTERNAL_PMU_H */
diff --git a/tools/lib/perf/pmu.c b/tools/lib/perf/pmu.c
index 2fa361516ca8..af7f1c44c914 100644
--- a/tools/lib/perf/pmu.c
+++ b/tools/lib/perf/pmu.c
@@ -10,6 +10,7 @@
 #include <sys/types.h>
 #include <dirent.h>
 #include <internal/pmu.h>
+#include "internal.h"
 
 extern FILE *perf_pmu_in;
 
@@ -81,3 +82,36 @@ int perf_pmu__format_parse(char *dir, struct list_head *head)
 	closedir(format_dir);
 	return ret;
 }
+
+void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
+				   const char *name)
+{
+	struct perf_pmu_format *format;
+	__u64 masks = 0, bits;
+	char buf[100];
+	unsigned int i;
+
+	list_for_each_entry(format, &pmu->format, list)	{
+		if (format->value != PERF_PMU_FORMAT_VALUE_CONFIG)
+			continue;
+
+		for_each_set_bit(i, format->bits, PERF_PMU_FORMAT_BITS)
+			masks |= 1ULL << i;
+	}
+
+	/*
+	 * Kernel doesn't export any valid format bits.
+	 */
+	if (masks == 0)
+		return;
+
+	bits = config & ~masks;
+	if (bits == 0)
+		return;
+
+	bitmap_scnprintf((unsigned long *)&bits, sizeof(bits) * 8, buf, sizeof(buf));
+
+	pr_warning("WARNING: event '%s' not valid (bits %s of config "
+		   "'%llx' not supported by kernel)!\n",
+		   name ?: "N/A", buf, config);
+}
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 5bda7796f91a..920f2df52b6d 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1846,39 +1846,6 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
 	return nr_caps;
 }
 
-void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
-				   const char *name)
-{
-	struct perf_pmu_format *format;
-	__u64 masks = 0, bits;
-	char buf[100];
-	unsigned int i;
-
-	list_for_each_entry(format, &pmu->format, list)	{
-		if (format->value != PERF_PMU_FORMAT_VALUE_CONFIG)
-			continue;
-
-		for_each_set_bit(i, format->bits, PERF_PMU_FORMAT_BITS)
-			masks |= 1ULL << i;
-	}
-
-	/*
-	 * Kernel doesn't export any valid format bits.
-	 */
-	if (masks == 0)
-		return;
-
-	bits = config & ~masks;
-	if (bits == 0)
-		return;
-
-	bitmap_scnprintf((unsigned long *)&bits, sizeof(bits) * 8, buf, sizeof(buf));
-
-	pr_warning("WARNING: event '%s' not valid (bits %s of config "
-		   "'%llx' not supported by kernel)!\n",
-		   name ?: "N/A", buf, config);
-}
-
 bool perf_pmu__has_hybrid(void)
 {
 	if (!hybrid_scanned) {
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 091f49a655f8..077dbbdccb95 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -96,9 +96,6 @@ int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
 
 int perf_pmu__caps_parse(struct perf_pmu *pmu);
 
-void perf_pmu__warn_invalid_config(struct perf_pmu *pmu, __u64 config,
-				   const char *name);
-
 bool perf_pmu__has_hybrid(void);
 int perf_pmu__match(char *pattern, char *name, char *tok);
 
-- 
2.31.1

