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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2383C48BD1
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 06:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0FF613E4
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Jun 2021 06:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhFJGJn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 10 Jun 2021 02:09:43 -0400
Received: from mail-qv1-f73.google.com ([209.85.219.73]:48682 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbhFJGJn (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Jun 2021 02:09:43 -0400
Received: by mail-qv1-f73.google.com with SMTP id g17-20020a0caad10000b029021886e075f0so19641355qvb.15
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Jun 2021 23:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Lg7NuraxXh2lGd7qtwMfaQYNPCgBXTD5T5nmYD665wQ=;
        b=XQDwLZHgrwTj2N7cSculUYKf7ggeGIYs7rmgGFNgCu63nPGWMljiUz7paT3UduyVph
         X9JtaGiZtU3nhFNvY1GVXyin2R/z4CefzNxlhW4K+Q+jWv62xcHPnMh2dbjqejXR9url
         mcz4H36GEvfkpCQbPk+hxJUS6ubSwmmrW6eAgCct0BFnBqkEBf2LCrJbnEh420GnmYno
         4lfomSXGx1EouNHpYce2HRHonMh8WbiOClMcXqW7dpiXoU6L/X6oQ8OQ8DrrH5Xibf5x
         U+9IfykvcPwpaKU0AfYBqpanzhoMdYc7dOLOdd2XejjXk/c5M76ZleDcxDWfxJqTG+1O
         +QFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Lg7NuraxXh2lGd7qtwMfaQYNPCgBXTD5T5nmYD665wQ=;
        b=uVtMDouA8W6FmhFvvcLsdfcjUoUr5g5bKohmPxNR58LiR9nOiCErSSzQynb9gai7Xh
         zHg0xaCLr1LQ3X0w963cj+eJzpybbOzoC7cqGqjf6fqKSRPhMwAwOTwhQ0bL40icRuuM
         k8D4pdWH4I73+xUANr8+OO8xURih1SeF+PZpMEoGfi8PEsVH5ITPZRmVc9BQO/gLDJiS
         umGasB+caJbNnenddH6ZJEyyV8KbGQqkjquKHwP5znbhkAbWHWBgfb6uRLOJ2MXT4jJZ
         1RTLio5STAjxeVO48y5rbr+g1aHhKrwcw4wkmja7nqd3SGPFd91dxbtUeI2hjdraL0e5
         NQkA==
X-Gm-Message-State: AOAM5328NJFXJbBmXP9pO9IyHUwvRpGqj7q7lfsqhf+ApMkq5bFn0lgP
        F60qKwWuCwK6Y+B+mTUFkbouvm0dpPzN
X-Google-Smtp-Source: ABdhPJzG/2358ozZYs12Ycqlx4w1jnfiR285NrgYiNH84RWzpWIUrE5BLAl8Upw+zzR7i5/BgZvTg7zCLSeq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:7996:689a:4aa:98a7])
 (user=irogers job=sendgmr) by 2002:a0c:fe45:: with SMTP id
 u5mr3629854qvs.53.1623305207282; Wed, 09 Jun 2021 23:06:47 -0700 (PDT)
Date:   Wed,  9 Jun 2021 23:06:43 -0700
Message-Id: <20210610060643.595673-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [RFC PATCH] libtraceevent: Increase libtraceevent logging when verbose
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-users@vger.kernel.org,
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
As this API isn't present in the deprecated tools version of
libtracevent I'm uploading this as an RFC.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/debug.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index 2c06abf6dcd2..700828e92fe1 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -24,6 +24,7 @@
 #include "util/parse-sublevel-options.h"
 
 #include <linux/ctype.h>
+#include <traceevent/event-parse.h>
 
 int verbose;
 int debug_peo_args;
@@ -228,6 +229,13 @@ int perf_debug_option(const char *str)
 	/* Allow only verbose value in range (0, 10), otherwise set 0. */
 	verbose = (verbose < 0) || (verbose > 10) ? 0 : verbose;
 
+	if (verbose == 1)
+		tep_set_loglevel(TEP_LOG_INFO);
+	else if (verbose == 2)
+		tep_set_loglevel(TEP_LOG_DEBUG);
+	else if (verbose >= 3)
+		tep_set_loglevel(TEP_LOG_ALL);
+
 	return 0;
 }
 
-- 
2.32.0.272.g935e593368-goog

