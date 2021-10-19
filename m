Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4AEC4332F
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 23:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF88610D0
	for <linux-perf-users@archiver.kernel.org>; Tue, 19 Oct 2021 23:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhJSXV0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 19 Oct 2021 19:21:26 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:33744 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhJSXVY (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 19 Oct 2021 19:21:24 -0400
Received: by mail-oi1-f170.google.com with SMTP id q129so7421585oib.0;
        Tue, 19 Oct 2021 16:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ittPuaaAb6BbKzqxfVLQuW2CwyJEQqA2ePbGsF19zjE=;
        b=bmsGr3yHHJP4pVaTwl8Ix7nNbCa31iXRCCRdL/FwZt0B7YO4/m5lXYr0FnJX18uOGi
         GrxJGMJ3Ueg5r2FZ55bediS/iNT0fFazbdvqx/Y3TQwtS1V4PDUnmvvnbHTS49EVC6ew
         qnoJIlZDOqoVZ6D98+aoUv+E7vYI3Ki/ms4hNfqSLTzTx2cj0se0kUHUf/v9w+rwxJW2
         Ghuv+HlG73ChRYeWtAyw/73BPc3tQYswJAVTkVES09q/5EGs0RmiSB+6lcBg935GHIup
         L87M2oLDA6ujWXKN+rUJKG3aJD0LlKWEemSicdxUGlDW+g/Jj5tj1OKEV22sMqKP0Rid
         8ALg==
X-Gm-Message-State: AOAM533jAf+BsL+auSa6bu3apWQdfgapDyBIRRyy1a4DJGuQ2mtlNy7p
        1iBIOn1OI/++OmR0cNMF0Q==
X-Google-Smtp-Source: ABdhPJwfAmKftrawIsbL/H+4+r+nNQRmwOG5i68jp2kA55oez+5lwFCtksS/X0B/5F6t4+cv0yRW7A==
X-Received: by 2002:aca:3e8a:: with SMTP id l132mr6195713oia.95.1634685550299;
        Tue, 19 Oct 2021 16:19:10 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id w141sm118375oif.20.2021.10.19.16.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 16:19:09 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH v11 1/5] x86: perf: Move RDPMC event flag to a common definition
Date:   Tue, 19 Oct 2021 18:19:03 -0500
Message-Id: <20211019231907.1009567-2-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211019231907.1009567-1-robh@kernel.org>
References: <20211019231907.1009567-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

In preparation to enable user counter access on arm64 and to move some
of the user access handling to perf core, create a common event flag for
user counter access and convert x86 to use it.

Since the architecture specific flags start at the LSB, starting at the
MSB for common flags.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-perf-users@vger.kernel.org
Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v11:
 - Move PERF_EVENT_FLAG_USER_READ_CNT definition above struct
---
 arch/x86/events/core.c       | 10 +++++-----
 arch/x86/events/perf_event.h |  2 +-
 include/linux/perf_event.h   |  9 +++++++++
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 2a57dbed4894..2bd50fc061e1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2469,7 +2469,7 @@ static int x86_pmu_event_init(struct perf_event *event)
 
 	if (READ_ONCE(x86_pmu.attr_rdpmc) &&
 	    !(event->hw.flags & PERF_X86_EVENT_LARGE_PEBS))
-		event->hw.flags |= PERF_X86_EVENT_RDPMC_ALLOWED;
+		event->hw.flags |= PERF_EVENT_FLAG_USER_READ_CNT;
 
 	return err;
 }
@@ -2503,7 +2503,7 @@ void perf_clear_dirty_counters(void)
 
 static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
 {
-	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
+	if (!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT))
 		return;
 
 	/*
@@ -2524,7 +2524,7 @@ static void x86_pmu_event_mapped(struct perf_event *event, struct mm_struct *mm)
 
 static void x86_pmu_event_unmapped(struct perf_event *event, struct mm_struct *mm)
 {
-	if (!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED))
+	if (!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT))
 		return;
 
 	if (atomic_dec_and_test(&mm->context.perf_rdpmc_allowed))
@@ -2535,7 +2535,7 @@ static int x86_pmu_event_idx(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (!(hwc->flags & PERF_X86_EVENT_RDPMC_ALLOWED))
+	if (!(hwc->flags & PERF_EVENT_FLAG_USER_READ_CNT))
 		return 0;
 
 	if (is_metric_idx(hwc->idx))
@@ -2718,7 +2718,7 @@ void arch_perf_update_userpage(struct perf_event *event,
 	userpg->cap_user_time = 0;
 	userpg->cap_user_time_zero = 0;
 	userpg->cap_user_rdpmc =
-		!!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED);
+		!!(event->hw.flags & PERF_EVENT_FLAG_USER_READ_CNT);
 	userpg->pmc_width = x86_pmu.cntval_bits;
 
 	if (!using_native_sched_clock() || !sched_clock_stable())
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index e3ac05c97b5e..49f68b15745f 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -73,7 +73,7 @@ static inline bool constraint_match(struct event_constraint *c, u64 ecode)
 #define PERF_X86_EVENT_PEBS_NA_HSW	0x0010 /* haswell style datala, unknown */
 #define PERF_X86_EVENT_EXCL		0x0020 /* HT exclusivity on counter */
 #define PERF_X86_EVENT_DYNAMIC		0x0040 /* dynamic alloc'd constraint */
-#define PERF_X86_EVENT_RDPMC_ALLOWED	0x0080 /* grant rdpmc permission */
+
 #define PERF_X86_EVENT_EXCL_ACCT	0x0100 /* accounted EXCL event */
 #define PERF_X86_EVENT_AUTO_RELOAD	0x0200 /* use PEBS auto-reload */
 #define PERF_X86_EVENT_LARGE_PEBS	0x0400 /* use large PEBS */
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fe156a8170aa..34ebcc9af608 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -128,6 +128,15 @@ struct hw_perf_event_extra {
 	int		idx;	/* index in shared_regs->regs[] */
 };
 
+/**
+ * hw_perf_event::flag values
+ *
+ * PERF_EVENT_FLAG_ARCH bits are reserved for architecture-specific
+ * usage.
+ */
+#define PERF_EVENT_FLAG_ARCH			0x0000ffff
+#define PERF_EVENT_FLAG_USER_READ_CNT		0x80000000
+
 /**
  * struct hw_perf_event - performance event hardware details:
  */
-- 
2.32.0

