Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3648DECAAA1
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 19:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbiJXTIi (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbiJXTIT (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2022 15:08:19 -0400
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6991811540C
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 10:47:25 -0700 (PDT)
Received: by mail-oo1-f74.google.com with SMTP id w22-20020a4a9d16000000b00480e74f0addso4797174ooj.4
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 10:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hFzbgI1FGJfzvaw1p5CnFtlagUkgu7Ee7Fasb8Aycow=;
        b=g6qsNykjBvc8d3AMtRafZDv5pP5cGaxqxFeoYFGwLROZDHq+3WE2OKYgVBPVOjacpP
         Su1/KJ1NSg8qrV0haZyA6FY4ifaAtIIXYNxNPiIkdwfQ2D90z+QD1IlGh/RuxOWh7i2c
         VME/ZGXfkVOKwf52i6LRPxNoVKvaIcqHKhHTOIYGpRhjbjHoJkdkOpvZ88pUkrDAWJbd
         H9U69WkQT55DQxWyH4w6TKsAKG1luUqFVxlofXfJSOSNZe2uB2cFmt4300lCYBm2gv4L
         ovqlDuERntsgpv0Q3tM6N97YOvFooB+FhMo3fM41rUO1tHvbFUysFQORJzWsXB8HzkkY
         q4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hFzbgI1FGJfzvaw1p5CnFtlagUkgu7Ee7Fasb8Aycow=;
        b=FAlhjf4pfJD2HFmF6uTd2Xg7wUm17GZtAiojbC4KecR1x80Zas8eqqX7iy+wkgG4mB
         0c+GBeoWxDyN7vqviyKs5iR9u0FzOgIFapb2bl6Xaa+GKz0bvenRROcZcxvMzCLKjxH7
         3kYxvtwBHvq9edcRgDhYuvUL7hFZTqLpQgKNlrGYKfKi2nfyZhqh39FO9MKutvooiiO2
         RrtAYShYmsjtdlQo4pksNrTbVTJJtI9BKPxAMszQIh89eo1ca8GK3QVpgUzUlmBKWnIo
         50qNmmTElrMmrnfGnW+AMsabauXDTRRVi5dYr0Li6Wozdj30wU8b9cEfgmsl19mob2jx
         JQJw==
X-Gm-Message-State: ACrzQf3x18I/H3hZ6XdU/Ufo0M61fI/qCpeVfi8lgTk0GutMcHSute8k
        Zpj/fwi6WbTx077j9unTxgd7/zs6H2UY
X-Google-Smtp-Source: AMsMyM7mUsQM8EUDobG3QZ+jix6KAWAWUli4bv59QJYVuz1qp9NbUEOuW5M6v/oq3vRq+CSLYwvCIcA9tzN7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a17:90b:1b03:b0:20d:ac3b:f1dd with SMTP id
 nu3-20020a17090b1b0300b0020dac3bf1ddmr65650424pjb.121.1666632982742; Mon, 24
 Oct 2022 10:36:22 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:35:20 -0700
In-Reply-To: <20221024173523.602064-1-irogers@google.com>
Message-Id: <20221024173523.602064-6-irogers@google.com>
Mime-Version: 1.0
References: <20221024173523.602064-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v1 5/8] perf session: Change type to avoid UB
From:   Ian Rogers <irogers@google.com>
To:     Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

session_done is written to inside the signal handler of perf report
and script. Switch its type to avoid undefined behavior.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/session.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 1a4f10de29ff..ba52cc4092dc 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <stdatomic.h>
 #include <inttypes.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
@@ -2022,7 +2023,7 @@ static int perf_session__flush_thread_stacks(struct perf_session *session)
 					 NULL);
 }
 
-volatile int session_done;
+volatile sig_atomic_t session_done;
 
 static int __perf_session__process_decomp_events(struct perf_session *session);
 
-- 
2.38.0.135.g90850a2211-goog

