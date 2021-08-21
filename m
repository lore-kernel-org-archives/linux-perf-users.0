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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C154C432BE
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2425C61205
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhHUJW5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbhHUJWd (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:22:33 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAC5C061156;
        Sat, 21 Aug 2021 02:20:35 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id e21so9301183ejz.12;
        Sat, 21 Aug 2021 02:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=luODGGdTKMSVHQNhZwY0q6ykClJFkZ30Qtks/1RszYE=;
        b=rxguwcdIVN6PUc+2PVw9G6OIRfOCWxNfYnKXtvbbMX/eeIbd4pTQ4qofcRbBIv5DHY
         OYfZS9M0/CWVffCZoTtl0C3jwDS2QI43pmIEUTiD4Einub29D4MdUCGue8YE5NGUl5Gs
         6YMi5FqQhc4b8ZjpVBDrqTr0BtdTNZJ30WqotQcdgEV/xtRRDDhe/+ZVpUiJp2QpV2lz
         /dBjYvypxxQ8ECFJbBTNc7eNI9+60UzGkIVKZCGQClZRnetCgT6LEocF4BtLS9KeNYyv
         grsZksuoN2FRtK9HuAdfImNqFh78OeF3r3PAqBlAC3avq68QTabHhe+gTC7HT3mXFZgM
         pIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=luODGGdTKMSVHQNhZwY0q6ykClJFkZ30Qtks/1RszYE=;
        b=LPoNe4RZDvnnryRVy4CUGnMJo5wbmvxHwD9xIVc9GYgv7gRLAvvLfktptCX4eeGNdM
         UQaYffsmQFbHnLNfif2mjL4DDWsiyec8OcC0N7lqq83qaGHWyq+BB0eTMin4AnJYpTOe
         /snyi2cEPFcQHR6kNyu2yq3rT8H7np7sIT+ZtRDNjDE2fZr4DShasowW6/6Vr1RmTPNI
         oKne4Euupw09jg9e3O5cHzxRsql7o0rPl1p8gAdj0rK0PuTEhtCAfQIMDcoXehkOE2b9
         i1oz3qoCzJlmTIUVLZX6GiqzwqHAs+iaY6ZfKmD3Wd/qy1iaR8f6bRHMDK1MWjWbTr/u
         LPJA==
X-Gm-Message-State: AOAM5320rVgYPrcAtcgYf2qt6wiPsYm5ipPd0WnJ372YM1dm5XxFOt3i
        MGND+GmZMP4JjlcQ1nrtKKQ=
X-Google-Smtp-Source: ABdhPJzt48eQb0wDTCqRy8w5b0Kgi385W8LmXZDYo/2Jb9nbZOTl+g5B1eG+X9UW2bSfNrHZVd+pIA==
X-Received: by 2002:a17:906:fb91:: with SMTP id lr17mr25878506ejb.110.1629537633955;
        Sat, 21 Aug 2021 02:20:33 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:33 -0700 (PDT)
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
Subject: [RFC PATCH v1 36/37] perf test/evlist-open-close: use inline func to convert timeval to usec
Date:   Sat, 21 Aug 2021 11:19:42 +0200
Message-Id: <b95035ec4a125355be8ea843f7275c4580da6398.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch introduces a new inline function to convert a timeval to
usec.
This function will be used also in the next patch.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/bench/evlist-open-close.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/bench/evlist-open-close.c b/tools/perf/bench/evlist-open-close.c
index c18aa85725281795..00d0aef564f80d44 100644
--- a/tools/perf/bench/evlist-open-close.c
+++ b/tools/perf/bench/evlist-open-close.c
@@ -26,6 +26,11 @@ static int iterations = 100;
 static int nr_events = 1;
 static const char *event_string = "dummy";
 
+static inline u64 timeval2usec(struct timeval *tv)
+{
+	return tv->tv_sec * USEC_PER_SEC + tv->tv_usec;
+}
+
 static struct record_opts opts = {
 	.sample_time	     = true,
 	.mmap_pages	     = UINT_MAX,
@@ -197,7 +202,7 @@ static int bench_evlist_open_close__run(char *evstr)
 
 		gettimeofday(&end, NULL);
 		timersub(&end, &start, &diff);
-		runtime_us = diff.tv_sec * USEC_PER_SEC + diff.tv_usec;
+		runtime_us = timeval2usec(&diff);
 		update_stats(&time_stats, runtime_us);
 
 		evlist__delete(evlist);
-- 
2.31.1

