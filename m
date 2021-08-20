Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CA5C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 11:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1148061051
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 11:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239832AbhHTLdG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 07:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239812AbhHTLdF (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 07:33:05 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BECC061575;
        Fri, 20 Aug 2021 04:32:27 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id b7so13584209edu.3;
        Fri, 20 Aug 2021 04:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+dxqelAbvAgNzB6Yr+hihCSpE0opyXvrOZ0GbMhC7Fo=;
        b=IzXjk5b14F2daFLa65zWeNOReFFiTePMbSrS3KBKO1lYrdhxSFmcN0hkmNj6A3N968
         EtxIuUT+JPTRSHoNBQ/zejh6gt4Mai9VID/KWsprOSomppPZXas38GoZJJKx2rCBb/F7
         3cD1Y02Xv7asguMQZ/4gQApF9l3nJxB4S9GvoGsUkEyRMbD8n+n0SvvvrBatmHVf8fHw
         vJSSq5Pcrh2CcJnHA4s27ItuIY6gAwPNNkoLu0v9eY6frzWYH+t9t0vqzOzSoDRO0Fg7
         wYY52oeA29fRejQ/XB1TsAlSVY+dtzoFqfyiRZK0rH6QqdtB+i6rBqjkoABJkHIYtJpd
         2QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+dxqelAbvAgNzB6Yr+hihCSpE0opyXvrOZ0GbMhC7Fo=;
        b=f0/11XEKtNEwyaiy9s2VKS7JWobp4zHe328/FqZ88WYe1iRuKxCGFdvNlBWDcCy8Pm
         sriDttvVy821ZzDTLLK9rYDxJW56r4c6IkqBehOYsskZ+/bBSYgwf9H+7Sb7oQpiot1H
         OVl/NrW4zvZzBSpGW9N22y+Tg1h/vW+5M+DusYoVKLz/OUVakuyfDcbwBdFxF8IIQyuq
         lXFycNTKn9ddS9Sw5Yt7llCG1k70VHbTgKUGJyWFdtM/PBTzgaVfiZKvLZjzksplbSSe
         ehJ5kJ5nUbpRISEyABZE2V4L8FTHDMvHqZ8knwDq/i9GzWs50Oq0h1HmU+LVNQO6YxdT
         V3fQ==
X-Gm-Message-State: AOAM532atuT/sFtNjm33q5ZPd/BGsRxkJPLhMlNwf2zZjZHHWEN2huqz
        CGd/93ZQKu3Iid+KyEg3scg=
X-Google-Smtp-Source: ABdhPJz9HznewVbDKl9DS6Jhsntt2saEODUgRgMy2oYmpymp57dSQ746yWqT/+skGHa7Q/u/Eo3W/A==
X-Received: by 2002:a05:6402:1206:: with SMTP id c6mr22181041edw.264.1629459146274;
        Fri, 20 Aug 2021 04:32:26 -0700 (PDT)
Received: from honeypot.epfl.ch (mob-37-181-187-184.net.vodafone.it. [37.181.187.184])
        by smtp.googlemail.com with ESMTPSA id x15sm2693333ejv.95.2021.08.20.04.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 04:32:25 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf tests: dlfilter: free desc and long_desc in check_filter_desc
Date:   Fri, 20 Aug 2021 13:31:29 +0200
Message-Id: <20210820113132.724034-1-rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In dlfilter-test, the function check_filter_desc calls get_filter_desc
which allocates desc and long_desc.
However, these variables are never deallocated.

This patch adds the missing frees.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Fixes: 9f9c9a8de2d5e96c ("perf tests: Add dlfilter test")
Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/tests/dlfilter-test.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/dlfilter-test.c b/tools/perf/tests/dlfilter-test.c
index 7eba7955d53154e1..bc03b5df6828d6fa 100644
--- a/tools/perf/tests/dlfilter-test.c
+++ b/tools/perf/tests/dlfilter-test.c
@@ -239,15 +239,20 @@ static int get_dlfilters_path(char *buf, size_t sz)
 
 static int check_filter_desc(struct test_data *td)
 {
-	char *long_desc;
-	char *desc;
+	char *long_desc = NULL;
+	char *desc = NULL;
+	int ret;
 
 	if (get_filter_desc(td->dlfilters, "dlfilter-test-api-v0.so", &desc, &long_desc) &&
 	    long_desc && !strcmp(long_desc, "Filter used by the 'dlfilter C API' perf test") &&
 	    desc && !strcmp(desc, "dlfilter to test v0 C API"))
-		return 0;
+		ret = 0;
+	else
+		ret = -1;
 
-	return -1;
+	free(desc);
+	free(long_desc);
+	return ret;
 }
 
 static int get_ip_addr(struct test_data *td)
-- 
2.31.1

