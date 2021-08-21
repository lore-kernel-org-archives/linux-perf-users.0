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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759F2C432BE
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EDF66121E
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbhHUJWP (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbhHUJVk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:21:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03A3C0611F9;
        Sat, 21 Aug 2021 02:20:18 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b7so17672936edu.3;
        Sat, 21 Aug 2021 02:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hSVEhq3LjLu21uthNLRpY++hxTR94OXd9+gS0oH2CrE=;
        b=G8amz1JObX3GRuSFcCEiYiCvwXSjKBNuwgNbi39x6nCiZTXag+QSolTMaj1Kx67Ql5
         JfdLV43x4cDZqjHCqR9jkyJHHCD+bKVf/0bUENiYi8MJa9hUDJW/X3kpGiXq/SAhP9DV
         kMF4W+g8Nxv7AlK2iUX1vXciV+vmaJX/uQVi5StttjMOu20XzHSgQej4DC7JCo8FE68/
         BP5DT1TVZmE/oxNjuNbfXlpvXUgN/jwrDtzb7Y052JNDz4iwaEkYEoesC2edgzZb8oLg
         BIGmjGLO0HKDanfjrIJ1qmj7kXRQIu4jb8r+yeWpPKv1pT464TAhRHxFKpI2OSKkRQHz
         Jqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hSVEhq3LjLu21uthNLRpY++hxTR94OXd9+gS0oH2CrE=;
        b=IMIFvwgye91jeV1NxUVXjh1qud4rD7zmKHawLd0SbePj3OAxa18tZQQ5PmY9Gc2t7h
         pfXNMSn69Llv3ScraMN6SHFkpvVROo1B4Y2w6LL9YlN5Ohphz2T5sfmkBD3UCfh2ln2c
         7k578s8v4F5p4f+W14Y+XsG7/9MsUiUvR0yYVcl6rssdY5kM+NWjuI2YBhkdh/G4HcCT
         OXSLn7KefsA7W4nGpdozpaT8VAP/mg5tm5nEyibo4HmWoxqXENJuhAhyJ4mcDbnmSkiU
         yzBaRAx6Iy10OOZpMmCANijaGK0nwom6YOYiNJuHnXiSzvI2VWxX7cOyUwXSb93vYm/i
         lS7A==
X-Gm-Message-State: AOAM530xBkQTNSvA8mb2POP3gmAI7O2U0Amlpmp8OdDYm9urqAva6Snv
        ORMbL7ANES9FHtye3ZnswuQ=
X-Google-Smtp-Source: ABdhPJy84gtsoCFiGxshU5Ik3OhmeQJqe3S2bHeBRTU237vjJQibWM/xI1V6+TWZ04pQHELxji/MkQ==
X-Received: by 2002:aa7:db82:: with SMTP id u2mr27502712edt.299.1629537617286;
        Sat, 21 Aug 2021 02:20:17 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:17 -0700 (PDT)
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
Subject: [RFC PATCH v1 23/37] perf evsel: move bpf_counter__install_pe to success path in evsel__open_cpu
Date:   Sat, 21 Aug 2021 11:19:29 +0200
Message-Id: <64f8a1b0a838a6e6049cd43c1beafd432999ae57.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

I don't see why bpf_counter__install_pe should get called even if fd=-1,
so I'm moving it to the success path.

This will be useful in following patches to separate the actual open and
the related operations from the fallback mechanisms.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/evsel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index d2b0391569286080..3e556afed8dd396c 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2009,8 +2009,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 			FD(evsel, cpu, thread) = fd;
 
-			bpf_counter__install_pe(evsel, cpu, fd);
-
 			if (fd < 0) {
 				err = -errno;
 
@@ -2019,6 +2017,8 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 				goto try_fallback;
 			}
 
+			bpf_counter__install_pe(evsel, cpu, fd);
+
 			if (unlikely(test_attr__enabled)) {
 				test_attr__open(&evsel->core.attr, pid, cpus->map[cpu],
 						fd, group_fd, evsel->open_flags);
-- 
2.31.1

