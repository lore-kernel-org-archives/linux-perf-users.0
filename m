Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7642AC4338F
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 18:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 511DA60FE6
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 18:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhHKSHt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 11 Aug 2021 14:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhHKSHs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 11 Aug 2021 14:07:48 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5876C061765;
        Wed, 11 Aug 2021 11:07:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id bo19so5030688edb.9;
        Wed, 11 Aug 2021 11:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xb03FgVtSdL/eKVadSdipMPboOiS/FGTVbT0hN2/lu8=;
        b=aGw9my41iuUPHtiwgx1d0wHLxfBuvqFMS8xth7k++QITMb41ohjRKXBeWTJB5DPvY7
         A+KpI1OL3/uhcAF+IBEnM6Z/NGNe7SCfUfEN80MQq3HdUtZiK0OIhpvxWIgXX2gv4woH
         Q7H9SzsZXRGklULXUKMjNqt997rwqMPHRZjD/lp6myVQawfQ2FFKtipTLYHhLb2W9MXq
         hSrzP/OTOdArdo/iLdSwI46VKebLp7Z4+gs8gcAWLuWJAzUF0BqWAIjvPgjIkXf3+8MZ
         F7iCi/VdB5zFc2rndLznU2AGugoThkPHPobpKfTS4YwF+JVcvJF/5jXoYLTcMyuhqtfI
         grhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xb03FgVtSdL/eKVadSdipMPboOiS/FGTVbT0hN2/lu8=;
        b=pSK2tFWtx79LgMLjeK3jVSHBm6Hf8uHTjAQ2jBsyghUm8mRM26Pa7E8y0MEctBd733
         YBZLp5sn9tdQYlBrWDVFUnqoxRRqGpuq+yO2SzZpN8QOFVY+R5KTG9DKsJ4s4jqIkK7O
         /1EnhMrA5+VaGayjr497eARN1qzY5VPhA1yXi28hPzuyswDoctjDJUDPp0nKws0w/Rga
         gyhqrv/pxvjP9qCYmCqALk+NY3TPAzAzAftLfq3us8jcXjc1jydVExDI7OzqbMNA5BK/
         U7G7hJY2WdaqEE2CBptKVaC0yZ5GrikUlxNFP8GTN/Law9mCYXm9ktZhZXF8gAxTOgw0
         OBIg==
X-Gm-Message-State: AOAM530jKrz+GJVrbpNI2dc5mhXUCto/ETSvqIzEsyR8zWM2ThA+arbC
        GHyhpRP9kxpfl3+F51pDvr4=
X-Google-Smtp-Source: ABdhPJytTZONblhK1d1l7L9yPJIgNeuA6t/4wfBiKbR/PvleJdikJvT6EqRfoo/qC7fh/wumVkoSzA==
X-Received: by 2002:a05:6402:48e:: with SMTP id k14mr200546edv.212.1628705243247;
        Wed, 11 Aug 2021 11:07:23 -0700 (PDT)
Received: from honeypot.. ([5.179.189.16])
        by smtp.googlemail.com with ESMTPSA id g23sm51588ejm.26.2021.08.11.11.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:07:22 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [PATCH] perf test: make --skip work on shell tests
Date:   Wed, 11 Aug 2021 20:06:26 +0200
Message-Id: <20210811180625.160944-1-rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

perf-test has the option --skip to provide a list of tests to skip.
However, this option does not work with shell scripts.

This patch passes the skiplist to run_shell_tests, so that also shell
scripts could be skipped using --skip.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/tests/builtin-test.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 5e6242576236325c..fb4a75cc8fa9530e 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -594,7 +594,8 @@ static int shell_test__run(struct test *test, int subdir __maybe_unused)
 	return WEXITSTATUS(err) == 2 ? TEST_SKIP : TEST_FAIL;
 }
 
-static int run_shell_tests(int argc, const char *argv[], int i, int width)
+static int run_shell_tests(int argc, const char *argv[], int i, int width,
+				struct intlist *skiplist)
 {
 	struct dirent **entlist;
 	struct dirent *ent;
@@ -628,6 +629,12 @@ static int run_shell_tests(int argc, const char *argv[], int i, int width)
 
 		st.file = ent->d_name;
 		pr_info("%2d: %-*s:", i, width, test.desc);
+
+		if (intlist__find(skiplist, i)) {
+			color_fprintf(stderr, PERF_COLOR_YELLOW, " Skip (user override)\n");
+			continue;
+		}
+
 		test_and_print(&test, false, -1);
 	}
 
@@ -727,7 +734,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 		}
 	}
 
-	return run_shell_tests(argc, argv, i, width);
+	return run_shell_tests(argc, argv, i, width, skiplist);
 }
 
 static int perf_test__list_shell(int argc, const char **argv, int i)
-- 
2.31.1

