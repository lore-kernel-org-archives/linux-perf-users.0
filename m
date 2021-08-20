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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E19C432BE
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC0860C3E
	for <linux-perf-users@archiver.kernel.org>; Fri, 20 Aug 2021 10:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239280AbhHTKzG (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 20 Aug 2021 06:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239298AbhHTKy4 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Aug 2021 06:54:56 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23B6C061757;
        Fri, 20 Aug 2021 03:54:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id b7so13425774edu.3;
        Fri, 20 Aug 2021 03:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5xCOtqv2tenj2Od+wPZTYC3Z57feU6O1gHbiYEDCzbQ=;
        b=B+o+G6szk+eRXpavZ6YUPf5bT8d1QerRz7hukoTTR96Cha1HLuXA2x50p5luQzbaRz
         nS9IwykomRee5HAVgPZrjd2UrVSWA+pSD3Gnq6S7aK4HjxPzoiY7aDSoEA5Ot/uBHIpv
         NLUUM7ALis4QTO7dA2h0gZ+lfNfpkZtmjaytbFESeRPBwURRVmGmzK6SvO+cjpUQKzr1
         W3YO1fXRlVVFsHL4alRPkYKOtkRnbyQONi4I+WgeKoKyWNtam2ghTOiHGzKP69FuGMEY
         yAUBodMpuDIan7/wTBgWqD9nqy/sHRghf0FFTSQ/drGPYoc4AlOY9wq0efeGf1cvuMtm
         eSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5xCOtqv2tenj2Od+wPZTYC3Z57feU6O1gHbiYEDCzbQ=;
        b=FZdhETE+uoT0o0zUukVVl1FoHGA0boLU9AaGZSjBETnfNwZobuvtDbqjvJvXciomKl
         QacqHJU5afNnuJxG9xchsz6RXz6mnADdKrX+c2oxaV61K4XiipzP992vBiWeQcJYNhGT
         WP7dQqyHReqBONSH8fHjaHm2399DeN/WmdvDLKq0su/VvtRQrZvB6NZG44KrURwv+aHP
         55G0BhwZ5U5KFedth0UISjbBlmKSheWzCgxc9I79TjxhqrzwW/Tr9HAPQIgTaq6DH//z
         Usya3zuoffMrypc9KOdQkMvAIGTH0gQHXTgQjG0TKmKlavGH7qFhCuDJhvalDZGmf1o/
         B3ZQ==
X-Gm-Message-State: AOAM531cM78+5O9nxc2qI1TPWWBFJRc1TxMdrlVdFE9m+2QO++if2RxT
        ixBZWPAu0VLZnKHPhoTfZ6Fonx04Ff6U4llQwgc=
X-Google-Smtp-Source: ABdhPJwPrm4T5GBMAeafsNVppWN924aeBY7diGUiuYIFJzeCNx4d+xsHrtpIGd3tIqDw8ixifhs5qw==
X-Received: by 2002:aa7:c890:: with SMTP id p16mr21194998eds.280.1629456856538;
        Fri, 20 Aug 2021 03:54:16 -0700 (PDT)
Received: from honeypot.epfl.ch (mob-176-243-199-7.net.vodafone.it. [176.243.199.7])
        by smtp.googlemail.com with ESMTPSA id g29sm3451459edf.31.2021.08.20.03.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 03:54:16 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [RFC PATCH v3 05/15] tools: add sparse context/locking annotations in compiler-types.h
Date:   Fri, 20 Aug 2021 12:53:51 +0200
Message-Id: <6b8c28e268003ca2276c0d018248e27442fbbf49.1629454773.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629454773.git.rickyman7@gmail.com>
References: <cover.1629454773.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch copies sparse context/locking annotations from
include/compiler-types.h to tools/include/compiler-types.h.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/include/linux/compiler_types.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/include/linux/compiler_types.h b/tools/include/linux/compiler_types.h
index feea09029f610120..24ae3054f304f274 100644
--- a/tools/include/linux/compiler_types.h
+++ b/tools/include/linux/compiler_types.h
@@ -13,6 +13,24 @@
 #define __has_builtin(x) (0)
 #endif
 
+#ifdef __CHECKER__
+/* context/locking */
+# define __must_hold(x)	__attribute__((context(x,1,1)))
+# define __acquires(x)	__attribute__((context(x,0,1)))
+# define __releases(x)	__attribute__((context(x,1,0)))
+# define __acquire(x)	__context__(x,1)
+# define __release(x)	__context__(x,-1)
+# define __cond_lock(x,c)	((c) ? ({ __acquire(x); 1; }) : 0)
+#else /* __CHECKER__ */
+/* context/locking */
+# define __must_hold(x)
+# define __acquires(x)
+# define __releases(x)
+# define __acquire(x)	(void)0
+# define __release(x)	(void)0
+# define __cond_lock(x,c) (c)
+#endif /* __CHECKER__ */
+
 /* Compiler specific macros. */
 #ifdef __GNUC__
 #include <linux/compiler-gcc.h>
-- 
2.31.1

