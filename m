Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90E7C76195
	for <linux-perf-users@archiver.kernel.org>; Tue, 28 Mar 2023 01:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjC1Ble (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 27 Mar 2023 21:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbjC1Blc (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 27 Mar 2023 21:41:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C857212B
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Mar 2023 18:41:29 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y144-20020a253296000000b00b69ce0e6f2dso10531747yby.18
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Mar 2023 18:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679967688;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=verDCOyK5Vg94wY3RYziaAnvJXO3pRUoQeewltL/GMo=;
        b=ndnM0GnxAOGbyZy68kGiLzbQMq4EeNAsxSUT51Bn6RMCvx2haDbE+mktB1A7n60kkf
         LutpwxHw8zyfU9PxO983Ja7NQcDetX6Z2aa9dt8IwGXI/HJ/9IOIu2Pvebk4pyfG815X
         xM0/qdH1XYOdZkC4QIeYFOVRFdSHjBVkrm7FxGI/JsU5Z971jcdx70WuEksPrOwW4mMQ
         u+R5U77kTBA3RtHekOgY8tlhG5HjoUmpbq4siVNJNUoekTQ2yEgcIsDWqxcr3+VaVMRl
         2rR5mhMfyO7QsW304uMlWQ7pblkGURwaXaLW3G5XeMCXPOqvC/rAiRbxB/1tsEa4IJgG
         YdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679967688;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=verDCOyK5Vg94wY3RYziaAnvJXO3pRUoQeewltL/GMo=;
        b=PZHz3iHjHmlK49PLCEe1P+GPG5x0TrdU8nJTPEr04Y6WPuhVyhdJx+w7HC8DQgATR7
         Vdqkp4gJsFV/oqqFVe0Rnq2jJ6ORv6+MwDHV9KatY0Gyl+cK0z2ZlCaL3xqc9R+94Zb2
         +x6YGUrxgxrtIO4Cphv5E86x6JsAGfAF1RC/3dzA/XKUO9R86MoKxZwlrts7vaOB8DXb
         jjH3ghjFiAfqsNEdZC7zT0ba23hYdmJO1P9QK/jWLt0OwVLlj5d8dJb1Z+WH9rijQcHk
         EMjNaYwLzeIkQbNgFRiGAFLHx6z9tQgGjgWHD2U6vqPztCD43cQTs+2vOW5PVmMvGMy7
         hesQ==
X-Gm-Message-State: AAQBX9e/uzPcRAjTx5XsUug+zLQWyDPJ/MNutce/CMkeGzl4TdhtW/I/
        LHyP1zFa8QBqAOfmli+1urp95x2lXUla
X-Google-Smtp-Source: AKy350YwGBCHh+XFGIs5PnSfm8ziU1iAddLYb++rz17r47e/PoS0PBSTU4sb5sYQtlNpV7zfvdyxIqDVAcsK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:a544:20a5:5228:d98f])
 (user=irogers job=sendgmr) by 2002:a81:ac13:0:b0:545:bade:c57e with SMTP id
 k19-20020a81ac13000000b00545badec57emr4179381ywh.5.1679967687965; Mon, 27 Mar
 2023 18:41:27 -0700 (PDT)
Date:   Mon, 27 Mar 2023 18:40:54 -0700
In-Reply-To: <20230328014058.870413-1-irogers@google.com>
Message-Id: <20230328014058.870413-3-irogers@google.com>
Mime-Version: 1.0
References: <20230328014058.870413-1-irogers@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Subject: [PATCH v1 2/6] perf usage: Move usage strings
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

This simplifies linking a main function when perf.c isn't present.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-help.c | 1 +
 tools/perf/builtin.h      | 3 ---
 tools/perf/perf.c         | 6 ------
 tools/perf/util/usage.c   | 6 ++++++
 tools/perf/util/util.h    | 3 +++
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-help.c b/tools/perf/builtin-help.c
index 3976aebe3677..3e7f52054fac 100644
--- a/tools/perf/builtin-help.c
+++ b/tools/perf/builtin-help.c
@@ -14,6 +14,7 @@
 #include <subcmd/run-command.h>
 #include <subcmd/help.h>
 #include "util/debug.h"
+#include "util/util.h"
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
index d03afea86217..f2ab5bae2150 100644
--- a/tools/perf/builtin.h
+++ b/tools/perf/builtin.h
@@ -2,9 +2,6 @@
 #ifndef BUILTIN_H
 #define BUILTIN_H
 
-extern const char perf_usage_string[];
-extern const char perf_more_info_string[];
-
 void list_common_cmds_help(void);
 const char *help_unknown_cmd(const char *cmd);
 
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 4b1b31e78332..997bb9ea5ebc 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -39,12 +39,6 @@
 #include <linux/string.h>
 #include <linux/zalloc.h>
 
-const char perf_usage_string[] =
-	"perf [--version] [--help] [OPTIONS] COMMAND [ARGS]";
-
-const char perf_more_info_string[] =
-	"See 'perf help COMMAND' for more information on a specific command.";
-
 static int use_pager = -1;
 const char *input_name;
 
diff --git a/tools/perf/util/usage.c b/tools/perf/util/usage.c
index 196438ee4c9d..4c8ffbad2323 100644
--- a/tools/perf/util/usage.c
+++ b/tools/perf/util/usage.c
@@ -12,6 +12,12 @@
 #include <stdlib.h>
 #include <linux/compiler.h>
 
+const char perf_usage_string[] =
+	"perf [--version] [--help] [OPTIONS] COMMAND [ARGS]";
+
+const char perf_more_info_string[] =
+	"See 'perf help COMMAND' for more information on a specific command.";
+
 static __noreturn void usage_builtin(const char *err)
 {
 	fprintf(stderr, "\n Usage: %s\n", err);
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 1d3b300af5a1..5010abf9e01e 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -15,6 +15,9 @@
 #include <internal/cpumap.h>
 #endif
 
+extern const char perf_usage_string[];
+extern const char perf_more_info_string[];
+
 /* General helper functions */
 void usage(const char *err) __noreturn;
 void die(const char *err, ...) __noreturn __printf(1, 2);
-- 
2.40.0.348.gf938b09366-goog

