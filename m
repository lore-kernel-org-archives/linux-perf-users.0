Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3A6C4338F
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Jul 2021 23:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9628A6101B
	for <linux-perf-users@archiver.kernel.org>; Wed, 28 Jul 2021 23:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhG1XCo (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 28 Jul 2021 19:02:44 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:34708 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbhG1XCm (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 28 Jul 2021 19:02:42 -0400
Received: by mail-io1-f51.google.com with SMTP id y200so4675689iof.1;
        Wed, 28 Jul 2021 16:02:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EW1pTqw0YEcZ24+jdn1CJL3k17X+sqglrHQsZ+uJu9U=;
        b=FF+YUdmLsF56dXVUPvZNy/OgfpL4G95EDZ6VsxKJKwdosgCl3mVyeFjw5vWKDv6DhT
         UK2tgG646lruhT0yAAiBfSkRPnw0IZZHUUWHbdexmmW0oaCD1XE04NmPmZCg0GD2r8wl
         /ziQ2C2LYOvhL+yrIDqdNVgAceXBU8DOiLwPpZFAtHBB85kFoyzTkDyU8cxzr9dLq8Qu
         LAyj+X5fd3F4p2Dhh2aCXkIAXqMAM8xO7+cLG5b0t46ko+LvlYTEwOBstToDqo++GCV5
         GqIf3HzqXc5R7DdEXcuunr1nsxVLiyRtAA+dq5jduuKl4xV1wqXxTAzoOsWzeKudfmya
         yMlA==
X-Gm-Message-State: AOAM532otT9OgpO2pMAYeG7Qz6cIoAOBabNia99OzPWGvYifiGQ/+tNc
        dPcLXYzPpslmCUFLCIaC5g==
X-Google-Smtp-Source: ABdhPJydluymemd3WRftvzudMMUWpL6+30O+SLEfYvjHZSzrlxeqnl+wXsn9+qtizKG29cAZPHQBDw==
X-Received: by 2002:a5e:a818:: with SMTP id c24mr1450286ioa.180.1627513358799;
        Wed, 28 Jul 2021 16:02:38 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id j20sm974821ile.17.2021.07.28.16.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 16:02:37 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-perf-users@vger.kernel.org
Subject: [RFC 1/3] x86: perf: Move RDPMC event flag to a common definition
Date:   Wed, 28 Jul 2021 17:02:28 -0600
Message-Id: <20210728230230.1911468-2-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210728230230.1911468-1-robh@kernel.org>
References: <20210728230230.1911468-1-robh@kernel.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-perf-users@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/x86/events/core.c       | 10 +++++-----
 arch/x86/events/perf_event.h |  2 +-
 include/linux/perf_event.h   |  2 ++
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1eb45139fcc6..03f87fd4c017 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2471,7 +2471,7 @@ static int x86_pmu_event_init(struct perf_event *event)
 
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
index 2bf1c7ea2758..84d803c5cc87 100644
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
index 2d510ad750ed..f5815448ca9b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -142,6 +142,8 @@ struct hw_perf_event {
 			int		event_base_rdpmc;
 			int		idx;
 			int		last_cpu;
+
+#define PERF_EVENT_FLAG_USER_READ_CNT	0x80000000
 			int		flags;
 
 			struct hw_perf_event_extra extra_reg;
-- 
2.27.0

