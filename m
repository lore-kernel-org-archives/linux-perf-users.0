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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05AAEC636C8
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 02:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7CE761178
	for <linux-perf-users@archiver.kernel.org>; Wed, 21 Jul 2021 02:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbhGUBpH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 20 Jul 2021 21:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbhGUBpE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Jul 2021 21:45:04 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E844C061574;
        Tue, 20 Jul 2021 19:25:42 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id j1-20020a0568302701b02904d1f8b9db81so721175otu.12;
        Tue, 20 Jul 2021 19:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aDp1Sbc7Q+/I5oxSEHI3ZL2iq8pyuXoWqX53xRk7g+U=;
        b=Dz59CAZuL0q69B5FwsM04Z1ucFChwmWiv+sjbrlMZQyTlVy+6bHLWAaBpGHjRq/FlM
         mTr9jbZ1uiy7tZkihAZBM4cpaP2iZL0AvPfFt4gSPcBmHFcAQBrhxSpkuohzLpYK1wfF
         3y8TEERNYygmPoec23V4WPLtiXKoSD1nlEd5mDSFGUAhlIbR+Nh5BHye1JuCja0G4RQp
         W3fxAyaTBtFgX3ePp6gX75hzJYQDKb4j660Yde1x23Cgwy0rUh5zLhz/VUTMNI6KSEEB
         UQxDzntGdYdQ2sHXZ1WXQSlLIdiAjCunNymErF3P4fpLgc66aTejxqyusV6xAf1NMaQC
         damA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aDp1Sbc7Q+/I5oxSEHI3ZL2iq8pyuXoWqX53xRk7g+U=;
        b=nazOXHPx/cEsCw7b+CLagjtMOMvtYbvQ5BuKXOQRDvwYHRpVvlQMc9nW3mZrpiCTFg
         IfU28nzW9D3j85KbdRKh2uzqVHifkKOUDxO9UrYXrXQTdJ4u3uTE1LIU/7ihj5B6qEG8
         7Fk41HNy2158a5WEGuswuAsghpqsLCq3sc7g/Vs1nItDQVKlLZxwlLmggxiDj99E3BgI
         NbOMfDuq4STySpoN092ddudLUQmHh2Rm45EMvj1d/lTcMCvgM9vLKyaLKtXhGsTmhZ9A
         Lw8H3Waqu6WdJVNPpvrWX1XZqvuP10iRDuZeom+Q3BIrExHu0qo0JjN26B4mbjoUfZlT
         wXdA==
X-Gm-Message-State: AOAM531cin3rzZcAcqYjUMZL65lY0+mfncRKgYzYiRLqgNFnWLej40IY
        1IS+b2oAsfrA2JpbWm31wctoMjrkHIodpDmJ/ok=
X-Google-Smtp-Source: ABdhPJy6w2NlTHnzYqZX447IxmhSjiliNstyArWeoKp1KAOiR32KQul8JuTAfrbxHo/v9bxHWZmZcA==
X-Received: by 2002:a9d:4112:: with SMTP id o18mr25081915ote.128.1626834341643;
        Tue, 20 Jul 2021 19:25:41 -0700 (PDT)
Received: from localhost.localdomain (c-98-249-124-70.hsd1.nm.comcast.net. [98.249.124.70])
        by smtp.googlemail.com with ESMTPSA id v5sm2542722oor.33.2021.07.20.19.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 19:25:41 -0700 (PDT)
From:   Brett Holman <bholman.devel@gmail.com>
Cc:     linux-perf-users@vger.kernel.org,
        Brett Holman <bholman.devel@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] perf mem: Standardize 'perf mem' arg parsing
Date:   Tue, 20 Jul 2021 20:24:42 -0600
Message-Id: <20210721022442.159436-2-bholman.devel@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210721022442.159436-1-bholman.devel@gmail.com>
References: <20210721022442.159436-1-bholman.devel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Arguments are parsed differently by 'perf record' and 'perf mem
record'. While '--' can be used to stop parsing arguments in both,
'perf record' stops parsing when an unknown argument is found and 'perf
mem record' does not. This may lead to surprise when flags are stripped
from the command being tested with 'perf mem record'. This patch
eliminates this difference in behavior.

Signed-off-by: Brett Holman <bholman.devel@gmail.com>
---
 tools/perf/builtin-mem.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
index 0fd2a74dbaca..ce734774b552 100644
--- a/tools/perf/builtin-mem.c
+++ b/tools/perf/builtin-mem.c
@@ -89,7 +89,7 @@ static int __cmd_record(int argc, const char **argv, struct perf_mem *mem)
 	}
 
 	argc = parse_options(argc, argv, options, record_mem_usage,
-			     PARSE_OPT_KEEP_UNKNOWN);
+			     PARSE_OPT_STOP_AT_NON_OPTION);
 
 	if (!perf_pmu__has_hybrid())
 		rec_argc = argc + 9; /* max number of arguments */
@@ -484,9 +484,14 @@ int cmd_mem(int argc, const char **argv)
 		NULL
 	};
 
-	argc = parse_options_subcommand(argc, argv, mem_options, mem_subcommands,
+	if (!strncmp(argv[1], "rec", 3))
+		argc = parse_options_subcommand(argc, argv, mem_options, mem_subcommands,
+					mem_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+	else
+		argc = parse_options_subcommand(argc, argv, mem_options, mem_subcommands,
 					mem_usage, PARSE_OPT_KEEP_UNKNOWN);
 
+
 	if (!argc || !(strncmp(argv[0], "rec", 3) || mem.operation))
 		usage_with_options(mem_usage, mem_options);
 
-- 
2.31.1

