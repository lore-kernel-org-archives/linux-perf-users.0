Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89924C433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 20:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64C3061166
	for <linux-perf-users@archiver.kernel.org>; Tue, 14 Sep 2021 20:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbhINUtV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 14 Sep 2021 16:49:21 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:38824 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbhINUtU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 14 Sep 2021 16:49:20 -0400
Received: by mail-ot1-f49.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso415128ots.5;
        Tue, 14 Sep 2021 13:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uDRIOAbaco8+BSUgKBvehxogpXwXvKtkYheC/i9Zz6o=;
        b=nj0bIZwf5a1xZwbdXsy7bwC1d2N4PClF1K8a+jsA8XWPhjp/D464ysYBSugOt0nXwD
         Tanb5sp+CjozGbtdxDMnhl/Fu+WsL/nX9prDHRgNg0H4VJIjmeKyoyCGQFAqzr48qm4/
         YKrpTHqc+Kp1IBbtsyOcMXsf6FPxIAIG3M6+7wYLDDycR2lM4a5iXH+xP8lljs37ZKZH
         UkIcABvg53uFeKB4xOslksAyv1blAuXO9xS0eWOjj8Vb13O6gVQU0eVyQj0hZC+SADcH
         bIs9BlHy78h+LcwyNkrviKJ9oOF6+HdxrwLI2YzBbGycMNAG8MO28yy6oFa9d93pPKZx
         3f3w==
X-Gm-Message-State: AOAM533d/OOg2iWFfQjH6j/j1/ynYasmapykrW9XWtiUEKnnExLUOGS8
        3p/323LEfe8BgR0VeedRMg==
X-Google-Smtp-Source: ABdhPJxDg0ZgOkAhOmf9hw7oTaPl+RpE5u2yx9glWvv4gFjePmF3bu1T2firC/i95H0r26La87qCMQ==
X-Received: by 2002:a9d:7294:: with SMTP id t20mr16515006otj.275.1631652482637;
        Tue, 14 Sep 2021 13:48:02 -0700 (PDT)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id y14sm2883236oti.69.2021.09.14.13.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 13:48:02 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        Vince Weaver <vincent.weaver@maine.edu>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org
Subject: [PATCH v10 1/5] x86: perf: Move RDPMC event flag to a common definition
Date:   Tue, 14 Sep 2021 15:47:56 -0500
Message-Id: <20210914204800.3945732-2-robh@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210914204800.3945732-1-robh@kernel.org>
References: <20210914204800.3945732-1-robh@kernel.org>
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
index fe156a8170aa..12debf008d39 100644
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
2.30.2

