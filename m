Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD11C07E9B
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 10:41:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DAE66127C
	for <linux-perf-users@archiver.kernel.org>; Sun, 11 Jul 2021 10:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhGKKoT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 11 Jul 2021 06:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbhGKKoR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 11 Jul 2021 06:44:17 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7CDC0613DD
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jul 2021 03:41:31 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id u3so2363880plf.5
        for <linux-perf-users@vger.kernel.org>; Sun, 11 Jul 2021 03:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u/h6y01vhaIboCmoU5QTv0ntWs0BLu7zaNEJjRy0DS4=;
        b=Zj4Ser95niZXysKWnByhPGn7HehGVUfl7nnW2uuuLdWtt8FvTDn1DJtkiYlqAnXvOM
         7WCBS51r0hic0n23bnvsFNPevM4yPDsBKiSvWwSn6nKFqz0PWzZv+RJRknCjQCOzsDPP
         EuyR+YEhdCXDh2knglL4Cu/TkXTQyTnW1vqwwxc/d4uqpucKLc+vqGtouhD/lHT+TTI8
         VT+K2XW6Icb+WrhYViyqeM+3Tm37FrkfBGFycyasGrpZuIa2WUVlspB/+2NUJDmRWuX8
         jQypzUWDQ7ynkeWluJoJvOUOLYONU5hyByk9uTPe4CWIvrRD31gehKnInez5iF2XZ4z3
         OnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u/h6y01vhaIboCmoU5QTv0ntWs0BLu7zaNEJjRy0DS4=;
        b=bPpCQ4vsXJVPZqvW15LtcgaO/fznbc8RvPzdhYRxiMRpheWIp8F67M0pfqVRszPzFl
         TLAlAErETzTD6IxgSy8qH9DZRD/8XO5NFV405JebTzM7K9vOmRGsDMEFZE+j5jXI1YxD
         snV5gW916OZm3r4bTyuoz/y6W5rOXaLt4RhAYhMSeQf/riRo7iG/9EOq4dvUv0Dgo6UD
         DnnsJPFLGPT8UfOrbR1gfe8CaF1isBHsqjN9c87s9XHWAyGlIFaOMWRs8jPm1I+LcY5h
         t7SzGKzE6+5aOmAXp8RvU5NksN1yqLihW2ewc75+UIjkugWncKIkL6e9ge50btG0kYmu
         g9xg==
X-Gm-Message-State: AOAM5332KuZWe++iBzX1DIa1xEGns2ww3BohxgOwdhvvEYkRTDkpsfX7
        fqsmyAmO/ffl6TvkpZdUXrb+U9XpK1vKAe4m
X-Google-Smtp-Source: ABdhPJx2ZkD3Ke+xwOEnTb++Cdto4iZATSeueTetnce3xcHV5VkEW1GhkVilI+3vLAFjAjrNQ7Ftgw==
X-Received: by 2002:a17:903:1243:b029:ed:8298:7628 with SMTP id u3-20020a1709031243b02900ed82987628mr38413186plh.11.1626000090951;
        Sun, 11 Jul 2021 03:41:30 -0700 (PDT)
Received: from localhost ([103.127.241.250])
        by smtp.gmail.com with ESMTPSA id w6sm14036962pgh.56.2021.07.11.03.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 03:41:30 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v4 05/11] perf auxtrace: Use WRITE_ONCE() for updating aux_tail
Date:   Sun, 11 Jul 2021 18:40:59 +0800
Message-Id: <20210711104105.505728-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210711104105.505728-1-leo.yan@linaro.org>
References: <20210711104105.505728-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Use WRITE_ONCE() for updating aux_tail, so can avoid unexpected memory
behaviour.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/perf/util/auxtrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index cc1c1b9cec9c..79227b8864cd 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -480,7 +480,7 @@ static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
 	/* Ensure all reads are done before we write the tail out */
 	smp_mb();
 #if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
-	pc->aux_tail = tail;
+	WRITE_ONCE(pc->aux_tail, tail);
 #else
 	do {
 		old_tail = __sync_val_compare_and_swap(&pc->aux_tail, 0, 0);
-- 
2.25.1

