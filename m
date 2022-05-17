Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4568FC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 May 2022 20:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243450AbiEQUlw (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 17 May 2022 16:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbiEQUlu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 17 May 2022 16:41:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0790F1AF30
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 13:41:50 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 135-20020a25058d000000b0064dd6bc9cfdso118433ybf.23
        for <linux-perf-users@vger.kernel.org>; Tue, 17 May 2022 13:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=F1aO125Yx/obUzt176koWYfMkjjCHKow9Xi2uikrxmo=;
        b=OJLu59Z9I7+iGu+w6BJz1flN1H7Lq37JKIIeBhbkkFE8lxwJAcd/Y/JolCT4Ugw/iR
         UX7ZzX+kGoIr4PYaVPUDfI9TPmcQwGYT3K4cFHDHxvGpv9uhLQ911/69VKgjOK5i3nXr
         kj0Oids4J4EhXyiwHl09Qv27HCg/SVpM/axA6QWi25KpJUQqd7mvLYAc5M15X82T1UqV
         prVRY7nSuQv+oVsMriq1Qvuv0eiUsKBv/dXhppuPU3zL9sWGAdQkk8+WP13fBdA+Djt1
         0BywV737AySz9ad0tMGXs3m+ujJGzptV38gDEfLJyh1unXHrUsd+RyLLXte2O7DiujVz
         yR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=F1aO125Yx/obUzt176koWYfMkjjCHKow9Xi2uikrxmo=;
        b=0nJ2HYhxo86HQgl1/A5FyCOIODGS8zrMwED6Yu/mWPakjsmMkKP80R9pp9z7R6WBAY
         0WErQcShFK7IAr7ltjxP1o/XCnQ45KEIEIbaaa72EnAxq4A/WCsLUVjz1NtMiwTdUinn
         NgkAbLf1p5XSs7PTaErGcps0P7fJVdZiQuzQFTz1qqEhEEvumyFdF/BJmfZLIbZmGPRC
         iwqOPKDH0cXyhsUL6vrq4A6m08jwSuoyy0uu4PQ1JMDXfZEahYzZtX90OL2gfHqSOdRV
         6UsJ+Uw7fc+f0+XvIO66rFYwzXjXfdLFVoULh/dXbgY8zaSEVoEVf8gesiWJ1s3HN/PN
         C1Dg==
X-Gm-Message-State: AOAM5335iF737vVUKEUcxAFn5pqmDdw7hhZCMl6AnkULujVy9BPz3+Yo
        fk93uRQoo32apGUke5rRCRMR8hutl4JM
X-Google-Smtp-Source: ABdhPJzQbMHxPnHyCRWSpO1aAxJUO3kNUrzA0+BiWBnhXCydxYORM5RkoFxZ684mR8ROIS9ddQIxi/TLLKND
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:a5a1:af73:fe09:fd5])
 (user=irogers job=sendgmr) by 2002:a0d:c4c2:0:b0:2f1:6c00:9eb4 with SMTP id
 g185-20020a0dc4c2000000b002f16c009eb4mr29222866ywd.448.1652820108545; Tue, 17
 May 2022 13:41:48 -0700 (PDT)
Date:   Tue, 17 May 2022 13:41:44 -0700
Message-Id: <20220517204144.645913-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH] perf test: Avoid shell test description infinite loop
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Marco Elver <elver@google.com>,
        Sohaib Mohamed <sohaib.amhmd@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

for_each_shell_test is already strict in expecting tests to be files and
executable. It is sometimes possible when it iterates over all files
that it finds one that is executable and lacks a newline character. When
this happens the loop never terminates as it doesn't check for EOF. Add
the EOF check to make this loop at least bounded by the file size.

If the description is returned as NULL then also skip the test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 3c34cb766724..aa40eae1c9cf 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -279,6 +279,7 @@ static const char *shell_test__description(char *description, size_t size,
 {
 	FILE *fp;
 	char filename[PATH_MAX];
+	int ch;
 
 	path__join(filename, sizeof(filename), path, name);
 	fp = fopen(filename, "r");
@@ -286,7 +287,9 @@ static const char *shell_test__description(char *description, size_t size,
 		return NULL;
 
 	/* Skip shebang */
-	while (fgetc(fp) != '\n');
+	do {
+		ch = fgetc(fp);
+	} while (ch != EOF && ch != '\n');
 
 	description = fgets(description, size, fp);
 	fclose(fp);
@@ -419,7 +422,8 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width,
 			.priv = &st,
 		};
 
-		if (!perf_test__matches(test_suite.desc, curr, argc, argv))
+		if (test_suite.desc == NULL ||
+		    !perf_test__matches(test_suite.desc, curr, argc, argv))
 			continue;
 
 		st.file = ent->d_name;
-- 
2.36.0.550.gb090851708-goog

