Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A788C4338F
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6659760FE8
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239608AbhHTKzd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239478AbhHTKzP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 06:55:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA0BC0612AD;
        Fri, 20 Aug 2021 03:54:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r19so13354947eds.13;
        Fri, 20 Aug 2021 03:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L7QHu74I01dc1FE7Nbl6f48bT1s7R3OY2qQF09h9Bbs=;
        b=rsKLY3CieE6e1FPoqQmGK0tZzKJtc/ah2ScOE2u/7uWUe3V90iP8wF57N+ER+/iqzl
         sdfLG+REzRltj3wIeN0A82vaYPt4NC8YIH+3lHH6CX+0tidfnFJabsfHQvj+1huO9i7K
         edfG7rT9hBBxAQZsKd2At1tgs0cO3iAjedP3xQsw/GhG9x6FRlCplPGUEqRBedvNJgdV
         hW6qfKDQq9nwOh+ZAt0dmcXLV7JpFhHCNTwgCMyI4MBdfdgK5STs0ekSHJ9XXFN954Qo
         W3rtfoEg2DOrC/SheYOPh74OwXU1ENgitQeDQ4F+ZkIpATEe1SB1BrUeDxwuFgao/K3j
         kufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L7QHu74I01dc1FE7Nbl6f48bT1s7R3OY2qQF09h9Bbs=;
        b=qtQZUIUnDlLsVundr1RgQM4Pb21uOUysdoE0OQFsuPY/PJEVM0p50rVENVo/pKF00A
         5Zly7IVxwG+7fgWUrr+LUf1UIqYukAJHAbofdcGJwZV++PUHbAZlGo8bN7dTR/wt/VBq
         uKPWQGy49ZNoacT8E2n2uWuKKmJZ7xqKM+gk8ASTYoPfuM1mg00gjXSng7XijccNCojX
         elw8Vn/o8hP196axsa09ob7P4Ffx0Sr/8SLbGuaA7PKb9oBTush/qW5XySNJd01ypNry
         jlWloio2dA0EhS1OyET67F0VisRwfwV174JFVSNxbm93JUzMFvdSxvXn/EmE7iwMtoF0
         5psw==
X-Gm-Message-State: AOAM533W8+8dRJbmB/j5lW1c1Qamjoqs5tFD5N8rJJmoteKtUSt5z5zF
        eIragqyx/FN/v6rK6KDtxIw=
X-Google-Smtp-Source: ABdhPJzaK2X/Ig1CrjdXwDVCt/1WmKT7Om0a8PW3vPp9zvso+emdsTW4+2ayLWFo32wPgDVm61NmqA==
X-Received: by 2002:aa7:c790:: with SMTP id n16mr21754078eds.223.1629456874674;
        Fri, 20 Aug 2021 03:54:34 -0700 (PDT)
Received: from honeypot.epfl.ch (mob-176-243-199-7.net.vodafone.it. [176.243.199.7])
        by smtp.googlemail.com with ESMTPSA id g29sm3451459edf.31.2021.08.20.03.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 03:54:34 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v3 14/15] perf test/synthesis: setup global workqueue
Date:   Fri, 20 Aug 2021 12:54:00 +0200
Message-Id: <17b1c402f4a2f82f784ef40de6c7b62d8c6846ed.1629454773.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629454773.git.rickyman7@gmail.com>
References: <cover.1629454773.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch sets up the global workqueue in the synthesis test.
The next patch will use it for synthesis.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/bench/synthesize.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/synthesize.c b/tools/perf/bench/synthesize.c
index 05f7c923c745b4e8..738821113a005a6c 100644
--- a/tools/perf/bench/synthesize.c
+++ b/tools/perf/bench/synthesize.c
@@ -16,6 +16,7 @@
 #include "../util/thread_map.h"
 #include "../util/tool.h"
 #include "../util/util.h"
+#include "../util/workqueue/workqueue.h"
 #include <linux/atomic.h>
 #include <linux/err.h>
 #include <linux/time64.h>
@@ -208,6 +209,7 @@ static int run_multi_threaded(void)
 	};
 	unsigned int nr_threads_synthesize;
 	int err;
+	char errbuf[BUFSIZ];
 
 	if (max_threads == UINT_MAX)
 		max_threads = sysconf(_SC_NPROCESSORS_ONLN);
@@ -219,10 +221,17 @@ static int run_multi_threaded(void)
 	for (nr_threads_synthesize = min_threads;
 	     nr_threads_synthesize <= max_threads;
 	     nr_threads_synthesize++) {
-		if (nr_threads_synthesize == 1)
+		if (nr_threads_synthesize == 1) {
 			perf_set_singlethreaded();
-		else
+		} else {
+			err = setup_global_workqueue(nr_threads_synthesize);
+			if (err) {
+				create_workqueue_strerror(global_wq, errbuf, sizeof(errbuf));
+				pr_err("setup_global_workqueue: %s\n", errbuf);
+				return err;
+			}
 			perf_set_multithreaded();
+		}
 
 		printf("  Number of synthesis threads: %u\n",
 			nr_threads_synthesize);
@@ -230,6 +239,9 @@ static int run_multi_threaded(void)
 		err = do_run_multi_threaded(&target, nr_threads_synthesize);
 		if (err)
 			return err;
+
+		if (nr_threads_synthesize > 1)
+			teardown_global_workqueue();
 	}
 	perf_set_singlethreaded();
 	return 0;
-- 
2.31.1

