Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2E8C6FD20
	for <linux-perf-users@archiver.kernel.org>; Fri, 24 Mar 2023 07:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjCXHY2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 24 Mar 2023 03:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjCXHXw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 24 Mar 2023 03:23:52 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3736AD31
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Mar 2023 00:23:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e129-20020a251e87000000b00b56598237f5so1069029ybe.16
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Mar 2023 00:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679642622;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry4pmDb5s4Gk++Qn3wAlJyxk1mZP2UHgdh+PE9tgx6g=;
        b=tW4mgV7mWQiLK8AcqTZXh2yuHazguhic3RAC0D48flVTHzpTBmEIg5QxvvpDebANjd
         4l4G90L5nSp32JP1KyMED+mHvT5t/5CrbidI+71CSQGusErjYj5J51P5O++HjXQR+kMI
         vszIacWM8EARfIYHgYb0XcCKfO1dZCB5KKjIEnutn71Hs3ZyyHsU+bMMvwDQGRx2q3TD
         PKGUqjw7HjthWQbG2tLVurufNNQ3Rd5AnDbEV+EE9m9dBqWz6VUO9QEM4RlJpJDv7y09
         U6iszN7+qvuDto/1G10635ElvnFsFmqg0E7oFOBQ2EwKFdAsm2CYS9IJeED+w1u+OKHv
         QDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679642622;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ry4pmDb5s4Gk++Qn3wAlJyxk1mZP2UHgdh+PE9tgx6g=;
        b=yXoGI2d2RiEyFlti2bHI9TNAHgjquwQNFL9dkl29TTKNevbnwPQqVxN1tjWI4UMndZ
         C/TuBWUAF+lLNLSOClmnMC293k3q90nhCHR+3ds8HNDRMYZwLxxDFunhOS4vDqtGa8Tu
         hf66+w6F5MXrckOYEUPfUWdwkOniwHh8bTh8eSrEMGLK3LjWyG3GB7IO18z70NlhYHO8
         6XpiNC560ruYHAUGfHF5T8DCoMvOiEwc8RcXaqi+sjmpPoK1OPZmJFE6KfqtxLUoWnD9
         AKnlL7Vv7kzvHB60FXh3MU4wmAhlQYFFJBd6xzsuQbQHxG2WZK9Qq7cuPK1MO46fN/m+
         yVmg==
X-Gm-Message-State: AAQBX9dzMWGe5IDf3c8F+P6wVOYiwwbI5l9ypilo6LYUGnVXVgGV7IuG
        5mhsW1/31/FnvsOmFZ+i3ClbIh0ZQbUg
X-Google-Smtp-Source: AKy350byPKDNZqQaNWAL43WYzFKPlhuXpZ/JUAVqqb5cbjw2IhUnkzZqyfFQ8d3iUk7LSl29zpi4mmzf+Wuw
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e705:3a3d:46e5:fb50])
 (user=irogers job=sendgmr) by 2002:a81:e405:0:b0:544:d5ce:eb33 with SMTP id
 r5-20020a81e405000000b00544d5ceeb33mr548381ywl.8.1679642622088; Fri, 24 Mar
 2023 00:23:42 -0700 (PDT)
Date:   Fri, 24 Mar 2023 00:22:17 -0700
In-Reply-To: <20230324072218.181880-1-irogers@google.com>
Message-Id: <20230324072218.181880-9-irogers@google.com>
Mime-Version: 1.0
References: <20230324072218.181880-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v3 8/9] perf metrics: Add has_pmem literal
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        perry.taylor@intel.com, caleb.biggers@intel.com,
        samantha.alt@intel.com, weilin.wang@intel.com
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Add literal so that if nvdimms aren't installed we can record fewer
events.  The file detection mechanism was suggested by Dan Williams
<dan.j.williams@intel.com> in:
https://lore.kernel.org/linux-perf-users/641bbe1eced26_1b98bb29440@dwillia2-xfh.jf.intel.com.notmuch/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index d46a1878bc9e..bb6ddad7e021 100644
--- a/tools/perf/util/expr.c
+++ b/tools/perf/util/expr.c
@@ -14,6 +14,7 @@
 #include "util/hashmap.h"
 #include "smt.h"
 #include "tsc.h"
+#include <api/fs/fs.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/zalloc.h>
@@ -400,6 +401,20 @@ double arch_get_tsc_freq(void)
 }
 #endif
 
+static double has_pmem(void)
+{
+	static bool has_pmem, cached;
+	const char *sysfs = sysfs__mountpoint();
+	char path[PATH_MAX];
+
+	if (!cached) {
+		snprintf(path, sizeof(path), "%s/firmware/acpi/tables/NFIT", sysfs);
+		has_pmem = access(path, F_OK) == 0;
+		cached = true;
+	}
+	return has_pmem ? 1.0 : 0.0;
+}
+
 double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx)
 {
 	const struct cpu_topology *topology;
@@ -449,6 +464,10 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
 		result = perf_pmu__cpu_slots_per_cycle();
 		goto out;
 	}
+	if (!strcmp("#has_pmem", literal)) {
+		result = has_pmem();
+		goto out;
+	}
 
 	pr_err("Unrecognized literal '%s'", literal);
 out:
-- 
2.40.0.348.gf938b09366-goog

