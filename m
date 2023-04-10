Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AACC77B70
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Apr 2023 16:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjDJQ0x (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Apr 2023 12:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjDJQ0d (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Apr 2023 12:26:33 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D851BEF
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Apr 2023 09:26:19 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id v8-20020a17090a520800b0023fe33f8825so1335650pjh.9
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Apr 2023 09:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1681143979;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ENoaaMVMubn/KcAmMx1x6HeWtqhy9i1fT7aioBHDXcc=;
        b=fkdy28z/x/2Y6DzjeJO8cFcorqVS2iQDlBg6nwCCEsLmc0YSKFWRkDDUBgK4Qh1ssz
         iwDNO8Hd67Ef16nRflOkFUiIt5a51EaDJfN8UTwPD/whOCTFh3F84c8IR+pfECYUKq7g
         r13FbXs8yGWePJRNzWzgWMNv8kD4JnSxRR/XCbXBwGw2C3tBkdCU1AtzfP0MjS9tH/Hj
         DoiqwLgdulk6HRVolSVLCb/W+HEc28AwroX6CCqmdX984fjU6q0/20gcNlvwMzy2kJbA
         AQ5UfAuoCMSmIFeZaNhmzckv86+tjNerhMdEve/6c13D+HEOOq85zJhaNLfcdRtH0s2x
         bQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681143979;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ENoaaMVMubn/KcAmMx1x6HeWtqhy9i1fT7aioBHDXcc=;
        b=N67ugMP1Shw0Znz9QktQL7tmd33nD0rKmrW5BBoeESFsaek23ASv91nLJ+FgijYJpP
         jvxXwkeA8yGHNHOAe48QKUxNVTr9Dmudrb+zvrJKPf0WvPtSwux6G9TWVybQ84xPnk6d
         FXIgtWfgBQkWte2J15iVlH70ka1QOlEcHg8nrSf2XdPxPvOMQvaYJC4e/5VBPJyeRbZ6
         u1pVy4jfaKuHopuNNt26BQ9Msk0oQgGkb8F5IM8LBiSfFZB4Qgtgru5wVDO+Ozsa6/iF
         LfFt8LyDc9vX6jCmWHeCj9/jFkhLeY5jKAMj/XQbxlP2Ksx/hvzwBwQtcoL16wTiK/zg
         R2jQ==
X-Gm-Message-State: AAQBX9cwuVFq4qwp3/8FhwqUbolcHtQFrcQC1fUt/u2ID6OnkSmQw2YI
        nut38qS9W3mMXzBYwfmzpdUw8DrfCQ2h
X-Google-Smtp-Source: AKy350bzXEkhKfRJnIJa5gh4FNDi8DMbaX5c5UaYQ5moE3r6h9mw8wVurekcapCgL+GPU6sq4aikyT8kE+VD
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:fc51:6a03:541d:a18d])
 (user=irogers job=sendgmr) by 2002:a63:4466:0:b0:509:4ac5:7f3a with SMTP id
 t38-20020a634466000000b005094ac57f3amr2582205pgk.0.1681143979133; Mon, 10 Apr
 2023 09:26:19 -0700 (PDT)
Date:   Mon, 10 Apr 2023 09:25:11 -0700
In-Reply-To: <20230410162511.3055900-1-irogers@google.com>
Message-Id: <20230410162511.3055900-7-irogers@google.com>
Mime-Version: 1.0
References: <20230410162511.3055900-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Subject: [PATCH v2 6/6] perf util: Move perf_guest/host declarations
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
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Raul Silvera <rsilvera@google.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Rob Herring <robh@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Chengdong Li <chengdongli@tencent.com>,
        Denis Nikitin <denik@chromium.org>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The definitions are in util.c so move the declarations to match.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-diff.c      | 2 +-
 tools/perf/builtin-kvm.c       | 1 +
 tools/perf/perf.h              | 4 ----
 tools/perf/ui/hist.c           | 2 +-
 tools/perf/util/cs-etm.c       | 1 +
 tools/perf/util/event.c        | 2 +-
 tools/perf/util/evlist.c       | 1 +
 tools/perf/util/parse-events.c | 2 +-
 tools/perf/util/session.c      | 2 +-
 tools/perf/util/top.c          | 2 +-
 tools/perf/util/util.h         | 3 +++
 11 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 22b526766e14..dbb0562d6a4f 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -6,7 +6,6 @@
  * DSOs and symbol information, sort them and produce a diff.
  */
 #include "builtin.h"
