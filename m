Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAC1C433EF
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Sep 2021 20:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2156461156
	for <linux-perf-users@archiver.kernel.org>; Tue, 21 Sep 2021 20:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhIUUu2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 21 Sep 2021 16:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbhIUUu1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 21 Sep 2021 16:50:27 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CECAC061757
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 13:48:58 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id w10-20020a0cb54a000000b0037a9848b92fso6697162qvd.0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Sep 2021 13:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YRlcwai5LvG85hd6NJ2+esADNJKAvO1QJ6LOzStIvoc=;
        b=cx4RaPiuNKucS5+fY05v1LAUQYp712Amt429aLOtH8a8ka46KPAEKxfwsXrsL6yLW1
         m+WlfS1neH18WD5ARNcB41n/PG0idYcgGY6G69i1KXY30wVDHCIFAXMmIvsSkPs8bpAc
         CiIYizrE/d4PhAc6ucG7SIHrWLJMhQHCED2E787XVwR28fHMLp1zFtSNzm6HmdvOFyrn
         ZKUqynWRefx2fM+ICY+L52VT8kiqkuRp5iY9jjdvly4xxZ2Q3nFgGufOHjwM3Qo3OGN2
         xhW9N+0HcXXmglPNPqfd0C7uf16O+m6qf0FxOw8MXch1B0Zr2JXRCEdcPVXzT25mhbVF
         KUsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YRlcwai5LvG85hd6NJ2+esADNJKAvO1QJ6LOzStIvoc=;
        b=7E0dsaVJvgpg1VEjoDBt8wQ51GA2S2Nux0CHrYd8MIXiXcrV3ovJqgIV1cfyDKPUHS
         6F8D3AtVMv3MLajcj/CUJx1XtWExyXGwmquiFzNfi+kJ/E/kgfH61E6zOOJz8NZm2vQu
         Nd2G8bXS1AuaAYhylvi8K+DsWsOQEoGbeFwvPvqd9L950Tpo20uIvMvRmfcIdPkuySkJ
         xBkMyQzVv2UIS9BspBHHfjMGcl8IvfMYh6WwelHoaPmsQSP5B/XUdpgbvFng4AnoH7bb
         GRQpOsWphyrgiYOnFzkFmfNJ1YWob+owsYyHF1gItXNLhlZkCU1YD7DFqx7+OTrfjGHe
         /ZfQ==
X-Gm-Message-State: AOAM532Qfkr9PLWAddy2zx/s/+fjCjRJdHTSDfhqlxbsgBql3oCoMnqZ
        /F4yzwNRbgfGhOMRDVH6ApCirmu8XwvD
X-Google-Smtp-Source: ABdhPJy7pzI+58A/rFxsyE7qXX7Ruf8kuENwAlDeUpw1b6W37wfBiWGzDyGN2PwEYrHoXS953LTY0nQ6B+Z6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:dffa:819a:f0e2:47e])
 (user=irogers job=sendgmr) by 2002:a0c:ef04:: with SMTP id
 t4mr2006399qvr.61.1632257337601; Tue, 21 Sep 2021 13:48:57 -0700 (PDT)
Date:   Tue, 21 Sep 2021 13:48:39 -0700
In-Reply-To: <20210921204839.236840-1-irogers@google.com>
Message-Id: <20210921204839.236840-4-irogers@google.com>
Mime-Version: 1.0
References: <20210921204839.236840-1-irogers@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v2 4/4] libtraceevent: Increase libtraceevent logging when verbose
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
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
The code is conditionally enabled based on the libtraceevent version as
discussed in the RFC:
https://lore.kernel.org/lkml/20210610060643.595673-1-irogers@google.com/

v2. Is a rebase and handles the case of building without
    LIBTRACEEVENT_DYNAMIC.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/debug.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 2c06abf6dcd2..c7a9fa0ffae9 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -24,6 +24,16 @@
 #include "util/parse-sublevel-options.h"
 
 #include <linux/ctype.h>
+#include <traceevent/event-parse.h>
+
+#define MAKE_LIBTRACEEVENT_VERSION(a, b, c) ((a)*255*255+(b)*255+(c))
+#ifndef LIBTRACEEVENT_VERSION
+/*
+ * If LIBTRACEEVENT_VERSION wasn't computed then set to version 1.1.0 that ships
+ * with the Linux kernel tools.
+ */
+#define LIBTRACEEVENT_VERSION MAKE_LIBTRACEEVENT_VERSION(1, 1, 0)
+#endif
 
 int verbose;
 int debug_peo_args;
@@ -228,6 +238,15 @@ int perf_debug_option(const char *str)
 	/* Allow only verbose value in range (0, 10), otherwise set 0. */
 	verbose = (verbose < 0) || (verbose > 10) ? 0 : verbose;
 
+#if MAKE_LIBTRACEEVENT_VERSION(1, 3, 0) <= LIBTRACEEVENT_VERSION
+	if (verbose == 1)
+		tep_set_loglevel(TEP_LOG_INFO);
+	else if (verbose == 2)
+		tep_set_loglevel(TEP_LOG_DEBUG);
+	else if (verbose >= 3)
+		tep_set_loglevel(TEP_LOG_ALL);
+#endif
+
 	return 0;
 }
 
-- 
2.33.0.464.g1972c5931b-goog

