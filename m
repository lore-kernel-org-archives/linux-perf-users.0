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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0605C47E48
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA49613F0
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234795AbhGOQKj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbhGOQKh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:10:37 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FE7C061766;
        Thu, 15 Jul 2021 09:07:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k4so8452959wrc.8;
        Thu, 15 Jul 2021 09:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=czRWs8lyUh4UdNQjlDrLUKXCeLSMkK3ygdHfrYfKD9s=;
        b=CEgKuQWO3EHR56h3sCFiXdiY1MMMi7CHDOrSH4yY59wafHyQ7ANPlFRZY405kMrSo3
         Kbna4ktV0nySJkIZqXeVZQC4JWpXx2hNpIQGXzr9dY1tY9ZeZwN19NJIZQ1RbaFEqi3J
         SpiDu6hBm3U6JTbRNUe9gApmug/rigKLTCkS3Ex+iE+LTEIG9oyJd9MGBR5ASexaGYS9
         GewDkMGnT4OyJODZqOSsGEXvBZ/wCci4x45XFb1t03HIiIVhMHlhYOyF/to0eWibahb9
         k4LFkVfDqqElb8j8uvahQEFOjO4t2yuaGhj++22bjH7lcqD7CL7eYts2Oh/kAiKTKakr
         ZVgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=czRWs8lyUh4UdNQjlDrLUKXCeLSMkK3ygdHfrYfKD9s=;
        b=CzoRU57YGhcfEkmNjExRH3dRSSILRbJBYzxH0+fjSn4h7baqC09MUNNfspMtOlsexT
         q/wEKGikDG4E17/xmSzehSidnmPjrvADAXisjautz4CIIrQJcPE9Vfj5TCPTaF1mxcrv
         L26m1eRgpLSSOtYaP4qgV+SbeS4qg8BjbKfFR9eFMgbbiQ7IgvJdAo8tCDUvgd3UDGY3
         Mhe0r4mHck6CyhKr6MeVYeIUSk7k7WV8XQRLsBsN5xK7I70uA1xLxY0sloZG1zxeUvK2
         7T4/C0sfm9k4TIUA19ta1nGFgjBR8rJyyFDq0027LAqNegYtBewBBVt6Rn/PEcXYk3jA
         mJeA==
X-Gm-Message-State: AOAM532zgDbRdH5yHzPulhes/DJ+XpGcNIChZ47RTl3eykEQzQppqAO4
        mF6hrZffNoiMNCQ7nia/Uwg=
X-Google-Smtp-Source: ABdhPJxToTvj8rbAhU4oKPyxoRCvXl738NbWRNJoiPdn66huTTBKSiHtJ/qpA2sB6SxTpZFxLcerrA==
X-Received: by 2002:adf:e488:: with SMTP id i8mr6625552wrm.285.1626365261728;
        Thu, 15 Jul 2021 09:07:41 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id k13sm7446952wrp.34.2021.07.15.09.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:07:41 -0700 (PDT)
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
Subject: [PATCH 12/20] perf script: release zstd data
Date:   Thu, 15 Jul 2021 18:07:17 +0200
Message-Id: <39388e8cc2f85ca219ea18697a17b7bd8f74b693.1626343282.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626343282.git.rickyman7@gmail.com>
References: <cover.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports several memory leak while running the perf test
"82: Use vfs_getname probe to get syscall args filenames".
One of the leaks is caused by zstd data not being released on exit in
perf-script.

This patch adds the missing zstd_fini.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/builtin-script.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 8c03a9862872d495..bae0e5b72c0e6050 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -4143,6 +4143,7 @@ int cmd_script(int argc, const char **argv)
 		zfree(&script.ptime_range);
 	}
 
+	zstd_fini(&(session->zstd_data));
 	evlist__free_stats(session->evlist);
 	perf_session__delete(session);
 
-- 
2.31.1

