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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDC6C63799
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jul 2021 15:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 041AF6052B
	for <linux-perf-users@archiver.kernel.org>; Thu, 22 Jul 2021 15:34:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhGVOxv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 22 Jul 2021 10:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhGVOxu (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 22 Jul 2021 10:53:50 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EECC061757;
        Thu, 22 Jul 2021 08:34:24 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r11so6381037wro.9;
        Thu, 22 Jul 2021 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M49ul0bkJBQFuWjJm4FuBm3fFgxnr1HIV0sqLLOvDXs=;
        b=armzozJMAlKNiuq9bWfR6WGUdd8xa0OHH5L5fy0Ia6FcdEC03WhPLs3BfOdh2WwmSj
         sKKoefIXGpgTdb20h8CIZ5eBCual812a9RyuaKvjC8TiZl4fHl65Yd6YOfk159xQfuud
         mfXZohGq/H9TlSrjOUuRhz60lR8DH/bc3cHoBzZyMHqsnj8FrSDp73xVhgYxNUICWfxg
         T7Tb9yrBwxEOAoq0rPK8orHzbLi7Ev65qBY8p0T7Zsp+exx15+iQaQc8FcG+Ta6l6jaI
         ilhi+3hVOqbV3O/+FX3PtQAifol5x77zKvjnIs9X1JoPO/P/lZlj2rqYqi3Db5X2X8on
         g93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M49ul0bkJBQFuWjJm4FuBm3fFgxnr1HIV0sqLLOvDXs=;
        b=F7NjLRw5TGWcG29yT9up+iCvHfmsjJUVAPOx0DzQCGZmBuF92RLW4AEgL0ic4y+Ye+
         uZJzEw1RWyrlbGVofwQBxoRrc/DBoF2FjoP8u0CTBwPSaX3nAonFJLK/HJMV6rY5OCV/
         GsCDbLjAWxRY90HeXWCRGrVwYa5ek0/7np1XrlCc0iGX/MG0IK6fohPfMzKxU78hJdHv
         HQrtdImxTfGiFTdaATdvA9jaOouW7d1vxlysjwujnAJvA7XH+wTN9BDkLjATZbR8Pd9r
         fVjrxuY64UoFXEVJRjlX8ngY6rZ8kT8ED9YNE/v8wGNscq7Sm2mi7Tc+uZWhKXq6AzA6
         YH8Q==
X-Gm-Message-State: AOAM530Zc7mPIBk4XL37FRditg64Fnf97UPZybNB55inFcYPWSiAehJo
        COKCSc0Nr4Rf0ow5bCQpavc=
X-Google-Smtp-Source: ABdhPJwE7vPAoVuY4DJru2lCuHaWt4j5GDD3Ge5/oeUElLRfRHo7oQq+xdySreCxwS2j4JAeNOPThg==
X-Received: by 2002:adf:db85:: with SMTP id u5mr547432wri.167.1626968063144;
        Thu, 22 Jul 2021 08:34:23 -0700 (PDT)
Received: from honeypot.. ([185.91.190.155])
        by smtp.googlemail.com with ESMTPSA id o29sm23735557wms.13.2021.07.22.08.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 08:34:22 -0700 (PDT)
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
Subject: [PATCH 3/3] perf test: mmap-thread-lookup: use gettid
Date:   Thu, 22 Jul 2021 17:34:16 +0200
Message-Id: <0328557450dc7817cd979ee71b33ca9166a1d78b.1626966805.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626966805.git.rickyman7@gmail.com>
References: <cover.1626966805.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

This patch replaces the manual syscall to get the current thread tid,
with the libc equivalent gettid.
Since it is only available from glibc 2.30, the libc_compat.h header is
included, which provides its definition in case gettid is not available.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/tests/mmap-thread-lookup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/mmap-thread-lookup.c b/tools/perf/tests/mmap-thread-lookup.c
index 8d9d4cbff76d17d5..055cc850a6061798 100644
--- a/tools/perf/tests/mmap-thread-lookup.c
+++ b/tools/perf/tests/mmap-thread-lookup.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <inttypes.h>
 #include <unistd.h>
-#include <sys/syscall.h>
+#include <tools/libc_compat.h> // gettid
 #include <sys/types.h>
 #include <sys/mman.h>
 #include <pthread.h>
@@ -45,7 +45,7 @@ static int thread_init(struct thread_data *td)
 	}
 
 	td->map = map;
-	td->tid = syscall(SYS_gettid);
+	td->tid = gettid();
 
 	pr_debug("tid = %d, map = %p\n", td->tid, map);
 	return 0;
-- 
2.31.1

