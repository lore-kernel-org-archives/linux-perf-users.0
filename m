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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE1DC433ED
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 May 2021 19:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E378C613E2
	for <linux-perf-users@archiver.kernel.org>; Tue,  4 May 2021 19:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232456AbhEDTob (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 4 May 2021 15:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232145AbhEDToa (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 4 May 2021 15:44:30 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99569C06174A
        for <linux-perf-users@vger.kernel.org>; Tue,  4 May 2021 12:43:34 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id i19-20020a0cf3930000b02901c3869f9a1dso62991qvk.5
        for <linux-perf-users@vger.kernel.org>; Tue, 04 May 2021 12:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1FnFnn4wDfYMWQqvn7hSz/1lOfOioIUbh4DjTNFjqJE=;
        b=kViYkO9TIKTlBg5tDqdI5ZVgGE5/StSOxh6VL+ktWyy3Y44ItEQ/XQPFu1fYX/vLKH
         FD4xtMj7hqXqwe3GNljcENVZqEaTXqypAWpLpyCtp4Cvch/jaghp35q6yFOQo0k0suJH
         GdYS1RoMMpiKs+RX7MBQmzJ3Ll1MRTBcCWQ6LsMF728Y99b8EPLY90ZRJq9ieQBR91gn
         /LLXVTKWdUNsp2bnaZdcuQei86vZWBjSvru1g3GEb0D/Sa8GlMCF5VIr62BZna9lL1ri
         E0nwPQ+RpVZT6TDaBg5o4bzPtpvatqs7ytFUhu1nQWrUt4ndC6UE6n7yARK3JTludK2U
         wPNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1FnFnn4wDfYMWQqvn7hSz/1lOfOioIUbh4DjTNFjqJE=;
        b=gEBuqM96PDQY92YsavIS/ClnPvEjLcVweFHHrBQOlnhG1hNCoNT/wZOI9PVtoH4hrj
         BRsgyaQ0fVRKG4p8I4taiZj1g7y7Yhft91Hb3b9dix/iq8N2kQTzmmvk8Rm5VnTlkasI
         U3TggGD1xXI8Fju1cxi9PZJ/Ee0dPTdkMiXC9adxShF4T+DVSxGmSIPKHiNRNnSBJQmA
         hhaaHwD6XWGWu3tt1/jtnxpI2dknkg95AOH7kn6CYpt3CusWkOPlIo6sakY9P0sD/wBR
         Tow/hg6CVuDYd7qLvywJSXLJCQLKjeme160uisXUCy1cYN2t5MDmyJjd8XsEbpSI4+5H
         qhNA==
X-Gm-Message-State: AOAM532vA0Zej9ibv3TcHwV9ua3xGosGIvvIjoz+sPPK9NxzlL2GqY4n
        lBR4CsDW2OXxNtnilKZZxc3YSgeL5NXC
X-Google-Smtp-Source: ABdhPJwKkimx4a054iRJK7kgTW2d9OhbvG1mRn/VpC5JH8W6IuJGqvaRm6pn2JhRmSgNeny+QlyTpcs0mhY5
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6f05:c90a:7892:8680])
 (user=irogers job=sendgmr) by 2002:a0c:b38b:: with SMTP id
 t11mr27290262qve.25.1620157413615; Tue, 04 May 2021 12:43:33 -0700 (PDT)
Date:   Tue,  4 May 2021 12:43:29 -0700
Message-Id: <20210504194329.840964-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH] libperf test: Silence printf flag warning
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Rob Herring <robh@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

__u64 maybe an unsigned long, it may also differ from the format
expected by PRIu64. Add a cast to silence the warning:

tools/lib/perf/tests/test-evsel.c:176:33: error: format specifies type 'unsigned long long' but the argument has type 'unsigned long' [-Werror,-Wformat]
                __T_VERBOSE("count = %llu\n", end - start);
                                     ~~~~     ^~~~~~~~~~~
                                     %lu

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/tests/test-evsel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/perf/tests/test-evsel.c b/tools/lib/perf/tests/test-evsel.c
index 288b5feaefe2..558097bbbfd0 100644
--- a/tools/lib/perf/tests/test-evsel.c
+++ b/tools/lib/perf/tests/test-evsel.c
@@ -173,7 +173,7 @@ static int test_stat_user_read(int event)
 
 		__T("invalid counter data", (end - start) > last);
 		last = end - start;
-		__T_VERBOSE("count = %llu\n", end - start);
+		__T_VERBOSE("count = %llu\n", (unsigned long long)(end - start));
 	}
 
 	perf_evsel__munmap(evsel);
-- 
2.31.1.607.g51e8a6a459-goog

