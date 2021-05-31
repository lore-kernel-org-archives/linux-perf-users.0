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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD62C47080
	for <linux-perf-users@archiver.kernel.org>; Mon, 31 May 2021 21:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7137460E09
	for <linux-perf-users@archiver.kernel.org>; Mon, 31 May 2021 21:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhEaVda (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 31 May 2021 17:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbhEaVda (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 31 May 2021 17:33:30 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17F7C061574;
        Mon, 31 May 2021 14:31:48 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b11so8057300edy.4;
        Mon, 31 May 2021 14:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BUzR9q9xMCrnYk7GXKRktXhKYKGCLSyWr6ZPj2PNhxU=;
        b=e1T7AgkCjMbptDQBztdPgw4yrRR2awCT20SxhaqPT+g3tgygJtGok/JpGEdM0BbG2m
         /SghMH9LWm3dafuF/OrD9L7bczCiFJYK0zGbTYeDr7bcdy6aXADkmcjkj8xMPiJFwoKT
         V6rtLhdXEazSEEJI9KFzkuS4LBeSrT9lhvEKitbYeEa8chDKNWjPlGzxO9XCflMHF3hy
         myKttnjOqyEB2jBghwGnUGMXGCKHK2l+cXFrRw9U4CeVvzu4XOP7HwuLGBGlca0JZQtP
         CnIfl69h6PkkxXKoX9il2R3j/yfjDNwJpycPxnXY496xlc1lTPOGD09P51Fgm9V8C/R6
         nVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BUzR9q9xMCrnYk7GXKRktXhKYKGCLSyWr6ZPj2PNhxU=;
        b=BDoz84GwR7ZrGrigTGmPgntrsntOXykdI0wbWOcYZ3FvCULxsfnUUmo3xinoGKgzy3
         0e5g71/TXtvyqf3jZUyytgfnaPzmlxdjnQf4Mb07nG2amXADtK6n34xGZRXcq/oG7lDY
         h5R3WR8EGUNgZmTsSiWg8NqpwXuT5qswHTnK8voO99vF64mwdel4sYWDl9Jm1xWIYdq7
         lRXN5C1/0ygulBNcGJbNW9km/iksuievbuNP63xt+GsohPThhdDHaynN9KgSZN84YiMO
         EvbDgyt2t8IHq3D2l/OMNc6RkUcYyXTfiSYsVZqrBWMGOhOb0kheAcSacbbVn355Si0Z
         ZwOw==
X-Gm-Message-State: AOAM530Iye7BLYyceCHdgEH68HCdyBxvcVMk3sDE2C+BPZ3Jedmoe9XP
        MV++iLA2mm+pIA98aKpn2VY=
X-Google-Smtp-Source: ABdhPJyxJ3Gzz6F2xd/7wPC1m151hLhoC+K6x/fTtVUWFOw05S+oLq2WkJ0IO/pHAMHsghrvhrFOwA==
X-Received: by 2002:a05:6402:1648:: with SMTP id s8mr20501261edx.256.1622496707315;
        Mon, 31 May 2021 14:31:47 -0700 (PDT)
Received: from honeypot.. ([151.29.82.133])
        by smtp.googlemail.com with ESMTPSA id m16sm7364358edq.56.2021.05.31.14.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 14:31:46 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Riccardo Mancini <rickyman7@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf: fix segfault when wrong option for --debug is provided
Date:   Mon, 31 May 2021 23:28:28 +0200
Message-Id: <20210531212828.240077-1-rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The command `perf --debug record` causes a segfault instead of notifying
the user of the unrecognized option for --debug (the correct syntax would
be `perf --debug verbose=2 record`).

The bug is caused by a call to pr_err before debug_file (debug.c:34) is
set via perf_debug_setup(). It has been introduced in
commit 8abceacff87d ("perf debug: Add debug_set_file function").

This patch resolves the bug by calling perf_debug_setup earlier in the
main, so that debug_file is set to stderr before any call to a debug
printing function is made.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/perf.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index 20cb91ef06ffc..cffbab2d085a7 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -448,6 +448,7 @@ int main(int argc, const char **argv)
 	pager_init(PERF_PAGER_ENVIRONMENT);
 
 	libperf_init(libperf_print);
+	perf_debug_setup();
 
 	cmd = extract_argv0_path(argv[0]);
 	if (!cmd)
@@ -531,8 +532,6 @@ int main(int argc, const char **argv)
 	 */
 	pthread__block_sigwinch();
 
-	perf_debug_setup();
-
 	while (1) {
 		static int done_help;
 
-- 
2.23.0

