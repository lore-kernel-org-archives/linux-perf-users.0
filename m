Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38255C43461
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 May 2021 20:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 172FA61401
	for <linux-perf-users@archiver.kernel.org>; Fri,  7 May 2021 20:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhEGU4n (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 7 May 2021 16:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhEGU4l (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 7 May 2021 16:56:41 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBB9C0613ED
        for <linux-perf-users@vger.kernel.org>; Fri,  7 May 2021 13:55:41 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id b21so5927944plz.0
        for <linux-perf-users@vger.kernel.org>; Fri, 07 May 2021 13:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fDVsOdAVuMhU9NSPpB3f6fpg/PnSrq0B5y1jEjDIJ0Q=;
        b=iD4tT85K8xm9TDTBgGU2oOwO9GUijBqfHLjv3EXuS9Zw0hEezZnEc0WCBIpu18QYz8
         SRhrpjVQ0YUviI9ogflFsSK1t6zORia+iIH3J3U41imjKQG4Eo1LvC3k3oBTIF1vy7yz
         CqNy0k1EtObpp1znQt6FQP7wEKvTnu5ggjqSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fDVsOdAVuMhU9NSPpB3f6fpg/PnSrq0B5y1jEjDIJ0Q=;
        b=CcA70umEV3BwP6zNP+Gf4hO4NAAGTaE0Jw0KyR77TJiWETa9Vds3ElBiTE0JPRK9xl
         dDhMNeIXRF8YW8tcBa5mIcnLriWDpvKx4W5TkosjwT21mUs+TuWf6H4VQG23Ni7Z6ZdI
         rIQdxLjuuXCjN6Rk+q56Ht7PHdwDePZFkYrUADz9v42GGkc7QrcbK0h2NPEe0q0EE56L
         X5QaLlcDZsutY4o5gc5BrwxTfmSXi9FXClGl96N/pjI8351uVSzUNm9hcj/eYgBSlOB1
         0e2U3JxuK6i4uDdpELERCx4TZ1h6ChF7uYDMcLIikHbTBr+PlzSFkWZvGua2ieSVE4wc
         bLBg==
X-Gm-Message-State: AOAM533f56fyrCq4Qu1kh5cer+cECMPQVN/HRkIr4lRF+6OC2Y0hB0wy
        dVbVvF5KfCb8tQdy8oRqfbuyMA==
X-Google-Smtp-Source: ABdhPJwIhmCrqWymkSZsKHAEaKiN1ow1As3pPhFdtCJfJRUezNcgFZBgBc7MgNBLDSOmDyqpmXPmoA==
X-Received: by 2002:a17:90b:19c4:: with SMTP id nm4mr2729502pjb.102.1620420940597;
        Fri, 07 May 2021 13:55:40 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:3c7e:d35:3a19:632f])
        by smtp.gmail.com with ESMTPSA id ge4sm13161565pjb.49.2021.05.07.13.55.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 13:55:40 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Seth LaForge <sethml@google.com>,
        Ricky Liang <jcliang@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 3/3] arm64: perf: Add a config option saying 32-bit thumb code uses R11 for FP
Date:   Fri,  7 May 2021 13:55:13 -0700
Message-Id: <20210507135509.3.Ib4ca8cf998782d53b9613b12a6aca65605b91c72@changeid>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
In-Reply-To: <20210507205513.640780-1-dianders@chromium.org>
References: <20210507205513.640780-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The frame pointer story for 32-bit ARM/Thumb code is a bit of a
nightmare. See the patch ("arm64: perf: perf_callchain_user() compat
support clang/non-APCS-gcc-arm") (including the inline comments) for
some details.

Apparently, all hope is not lost for some resolution to this story.
Recently it's been agreed upon that the frame pointer should be R11
across both ARM and Thumb. This should, at least, allow us to crawl
through mixed code.

Unfortunately I can't think of any automagic way to figure out if code
is using R7 or R11 for the frame pointer. We'll force the person
compiling the kernel to choose one or the other.

NOTE: apparently as-of right now (2021Q1) there are no compilers out
there that actually support this. Thus this patch is untested.
However, it's so simple that it feels right to land it now while
everyone is thinking about it. I have, at least, confirmed that
tracing Thumb code produced with the old compiler _breaks_ when I set
this option. ;-)

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/Kconfig                 | 12 ++++++++++++
 arch/arm64/kernel/perf_callchain.c | 12 ++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9f1d8566bbf9..f123736ac535 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1062,6 +1062,18 @@ config ARCH_SPARSEMEM_ENABLE
 	select SPARSEMEM_VMEMMAP_ENABLE
 	select SPARSEMEM_VMEMMAP
 
+config PERF_COMPAT_THUMB_FP_R11
+	bool "Assume userspace 32-bit Thumb code uses R11 for Frame pointer"
+	help
+	  Historically R11 was the frame pointer (FP) for 32-bit ARM code
+	  and R7 was the frame pointer for 32-bit Thumb code. This resulted in
+	  the inability to use the FP for stack crawling with mixed code.
+	  The 2019Q4 Issue of AAPCS revised the frame pointer to be R11 for
+	  BOTH ARM and Thumb. If your userspace was built with this new
+	  standard then say "yes" here.
+	depends on PERF_EVENTS
+	depends on COMPAT
+
 config HW_PERF_EVENTS
 	def_bool y
 	depends on ARM_PMU
diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index b3cd9f371469..c8187acdbf3f 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -311,12 +311,16 @@ static void compat_perf_callchain_user(struct perf_callchain_entry_ctx *entry,
 
 	/*
 	 * Assuming userspace is compiled with frame pointers then it's in
-	 * R11 for ARM code and R7 for thumb code. If it's thumb mode we'll
-	 * also set the low bit of the PC to match how the PC indicates thumb
-	 * mode when crawling down the stack.
+	 * R11 for ARM code and R7 for thumb code (unless you've got a really
+	 * new compiler). If it's thumb mode we'll also set the low bit of
+	 * the PC to match how the PC indicates thumb mode when crawling
+	 * down the stack.
 	 */
 	if (compat_thumb_mode(regs)) {
-		fp = regs->regs[7];
+		if (IS_ENABLED(CONFIG_PERF_COMPAT_THUMB_FP_R11))
+			fp = regs->regs[11];
+		else
+			fp = regs->regs[7];
 		pc |= BIT(0);
 	} else {
 		fp = regs->compat_fp;
-- 
2.31.1.607.g51e8a6a459-goog

