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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E60C1B08C
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D4C9613F6
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233469AbhGOQKj (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbhGOQKf (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:10:35 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A916C06175F;
        Thu, 15 Jul 2021 09:07:42 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso5516392wmc.1;
        Thu, 15 Jul 2021 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uIlFdTueIqRJSW/8KrJBB/lB3UR/lkZ7OqoCtQMTjFM=;
        b=o3DVlsFzay8sgFC+YRJykVJhUKb615/2U9IbJnCM+pMMNz3Zdz6x2h0zVJSz8TnKsk
         2lGJNfCIPVW3iRNQm/sic/yW9kwFRooT8KAED76tRMfwykheVFz4HPyMz913XTnG+bmU
         pQzLw3HcLI+O3M0mmFxrw1ViqNMxEVSZqDABj+ld1M4NCaXhShYc6Eo2Gka1gW1cYsH/
         a3CB94Jy9gOY1JhooYLX+xCmxtZ2yN969nfJnTaqVPh/cKQXV/8EhP+acE8EHRNjXqOd
         eUd010XAGNS74V0Xpjxp4CBpQ9eYPn+L5KMary2jkh1CaP0PYtOSFmTGhTWB9aGBjuiK
         mglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uIlFdTueIqRJSW/8KrJBB/lB3UR/lkZ7OqoCtQMTjFM=;
        b=feY4p3P/OYMrGeY5KlCDGxtnaMWlHpwgFlTatbn2Su7kXYzfAhhHPd8BL+5PZNyry+
         hkjnhM2AFaxUtXZ5FIVxEAsp2nrBVfcqzapjv0fm1uICo21C8FFOWNGK6mTgpT182OWk
         Y2kWM2g7Y5MgdJdFnCQSsSz+ilz3aJiALpClNtvYW/mRAC4ONVhXKp3Kb48bY+BlORpv
         FucUNQCH8D4mMeVGsPK1ihoEEc/B0FYMyY6J6Z7RVHBLdk6NKyxsMJKnqleH/wPY1wGJ
         oL4rMfJXU0tz46rAOzhM9SbEcqTj9EsyOYX1qA/Ve5O8Zcaa/E63XOxSPFHgEUVLVBTL
         jevg==
X-Gm-Message-State: AOAM5314v/VxrCSXYfhaY7ZD5ANeMrzVcRdNMmNpoeiaVH2c6SN2hlwN
        OJd9UeptfKTk2lCQinMJoz4=
X-Google-Smtp-Source: ABdhPJylV1XXTUaVQF0DEro7eZtQ/CfLviXy99OdLDJATeu3WOIvJm7lifMw8+dxebW15a7Rd0cfBw==
X-Received: by 2002:a1c:416:: with SMTP id 22mr11572591wme.59.1626365260490;
        Thu, 15 Jul 2021 09:07:40 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id k13sm7446952wrp.34.2021.07.15.09.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:07:39 -0700 (PDT)
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
Subject: [PATCH 11/20] perf session: cleanup trace_event
Date:   Thu, 15 Jul 2021 18:07:16 +0200
Message-Id: <fa2a3f221d90e47ce4e5b7e2d6e64c3509ddc96a.1626343282.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626343282.git.rickyman7@gmail.com>
References: <cover.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports several memory leaks when running the perf test
"82: Use vfs_getname probe to get syscall args filenames", many of which
are related to session->tevent.
This patch will solve this problem, then next patch will fix the remaining
memory leaks in perf-script.
This bug is due to a missing deallocation of the trace_event data
strutures.

This patch adds the missing trace_event__cleanup in
perf_session__delete.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/session.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index e9c929a39973ace9..51f72740291267c5 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -306,6 +306,7 @@ void perf_session__delete(struct perf_session *session)
 			evlist__delete(session->evlist);
 		perf_data__close(session->data);
 	}
+	trace_event__cleanup(&session->tevent);
 	free(session);
 }
 
-- 
2.31.1

