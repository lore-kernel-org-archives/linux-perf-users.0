Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA8EC7618D
	for <linux-perf-users@archiver.kernel.org>; Thu,  6 Apr 2023 06:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235626AbjDFGwn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 6 Apr 2023 02:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235608AbjDFGwl (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 6 Apr 2023 02:52:41 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABFD8A75
        for <linux-perf-users@vger.kernel.org>; Wed,  5 Apr 2023 23:52:39 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54c0b8ca2d1so14676317b3.17
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Apr 2023 23:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680763959;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9nm1xQP5/CZTYWyFSei8uHNISktYFNWv+Clu34MqVSI=;
        b=aF4o0ID3B8PG82DEAzeXoAcnPn1WF9QIuD7OyY1P2NqOM2Dh9v/NE2dz82JzAm2DFr
         Ap+MaCgzmrtRHJC4qKdqBZOE7jD/tQgasQ+zXPaV10HdXO0rC1ui/jhA60SQn4KeIF8W
         v9UvAumeG4rSnAFaOSQMWLRbjyo5rVJJlPsjfT+xjiC96sTvuTHbAV7dxgFVETkoymhP
         eDrXMV4iDw+pge6SOnzc9N6hH5oYOHgRhfohIsya/rrRRvUB7isrvmSrIiT0WutCRyTZ
         2HWVNLEloX00o86nLmQpgXk2Fx5MXyQ8IW9Uig/Q2aEtdJC1yZaPIPq5eu2xQH666dzM
         g61Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680763959;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9nm1xQP5/CZTYWyFSei8uHNISktYFNWv+Clu34MqVSI=;
        b=4sEkMMiktrVYBId52dHK3KwizAqqji0SPHWCFKm7I1oOJx5L9oGBly5ZPl+bezQu8u
         ewtltYaYtvsMt3+kuhlyejYRFCk24V+xm7kiOp35+53LgTuW6O0wDcORONul28ElGlVC
         OqOqsIl5IgX1l5Bl7M8OQ+GWsbah2hzWnvRGEpXKPnRvxsrqa/MoblsQ2iWYnz6sUNP6
         91cfqOX0MnIhYT7BK+L3x5fTKd+olsIoQK1zo1Oy0PSuhHpPxJg4EhO08T7VQBX8RyKJ
         zV7OFWi2+dMmXGngUW+K9MR6minl1xAFaNz+g1jtGQZdujhjIVU4ma/5NkwyeO5d1dpu
         uMuA==
X-Gm-Message-State: AAQBX9ft9LXqCyaUcch8mBWYZR+o9Uptx6eUe7lA2dRfI8lIJjgwav4+
        BqSI+xzJl0oF/9i5mwq3txZPqxgqPruR
X-Google-Smtp-Source: AKy350bQ4nVxm9pm1EMUTqmjPalcWhGurSYQoufT2eKUEZbCulj7gZYb3C05jpRER3BtDbL4Fhf0v9y+EwUo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:713a:ed0b:3d14:a4da])
 (user=irogers job=sendgmr) by 2002:a25:cb03:0:b0:b8b:fd23:5028 with SMTP id
 b3-20020a25cb03000000b00b8bfd235028mr179977ybg.3.1680763959081; Wed, 05 Apr
 2023 23:52:39 -0700 (PDT)
Date:   Wed,  5 Apr 2023 23:52:23 -0700
Message-Id: <20230406065224.2553640-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v3 1/2] perf pmu: Make parser reentrant
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
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

By default bison uses global state for compatibility with yacc. Make
the parser reentrant so that it may be used in asynchronous and
multithreaded situations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 26 ++++++++++++++++++++------
 tools/perf/util/pmu.h |  2 +-
 tools/perf/util/pmu.l | 17 ++++++++++++-----
 tools/perf/util/pmu.y |  5 ++++-
 4 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 78a407b42ad1..96ef317bac41 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -24,6 +24,8 @@
 #include "evsel.h"
 #include "pmu.h"
 #include "pmus.h"
+#include "pmu-bison.h"
+#include "pmu-flex.h"
 #include "parse-events.h"
 #include "print-events.h"
 #include "header.h"
@@ -57,9 +59,6 @@ struct perf_pmu_format {
 	struct list_head list;
 };
 
