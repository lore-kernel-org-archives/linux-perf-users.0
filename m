Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A00C47083
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 10:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E453613BF
	for <linux-perf-users@archiver.kernel.org>; Wed,  2 Jun 2021 10:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbhFBKcS (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 2 Jun 2021 06:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232638AbhFBKcQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Jun 2021 06:32:16 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24099C061574
        for <linux-perf-users@vger.kernel.org>; Wed,  2 Jun 2021 03:30:32 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 29so1845494pgu.11
        for <linux-perf-users@vger.kernel.org>; Wed, 02 Jun 2021 03:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WZdXkeLXyTRCRBlV6ZkvwSxOi71Ng+ItJPqjFI54Mcg=;
        b=Z3sB+5zdNXr9kef5JA3bJvYP76xDiTOty/eJXFB532T92HsbDk7gItssLcLF5a+Okv
         DRLOrn43EY1kdU1/LchPW2gzDwUvBULq3wHLgA2d+huNDCSOW5BOnFEfY/+os56y11aX
         rXEdqD5bI1hPOr7cu5P7uCRP67zfCHm0xxmaIXH3md4KFb9EDuvM6upqbbtw2DWjc/+V
         ZpdMWlGpHm9FJDb0D7TutJxr8CzO8iwi4Hzq1A+u2+SJMti1ch5We3G2fjdnzNjV1A4+
         aa4jPTK5jbAq2gdWcArgQFFCyQFQJvzpSy60LSq47C48o1c5NQSFtQ9qrYHbHxgWwkk7
         t0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WZdXkeLXyTRCRBlV6ZkvwSxOi71Ng+ItJPqjFI54Mcg=;
        b=cGnH3uakdBnFqfT+ZoqVyZ4P4Siw3phLCb7MFHcAG0HLJObwZDLV8Ty4sIiQ9KXt90
         GSFm+ZVf+HJ7hatVH8ZzfRtMiQgbzpJR1PluZFboBfBss1VNW/A4pxfYqc2bProldm5m
         /ogtJKf5Ow4UZwLll77O65TBbGTww9PRORfAPQ4wWGWy1DtrVrhh9BSt/BMgcUJ0xRkB
         5Qr3rPRoL+IpggPqY5Ew6dhEUl5T1LrWvrm2uSZf5ZGygtgN8iwNM5iudBksPDK1UC0Q
         E3IngH/R5vzs67/PRLNYCy7RlisfJ1hX+PfZmvHr9jham4WV0zq8Fd6gTyj7zma1i+hR
         wPpg==
X-Gm-Message-State: AOAM530u2nV1oqVK0a12gEFRJ++MLgBZDo7ioOADnHSTXWPoTV6JNUSO
        IuQkC26+lcRF4hpBAYVgmfuG+w==
X-Google-Smtp-Source: ABdhPJyzXB1PcQNWg3aQfHpUUQxqS7K4lMUmeNIvTRxqevGy++Vn5qNRvTHr+W+TDzT0S9K2D8xe3Q==
X-Received: by 2002:a63:471f:: with SMTP id u31mr33399072pga.85.1622629831701;
        Wed, 02 Jun 2021 03:30:31 -0700 (PDT)
Received: from localhost (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id o24sm16697046pgl.55.2021.06.02.03.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:30:31 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 5/8] perf auxtrace: Change to use SMP memory barriers
Date:   Wed,  2 Jun 2021 18:30:04 +0800
Message-Id: <20210602103007.184993-6-leo.yan@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602103007.184993-1-leo.yan@linaro.org>
References: <20210602103007.184993-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The kernel and the userspace tool can access the AUX ring buffer head
and tail from different CPUs, thus SMP class of barriers are required
on SMP system.

This patch changes to use SMP barriers to replace mb() and rmb()
barriers.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/auxtrace.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index a4fbb33b7245..42b7ef811bde 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -444,7 +444,7 @@ static inline u64 auxtrace_mmap__read_snapshot_head(struct auxtrace_mmap *mm)
 	u64 head = READ_ONCE(pc->aux_head);
 
 	/* Ensure all reads are done after we read the head */
-	rmb();
+	smp_rmb();
 	return head;
 }
 
@@ -458,7 +458,7 @@ static inline u64 auxtrace_mmap__read_head(struct auxtrace_mmap *mm)
 #endif
 
 	/* Ensure all reads are done after we read the head */
-	rmb();
+	smp_rmb();
 	return head;
 }
 
@@ -470,7 +470,7 @@ static inline void auxtrace_mmap__write_tail(struct auxtrace_mmap *mm, u64 tail)
 #endif
 
 	/* Ensure all reads are done before we write the tail out */
-	mb();
+	smp_mb();
 #if BITS_PER_LONG == 64 || !defined(HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT)
 	pc->aux_tail = tail;
 #else
-- 
2.25.1

