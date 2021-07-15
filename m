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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9288CC47E48
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 801E1613F6
	for <linux-perf-users@archiver.kernel.org>; Thu, 15 Jul 2021 16:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233758AbhGOQKe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 15 Jul 2021 12:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhGOQKb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 15 Jul 2021 12:10:31 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD9EC061764;
        Thu, 15 Jul 2021 09:07:37 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v5so8502314wrt.3;
        Thu, 15 Jul 2021 09:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BXFdRwfSh/bEwWtJAAKqaZ/Dfgb0l78ZFWkOfVRAIR8=;
        b=s7QAG04/uowor3SEV4/GhhxGEGNY/ExxjwKTHa0V0AIoGa4Kf5XxX6q+owJh1DCCme
         r3z9XIBw/7JWTysK5sB6hnPpz4flnyI2EWXDJl5jSm/pIgClWoVMjCqbIRKt3IL+scoL
         URWg5tq79kb9stUL43kVfR2cIMvFepSaujievngMiWU4eK3HdGNwXzgiA6r1CNjFLNAM
         ANskkpb5fyU+GJBx9YqpyUqpK9bClrkaGrzPNXMz6yUhREQCLQFEhQODBlPVYUNCC1Xp
         VqisP7FQGVEi/Pqd8hJ310d4+GxTRlgz6jqSCK+tjKJs1s5Vjpj88swLoa/56yC01/Cd
         tKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BXFdRwfSh/bEwWtJAAKqaZ/Dfgb0l78ZFWkOfVRAIR8=;
        b=LO6skMq4rwpB8uRy7MD4wK10VvRuDEkTXoDLH2PuUZjwnutnhS5TtgLj9WDM+qHKJ4
         wWVx3CkqEgfuaj3yxJ7ENkQzTDCamCDxMYPvC3IE3eAvsSRQ/15SDwWd3mZpCS7QFVLB
         qo7AWANkyzvxlofqm/HEBSTA/sG2IbgKgdJEB/x6qhGQQ6WhcdAnDzPmD2gic8aaK3SL
         fHxhG+1mtWlaohmGKpIVMSN5wHAB4A+tfn4XzfKNkLvQXpZv7KKbo4e4NzhR800jSFfJ
         CMmmXcxlsAooOZdx86yPG7SddzI+prXzQD54WR/GAXA6H6UANralgxPr0AeMAwsYZcqt
         mllg==
X-Gm-Message-State: AOAM532E2iO5HGHLQW6vsCeAqrzPDXYi8Rc8ZLR5XZ/4VtvHJfVr3uVk
        cyjifEk3HbdK4HVa79uStT0=
X-Google-Smtp-Source: ABdhPJzwd0IW2F5i3hDXQeeJf2tHBVKo+KVqevdBncEuIQ0+G4Z93HMHLu6+pTjXtrBNllgl1L/LCQ==
X-Received: by 2002:a5d:408f:: with SMTP id o15mr6645193wrp.342.1626365256439;
        Thu, 15 Jul 2021 09:07:36 -0700 (PDT)
Received: from honeypot.lan ([2001:b07:6456:fd99:ced0:db1c:53e1:191e])
        by smtp.googlemail.com with ESMTPSA id k13sm7446952wrp.34.2021.07.15.09.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 09:07:35 -0700 (PDT)
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
Subject: [PATCH 08/20] perf env: fix memory leak of cpu_pmu_caps
Date:   Thu, 15 Jul 2021 18:07:13 +0200
Message-Id: <6ba036a8220156ec1f3d6be3e5d25920f6145028.1626343282.git.rickyman7@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626343282.git.rickyman7@gmail.com>
References: <cover.1626343282.git.rickyman7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ASan reports memory leaks while running the perf test
"83: Zstd perf.data compression/decompression".
The first of the leaks is caused by env->cpu_pmu_caps not being freed.

This patch adds the missing (z)free inside perf_env__exit.

Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
---
 tools/perf/util/env.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 6c765946ef6f591c..cec2e6cad8aabfe7 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -191,6 +191,7 @@ void perf_env__exit(struct perf_env *env)
 	zfree(&env->sibling_threads);
 	zfree(&env->pmu_mappings);
 	zfree(&env->cpu);
+	zfree(&env->cpu_pmu_caps);
 	zfree(&env->numa_map);
 
 	for (i = 0; i < env->nr_numa_nodes; i++)
-- 
2.31.1

