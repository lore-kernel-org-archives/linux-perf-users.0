Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F369DC67871
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 Oct 2022 19:59:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJXT7r (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 Oct 2022 15:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233933AbiJXT63 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 Oct 2022 15:58:29 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA2927E075
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 11:21:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f126-20020a255184000000b006cb2aebd124so1843084ybb.11
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Oct 2022 11:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N6W+CXwQP9ZcH6ztCYE0MpcmSu0rfOg+3GfDaO039jk=;
        b=MyyCJTcbNDcWyLPc/QWROdPmUsiRtgLtA0uZwhDYIaxhjKZzDxzsl0LiHcpqoHsJtK
         1uA9haRF3y8/UUCcPDlSPw8+dqL3V6VLOOb6vGOCckQozVmUJ12d87C6a10LYnyDMeGe
         IOjzMYM+Qk/DMWgi1nw/qHPpKQ7Sjio4Z2pee+crAwV8uPUxdioh1H32O9lF+3yXMrsu
         p+uwpa6xXEwn9uUvYsT2zOZBhvGXMdYYIM+P+3FTnb4A/4gA6e0Ms4EsPIQgfnvBOp8I
         dX2qW7UCwOEVF89oEkT0K59f5ns6ha35MwcUu7PlLh6ia4fRViZXBJqniEWLj+wtEmsH
         1YHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N6W+CXwQP9ZcH6ztCYE0MpcmSu0rfOg+3GfDaO039jk=;
        b=mEUGnd9rYfYh86XIk8HGz1mAFaurb3WyoHIBb4ncDsFUmQ9xLN9GOcbPYBXM1a+pEB
         Ct757Pm2Hmq+3SB2o3IORyTk5HiAaiC7wytiGOYyMfag7pOzI7XhaNBJqcFixj3wzgq/
         tX4hRj3xAN7Fosh6XldbAd0nu6J5Kn4bdsecwqR270zRRN9hrtI5x5Yao0LNSLv7GDJV
         145TVlA743XXy4PP8IIrSldhPQvRyhn0s38DZI0WHjPc7B+GWDxhkP9yo70ctFODrI1X
         fxstF1nxLB+VawKASEsHvVeaRbsiy4tV5xxMIBuMjnlay5MJK9IwxmGfsTSCpPzymyef
         2bsA==
X-Gm-Message-State: ACrzQf2GwD1CqMdU5k59oYtDHvWBQu0L1ky1eYSmPNVNj+j5kLXApFHB
        1zQwImn8PMsWrxaiwNKq3HAHGjRZQ8JU
X-Google-Smtp-Source: AMsMyM452qYtauCW4EO7scWSZkNj9sZ2nSnvYtqYPGuBG/6+zXZy0eh9dOLzUYkV9HTbdEPxf+TKeyEWlaGY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:b8bc:a57d:a2a2:efdc])
 (user=irogers job=sendgmr) by 2002:a0d:d954:0:b0:368:d5ea:fc6a with SMTP id
 b81-20020a0dd954000000b00368d5eafc6amr20555995ywe.50.1666635616419; Mon, 24
 Oct 2022 11:20:16 -0700 (PDT)
Date:   Mon, 24 Oct 2022 11:19:10 -0700
In-Reply-To: <20221024181913.630986-1-irogers@google.com>
Message-Id: <20221024181913.630986-6-irogers@google.com>
Mime-Version: 1.0
References: <20221024181913.630986-1-irogers@google.com>
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Subject: [PATCH v2 5/8] perf session: Change type to avoid UB
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
index 1a4f10de29ff..0e1a3d6bacb9 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <errno.h>
+#include <signal.h>
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

