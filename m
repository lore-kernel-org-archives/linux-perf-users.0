Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082FBC4338F
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 06:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6A961042
	for <linux-perf-users@archiver.kernel.org>; Thu, 29 Jul 2021 06:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbhG2GZD (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 02:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbhG2GZC (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 29 Jul 2021 02:25:02 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F79C061765
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Jul 2021 23:25:00 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y125-20020a2532830000b029058328f1b02eso5480965yby.7
        for <linux-perf-users@vger.kernel.org>; Wed, 28 Jul 2021 23:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BFgxncVDj5jCNzVVsA7tSI3+CxqTrEq04XR7t3uim6A=;
        b=jyZoaRrWr6+mCcNQhxux2+kKNDSn/zDW4PyxlSvUYousZN6mgZ/lqxBJj3D/mxwdSN
         3m6huorXRcVFzwHtlIYOCCa9jRH8oEAO6sfQPdm+UhhNqJGa4jtbqpfx9ohVuIGWMKA7
         zEtRDGm42rvD7alADwYSvvvXYZ6cKe+j1SwAbDS/U0VxjHwIUWLQpzzOnAVs4FWSJa+z
         DWRIyAgGdKUU6S4KsKoE9MtdDk1zTCaPp9ivYYKe4dDW6OduPIsql06/yRGHR76SrgRO
         hjLOcGYnq14hA40cnPQ4WF4RkfLzEbZ77hroOHrdT1/gyh2K62njRRfX5a+JYgRZbNqn
         /SNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BFgxncVDj5jCNzVVsA7tSI3+CxqTrEq04XR7t3uim6A=;
        b=WbaNqSor9l2xvz37mSui7N6XINN8+Emsq72L1qSBLaHRv8yLKotXv41nipYUkMXY06
         3HBzjHIRm3HTzWyxJuEOwdTGb6G5c7eHsZ9hs8FJRnutyCy6ptIaE3bIgEMoagDaFCBO
         v0v1g89py8vcdz4WNGfhZkVYXz34cHgCEm+xkqy91B8un74P64gUQpAbXUe4GyTzUo4b
         2n6iHuaHAtPjkGSPiZjvJHaaEkHH2zCubv3kltVA+GzZeGRKcoMIXtMIp1JaVzxgHW3K
         uBFg1CIQEcB+ZqYdo8Gby2m/7vdqL5xaQLmMwOLwCzaUNfBeV5cosSbajxrunuy4sa4f
         NrFA==
X-Gm-Message-State: AOAM533cFOngbjLUnGu5ekKfMAA1B+FbEwlVfe8ZO2orDlZgn9HUX9qZ
        AbSB2lfFkGxjRid/MN57fkHKsI4WYUic
X-Google-Smtp-Source: ABdhPJza0pEGLNIWpVqaTumyFFNYcohPp9sSrl3Mba2QXUty4R0wrRhVwA5hXh1VTPh+5BSOzsrmdrMUUfQl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:8f98:bc28:73a6:e8c9])
 (user=irogers job=sendgmr) by 2002:a25:6e55:: with SMTP id
 j82mr4540463ybc.480.1627539899394; Wed, 28 Jul 2021 23:24:59 -0700 (PDT)
Date:   Wed, 28 Jul 2021 23:24:49 -0700
In-Reply-To: <20210729062451.1349566-1-irogers@google.com>
Message-Id: <20210729062451.1349566-2-irogers@google.com>
Mime-Version: 1.0
References: <20210729062451.1349566-1-irogers@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH 1/3] libperf: Prefer exit(EXIT_SUCCESS) over exit(0)
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Change exit code to be more intention revealing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/tests/test-evlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/tests/test-evlist.c b/tools/lib/perf/tests/test-evlist.c
index c67c83399170..eceacd4b014c 100644
--- a/tools/lib/perf/tests/test-evlist.c
+++ b/tools/lib/perf/tests/test-evlist.c
@@ -251,7 +251,7 @@ static int test_mmap_thread(void)
 		for (i = 0; i < 100; i++)
 			prctl(0, 0, 0, 0, 0);
 
-		exit(0);
+		exit(EXIT_SUCCESS);
 	}
 
 	threads = perf_thread_map__new_dummy();
-- 
2.32.0.432.gabb21c7263-goog

