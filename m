Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08FB1C07E9B
	for <linux-perf-users@archiver.kernel.org>; Sun,  4 Jul 2021 07:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E912F6195E
	for <linux-perf-users@archiver.kernel.org>; Sun,  4 Jul 2021 07:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhGDHUE (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 4 Jul 2021 03:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhGDHUA (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 4 Jul 2021 03:20:00 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E14C061764
        for <linux-perf-users@vger.kernel.org>; Sun,  4 Jul 2021 00:17:26 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id b1so8374798pls.5
        for <linux-perf-users@vger.kernel.org>; Sun, 04 Jul 2021 00:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cqZ3/8qRJ0T11IxZy6/iUe0ZOS4dBLD3FIlV5usicsM=;
        b=E3UX6x54x8lZhJxaCXtRbUP78eBR4I+u4kodpswYImEgDSGt5OsPpK6aig1cAPUsXW
         kGOyxg1euP+NI63PmPk3bax3UXoPbvCL4fY+7Yrxtec2/mcYxFDBcvjEkew+Z0LgD2Ke
         1JC8cnvg+TxOs/q06D+FZnf1x7Z0HSb+QFoHhPP1utkSIEuwI+Fttfbkc5fJ3KjWWpFT
         erb3my3THxDLnWwFHi/xusawcMjuE4iGWIRpqNkM2lAZ8uBd2vN1BUXxLjndkH1Cbiw6
         8wvnZ5X4WiApZ9Zm99zqorutI1O6Yirntyp/q6zjhnGbgKqWsYQMKvdJKEMXLY7n91Am
         uBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cqZ3/8qRJ0T11IxZy6/iUe0ZOS4dBLD3FIlV5usicsM=;
        b=lrw9lMXHrriZ2ayiOKTj9jdF6IHYr2L+eTfAl/WX7XKqE1JFwHWVElcl2L+KSuGj6k
         WojvGtrUQVg5pvJwgvUGV7g8aF1CmuOYlOpXn2p2sQvDL1LdGj+svy2rf89vmX9Wlqz6
         bjVGvMl5tJvdaC8ymiXFewyK3480eo+QNv0kUQV+1PqB59nsgJJn1sYhG1kjNqY3jHVL
         uil4A778bUN3hdYAh8fXsT34bAt5g4U+GJiq/0ZaOWaYFBLrIx1fMQHgmWGna9XUlbkT
         8caUyInuRrXiFa2xPh6Lavm3psUWvYBUPpFuNzQMh+Ez72MMnRiZlPobiaG0dGdQJQyg
         XDww==
X-Gm-Message-State: AOAM531HNEome5s+e9+Ex2PbzpfItCngwpQ8h2gY3eNlxJi0Obc9Med9
        wgfO/+z+1gZeLIHLe/IKeiMOPA==
X-Google-Smtp-Source: ABdhPJxxP1J0v8GY7Te1DQbveJ8mV/KCKQeQTcGZB4JU9I32dUshft2tWw6YxwA1immL4jEh56ilbg==
X-Received: by 2002:a17:90a:e415:: with SMTP id hv21mr8509138pjb.178.1625383045501;
        Sun, 04 Jul 2021 00:17:25 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id s20sm18870464pjn.23.2021.07.04.00.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 00:17:24 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v3 06/10] perf auxtrace: Remove auxtrace_mmap__read_snapshot_head()
Date:   Sun,  4 Jul 2021 15:16:40 +0800
Message-Id: <20210704071644.107397-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210704071644.107397-1-leo.yan@linaro.org>
References: <20210704071644.107397-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Since the function auxtrace_mmap__read_snapshot_head() is exactly same
with auxtrace_mmap__read_head(), whether the session is in snapshot mode
or not, it's unified to use function auxtrace_mmap__read_head() for
reading AUX buffer head.

And the function auxtrace_mmap__read_snapshot_head() is unused so this
patch removes it.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/auxtrace.c |  5 ++---
 tools/perf/util/auxtrace.h | 10 ----------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 9350eeb3a3fc..44bd04dbb6d6 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1686,13 +1686,12 @@ static int __auxtrace_mmap__read(struct mmap *map,
 	union perf_event ev;
 	void *data1, *data2;
 
+	head = auxtrace_mmap__read_head(mm);
+
 	if (snapshot) {
-		head = auxtrace_mmap__read_snapshot_head(mm);
 		if (auxtrace_record__find_snapshot(itr, mm->idx, mm, data,
 						   &head, &old))
 			return -1;
-	} else {
-		head = auxtrace_mmap__read_head(mm);
 	}
 
 	if (old == head)
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index f489ca159997..1a2f42980e3f 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -440,16 +440,6 @@ struct auxtrace_cache;
 
 #ifdef HAVE_AUXTRACE_SUPPORT
 
-static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
-{
-	struct perf_event_mmap_page *pc = mm->userpg;
-	u64 head = READ_ONCE(pc->aux_head);
-
-	/* Ensure all reads are done after we read the head */
-	smp_rmb();
-	return head;
-}
-
 static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
 {
 	struct perf_event_mmap_page *pc = mm->userpg;
-- 
2.25.1

