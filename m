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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34CDC4320A
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD02461186
	for <linux-perf-users@archiver.kernel.org>; Sat, 21 Aug 2021 09:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbhHUJWN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 05:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbhHUJVj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 21 Aug 2021 05:21:39 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E89C0611C2;
        Sat, 21 Aug 2021 02:20:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id bo19so17595501edb.9;
        Sat, 21 Aug 2021 02:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2DKoXbLqb5JEZfckQbGfo0eY1oqTs4gsyzCuCjXFWuM=;
        b=goOtNRccV4Ca5TUodnLlBiWwZbJJo4TWXbcTtsYNzoCukYgdjdCx6uHLXg7h/LJgv2
         hpvzqKh1Y90enpyN442g5a02CC7kxb3+1ZZr3s3UUWs5P6Ff5Nb3S3RKom7p9B8LaWtN
         a2cvV78I+6Gfmyxot7CJZ1rX5XInkZIPFu0IcYrDd2UvA8aNhQXtLmJNyPIUuhUrcV0+
         Hnrwlw3WnPCb7bVevf8eYsyqZaNfb98SvFcbZtuU6fBba42PnnUlMsxBCPvWBCpecezw
         tBqJawlPnEfMQwPsRiTXvYoFnkX5JBlNjI9zAcTtTnw8kWHaLj+Ent6B961Cxb4/2eNU
         iU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2DKoXbLqb5JEZfckQbGfo0eY1oqTs4gsyzCuCjXFWuM=;
        b=lvmzHL/3T6Jm+fgDI4sjVLinIbqGCOTTaWa9gGvSQLVJtYSNCUnDcQdUw+7QZTwNMJ
         ZbWG/isQRzZ9IChEcPD0S53a41NHVUg1vyoiyEDB5vW7MAnsFxs2md1+tGRisZpXpHa7
         SVeI8rpEokze/32l7C2izMq9kwL7rM0hjR5EHFhkqApEowKKC9uvNKD3ZQEFFlZQDWVm
         Bcy4jJ54JEmgo1wF372ieQblHm0NKKOhpsNnW/IgPC9i3+bqPWFYLNApRAiWFmZgmERO
         K5f9E4/PTuyzQRi/uPWQ+3oaa+mwmvtvhAMaoPfPhVIvzmzU57GVhbXSudfuPX/re3je
         0zGg==
X-Gm-Message-State: AOAM5320LRb8BCLCdpPKwOacw5rD4MM3615KVpGZppdpOMZwH8VwXCGT
        u8I2d1DQWqXLEp6N9P6jpEQ=
X-Google-Smtp-Source: ABdhPJxFTsrC49EPVHSw351D2Z7eBxtPfwGJL/PK7IyX79wNXB0WsrJNUsHn5g7qgqGDHYDba62n8Q==
X-Received: by 2002:a05:6402:214d:: with SMTP id bq13mr26632573edb.263.1629537615955;
        Sat, 21 Aug 2021 02:20:15 -0700 (PDT)
Received: from honeypot.. (mob-176-243-254-204.net.vodafone.it. [176.243.254.204])
        by smtp.googlemail.com with ESMTPSA id a25sm4003878ejv.91.2021.08.21.02.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Aug 2021 02:20:15 -0700 (PDT)
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
Subject: [RFC PATCH v1 22/37] perf evsel: move test_attr__open to success path in evsel__open_cpu
Date:   Sat, 21 Aug 2021 11:19:28 +0200
Message-Id: <b3baf11360ca96541c9631730614fd7d217496fc.1629490974.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629490974.git.rickyman7@gmail.com>
References: <cover.1629490974.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

test_attr__open ignores the fd if -1, therefore it is safe to move it to
the success path (fd >= 0).

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/evsel.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index a1a88607fd59efcb..d2b0391569286080 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2011,11 +2011,6 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 
 			bpf_counter__install_pe(evsel, cpu, fd);
 
-			if (unlikely(test_attr__enabled)) {
-				test_attr__open(&evsel->core.attr, pid, cpus->map[cpu],
-						fd, group_fd, evsel->open_flags);
-			}
-
 			if (fd < 0) {
 				err = -errno;
 
@@ -2024,6 +2019,11 @@ static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpus,
 				goto try_fallback;
 			}
 
+			if (unlikely(test_attr__enabled)) {
+				test_attr__open(&evsel->core.attr, pid, cpus->map[cpu],
+						fd, group_fd, evsel->open_flags);
+			}
+
 			pr_debug2_peo(" = %d\n", fd);
 
 			if (evsel->bpf_fd >= 0) {
-- 
2.31.1

