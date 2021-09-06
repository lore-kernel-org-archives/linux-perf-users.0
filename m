Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC354C433F5
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Sep 2021 01:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 853E960C3E
	for <linux-perf-users@archiver.kernel.org>; Mon,  6 Sep 2021 01:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbhIFByY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 5 Sep 2021 21:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbhIFByX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 5 Sep 2021 21:54:23 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32012C061757;
        Sun,  5 Sep 2021 18:53:20 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q68so5187507pga.9;
        Sun, 05 Sep 2021 18:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=4PiiYlxPArRq5bNiMMjosViIZMKcElEur95zboCrNWc=;
        b=UYSqN8uax4LRLi39QFa8Mz7ABGfHZ8ewGHROQoxi4wsxiwgIK0YIdBZ7M35lGC3r81
         Iwo2dw3LWZYTjTXTLm2D5jktMsJEAjQW0aIBWYYhJzrUc0o1pMo/avnBYhGqvdu7pQC1
         BcS5x1Kfa62L6YEeD6uw3nBds9PNbqbT3G/8bjb6bvtqPSaW41CT5mRu0ovlOIrXcO/K
         gXgeRukSwoE/MypUVWUvh9i/gw8em85bfudqRPZeym813AMv2JH6Si+bB4vkj6kbdQu3
         xqlndXQI2xbhNESwujcp4fO3751E0exp4jnbvVbFOFaHehvVlN7/S2IRFYuSBteOrzmz
         4kQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4PiiYlxPArRq5bNiMMjosViIZMKcElEur95zboCrNWc=;
        b=Ngl8JuJzZtoWrRT/e2Xbxf2d7jlDPHqnr2rV/Z8RHgWg9GgnHN/g4R54oYJ8Kk4a/z
         rlGV9S/1uPCZcrbx+qQjp/IdsQci4tkpMsznoBJhqZLXLWYlc8SXPvKVuoxyLEbwB0BD
         zjd4kTdkI+1mpkHTqlRZfNzoHG9BkOE+kjDuwDwalFquSZHVld3Y2jOV4iG16NOhmWSl
         SiExaWwykv9w7TeYE/3FzFe3h0Y5Pzupdvnlbm+9VnGhhi+1R2BbAuLgG5AaUvoHYMDD
         c2QbbJM7ihGt9uuRuEpWsDDL31KUlMNMpOhGNFzNA31VUcVyJca9/VMcb485XNKwYSon
         68Mw==
X-Gm-Message-State: AOAM530PXWcYwtOmVvM6v2RwPBHwPNqCr9W91hKtm9I8jQOfvQsRBKHP
        T86w5+tpoWNcN/IXzz5D/kk=
X-Google-Smtp-Source: ABdhPJwKyfZj/OJzI6XVdM1fGek0xGS2IzGTAr1CMphTAX1ZnA9VVy/1yw1xZJK1eWqDSTBaTo9ThA==
X-Received: by 2002:a63:3753:: with SMTP id g19mr9479040pgn.328.1630893199578;
        Sun, 05 Sep 2021 18:53:19 -0700 (PDT)
Received: from localhost (natp-s01-129-78-56-229.gw.usyd.edu.au. [129.78.56.229])
        by smtp.gmail.com with ESMTPSA id g7sm5704777pfr.126.2021.09.05.18.53.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Sep 2021 18:53:19 -0700 (PDT)
From:   Baptiste Lepers <baptiste.lepers@gmail.com>
Cc:     Baptiste Lepers <baptiste.lepers@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] events: Reuse value read using READ_ONCE instead of re-reading it
Date:   Mon,  6 Sep 2021 11:53:10 +1000
Message-Id: <20210906015310.12802-1-baptiste.lepers@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In perf_event_addr_filters_apply, the task associated with
the event (event->ctx->task) is read using READ_ONCE at the beginning
of the function, checked, and then re-read from event->ctx->task,
voiding all guarantees of the checks. Reuse the value that was read by
READ_ONCE to ensure the consistency of the task struct throughout the
function.

Signed-off-by: Baptiste Lepers <baptiste.lepers@gmail.com>
Fixes: 375637bc52495 ("perf/core: Introduce address range filtering")
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 744e8726c5b2..0c000cb01eeb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10193,7 +10193,7 @@ static void perf_event_addr_filters_apply(struct perf_event *event)
 		return;
 
 	if (ifh->nr_file_filters) {
-		mm = get_task_mm(event->ctx->task);
+		mm = get_task_mm(task);
 		if (!mm)
 			goto restart;
 
-- 
2.17.1

