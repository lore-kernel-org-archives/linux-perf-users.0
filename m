Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B581C432BE
	for <linux-perf-users@archiver.kernel.org>; Sun, 29 Aug 2021 10:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA1E60E90
	for <linux-perf-users@archiver.kernel.org>; Sun, 29 Aug 2021 10:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbhH2KXz (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 29 Aug 2021 06:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhH2KXz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 29 Aug 2021 06:23:55 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909BEC061756
        for <linux-perf-users@vger.kernel.org>; Sun, 29 Aug 2021 03:23:03 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id x19so2772785pfu.4
        for <linux-perf-users@vger.kernel.org>; Sun, 29 Aug 2021 03:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+tIlR3yAnihc/8N68dAkVCR/HC1yo91sWJBQN/lr8bM=;
        b=EpBQc1jEbWZQDKA/Hd96/dSblduNlrZBfncFOQFXZpBZasUh1zyFsHwfMwKgYRKn2h
         q4NE7GP+NXGct8xScaCRIZnWy+hcmxCEq/nCYqgCQNL6rwF/YRU1M6f1fD4O4cbNoTzz
         uXwFsacODV17YlAKMBclA++GTdimgD4pqTRn5Q4GCyKHe6AgjXLUHb8GqfqPlIGscUaX
         ZgDzHZA0qamkZz1/SgpKYCbiJR76MPDn6r/4PVd/QIasX3mNJggJd6mDMt0CtC5TAb4i
         KmmVTatyoe7/Mi9gAG1PbwKdoNzQK3A0UihvZVjffBNZQkyZ5IEgzccZ6tRbr9QFbn7X
         5f6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+tIlR3yAnihc/8N68dAkVCR/HC1yo91sWJBQN/lr8bM=;
        b=PKVsaS/u7hb+RHEz08mWhV/O6Ms7QQvc9Rl1qEo2DxWSIlrcfUjMWyXuEZwJBOFoH3
         uT7a8GqpUF0ax8OemJeSxc7ostbzEJtEt+AcnXLL58dmUud37Fmyj95KduuTIeqF9lpD
         cIek7hDTl2SMGxuq6uZTH84yncVvBfg8dHKir5m0xgv7oBsUOploXYiQNSYCMPuUAQNK
         HH8GVDHz2ot5wGODIzt3zCs225KxyI6Sja5gG6DZHSJ51Kxnh1Vz/sEz1zFFTV5BADGC
         KrFCZQZ8tHYzrV8+jL5AaZf2BILU82GI68+5btHnUKvDAqlVSAt89biB41Lo0ke7ehe0
         r4Ew==
X-Gm-Message-State: AOAM530/kWCsz0/WJdXvPG7I0UJu8maUbV0CLpgWU/d9vUJG4IjXr9WE
        7Y8zK93M8kq2AFsmebFUldkV0w==
X-Google-Smtp-Source: ABdhPJx0z9GdJsy4ggFkGrduZsKKGG/vfDnVoFB9KZKLY9yy2wtvbqbnc5phggOaYFxXoxCi8NiAQQ==
X-Received: by 2002:a62:8603:0:b029:3c8:3fdb:4aea with SMTP id x3-20020a6286030000b02903c83fdb4aeamr17882261pfd.6.1630232583070;
        Sun, 29 Aug 2021 03:23:03 -0700 (PDT)
Received: from localhost ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id b20sm11404522pfl.9.2021.08.29.03.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 03:23:02 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 2/2] perf auxtrace arm: Support compat_auxtrace_mmap__{read_head|write_tail}
Date:   Sun, 29 Aug 2021 18:22:38 +0800
Message-Id: <20210829102238.19693-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210829102238.19693-1-leo.yan@linaro.org>
References: <20210829102238.19693-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When the tool runs with compat mode on Arm platform, the kernel is in
64-bit mode and user space is in 32-bit mode; the user space can use
instructions "ldrd" and "strd" for 64-bit value atomicity.

This patch adds compat_auxtrace_mmap__{read_head|write_tail} for arm
building, it uses "ldrd" and "strd" instructions to ensure accessing
atomicity for aux head and tail.  The file arch/arm/util/auxtrace.c is
built for arm and arm64 building, these two functions are not needed for
arm64, so check the compiler macro "__arm__" to only include them for
arm building.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: James Clark <james.clark@arm.com>
Tested-by: James Clark <james.clark@arm.com>
---
 tools/perf/arch/arm/util/auxtrace.c | 32 +++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
index b187bddbd01a..c7c7ec0812d5 100644
--- a/tools/perf/arch/arm/util/auxtrace.c
+++ b/tools/perf/arch/arm/util/auxtrace.c
@@ -107,3 +107,35 @@ struct auxtrace_record
 	*err = 0;
 	return NULL;
 }
+
+#if defined(__arm__)
+u64 compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
+{
+	struct perf_event_mmap_page *pc = mm->userpg;
+	u64 result;
+
+	__asm__ __volatile__(
+"	ldrd    %0, %H0, [%1]"
+	: "=&r" (result)
+	: "r" (&pc->aux_head), "Qo" (pc->aux_head)
+	);
+
+	return result;
+}
+
+int compat_auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
+{
+	struct perf_event_mmap_page *pc = mm->userpg;
+
+	/* Ensure all reads are done before we write the tail out */
+	smp_mb();
+
+	__asm__ __volatile__(
+"	strd    %2, %H2, [%1]"
+	: "=Qo" (pc->aux_tail)
+	: "r" (&pc->aux_tail), "r" (tail)
+	);
+
+	return 0;
+}
+#endif
-- 
2.25.1

