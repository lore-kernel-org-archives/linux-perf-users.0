Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA562C3DA66
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 08:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbjHWIKK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 04:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbjHWIJX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 04:09:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F5DE7F
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 01:08:40 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d7231c761b6so6269768276.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 01:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692778119; x=1693382919;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zbOd4cktnqwY3C7uOx37I8EsWOiY3ojcBmbOEcOxtrg=;
        b=TVjeVQycUPbwnNb2TI5vTuU5hq4DhJNEjTYI2IlQgwLqdO0PCxXIn80etXfjCr0Gqy
         rdwS4hbhtA2laZE8pKKUgf/kJFKIIeJw3hbft9tSjDTb0uwa7XoLsoTCDIRTkd/ws75T
         s1zftdfnQCEfbkM8ssjC0CLnqkw3+HL9h10VbX3wxWp3qC+03Uct6bmSXDHtYt68W97+
         vfDrIfUxFdXIDl8LvxYwMz5NxFe2Qwu3QFTLH2UmCHGlIsUhsO3302gdoqMCVq2dECDZ
         dI8TUMAN3/XgCynHdQU8HN344ydOkFVTKj5ZXaZhEQUsU/WSg551gtpZa4nKIAxkSCU0
         6DKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692778119; x=1693382919;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zbOd4cktnqwY3C7uOx37I8EsWOiY3ojcBmbOEcOxtrg=;
        b=JaepRR/9oVmtDLqKAnEKiKefBagBxUzSz912BSmO/mhWcp94athYKnQ2eHGic3x7wY
         Ivp0ZhzrqD3CqEGjq3jJKW9uvSvlfPwyONTj3YhDMBwZJhNMSAevzUDiMvXbjG6Ax4YH
         prQES2+ZbYcZBri+VVQbZkgz93FPNAgU3m0PC8E3LLF1a2iEr/XcTZEdOnx/HK8bWWZO
         mUMHB0gHutwFETOKp/wBi4U6Q9OwbX+001Klfra1rzA5dZMcyPoDrZCeOR070i+pjsxa
         j1hVg+lHIRI86cIcvKlxh3n9bToZJ9sdxHgd5Ps84LQ4gdK77uC6Vwk6dWC7ALLyxuCV
         M18Q==
X-Gm-Message-State: AOJu0YwKOA+5DBxOvdmhdjzKYQ57H+QguXdcpLXBRk651LSndtuyglRA
        Hlh425VuYZVPX78674kik4/TJXkQqxck
X-Google-Smtp-Source: AGHT+IGXKT84Ue6RywhJHDK9fqe7aLr7VA0C6SOXlI2DXTTcq1jLdX9D5qIv5tM8tI38bPx1mkTkKSHNVhmo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3971:e84:f508:9a36])
 (user=irogers job=sendgmr) by 2002:a25:e70e:0:b0:d74:6a19:f91b with SMTP id
 e14-20020a25e70e000000b00d746a19f91bmr126206ybh.3.1692778119481; Wed, 23 Aug
 2023 01:08:39 -0700 (PDT)
Date:   Wed, 23 Aug 2023 01:08:06 -0700
In-Reply-To: <20230823080828.1460376-1-irogers@google.com>
Message-Id: <20230823080828.1460376-4-irogers@google.com>
Mime-Version: 1.0
References: <20230823080828.1460376-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Subject: [PATCH v1 03/25] perf pmu: Move perf_pmu__set_format to pmu.y
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
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Avoid having the function in the C and header file, as it is only used
locally by pmu.y.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/pmu.c | 12 ------------
 tools/perf/util/pmu.h |  1 -
 tools/perf/util/pmu.y | 12 ++++++++++++
 3 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7683c6749d66..40999e1fab8f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1417,18 +1417,6 @@ int perf_pmu__new_format(struct list_head *list, char *name,
 	return 0;
 }
 
-void perf_pmu__set_format(unsigned long *bits, long from, long to)
-{
-	long b;
-
-	if (!to)
-		to = from;
-
-	memset(bits, 0, BITS_TO_BYTES(PERF_PMU_FORMAT_BITS));
-	for (b = from; b <= to; b++)
-		__set_bit(b, bits);
-}
-
 void perf_pmu__del_formats(struct list_head *formats)
 {
 	struct perf_pmu_format *fmt, *tmp;
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 7ff925224165..9c9ea40b9c71 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -231,7 +231,6 @@ void perf_pmu_error(struct list_head *list, char *name, void *scanner, char cons
 
 int perf_pmu__new_format(struct list_head *list, char *name,
 			 int config, unsigned long *bits);
-void perf_pmu__set_format(unsigned long *bits, long from, long to);
 int perf_pmu__format_parse(int dirfd, struct list_head *head);
 void perf_pmu__del_formats(struct list_head *formats);
 bool perf_pmu__has_format(const struct perf_pmu *pmu, const char *name);
diff --git a/tools/perf/util/pmu.y b/tools/perf/util/pmu.y
index 3d46cca3bb94..9bd9e30791ff 100644
--- a/tools/perf/util/pmu.y
+++ b/tools/perf/util/pmu.y
@@ -21,6 +21,18 @@ do { \
                 YYABORT; \
 } while (0)
 
+static void perf_pmu__set_format(unsigned long *bits, long from, long to)
+{
+	long b;
+
+	if (!to)
+		to = from;
+
+	memset(bits, 0, BITS_TO_BYTES(PERF_PMU_FORMAT_BITS));
+	for (b = from; b <= to; b++)
+		__set_bit(b, bits);
+}
+
 %}
 
 %token PP_CONFIG
-- 
2.42.0.rc1.204.g551eb34607-goog

