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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A83C63798
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jul 2021 15:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0717F60BD3
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jul 2021 15:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbhGVOxu (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jul 2021 10:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbhGVOxt (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jul 2021 10:53:49 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A458EC061575;
        Thu, 22 Jul 2021 08:34:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id f17so6388846wrt.6;
        Thu, 22 Jul 2021 08:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=67qwQMdJiWpJhcKWHqbeIHIALS+B+pZPfDzT1EC8xO0=;
        b=BxjUIh+JjBdbu5EiOvQ7SHg3AI5wMYa9cqio9E/gRh1eSlFlXcTMiAHW6pYKdzxLlo
         H18rNtZ3h0Bj9ORH7+gO3RDHNSPveR+Cx1EUlNjAGA/SnBPhZ41EFwjbq9d517hpYm47
         qWDEpD45M/KkMGbor6wm3O5x4FlAq0umruP+1UnhEpzgEjfxtzY4YEDnq/y3mq99vb6u
         3AS/srj8/LKRNdSrD8ogPQdxUwII1U677GVrNdouJBMZqujXkBTRKgViGT2o4TShJ8PZ
         YZOFRNkjY8q1uT/Ft5Uu+ZUzuJXEt+fpYTXd3VReJv50PAD0L5Gwaj1ydYQf0JF+VBRU
         YOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=67qwQMdJiWpJhcKWHqbeIHIALS+B+pZPfDzT1EC8xO0=;
        b=T//v340Cxb13imjnJ0J8mOdvvVSYE7oofqi4KFjXb9Wcw+tIntpiH2rEZCe7vcJNtS
         ethfc603EjZX6MbvqN33D/Ouwv4xwxxdYEBbRGJy1uSKmCRZwt3jhE1xYGDtHxZg0YMw
         PdiR9+aTPKAKUhn97edBhjDvdK4FwwzopWIt41sQwKXsrfHKSE4oTgr/tImQzWpglERH
         Sg5eIKIkOiYj7AMYZHSCsSLB1o8z6quWSSMon1VwONqHBE2yClNTla2WZWK9inrHOyqT
         TMKajGt2uJAi+ih/Iy0CeJDTJQ8tNHa46lN0qngoYnbqLj4l6n7MB90/cSN/ePMvluFK
         dS5w==
X-Gm-Message-State: AOAM530ZcrvzxefroBCq/xGbrl2MFCem3zlgrJb+HXVo0IC3EHXyrPVi
        dqkKYx7eYFlKf1ym21Oqg4Q=
X-Google-Smtp-Source: ABdhPJyBuQJW0ucUYrGfD/t7PI00bPap8z4Qzxz23rdMY7Kf1oLMjRlx1tL9XxPVnWEBlRKB67efZA==
X-Received: by 2002:a5d:6209:: with SMTP id y9mr559965wru.402.1626968062269;
        Thu, 22 Jul 2021 08:34:22 -0700 (PDT)
Received: from honeypot.. ([185.91.190.155])
        by smtp.googlemail.com with ESMTPSA id o29sm23735557wms.13.2021.07.22.08.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 08:34:21 -0700 (PDT)
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH 2/3] perf jvmti: use gettid from libc_compat
Date:   Thu, 22 Jul 2021 17:34:15 +0200
Message-Id: <4e24f9b00cbe53520cfe66781b29a3977ae23243.1626966805.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626966805.git.rickyman7@gmail.com>
References: <cover.1626966805.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch removes the re-definition of gettid in jvmti_agent.c, adding
the include of the libc_compat.h header, which now contains the gettid
function.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/jvmti/jvmti_agent.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/tools/perf/jvmti/jvmti_agent.c b/tools/perf/jvmti/jvmti_agent.c
index 526dcaf9f07903dd..299e7e87198cc18d 100644
--- a/tools/perf/jvmti/jvmti_agent.c
+++ b/tools/perf/jvmti/jvmti_agent.c
@@ -33,7 +33,7 @@
 #include <unistd.h>
 #include <time.h>
 #include <sys/mman.h>
-#include <syscall.h> /* for gettid() */
+#include <tools/libc_compat.h> /* for gettid() */
 #include <err.h>
 #include <linux/kernel.h>
 
@@ -45,13 +45,6 @@
 static char jit_path[PATH_MAX];
 static void *marker_addr;
 
-#ifndef HAVE_GETTID
-static inline pid_t gettid(void)
-{
-	return (pid_t)syscall(__NR_gettid);
-}
-#endif
-
 static int get_e_machine(struct jitheader *hdr)
 {
 	ssize_t sret;
-- 
2.31.1

