Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6E6C433EF
	for <linux-perf-users@archiver.kernel.org>; Mon, 18 Jul 2022 16:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbiGRQn2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 18 Jul 2022 12:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235656AbiGRQnY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 18 Jul 2022 12:43:24 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB5B183B6
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jul 2022 09:43:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u15-20020a25ab0f000000b0066e49f6c461so9060148ybi.2
        for <linux-perf-users@vger.kernel.org>; Mon, 18 Jul 2022 09:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6ZhNslhhLNsgEg+FWq588BvRg4wz6Du1TOlV29T7frs=;
        b=AE1a2A8ktkCPoEaOl2Bjua2K9ctpZygOcIGgjIb7OmzO0HuCrX2VEssYRD0CzVzqeR
         Ghlv7ypWETR0HVub9zaNjlknRCHKRpKfsYR1BUSFSfqeQZXooaiVnhEhTJBpdQsg2Bxl
         U6GKtHZEJqRqnMJNabLeTsR/5QyZqCo6PKOaAWXBD5LXHAQGZPxkumXimRjuUvVNtP9N
         JezohPy9CWfP+fEHCTA8Pr62SmxfKloy1ghz2bLq3C0sAbTyeE+uaotJwS42xWh3rqiY
         zy/i+8uK7viWEa72tNyQra3m2thf0WpJQerzhr9FXsRjMXQYX84lYmXm/wtiQ4tAZpsw
         GdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6ZhNslhhLNsgEg+FWq588BvRg4wz6Du1TOlV29T7frs=;
        b=1hodqhhxFFFh0zJq16FnwuDf2AlPgQENdqzJhYvlbr7x7G1wI408xb0qgVGs8w216I
         pmJUZkBOjznLDoGeyza0g9GPAoy2C6xZXawcPJy/Zq+ToCDVuDPxLhwyHM4r8Vs3T4Vg
         rdVbkR+QlSSOB/whK8qIxq+6wuh5agEJ6MwsJiaPIOXg0cBhST8nLCj4LXE6Y4qbbCtU
         pM+E7EwEmyhOizpA1Lm68Bb/26nHfn4QUXTzK/IMAwYMMoZNeFeUwTMBm0KM3bHuMhBy
         bxp0bgY6wyp1fPfw9oXNRI9rkJLcS9N0yPQWuL2EPNJFZGNYiwlIlxp0W4FakyJEOu3k
         QGFw==
X-Gm-Message-State: AJIora8xJpJDTcTI8WhCV/G613NulEfZjW01UoSjPTqc70B6HHhb1OAY
        Ugd13HoVCPU+/GXd8rVzlIY3bF9p+ZbU
X-Google-Smtp-Source: AGRyM1vo+bqIlRAK/lQLOqnS2Cls5RI2liOXTblRr6VUX+Jdqlp2anG254SCKfSoUx+7XbTL01bcVQGdocpW
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:922:90e9:167f:1ccd])
 (user=irogers job=sendgmr) by 2002:a0d:e895:0:b0:31c:85a6:1444 with SMTP id
 r143-20020a0de895000000b0031c85a61444mr31886874ywe.493.1658162602493; Mon, 18
 Jul 2022 09:43:22 -0700 (PDT)
Date:   Mon, 18 Jul 2022 09:43:11 -0700
In-Reply-To: <20220718164312.3994191-1-irogers@google.com>
Message-Id: <20220718164312.3994191-3-irogers@google.com>
Mime-Version: 1.0
References: <20220718164312.3994191-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v4 2/3] perf tsc: Add cpuinfo fall back for arch_get_tsc_freq
From:   Ian Rogers <irogers@google.com>
To:     perry.taylor@intel.com, caleb.biggers@intel.com,
        kshipra.bopardikar@intel.com,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The CPUID method of arch_get_tsc_freq fails for older Intel processors,
such as Skylake. Compute using /proc/cpuinfo.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/x86/util/tsc.c | 52 +++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/x86/util/tsc.c b/tools/perf/arch/x86/util/tsc.c
index b69144f22489..eb2b5195bd02 100644
--- a/tools/perf/arch/x86/util/tsc.c
+++ b/tools/perf/arch/x86/util/tsc.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/types.h>
+#include <math.h>
 #include <string.h>
 
+#include "../../../util/debug.h"
 #include "../../../util/tsc.h"
 #include "cpuid.h"
 
@@ -14,6 +16,44 @@ u64 rdtsc(void)
 	return low | ((u64)high) << 32;
 }
 
+/*
+ * Derive the TSC frequency in Hz from the /proc/cpuinfo, for example:
+ * ...
+ * model name      : Intel(R) Xeon(R) Gold 6154 CPU @ 3.00GHz
+ * ...
+ * will return 3000000000.
+ */
+static double cpuinfo_tsc_freq(void)
+{
+	double result = 0;
+	FILE *cpuinfo;
+	char *line = NULL;
+	size_t len = 0;
+
+	cpuinfo = fopen("/proc/cpuinfo", "r");
+	if (!cpuinfo) {
+		pr_err("Failed to read /proc/cpuinfo for TSC frequency");
+		return NAN;
+	}
+	while (getline(&line, &len, cpuinfo) > 0) {
+		if (!strncmp(line, "model name", 10)) {
+			char *pos = strstr(line + 11, " @ ");
+
+			if (pos && sscanf(pos, " @ %lfGHz", &result) == 1) {
+				result *= 1000000000;
+				goto out;
+			}
+		}
+	}
+out:
+	if (fpclassify(result) == FP_ZERO)
+		pr_err("Failed to find TSC frequency in /proc/cpuinfo");
+
+	free(line);
+	fclose(cpuinfo);
+	return result;
+}
+
 double arch_get_tsc_freq(void)
 {
 	unsigned int a, b, c, d, lvl;
@@ -33,13 +73,17 @@ double arch_get_tsc_freq(void)
 	 * Don't support Time Stamp Counter and
 	 * Nominal Core Crystal Clock Information Leaf.
 	 */
-	if (lvl < 0x15)
-		return 0;
+	if (lvl < 0x15) {
+		tsc = cpuinfo_tsc_freq();
+		return tsc;
+	}
 
 	cpuid(0x15, 0, &a, &b, &c, &d);
 	/* TSC frequency is not enumerated */
-	if (!a || !b || !c)
-		return 0;
+	if (!a || !b || !c) {
+		tsc = cpuinfo_tsc_freq();
+		return tsc;
+	}
 
 	tsc = (double)c * (double)b / (double)a;
 	return tsc;
-- 
2.37.0.170.g444d1eabd0-goog

