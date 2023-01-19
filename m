Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30027C004D4
	for <linux-perf-users@archiver.kernel.org>; Thu, 19 Jan 2023 20:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjASUKv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 19 Jan 2023 15:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjASUKu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 19 Jan 2023 15:10:50 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB519373F
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jan 2023 12:10:49 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id y15-20020a2586cf000000b007d35ff419e6so3445820ybm.5
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Jan 2023 12:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ud0+INWLgaIQ+hxTqFXvd28kGTdvB7/WJm7UP9MKuZc=;
        b=CFW7nG1uUTu0Huw9MUGl9BOVAw8fTl3vDsX2+4BeHbSOlHP1fZT+RbxgSt4liySCdb
         fjYdhlAZXj1BXguWltFCB7yQPhye+r5Vgz1s9bZt3zzssFt+VOd5qHTNArDPiHfu+dnM
         n2+k1GjY/h7PLN2zf/QjSpSDCx3fAKJuqa9wpJbiBCOcW823o5tWHjJuDeXfGei7HDTN
         yB9oAVyhRub4xA76I8g0nZjbD64G8wfmfHy6o/vqNf8QVlg0ZmqDyuoqefwtFY1GmMlF
         g+u3ymcwbuQcQ1t9q17WDw1c2YdeFUoRPwNpSuI4bmkwcYCkDT0WgLqET/rSiGzKJx1z
         8buA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ud0+INWLgaIQ+hxTqFXvd28kGTdvB7/WJm7UP9MKuZc=;
        b=M0JYvvLDYxATvyGqXg9IGoeex/lYwQETVypPG5u3jMU1GICSeHvY6uQYUbvgbCiBxW
         Jel+uLe4cEuqA+ZD+lC9/TmNcE9LEsdx9IIqaIDR9bUWJKJYfydws6Mnjf5X4PDhH5PK
         DT7NwrWnXcrdKa8JTUJHJoDbggQjjaBQCB5qNhqcSWuDSIM0+DiSX19hPMWYxah04kel
         HYxhFV/mXUaWyTgrOeHnZ5FzRdzd8aDbXdef5TEwJ9pT1sdyjyrGKZhGEjBMH2pulsP9
         0Jqu2SqHpBZqq0cnIcsUP+tiUgnxzPJxoba4NTedWGt1rR+v+EpFcS3LmifBg3e/VF6d
         PHxg==
X-Gm-Message-State: AFqh2kq80nDeMBG4FxBEcdi8/JjCDYmeCRWdqbAovjenE/kvuPOgZB2X
        GbOlOCQgGGR81PvCfp6xrU1t07cYUs0O
X-Google-Smtp-Source: AMrXdXt4ilF3D8E8bzxXV+w9Ht3xFrVzF4S21ZEGIAneV5h+vLLAGkmT/IueAEPyTVumy8xcw2SyBjNTggBl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:93c6:b65e:5f33:bc6b])
 (user=irogers job=sendgmr) by 2002:a0d:e541:0:b0:44a:c8fb:93a2 with SMTP id
 o62-20020a0de541000000b0044ac8fb93a2mr1549070ywe.160.1674159048413; Thu, 19
 Jan 2023 12:10:48 -0800 (PST)
Date:   Thu, 19 Jan 2023 12:10:36 -0800
Message-Id: <20230119201036.156441-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Subject: [PATCH v1] perf tools: Fix foolproof typo
From:   Ian Rogers <irogers@google.com>
To:     Kan Liang <kan.liang@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Ali Saidi <alisaidi@amazon.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In the context of LBR stitching documentation.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Documentation/perf-c2c.txt    | 2 +-
 tools/perf/Documentation/perf-report.txt | 2 +-
 tools/perf/Documentation/perf-script.txt | 2 +-
 tools/perf/Documentation/perf-top.txt    | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-c2c.txt b/tools/perf/Documentation/perf-c2c.txt
index 5c5eb2def83e..af5c3106f468 100644
--- a/tools/perf/Documentation/perf-c2c.txt
+++ b/tools/perf/Documentation/perf-c2c.txt
@@ -121,7 +121,7 @@ REPORT OPTIONS
 	perf c2c record --call-graph lbr.
 	Disabled by default. In common cases with call stack overflows,
 	it can recreate better call stacks than the default lbr call stack
-	output. But this approach is not full proof. There can be cases
+	output. But this approach is not foolproof. There can be cases
 	where it creates incorrect call stacks from incorrect matches.
 	The known limitations include exception handing such as
 	setjmp/longjmp will have calls/returns not match.
diff --git a/tools/perf/Documentation/perf-report.txt b/tools/perf/Documentation/perf-report.txt
index 4fa509b15948..9b0c0dbf9a77 100644
--- a/tools/perf/Documentation/perf-report.txt
+++ b/tools/perf/Documentation/perf-report.txt
@@ -507,7 +507,7 @@ include::itrace.txt[]
 	perf record --call-graph lbr.
 	Disabled by default. In common cases with call stack overflows,
 	it can recreate better call stacks than the default lbr call stack
-	output. But this approach is not full proof. There can be cases
+	output. But this approach is not foolproof. There can be cases
 	where it creates incorrect call stacks from incorrect matches.
 	The known limitations include exception handing such as
 	setjmp/longjmp will have calls/returns not match.
diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 68e37de5fae4..8d77182fbf31 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -502,7 +502,7 @@ include::itrace.txt[]
 	perf record --call-graph lbr.
 	Disabled by default. In common cases with call stack overflows,
 	it can recreate better call stacks than the default lbr call stack
-	output. But this approach is not full proof. There can be cases
+	output. But this approach is not foolproof. There can be cases
 	where it creates incorrect call stacks from incorrect matches.
 	The known limitations include exception handing such as
 	setjmp/longjmp will have calls/returns not match.
diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index e534d709cc5a..c60e615b7183 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -334,7 +334,7 @@ use '-e e1 -e e2 -G foo,foo' or just use '-e e1 -e e2 -G foo'.
 	callgraph. The option must be used with --call-graph lbr recording.
 	Disabled by default. In common cases with call stack overflows,
 	it can recreate better call stacks than the default lbr call stack
-	output. But this approach is not full proof. There can be cases
+	output. But this approach is not foolproof. There can be cases
 	where it creates incorrect call stacks from incorrect matches.
 	The known limitations include exception handing such as
 	setjmp/longjmp will have calls/returns not match.
-- 
2.39.0.246.g2a6d74b583-goog

