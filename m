Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4880DC07E94
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 09:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A42E6140B
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 09:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbhFDJ32 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Jun 2021 05:29:28 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:43710 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhFDJ31 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Jun 2021 05:29:27 -0400
Received: by mail-ed1-f51.google.com with SMTP id s6so10333203edu.10
        for <linux-perf-users@vger.kernel.org>; Fri, 04 Jun 2021 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v4s7Wdp9P+q1iZfuGGxYhUoU58bq9Dm8LlurM2nZ904=;
        b=IbVRCbVi0TMLMZSOQCIoI6xN2Rk8hy4/iQ7Vg+2pMSUrilCtVQDK6uK6OyCqxzGLKW
         WdR5yT9nqflcvKcaHipGwqPpuU6t9iVvTPHF6HnQGtfAE3h5SBxQFZlmqcRkMB+DN+sk
         0G9TVefGF74xLo8BqBWJxN48XMpcg8fjfMJv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v4s7Wdp9P+q1iZfuGGxYhUoU58bq9Dm8LlurM2nZ904=;
        b=PwJ0UnnFjDt7vHWwS7Mb0pbip7U79PJ6+yt0RwZ5edl5UNOXmpLf1H088xO6qULuFP
         207adOTisZwudy40LQHX16bDNQdz5l3ZevnH2SrfklpihMoCtRReM44qdbLSuYVWiQwy
         5MbNr4Z2rs5dEgTbr8hAjrXzG+Pq5UyLMgCUVMucgR9oBvz0FfQM2U0z7ApUo3TbdC+q
         /N/nuhw7wNgdTepOpsaO0BYHHEM7bhhtTCWZY/nlkJTlPE7m07979JqWiNHmpeqNbJlu
         2Id1kKuaxxZg2+cBYbizyOMXycefzAhZcyK/dr0RTBxP6sTrV1c/SF/YEQCz0NVfnqIy
         Nt0w==
X-Gm-Message-State: AOAM533kt96qC6kRwlHruEtqAEk4BO3jEKgVPsW3S8vWR45f3ipSOyj3
        Cmro+3+AYCk9zp8bFdDBdONfKQ==
X-Google-Smtp-Source: ABdhPJyjZP8jlD/L9dViQFhwyi+cx1pz4rYhELSDTRpINtaExQYPqWEEcFK54K4RKtSCzFSQLh2rxQ==
X-Received: by 2002:aa7:db90:: with SMTP id u16mr3695449edt.106.1622798800833;
        Fri, 04 Jun 2021 02:26:40 -0700 (PDT)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id z22sm2095405ejm.71.2021.06.04.02.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 02:26:40 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH] tools/perf: Do not set a variable unless it will be used
Date:   Fri,  4 Jun 2021 11:26:38 +0200
Message-Id: <20210604092638.985694-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

clang-13 triggers the following warning:

bench/inject-buildid.c:351:6: error: variable 'len' set but not used [-Werror,-Wunused-but-set-variable]
        u64 len = 0;

This patch sets the value to len only if it will be used afterwards.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 tools/perf/bench/inject-buildid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/bench/inject-buildid.c b/tools/perf/bench/inject-buildid.c
index 55d373b75791..fee69ac787b2 100644
--- a/tools/perf/bench/inject-buildid.c
+++ b/tools/perf/bench/inject-buildid.c
@@ -348,13 +348,13 @@ static int inject_build_id(struct bench_data *data, u64 *max_rss)
 	int status;
 	unsigned int i, k;
 	struct rusage rusage;
-	u64 len = 0;
+	u64 len;
 
 	/* this makes the child to run */
 	if (perf_header__write_pipe(data->input_pipe[1]) < 0)
 		return -1;
 
-	len += synthesize_attr(data);
+	len = synthesize_attr(data);
 	len += synthesize_fork(data);
 
 	for (i = 0; i < nr_mmaps; i++) {
-- 
2.32.0.rc1.229.g3e70b5a671-goog