-int perf_pmu_parse(struct list_head *list, char *name);
-extern FILE *perf_pmu_in;
-
 static bool hybrid_scanned;
 
 static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name);
@@ -81,6 +80,8 @@ int perf_pmu__format_parse(int dirfd, struct list_head *head)
 	while (!ret && (evt_ent = readdir(format_dir))) {
 		char *name = evt_ent->d_name;
 		int fd;
+		void *scanner;
+		FILE *file;
 
 		if (!strcmp(name, ".") || !strcmp(name, ".."))
 			continue;
@@ -91,9 +92,22 @@ int perf_pmu__format_parse(int dirfd, struct list_head *head)
 		if (fd < 0)
 			break;
 
-		perf_pmu_in = fdopen(fd, "r");
-		ret = perf_pmu_parse(head, name);
-		fclose(perf_pmu_in);
+		file = fdopen(fd, "r");
+		if (!file) {
+			close(fd);
+			break;
+		}
+
+		ret = perf_pmu_lex_init(&scanner);
+		if (ret) {
+			fclose(file);
+			break;
+		}
+
+		perf_pmu_set_in(file, scanner);
+		ret = perf_pmu_parse(head, name, scanner);
+		perf_pmu_lex_destroy(scanner);
+		fclose(file);
 	}
 
 	closedir(format_dir);
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 32c3a75bca0e..d53618c65c92 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -206,7 +206,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, struct list_head *head_terms,
 			  struct perf_pmu_info *info);
 struct list_head *perf_pmu__alias(struct perf_pmu *pmu,
 				  struct list_head *head_terms);
-void perf_pmu_error(struct list_head *list, char *name, char const *msg);
+void perf_pmu_error(struct list_head *list, char *name, void *scanner, char const *msg);
 
 int perf_pmu__new_format(struct list_head *list, char *name,
 			 int config, unsigned long *bits);
diff --git a/tools/perf/util/pmu.l b/tools/perf/util/pmu.l
index 58b4926cfaca..67b247be693b 100644
--- a/tools/perf/util/pmu.l
+++ b/tools/perf/util/pmu.l
@@ -1,4 +1,6 @@
 %option prefix="perf_pmu_"
+%option reentrant
+%option bison-bridge
 
 %{
 #include <stdlib.h>
@@ -6,16 +8,21 @@
 #include "pmu.h"
 #include "pmu-bison.h"
 
-static int value(int base)
+char *perf_pmu_get_text(yyscan_t yyscanner);
+YYSTYPE *perf_pmu_get_lval(yyscan_t yyscanner);
+
+static int value(yyscan_t scanner, int base)
 {
+	YYSTYPE *yylval = perf_pmu_get_lval(scanner);
+	char *text = perf_pmu_get_text(scanner);
 	long num;
 
 	errno = 0;
-	num = strtoul(perf_pmu_text, NULL, base);
+	num = strtoul(text, NULL, base);
 	if (errno)
 		return PP_ERROR;
 
-	perf_pmu_lval.num = num;
+	yylval->num = num;
 	return PP_VALUE;
 }
 
@@ -25,7 +32,7 @@ num_dec         [0-9]+
 
 %%
 
-{num_dec}	{ return value(10); }
+{num_dec}	{ return value(yyscanner, 10); }
 config		{ return PP_CONFIG; }
 -		{ return '-'; }
 :		{ return ':'; }
@@ -35,7 +42,7 @@ config		{ return PP_CONFIG; }
 
 %%
 
-int perf_pmu_wrap(void)
+int perf_pmu_wrap(void *scanner __maybe_unused)
 {
 	return 1;
 }
diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
index e675d79a0274..dff4e892ac4d 100644
--- a/tools/perf/util/pmu.y
+++ b/tools/perf/util/pmu.y
@@ -1,6 +1,8 @@
-
+%define api.pure full
 %parse-param {struct list_head *format}
 %parse-param {char *name}
+%parse-param {void *scanner}
+%lex-param {void* scanner}
 
 %{
 
@@ -78,6 +80,7 @@ PP_VALUE
 
 void perf_pmu_error(struct list_head *list __maybe_unused,
 		    char *name __maybe_unused,
+		    void *scanner __maybe_unused,
 		    char const *msg __maybe_unused)
 {
 }
-- 
2.40.0.348.gf938b09366-goog

