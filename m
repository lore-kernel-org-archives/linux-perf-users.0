Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEC3C07E9C
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 10:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3E8E610D2
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 10:41:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232550AbhGKKoY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 11 Jul 2021 06:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232523AbhGKKoY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 11 Jul 2021 06:44:24 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01630C0613E8
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jul 2021 03:41:37 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s18so14975760pgg.8
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jul 2021 03:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkEOllshRjQL/AsgC277Y/O2zCWNhcoUJsl5iahG6Xw=;
        b=r3t5DXxk87nwQDHus4OE2UYk3L5lCMZPuk8LKYFoc2efl9wNS9ahDC8vcfVXCH6fVj
         6V+uMPygEXUnDeQIEvQEMj7fhKp7NlQXmZgMoh9X6ey1cmg7qJ5++ls9gWmrPjbx8C2b
         u2HG3UdYr+xEPTOzSxdnMs+/TbdQPbonvkfHLbsdeAmFNZND59AZiAzS1U0H391JBMsE
         YDiP6hK5my9hr1FDYdY4ITiDcKPzHd6ehrfma3b0WEgKveWAopvImUn7C6m45mhiBn0D
         nxt8Xm1idtUpe96NCmnHMlvFUfOX+RoveJfFZ3DxaOD0RRh/s2uutrWWDUWkuZAgpAnE
         I+Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkEOllshRjQL/AsgC277Y/O2zCWNhcoUJsl5iahG6Xw=;
        b=BGt2MTilPFfoJvmuaPcEicIhTGPhubzfIQOTU3N+beD0s99++nDksZUWdt354LVnMy
         AUeuCC8xX62AXeFZuQgqs2R6QhxvWMws864fw02FdCM4bYQcMVm+WPcropQAAz6ahZTG
         PAtrAnScJ8Gq3uXu+ux1QYbJWdgO9qKmlHKb/QhLgvdB2qLxKUqpTM+3eSEfpySPgyph
         rpks10LLX4Yho1nY7w64EEL99RWCspWt3nvYw3uKEwVEbWi84QL08JRXmZ6gNitQ3ewE
         aqJBPsAGTCZU/xVvK8WF71gKlOSisuSn9fG6W9YjApuyHBXKqfqeTyteCxV+tmNsT7A4
         HJ0g==
X-Gm-Message-State: AOAM531J2Ei0B12/1/8zBZ9xre6ehUlbwB9quuyjhtxuN7RDmEkzpPQi
        oEJz3vzSXJjqJEuGELnA3Mbs2Q==
X-Google-Smtp-Source: ABdhPJyrTBXR/XJLZhNLxu4wpVEIzMB1TraRsWe2fJghWktdvMaDePg5OxUllSODwoErCx4C+msgGw==
X-Received: by 2002:a63:170b:: with SMTP id x11mr20913040pgl.253.1626000096511;
        Sun, 11 Jul 2021 03:41:36 -0700 (PDT)
Received: from localhost ([103.127.241.250])
        by smtp.gmail.com with ESMTPSA id g9sm8281997pfr.133.2021.07.11.03.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 03:41:36 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: [PATCH v4 07/11] perf auxtrace: Remove auxtrace_mmap__read_snapshot_head()
Date:   Sun, 11 Jul 2021 18:41:01 +0800
Message-Id: <20210711104105.505728-8-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210711104105.505728-1-leo.yan@linaro.org>
References: <20210711104105.505728-1-leo.yan@linaro.org>
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
index cb19669d2a5b..7958e17229ea 100644
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
index 4f9176368134..d68a5e80b217 100644
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

