Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B91C6FD1D
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 Apr 2023 13:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbjDDNhD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 Apr 2023 09:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjDDNhB (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 Apr 2023 09:37:01 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD92468B
        for <linux-perf-users@vger.kernel.org>; Tue,  4 Apr 2023 06:36:44 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id u18-20020a170902e5d200b001a1d70ea3b6so19157263plf.6
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Apr 2023 06:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680615404;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cppqNuJqNfjI/fjE8JP7DNjn6r/mL5/pt3t5XxOPExA=;
        b=ehl5iEHVTIAEgtle7mTcCY2z3CyGMUn61IFUNizPHnQ6LhTrCkW2IP/z8bFv7OCKFC
         EsTwGxi616l/ek9+ml/5uO2ZA6UbVQESfOAviP4Eh4GWgyE/g7s+j7GRoq+IRSlr0ZFw
         RBMfkz79TSxP56t9QJr25B/STQo92SI8xoL+9xvxiWNOmiVPbsQMxGrNuPbHg+IOBqhp
         ly7Bar6GvzQArnAt53AQe1p78LihAAF0v4PWHPQtGxSRwA6VjFAVdKXrlxhMhYEvxYYN
         LId3mQGsuOWmaPw0655bS2PsZLAcf592syinv7VYb52oc6y+F6x6droyl0BK++NL5jKc
         hH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680615404;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cppqNuJqNfjI/fjE8JP7DNjn6r/mL5/pt3t5XxOPExA=;
        b=EmWIUol0jyoahewkJhRtJwCWIIxxBiUaRoi4xB5Bz8LQnh6+2U80gfm3YHwCSGRKCO
         PIATzJIm9BtAKbfLT/dxTvot+KhVcyClUxUB2v4rYl5g+bC6C9k3U+efZZKn2xXl/jXb
         QZeweokNkgbWreH6MqOhjISt9VSewuMMsE7zxNFrLElm2lGdPfHrtWPxsP3Xs1B2LxNV
         fVvyUlXAIMeqrnmqHpdXbcjPcg0W4kR4jHCiqy2i3M8E7qcmexMzO8VX+WWwshMwzF3s
         dS8IJPmC932pbiaBjQEpL8qxl9Oa/RiXFTIw5WMIfIQ/T5GjKq+36mk+nYKBejVwEILj
         aQKA==
X-Gm-Message-State: AAQBX9fMbYRlbjZOZo2ZHX9yJnbIntYqihiptAJxaGL/NIHZdBnZX0JS
        lmLs1FExUpNGlcrBexXvFzPdKkSb+ebm
X-Google-Smtp-Source: AKy350YAaDcmQVOcsIWil/7wHmUuytQoOyVBbAh0m+2nMYSO28buvvy6EHMK/Y/2H468iywCtYaZ89KWqbpB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9dc:a977:817d:341])
 (user=irogers job=sendgmr) by 2002:aa7:8887:0:b0:62d:ccc4:2e03 with SMTP id
 z7-20020aa78887000000b0062dccc42e03mr1297193pfe.4.1680615404097; Tue, 04 Apr
 2023 06:36:44 -0700 (PDT)
Date:   Tue,  4 Apr 2023 06:36:30 -0700
Message-Id: <20230404133630.1985739-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v2] perf pmu: Make parser reentrant
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
 tools/perf/util/pmu.c | 24 ++++++++++++++++++------
 tools/perf/util/pmu.h |  2 +-
 tools/perf/util/pmu.l | 17 ++++++++++++-----
 tools/perf/util/pmu.y |  5 ++++-
 4 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 78a407b42ad1..f603cdabf797 100644
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
@@ -91,9 +92,20 @@ int perf_pmu__format_parse(int dirfd, struct list_head *head)
 		if (fd < 0)
 			break;
 
-		perf_pmu_in = fdopen(fd, "r");
-		ret = perf_pmu_parse(head, name);
-		fclose(perf_pmu_in);
+		file = fdopen(fd, "r");
+		if (!file)
+			break;
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

