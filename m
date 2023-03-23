Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6229AC74A5B
	for <linux-perf-users@archiver.kernel.org>; Thu, 23 Mar 2023 19:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjCWTW3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 23 Mar 2023 15:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjCWTVv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 23 Mar 2023 15:21:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C078C1041A
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Mar 2023 12:21:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i11-20020a256d0b000000b0086349255277so23570252ybc.8
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Mar 2023 12:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679599303;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3Z0gHxtmfZoBxhh4tWLHtA08dcRu+l0xhSXqfOrne0=;
        b=WGY7xAmNweh22oGHAaxaxszMGdLe6NedB+9iPB735C8A8CSkRd5a5xewpT3tZxgRE9
         wsdBkdhH8uzOzswxN0vEU8NlwZb/82ndhAUQTyKYvPSKfL/QntlrzVSSU3AU+Dfbne/j
         4rz4hg68ZaweYkw7zGoHENvoZ9LyRuqLeCPFSZDCXOZJuJcvKbAyXFf9kNHypMEksOFW
         S1C8uiD2uy3GUJPVEVEs99dt60YZcmWJD19hEaQOJePzG64XxGe/ssw196Dm9VpyREtk
         6SaSJVWf5pKSZIewLhIjmVgxGLodzZndKhetpYVPUJR6f+PZfSP1pbRL7u+lw5oG6loq
         vN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679599303;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3Z0gHxtmfZoBxhh4tWLHtA08dcRu+l0xhSXqfOrne0=;
        b=KDbcUoNV/JhO1gc6RVPj8AVMOMrBic3ZiTcGCjemxx9lFlOO0KQbnAw0KnDsBy2EUS
         fY7EaxsBlt2H2wWljiTC3ezuH3F/Ebe4JECi2TZQtdEzPkHJznbDQRR8zIBK4EN/7rYv
         +CZCcz4CIvqgb32iX9bC6QUQdN+DR1aU3DeqI6QoKVS7LAwSOCRcjlr8sKRNBwZJnsXU
         TjBq6rk68hsAs6X2uIHUvOojd+TEXYZu2/hL4IDg95ke9NCDYas5oNXHwDXwQkIP8eMD
         OW9YSZzh5gRpvPhsWdvkrG26eu0X9XotCcblYKRF80OkH2rTOINhzlUj1WoL8lU04XP1
         3erQ==
X-Gm-Message-State: AAQBX9c9HzDdDB/DWmldh0ZoEwNBRaEeifYp0mS1qNZekei3hklEL/bd
        4S+3EU47QJRQeWVYr9okQLZ2jEslcyQs
X-Google-Smtp-Source: AKy350aF17WKZObbDWKxDxkWyl/jUkcIB2KgCdJDGWqoPOOexrGmy4dQxHJXbirXJZQo+pj2xFWaAoj44JyR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:e705:3a3d:46e5:fb50])
 (user=irogers job=sendgmr) by 2002:a05:6902:1021:b0:b77:3f5a:8a53 with SMTP
 id x1-20020a056902102100b00b773f5a8a53mr260388ybt.12.1679599302678; Thu, 23
 Mar 2023 12:21:42 -0700 (PDT)
Date:   Thu, 23 Mar 2023 12:20:27 -0700
In-Reply-To: <20230323192028.135759-1-irogers@google.com>
Message-Id: <20230323192028.135759-9-irogers@google.com>
Mime-Version: 1.0
References: <20230323192028.135759-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v2 8/9] perf metrics: Add has_optane literal
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

Add literal so that if optane memory isn't installed we can record
fewer events.  The file detection mechanism was suggested by Dan
Williams <dan.j.williams@intel.com> in:
https://lore.kernel.org/linux-perf-users/641bbe1eced26_1b98bb29440@dwillia2-xfh.jf.intel.com.notmuch/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/expr.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
index d46a1878bc9e..a43cdda0b044 100644
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
 
+static double has_optane(void)
+{
+	static bool has_optane, cached;
+	const char *sysfs = sysfs__mountpoint();
+	char path[PATH_MAX];
+
+	if (!cached) {
+		snprintf(path, sizeof(path), "%s/firmware/acpi/tables/NFIT", sysfs);
+		has_optane = access(path, F_OK) == 0;
+		cached = true;
+	}
+	return has_optane ? 1.0 : 0.0;
+}
+
 double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx)
 {
 	const struct cpu_topology *topology;
@@ -449,6 +464,10 @@ double expr__get_literal(const char *literal, const struct expr_scanner_ctx *ctx
 		result = perf_pmu__cpu_slots_per_cycle();
 		goto out;
 	}
+	if (!strcmp("#has_optane", literal)) {
+		result = has_optane();
+		goto out;
+	}
 
 	pr_err("Unrecognized literal '%s'", literal);
 out:
-- 
2.40.0.348.gf938b09366-goog