-#include "perf.h"
 
 #include "util/debug.h"
 #include "util/event.h"
@@ -26,6 +25,7 @@
 #include "util/spark.h"
 #include "util/block-info.h"
 #include "util/stream.h"
+#include "util/util.h"
 #include <linux/err.h>
 #include <linux/zalloc.h>
 #include <subcmd/pager.h>
diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
index fb9dc0dc46f9..747d19336340 100644
--- a/tools/perf/builtin-kvm.c
+++ b/tools/perf/builtin-kvm.c
@@ -23,6 +23,7 @@
 #include "util/data.h"
 #include "util/ordered-events.h"
 #include "util/kvm-stat.h"
+#include "util/util.h"
 #include "ui/browsers/hists.h"
 #include "ui/progress.h"
 #include "ui/ui.h"
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 49e15e2be49e..c004dd4e65a3 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -2,14 +2,10 @@
 #ifndef _PERF_PERF_H
 #define _PERF_PERF_H
 
-#include <stdbool.h>
-
 #ifndef MAX_NR_CPUS
 #define MAX_NR_CPUS			2048
 #endif
 
-extern bool perf_host, perf_guest;
-
 enum perf_affinity {
 	PERF_AFFINITY_SYS = 0,
 	PERF_AFFINITY_NODE,
diff --git a/tools/perf/ui/hist.c b/tools/perf/ui/hist.c
index 5075ecead5f3..f164bd26fc41 100644
--- a/tools/perf/ui/hist.c
+++ b/tools/perf/ui/hist.c
@@ -11,7 +11,7 @@
 #include "../util/sort.h"
 #include "../util/evsel.h"
 #include "../util/evlist.h"
-#include "../perf.h"
+#include "../util/util.h"
 
 /* hist period print (hpp) functions */
 
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 944835e16430..103865968700 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -38,6 +38,7 @@
 #include "tsc.h"
 #include <tools/libc_compat.h>
 #include "util/synthetic-events.h"
+#include "util/util.h"
 
 struct cs_etm_auxtrace {
 	struct auxtrace auxtrace;
diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
index 13f7f85e92e1..8ae742e32e3c 100644
--- a/tools/perf/util/event.c
+++ b/tools/perf/util/event.c
@@ -33,7 +33,7 @@
 #include "bpf-event.h"
 #include "print_binary.h"
 #include "tool.h"
-#include "../perf.h"
+#include "util.h"
 
 static const char *perf_event__names[] = {
 	[0]					= "TOTAL",
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index cc491a037836..df6af38ca22e 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -32,6 +32,7 @@
 #include "util/pmu.h"
 #include "util/sample.h"
 #include "util/bpf-filter.h"
+#include "util/util.h"
 #include <signal.h>
 #include <unistd.h>
 #include <sched.h>
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 0010e5e0ee68..f341995cb04e 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -25,10 +25,10 @@
 #include "util/parse-branch-options.h"
 #include "util/evsel_config.h"
 #include "util/event.h"
-#include "perf.h"
 #include "util/parse-events-hybrid.h"
 #include "util/pmu-hybrid.h"
 #include "util/bpf-filter.h"
+#include "util/util.h"
 #include "tracepoint.h"
 #include "thread_map.h"
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7d8d057d1772..e2806791c76a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -33,7 +33,7 @@
 #include "stat.h"
 #include "tsc.h"
 #include "ui/progress.h"
-#include "../perf.h"
+#include "util.h"
 #include "arch/common.h"
 #include "units.h"
 #include <internal/lib.h>
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index b8b32431d2f7..be7157de0451 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -11,7 +11,7 @@
 #include "parse-events.h"
 #include "symbol.h"
 #include "top.h"
-#include "../perf.h"
+#include "util.h"
 #include <inttypes.h>
 
 #define SNPRINTF(buf, size, fmt, args...) \
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 8bd515b67739..7c8915d92dca 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -20,6 +20,9 @@ extern const char perf_more_info_string[];
 
 extern const char *input_name;
 
+extern bool perf_host;
+extern bool perf_guest;
+
 /* General helper functions */
 void usage(const char *err) __noreturn;
 void die(const char *err, ...) __noreturn __printf(1, 2);
-- 
2.40.0.577.gac1e443424-goog

