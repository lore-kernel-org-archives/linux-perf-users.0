Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87021C07E9C
	for <linux-perf-users@archiver.kernel.org>; Sun,  4 Jul 2021 07:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72FD8617C9
	for <linux-perf-users@archiver.kernel.org>; Sun,  4 Jul 2021 07:17:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhGDHUN (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sun, 4 Jul 2021 03:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbhGDHUM (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 4 Jul 2021 03:20:12 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDF4C061764
        for <linux-perf-users@vger.kernel.org>; Sun,  4 Jul 2021 00:17:37 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id d12so14921833pgd.9
        for <linux-perf-users@vger.kernel.org>; Sun, 04 Jul 2021 00:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gwprV+HEULsEJDwZz52p62rJDy8elyvDLwuO5n6hP4M=;
        b=NgdnPOfd6b3O96H8aRbeIKmk+vH5RfMp2Nx3nRMWfJpHyBi8GKXwu7s38mdKLr/Gh4
         EkyVIEinvkCfBMH5Bm8zc4O3xeWmLnIw++hX6GlkQ1P6cXneJacsnmxsbswoyq/C+7hD
         iUnX5NIAASXCNNfOhyDskBZ/LUOsuCBQhbDDVjDPOMXLBtZtgFJSahSHXFSN6ZYu+vsg
         DtJpW1vOCS8mnBjSEmFlaiV9/14LVtriCLtG+aP7ikdJyAOOOxfQJuRJjD5bju3XD8xt
         XfpOHF6JVDEsubuEKt3P3jJ1sey12d6+zJGzvd3X93nAEobsnPvHA6Csz5+QCca/clMm
         CaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gwprV+HEULsEJDwZz52p62rJDy8elyvDLwuO5n6hP4M=;
        b=GcUVG7It/zO0VZFKhdYZMx2dBz9f01tYS4RBIOrqvvgpzxouAj8ghECsgaapEaXx6j
         f5LH9Mo6onoQ6G72QvfB5SlmrLuIv5w3GMDqsyCczee16YoVjQT7KghBKD0RzVOkkydT
         t9VOaAMNjHV97UvgCV+19fPwH7PljM0bBNZuSsFwemBh/wTW/at74FkK+2R/EueVCOtF
         wyhnHKyzqqJUZYEkVWYHh05cRRrFZ3Wo88G9pecaXY3zahaRYcJwx6isDRYxQlhFLcDx
         hmHsv4wWCONt7Jdn7J6Ef3CY+Odbpviy00LrmPz/EvCGQ1zmBvMGhD8/A+ePL5AyZGIQ
         vKJg==
X-Gm-Message-State: AOAM532XuW5TV8aH2548E4zzVVHnVqoCVPo1H5W6s2dHBsE9aucecF9a
        Gn9tcEIETyIr2/pJmOASOT9kHg==
X-Google-Smtp-Source: ABdhPJwi978cbAVtSkaJxDburLnX4Nsgf0DoJyTtLrWIgWNd8EQiH46mWics+JvO2UBcivpRgXdwFw==
X-Received: by 2002:aa7:8284:0:b029:312:1c62:cc0f with SMTP id s4-20020aa782840000b02903121c62cc0fmr8568364pfm.75.1625383056872;
        Sun, 04 Jul 2021 00:17:36 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id 9sm8834236pfv.42.2021.07.04.00.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 00:17:36 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
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
Subject: [PATCH v3 10/10] perf auxtrace: Add compat_auxtrace_mmap__{read_head|write_tail}
Date:   Sun,  4 Jul 2021 15:16:44 +0800
Message-Id: <20210704071644.107397-11-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210704071644.107397-1-leo.yan@linaro.org>
References: <20210704071644.107397-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

When perf runs in compat mode (kernel in 64-bit mode and the perf is in
32-bit mode), the 64-bit value atomicity in the user space cannot be
assured, E.g. on some architectures, the 64-bit value accessing is split
into two instructions, one is the low 32-bit accessing and another is
for the high 32-bit.

This patch introduces two functions compat_auxtrace_mmap__read_head()
and compat_auxtrace_mmap__write_tail(), as their naming indicates, when
perf tool works in compat mode, it uses these two functions to access
the AUX head and tail.  These two functions can allow the perf tool to
work properly in certain conditions, e.g. when perf tool works in
snapshot mode with only using AUX head pointer, or perf tool uses the
AUX buffer and the tail is not bigger than 4GB.

When the perf tool cannot handle the case when the AUX tail is overflow
for 4GB, the function compat_auxtrace_mmap__write_tail() returns -1 and
the caller is changed to bail out for the overflow error.

Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/auxtrace.c |  9 ++--
 tools/perf/util/auxtrace.h | 94 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 98 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index db6255b55c90..a430d74b279f 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1766,10 +1766,13 @@ static int __auxtrace_mmap__read(struct mmap *map,
 	mm->prev = head;
 
 	if (!snapshot) {
-		auxtrace_mmap__write_tail(mm, head);
-		if (itr->read_finish) {
-			int err;
+		int err;
 
+		err = auxtrace_mmap__write_tail(mm, head);
+		if (err < 0)
+			return err;
+
+		if (itr->read_finish) {
 			err = itr->read_finish(itr, mm->idx);
 			if (err < 0)
 				return err;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index d68a5e80b217..66de7b6e65ec 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -18,6 +18,8 @@
 #include <asm/bitsperlong.h>
 #include <asm/barrier.h>
 
+#include "env.h"
+
 union perf_event;
 struct perf_session;
 struct evlist;
@@ -440,23 +442,111 @@ struct auxtrace_cache;
 
 #ifdef HAVE_AUXTRACE_SUPPORT
 
+/*
+ * In the compat mode kernel runs in 64-bit and perf tool runs in 32-bit mode,
+ * 32-bit perf tool cannot access 64-bit value atomically, which might lead to
+ * the issues caused by the below sequence on multiple CPUs: when perf tool
+ * accesses either the load operation or the store operation for 64-bit value,
+ * on some architectures the operation is divided into two instructions, one
+ * is for accessing the low 32-bit value and another is for the high 32-bit;
+ * thus these two user operations can give the kernel chances to access the
+ * 64-bit value, and thus leads to the unexpected load values.
+ *
+ *   kernel (64-bit)                        user (32-bit)
+ *
+ *   if (LOAD ->aux_tail) { --,             LOAD ->aux_head_lo
+ *       STORE $aux_data      |       ,--->
+ *       FLUSH $aux_data      |       |     LOAD ->aux_head_hi
+ *       STORE ->aux_head   --|-------`     smp_rmb()
+ *   }                        |             LOAD $data
+ *                            |             smp_mb()
+ *                            |             STORE ->aux_tail_lo
+ *                            `----------->
+ *                                          STORE ->aux_tail_hi
+ *
+ * For this reason, it's impossible for the perf tool to work correctly when
+ * the AUX head or tail is bigger than 4GB (more than 32 bits length); and we
+ * can not simply limit the AUX ring buffer to less than 4GB, the reason is
+ * the pointers can be increased monotonically (e.g in snapshot mode), whatever
+ * the buffer size it is, at the end the head and tail can be bigger than 4GB
+ * and carry out to the high 32-bit.
+ *
+ * To mitigate the issues and improve the user experience, we can allow the
+ * perf tool working in certain conditions and bail out with error if detect
+ * any overflow cannot be handled.
+ *
+ * For reading the AUX head, it reads out the values for three times, and
+ * compares the high 4 bytes of the values between the first time and the last
+ * time, if there has no change for high 4 bytes injected by the kernel during
+ * the user reading sequence, it's safe for use the second value.
+ *
+ * When update the AUX tail and detects any carrying in the high 32 bits, it
+ * means there have two store operations in user space and it cannot promise
+ * the atomicity for 64-bit write, so return '-1' in this case to tell the
+ * caller an overflow error has happened.
+ */
+static inline u64 compat_auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
+{
+	struct perf_event_mmap_page *pc = mm->userpg;
+	u64 first, second, last;
+	u64 mask = (u64)(UINT32_MAX) << 32;
+
+	do {
+		first = READ_ONCE(pc->aux_head);
+		/* Ensure all reads are done after we read the head */
+		smp_rmb();
+		second = READ_ONCE(pc->aux_head);
+		/* Ensure all reads are done after we read the head */
+		smp_rmb();
+		last = READ_ONCE(pc->aux_head);
+	} while ((first & mask) != (last & mask));
+
+	return second;
+}
+
+static inline int compat_auxtrace_mmap__write_tail(struct auxtrace_mmap *mm,
+						    u64 tail)
+{
+	struct perf_event_mmap_page *pc = mm->userpg;
+	u64 mask = (u64)(UINT32_MAX) << 32;
+
+	if (tail & mask)
+		return -1;
+
+	/* Ensure all reads are done before we write the tail out */
+	smp_mb();
+	WRITE_ONCE(pc->aux_tail, tail);
+	return 0;
+}
+
 static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
 {
 	struct perf_event_mmap_page *pc = mm->userpg;
-	u64 head = READ_ONCE(pc->aux_head);
+	u64 head;
+
+#if BITS_PER_LONG == 32
+	if (kernel_is_64_bit)
+		return compat_auxtrace_mmap__read_head(mm);
+#endif
+	head = READ_ONCE(pc->aux_head);
 
 	/* Ensure all reads are done after we read the head */
 	smp_rmb();
 	return head;
 }
 
-static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
+static inline int auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
 {
 	struct perf_event_mmap_page *pc = mm->userpg;
 
+#if BITS_PER_LONG == 32
+	if (kernel_is_64_bit)
+		return compat_auxtrace_mmap__write_tail(mm, tail);
+#endif
 	/* Ensure all reads are done before we write the tail out */
 	smp_mb();
 	WRITE_ONCE(pc->aux_tail, tail);
+	return 0;
 }
 
 int auxtrace_mmap__mmap(struct auxtrace_mmap *mm,
-- 
2.25.1

