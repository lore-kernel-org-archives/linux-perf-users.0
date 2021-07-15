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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDF2C47E4B
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264F4613F1
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhGOQKZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhGOQKY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:10:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3B7C061760;
        Thu, 15 Jul 2021 09:07:31 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id m2so8522693wrq.2;
        Thu, 15 Jul 2021 09:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yjjAPXRU/f4tqUX/ioC2M8t0jbLZnsxTfex1QSCJU4I=;
        b=g0PtPXmhBXQThgh6YxtbMywRuoRp526rEAQ5qZDfuMd9nMsFgmWuqHzJyvcpy7MtIc
         qsxXJ/lMqfam7zpWiBtF+xBBG3Ir3MVFLfW+Km/bhhpQrBBJKNakjYE87QLOZMtuooeJ
         fvqsFXXArIuRN+yIkMGX+7bxdrWvJol0B6qcYHNxa+fASq2ppVZ7VPYuMMx5SFvbwn9M
         4qAgRuzaoJpNDO1UftdKztvYkgQDHLkYuJxzX24lLHzcjnSP6aULi1VfqNeJuJGnuwEz
         RWumYEu1TcY7zgXnpunHsZ36QcXxzoqW2GfM77BmOFrayuHaExVqVJHeUUTb2FErb61v
         DRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yjjAPXRU/f4tqUX/ioC2M8t0jbLZnsxTfex1QSCJU4I=;
        b=ElBgBps3rQfcaZH6r8E0rJGsX98rRU1P67+uqw0WQvvM4MyXU9Xb3dZfYxdbXKHXlj
         5fNhxzBPT8mPRy1QuIuzhUrk1RI0lIJO9Mteg2CHP1RIhkkq4X6GJez1BRdJ3A5k0XzY
         ZPTiZ1RiZiKCR0umb0cq/KZR7aFtiQcc1LbLeNCQrG/jHrOP9Ac/wvy8QyG8AKGwBNLT
         NTbuZOu0Fshq6HiZJXto+ufx0JXmhwph0EZuZhw3drDGhhBaziZTE8ED6fiEYi1WSVQ5
         RPDD5GTq5KjCPvmopKZuDvn40SXiOSAfw+6aXcllqC+ZPUGLGLdW+Unca5HEZcYbj01k
         yXAA==
X-Gm-Message-State: AOAM5323x2f1s4nDjrastVX1WllohGdPz6zYSLvXlgjliJZ1CYDaOYpF
        xnaYSNpJf2OpnAqBtNPMuxo=
X-Google-Smtp-Source: ABdhPJymV+auznvQIxzfmR04y/cdaIjTGoiYT5Z/ofxol79vlavPWgOt+z5BnKTf0f3zIn8Q7ARpcg==
X-Received: by 2002:a5d:4bc6:: with SMTP id l6mr6666652wrt.53.1626365249791;
        Thu, 15 Jul 2021 09:07:29 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id k13sm7446952wrp.34.2021.07.15.09.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:07:29 -0700 (PDT)
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
Subject: [PATCH 02/20] perf env: fix sibling_dies memory leak
Date:   Thu, 15 Jul 2021 18:07:07 +0200
Message-Id: <2140d0b57656e4eb9021ca9772250c24c032924b.1626343282.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626343282.git.rickyman7@gmail.com>
References: <cover.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports a memory leak in perf_env while running the perf test
"41: Session topology", caused by sibling_dies not being freed.

This patch adds the required free.

Fixes: acae8b36cded0ee6 ("perf header: Add die information in CPU topology")
Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/env.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index ebc5e9ad35db21d1..6c765946ef6f591c 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -186,6 +186,7 @@ void perf_env__exit(struct perf_env *env)
 	zfree(&env->cpuid);
 	zfree(&env->cmdline);
 	zfree(&env->cmdline_argv);
+	zfree(&env->sibling_dies);
 	zfree(&env->sibling_cores);
 	zfree(&env->sibling_threads);
 	zfree(&env->pmu_mappings);
-- 
2.31.1

