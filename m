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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9F3C4320E
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2711E61208
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbhHUJWh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbhHUJV6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:21:58 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E1FC061144;
        Sat, 21 Aug 2021 02:20:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id q3so17661996edt.5;
        Sat, 21 Aug 2021 02:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=54GMaFeo+0ii7XXdVN7OyGxlbAq4Jcyh9p53ycXRCvY=;
        b=f6FvLaETibhXox2YQ39Lc+SJfu9Vo/EqS1NZyGo8hGRMUepgc8jNljcjcnctclfV65
         SEDKK3ceXA4XW5N1Md5F8CFFKCrgmG3w1qsawwaYtri3Axe9qMWh163cTfGxcsnZENAA
         phtuhTyJgI7MW0QJeiKsmEcdFG6PfAflcTQjeXRdl/J7sCH5LPF3ccLftuywVbFMVES/
         QohdcKu4wyKM3YNrNny1mSSjeCe0BALohSzT77mbIq7jn1gwox5PKdoqvdUT3f9VS1/o
         Dbi7bBt7LkWPdEQWy8T3Qf4PGHKS2p/YMC6R2brwd77Pi72wM8FI3AdmCAj9uhCJJ99W
         k+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=54GMaFeo+0ii7XXdVN7OyGxlbAq4Jcyh9p53ycXRCvY=;
        b=iyTVp0oMo3BdcTz/LDMgoV5vGusRhfY7ql2WVtnhJOUwLoNksl19mu1lgylxat3DUO
         h+9fufJejPnMF5eaU3a7LcYQB543SP4asklI2AvpzOl0LYIBi2ndkeSbTooZP//hTBCT
         yY+TyPbLmcfrt9F8HB/+dqI+WEchDcWUNSl+q+W1KjRinZl2fAZcCTJ262lfgvhi3IbR
         c6tkuV0r1exgy5VGyYeY4ryr/jCCNTpp/GiTBPg+hho+avY045t5bbB909mc5/pTYIB5
         UeXBN1eImJ0Q4Am7zf/Nx1QICLZtZZkQcVbBL6igUAfAiNEMkM7lAzFpLw6h/62gOWov
         /bsQ==
X-Gm-Message-State: AOAM5319RfDxBJ495+9JUsnGHmzA8ubxRcBaC99MJW41WnkN3GIjHVwz
        esfjTKxbb7I5nPXK/P7gRNs=
X-Google-Smtp-Source: ABdhPJy2g+B62ZbkcrLfi6FK4ioITzqxZe5fXKbFOq1aQmJn46XwY+JUtgbIKCj1UF2UgiyCknlVlQ==
X-Received: by 2002:aa7:db8b:: with SMTP id u11mr26503283edt.362.1629537621120;
        Sat, 21 Aug 2021 02:20:21 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:20 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v1 26/37] perf evsel: add evsel__open_per_cpu_no_fallback function
Date:   Sat, 21 Aug 2021 11:19:32 +0200
Message-Id: <e4d366eab34d2427faded11de6ecb9efe8b781ef.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This function is equivalent to evsel__open, but without any fallback
mechanism, which should be handled separately.
It is also possible to a starting thread to be able to resume
a previous failing evsel__open_per_cpu_no_fallback.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/evsel.c | 44 +++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/evsel.h |  9 +++++++++
 2 files changed, 53 insertions(+)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index e41f55a7a70ea630..74aad07f3c1102cb 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2021,6 +2021,50 @@ static struct perf_event_open_result perf_event_open(struct evsel *evsel,
 	return res;
 }
 
+struct evsel_open_result evsel__open_per_cpu_no_fallback(struct evsel *evsel,
+					struct perf_cpu_map *cpus,
+					struct perf_thread_map *threads,
+					int cpu, int start_thread)
+{
+	int thread, nthreads, pid = -1;
+	struct evsel_open_result res = { .thread = start_thread };
+
+	if (cpus == NULL)
+		cpus = empty_cpu_map;
+
+	if (threads == NULL)
+		threads = empty_thread_map;
+
+	if (evsel->core.system_wide)
+		nthreads = 1;
+	else
+		nthreads = threads->nr;
+
+	if (evsel->cgrp)
+		pid = evsel->cgrp->fd;
+
+	display_attr(&evsel->core.attr);
+
+
+	for (thread = start_thread; thread < nthreads; thread++) {
+		res.peo_res = perf_event_open(evsel, pid, cpu, thread, cpus,
+					threads);
+
+		switch (res.peo_res.err) {
+		case PEO_SUCCESS:
+			continue;
+		case PEO_FALLBACK:
+			goto out;
+		default:
+		case PEO_ERROR:
+			goto out;
+		}
+	}
+out:
+	res.thread = thread;
+	return res;
+}
+
 static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads,
 		int start_cpu, int end_cpu)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 8c9827a93ac001a7..fa0d732d0a088016 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -294,10 +294,19 @@ struct perf_event_open_result {
 	int fd;
 };
 
+struct evsel_open_result {
+	int thread;
+	struct perf_event_open_result peo_res;
+};
+
 int evsel__open_per_cpu(struct evsel *evsel, struct perf_cpu_map *cpus, int cpu);
 int evsel__open_per_thread(struct evsel *evsel, struct perf_thread_map *threads);
 int evsel__open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads);
+struct evsel_open_result evsel__open_per_cpu_no_fallback(struct evsel *evsel,
+					struct perf_cpu_map *cpus,
+					struct perf_thread_map *threads,
+					int cpu, int start_thread);
 void evsel__close(struct evsel *evsel);
 int evsel__prepare_open(struct evsel *evsel, struct perf_cpu_map *cpus,
 		struct perf_thread_map *threads);
-- 
2.31.1

