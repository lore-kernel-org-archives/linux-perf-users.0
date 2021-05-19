Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69CFC433ED
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 14:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FFFC6108D
	for <linux-perf-users@archiver.kernel.org>; Wed, 19 May 2021 14:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346829AbhESOEs (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 19 May 2021 10:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240179AbhESOEs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 19 May 2021 10:04:48 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66349C06175F
        for <linux-perf-users@vger.kernel.org>; Wed, 19 May 2021 07:03:27 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p6so7079541plr.11
        for <linux-perf-users@vger.kernel.org>; Wed, 19 May 2021 07:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oP0t89Z9s5zYI84B3+SNIcurmrdDsju0OZrGse2TFeA=;
        b=ICLPeQzCtbELehERU89yG3KQaxR3nbDDBU/Z50AJbEvmoCKKe7A0QKvyT+Qvrs7Sly
         vxJbeNJKd0ypfW5noZpNgaxoKwYHkmMoZRVHkuzVmh53/ofr3J6ibtv4EcIDtUfq1iWd
         GljDFrI+YL3DlcA0A9D4cYlKKVPsmsLj9mvP9y56r5jmMbaqfScc+3uT7Uv/r3Lk8RsQ
         MpjvxHUL0V52PhdPMR8JaVhwYlwmKkwqJpA00UPQBpiuZ3G2YQ6Frn7E1rqH0uVDOkGF
         A8mrV9RrFUwZgovr1vIXFoV1l0BnPixMZa68iroQq5YqWePx9Cc5Vgw81PlpHFWVycOM
         YZTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oP0t89Z9s5zYI84B3+SNIcurmrdDsju0OZrGse2TFeA=;
        b=Uqaw8IxxYPqPb5/1mreRJncVD5SzC2BrRWG/ozmUC4us4flQ0E8vh7tb2pXil/zA9c
         qO/kAZQf26xbJRdWoIhfa2CU5CBbIDMHYICW8RAu2SRer2GRT23dj/4uq4mi+9ZpPsE2
         8XtcukoOjIofEXCheenf6xMsO8dvTPfyCoI7MjoiVleCqHsNX1UWZQzyTL+oTJqNjl/P
         S875PVy1pwEgIRhQrpHQPsqxJ5WZz7KTG6Soh2hJAbqD59ObA9kHuGqyP8tetsBf/fXu
         RNPFcPyo+pj9S4FpE99cSt6gM2KajxaohhVCbeLzR7eQG9k8Q5OubH4/CyUvYSPChtSN
         ouxA==
X-Gm-Message-State: AOAM5328vX6MpE9MMbDkHVmepopwK5veMIhZ++dY3mCRtjrR5pKSwxU+
        cqCpxNupZvd5cZTLuPo5iy4Cog==
X-Google-Smtp-Source: ABdhPJwAaQcoh9iBLUjGuXfB7OwaFwxQUc0lyCjjG1OAi+Y2iVdFDb3S7GBE1xmS7ZmabIe9H1AT7Q==
X-Received: by 2002:a17:902:7407:b029:f0:dace:a5a9 with SMTP id g7-20020a1709027407b02900f0dacea5a9mr11068213pll.34.1621433006886;
        Wed, 19 May 2021 07:03:26 -0700 (PDT)
Received: from localhost ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id r7sm2797423pjf.55.2021.05.19.07.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:03:26 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 1/2] perf auxtrace: Change to use SMP memory barriers
Date:   Wed, 19 May 2021 22:03:18 +0800
Message-Id: <20210519140319.1673043-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The AUX ring buffer's head and tail can be accessed from multiple CPUs
on SMP system, so changes to use SMP memory barriers to replace the
uniprocessor barriers.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/auxtrace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 472c0973b1f1..8bed284ccc82 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -452,7 +452,7 @@ static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
 	u64 head = READ_ONCE(pc->aux_head);
 
 	/* Ensure all reads are done after we read the head */
-	rmb();
+	smp_rmb();
 	return head;
 }
 
@@ -466,7 +466,7 @@ static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
 #endif
 
 	/* Ensure all reads are done after we read the head */
-	rmb();
+	smp_rmb();
 	return head;
 }
 
@@ -478,7 +478,7 @@ static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
 #endif
 
 	/* Ensure all reads are done before we write the tail out */
-	mb();
+	smp_mb();
 #if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
 	pc->aux_tail = tail;
 #else
-- 
2.25.1

