Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94A1C46467
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Jan 2023 07:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjAKHHM (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 11 Jan 2023 02:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234716AbjAKHHK (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 11 Jan 2023 02:07:10 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4C4B499
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Jan 2023 23:07:09 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-482d3bf0266so152820377b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Jan 2023 23:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NFrSxVrfdRZYprem1a+EonI6bqjM3AdjO9gRlJ+kQ1E=;
        b=MO/3evZ7yJJjjP0LMQV02qoI0xTtd6ha4a5z3beUr4g0O6L8XONbEla8E2UdAZJIbf
         84d93jxMcIe/UtdsXQcdt7czglCY/neqTcmt6w5Io248fs3NJqvNmufUyQJujptJGxZy
         3WmXrND91U9ecYTl4mOmCiwhRPOXiAh6TpgPmLbKp1sNihUYYzMD+O/diiFqdg56XIKm
         Ln/GcLW6voOZp4w/UOreYmTpKzpxGVVN9OIN2cv4npA3nLuNohm5USCvFybojI+eWR3X
         OunlVvkVtHpoEL4jFNB411m19HuOMIiY+maxmTRvTDXnwgqZbFtk5TsPxrk0ZiEt5cl6
         1uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFrSxVrfdRZYprem1a+EonI6bqjM3AdjO9gRlJ+kQ1E=;
        b=Sn5+PLZso29CBzHo7HJhm7pkdyLsdU2gP5ssSjHca7RIhVkEhZDj3UI49M0+isYEUT
         qSLGQl4VNGVEuFFWOzokZuw6kQ3vt56aRmM6OFqzcvrlph2ZrvdorEbIApmcBUQgxU2x
         4z299shIq6t/1qT15isNf1PGf5Olb7A6zIRARQrFwHLwqWsqT+ODMR5+YJzN0Tel9ER6
         h7HOZ2h4k/J5M/0TCM9W2XR2sYioNzEY11gfXcOunzbuPKlZ+v/y1RHDOlrk9hJS1pPN
         hGKB6s3rCBNU7IK1+Z0YwAJGKhoBCMVUImM2oz4aTYaaEHlXeER4nMIuKHl4I/hOpmZL
         0H5g==
X-Gm-Message-State: AFqh2kov2HthepyJ/OwrCy0QK8e9nX9veO4AQvBcItfev3IUtKYkTaPG
        gNoqbFHij28DxxHFIyKehKUzuBpkvs6i
X-Google-Smtp-Source: AMrXdXvQpil6jNPjSq/pZkWtOVRcWOV7+fsElOsbRFULBMoe4nkR1bf1Twel/XVb4Qj+4pg7OVSInxkCfaDU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:cebf:c37e:8184:56])
 (user=irogers job=sendgmr) by 2002:a25:3758:0:b0:7b5:f176:e485 with SMTP id
 e85-20020a253758000000b007b5f176e485mr2208774yba.556.1673420828555; Tue, 10
 Jan 2023 23:07:08 -0800 (PST)
Date:   Tue, 10 Jan 2023 23:06:41 -0800
In-Reply-To: <20230111070641.1728726-1-irogers@google.com>
Message-Id: <20230111070641.1728726-3-irogers@google.com>
Mime-Version: 1.0
References: <20230111070641.1728726-1-irogers@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Subject: [PATCH v2 3/3] perf debug: Increase libtraceevent logging when verbose
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Leo Yan <leo.yan@linaro.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

libtraceevent has added more levels of debug printout and with changes
like:
https://lore.kernel.org/linux-trace-devel/20210507095022.1079364-3-tz.stoyanov@gmail.com
previously generated output like "registering plugin" is no longer
displayed. This change makes it so that if perf's verbose debug output
is enabled then the debug and info libtraceevent messages can be
displayed.

This change was previously posted:
https://lore.kernel.org/linux-perf-users/20210923001024.550263-4-irogers@google.com/
and reverted:
https://lore.kernel.org/linux-perf-users/20220109153446.160593-1-acme@kernel.org/
The previous failure was due to -Itools/lib being on the include path
and libtraceevent in tools/lib being version 1.1.0. This meant that
when LIBTRACEEVENT_VERSION was 1.3.0 the #if succeeded, but the header
file for libtraceevent (taken from tools/lib rather than the intended
/usr/include) was for version 1.1.0 and function definitions were
missing.

Since the previous issue the -Itools/lib include path has been
removed:
https://lore.kernel.org/lkml/20221109184914.1357295-1-irogers@google.com/
As well as libtraceevent 1.1.0 has been removed from tools/lib:
https://lore.kernel.org/lkml/20221130062935.2219247-1-irogers@google.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/debug.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 190e818a0717..88378c4c5dd9 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -19,12 +19,19 @@
 #include "debug.h"
 #include "print_binary.h"
 #include "target.h"
+#include "trace-event.h"
 #include "ui/helpline.h"
 #include "ui/ui.h"
 #include "util/parse-sublevel-options.h"
 
 #include <linux/ctype.h>
 
+#ifdef HAVE_LIBTRACEEVENT
+#include <traceevent/event-parse.h>
+#else
+#define LIBTRACEEVENT_VERSION 0
+#endif
+
 int verbose;
 int debug_peo_args;
 bool dump_trace = false, quiet = false;
@@ -228,6 +235,14 @@ int perf_debug_option(const char *str)
 	/* Allow only verbose value in range (0, 10), otherwise set 0. */
 	verbose = (verbose < 0) || (verbose > 10) ? 0 : verbose;
 
+#if LIBTRACEEVENT_VERSION >= MAKE_LIBTRACEEVENT_VERSION(1, 3, 0)
+	if (verbose == 1)
+		tep_set_loglevel(TEP_LOG_INFO);
+	else if (verbose == 2)
+		tep_set_loglevel(TEP_LOG_DEBUG);
+	else if (verbose >= 3)
+		tep_set_loglevel(TEP_LOG_ALL);
+#endif
 	return 0;
 }
 
-- 
2.39.0.314.g84b9a713c41-goog

