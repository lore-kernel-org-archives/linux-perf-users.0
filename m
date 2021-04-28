Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C319C433B4
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Apr 2021 11:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 344E661418
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Apr 2021 11:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbhD1L7P (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Apr 2021 07:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhD1L7O (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Apr 2021 07:59:14 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB3EC06138A
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Apr 2021 04:58:25 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id p12so44531125pgj.10
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Apr 2021 04:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQ0ISyAjNzzN5FfydaMjwX+cPn7rkfwWXqcYmZ5n8y4=;
        b=nkAe45KqUV8lqneAljLskYmN+NX/bFMFdenuL7r95cZ5iUd/Hug64A+i2eLzKuuV9C
         0IyIbwlngDbKhWRrVr8sHXq2ZxqrmpCWuY2s5wOkfckOoV1sJUGOgV8kEYywag2Evmdx
         BZ+eIGE+9YmGbJ7P6ivMbgzNDqqHNeTLVJ6T49LBhfhOoro+vW98u0xpfJF3blJal6rA
         tFaOF0fRjHwH38E10ZsDl7x0Z5fOm9jz2BC26LJZmEbaZSLTABQR9d/10jr3DuhCKadI
         ElWCa9aS+D3/m3kSWtmz9yZ7yxnVs3xikLFF47ZFy8iIRDTlOg+VnItQb4NATd6uxSKj
         iRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQ0ISyAjNzzN5FfydaMjwX+cPn7rkfwWXqcYmZ5n8y4=;
        b=mepJ3lSX4r8AwAhcasE4Jk99q4W3FF/ob9+npcln+IuuygenMZRjnadbwUoT8rwuYh
         10/MoM+VYuiw/1gaLb0mapt52am94LsrJzhIRzNYmZunUpnRRDeePFOPpWH3YGAHIHO6
         KKFyE1UHQyKqukbIVK58vMiDCjF2kfcS9p9c7oezLhrROpZnr0RkJVXSzVe0qIVknsbe
         K7t5YPt7rnbr+egt4l9O4KnXOVbFJ8k0REToYRoZx1FRHLO9SMdhHscNdZm7DRct6POW
         veN33h5tVvQZv538WVV31RX22AWaB6vyy1ZHIZ0GQDLawDH5zPbPJHhmPkltDvGjEKR5
         3cQg==
X-Gm-Message-State: AOAM531pZb95hpc4A4+LcA3O4gqvAlEyXSM+ba6OMy8ML6tT8BVbN5V0
        PGGfHacpWqHrDUoUPzDmx7mthOgrNCcP7NEV
X-Google-Smtp-Source: ABdhPJwPHfaeiZeHbakyDfBswIxtz4TkDrKRognFaYRCK9PLqpFTxL9pqn7YK/L/CVzMTmtzoZQYGw==
X-Received: by 2002:a05:6a00:d52:b029:275:c409:fe37 with SMTP id n18-20020a056a000d52b0290275c409fe37mr16371555pfv.0.1619611104963;
        Wed, 28 Apr 2021 04:58:24 -0700 (PDT)
Received: from localhost (ec2-18-166-74-158.ap-east-1.compute.amazonaws.com. [18.166.74.158])
        by smtp.gmail.com with ESMTPSA id a26sm5145016pff.149.2021.04.28.04.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 04:58:24 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 4/4] perf session: Dump PERF_RECORD_TIME_CONV event
Date:   Wed, 28 Apr 2021 19:57:49 +0800
Message-Id: <20210428115749.5229-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210428115749.5229-1-leo.yan@linaro.org>
References: <20210428115749.5229-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Now perf tool uses the common stub function process_event_op2_stub() for
dumping TIME_CONV event, thus it doesn't output the clock parameters
contained in the event.

This patch adds the callback function for dumping the hardware clock
parameters in TIME_CONV event.

Before:

  # perf report -D

  0x978 [0x38]: event: 79
  .
  . ... raw event: size 56 bytes
  .  0000:  4f 00 00 00 00 00 38 00 15 00 00 00 00 00 00 00  O.....8.........
  .  0010:  00 00 40 01 00 00 00 00 86 89 0b bf df ff ff ff  ..@........<BF><DF><FF><FF><FF>
  .  0020:  d1 c1 b2 39 03 00 00 00 ff ff ff ff ff ff ff 00  <D1><C1><B2>9....<FF><FF><FF><FF><FF><FF><FF>.
  .  0030:  01 01 00 00 00 00 00 00                          ........

  0 0 0x978 [0x38]: PERF_RECORD_TIME_CONV
  : unhandled!

  [...]

After:

  # perf report -D

  0x978 [0x38]: event: 79
  .
  . ... raw event: size 56 bytes
  .  0000:  4f 00 00 00 00 00 38 00 15 00 00 00 00 00 00 00  O.....8.........
  .  0010:  00 00 40 01 00 00 00 00 86 89 0b bf df ff ff ff  ..@........<BF><DF><FF><FF><FF>
  .  0020:  d1 c1 b2 39 03 00 00 00 ff ff ff ff ff ff ff 00  <D1><C1><B2>9....<FF><FF><FF><FF><FF><FF><FF>.
  .  0030:  01 01 00 00 00 00 00 00                          ........

  0 0 0x978 [0x38]: PERF_RECORD_TIME_CONV
  ... Time Shift      21
  ... Time Muliplier  20971520
  ... Time Zero       18446743935180835206
  ... Time Cycles     13852918225
  ... Time Mask       0xffffffffffffff
  ... Cap Time Zero   1
  ... Cap Time Short  1
  : unhandled!

  [...]

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/session.c | 13 ++++++++++++-
 tools/perf/util/tsc.c     | 30 ++++++++++++++++++++++++++++++
 tools/perf/util/tsc.h     |  4 ++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 1e3cab92042d..cb6f9344341e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -29,6 +29,7 @@
 #include "thread-stack.h"
 #include "sample-raw.h"
 #include "stat.h"
+#include "tsc.h"
 #include "ui/progress.h"
 #include "../perf.h"
 #include "arch/common.h"
@@ -451,6 +452,16 @@ static int process_stat_round_stub(struct perf_session *perf_session __maybe_unu
 	return 0;
 }
 
+static int process_event_time_conv_stub(struct perf_session *perf_session __maybe_unused,
+					union perf_event *event)
+{
+	if (dump_trace)
+		perf_event__fprintf_time_conv(event, stdout);
+
+	dump_printf(": unhandled!\n");
+	return 0;
+}
+
 static int perf_session__process_compressed_event_stub(struct perf_session *session __maybe_unused,
 						       union perf_event *event __maybe_unused,
 						       u64 file_offset __maybe_unused)
@@ -532,7 +543,7 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 	if (tool->stat_round == NULL)
 		tool->stat_round = process_stat_round_stub;
 	if (tool->time_conv == NULL)
-		tool->time_conv = process_event_op2_stub;
+		tool->time_conv = process_event_time_conv_stub;
 	if (tool->feature == NULL)
 		tool->feature = process_event_op2_stub;
 	if (tool->compressed == NULL)
diff --git a/tools/perf/util/tsc.c b/tools/perf/util/tsc.c
index 62b4c75c966c..f19791d46e99 100644
--- a/tools/perf/util/tsc.c
+++ b/tools/perf/util/tsc.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <inttypes.h>
+#include <string.h>
 
 #include <linux/compiler.h>
 #include <linux/perf_event.h>
@@ -110,3 +112,31 @@ u64 __weak rdtsc(void)
 {
 	return 0;
 }
+
+size_t perf_event__fprintf_time_conv(union perf_event *event, FILE *fp)
+{
+	struct perf_record_time_conv *tc = (struct perf_record_time_conv *)event;
+	size_t ret;
+
+	ret  = fprintf(fp, "\n... Time Shift      %" PRI_lu64 "\n", tc->time_shift);
+	ret += fprintf(fp, "... Time Muliplier  %" PRI_lu64 "\n", tc->time_mult);
+	ret += fprintf(fp, "... Time Zero       %" PRI_lu64 "\n", tc->time_zero);
+
+	/*
+	 * The event TIME_CONV was extended for the fields from "time_cycles"
+	 * when supported cap_user_time_short, for backward compatibility,
+	 * prints the extended fields only if they are contained in the event.
+	 */
+	if (event_contains(*tc, time_cycles)) {
+		ret += fprintf(fp, "... Time Cycles     %" PRI_lu64 "\n",
+			       tc->time_cycles);
+		ret += fprintf(fp, "... Time Mask       %#" PRI_lx64 "\n",
+			       tc->time_mask);
+		ret += fprintf(fp, "... Cap Time Zero   %" PRId32 "\n",
+			       tc->cap_user_time_zero);
+		ret += fprintf(fp, "... Cap Time Short  %" PRId32 "\n",
+			       tc->cap_user_time_short);
+	}
+
+	return ret;
+}
diff --git a/tools/perf/util/tsc.h b/tools/perf/util/tsc.h
index 72a15419f3b3..7d83a31732a7 100644
--- a/tools/perf/util/tsc.h
+++ b/tools/perf/util/tsc.h
@@ -4,6 +4,8 @@
 
 #include <linux/types.h>
 
+#include "event.h"
+
 struct perf_tsc_conversion {
 	u16 time_shift;
 	u32 time_mult;
@@ -24,4 +26,6 @@ u64 perf_time_to_tsc(u64 ns, struct perf_tsc_conversion *tc);
 u64 tsc_to_perf_time(u64 cyc, struct perf_tsc_conversion *tc);
 u64 rdtsc(void);
 
+size_t perf_event__fprintf_time_conv(union perf_event *event, FILE *fp);
+
 #endif // __PERF_TSC_H
-- 
2.25.1

