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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0CAC47082
	for <linux-perf-users@archiver.kernel.org>; Sat,  5 Jun 2021 15:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE2560720
	for <linux-perf-users@archiver.kernel.org>; Sat,  5 Jun 2021 15:57:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbhFEP7F (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 5 Jun 2021 11:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhFEP7F (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 5 Jun 2021 11:59:05 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9F8C061767;
        Sat,  5 Jun 2021 08:57:17 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id m3so15605250lji.12;
        Sat, 05 Jun 2021 08:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rGmMKwMLob/kIPEE18djDEF0ui32owc1tXczrBa6xgw=;
        b=RgRlql7lAcvLdeO3ITEDlkogtqxIXQKF6xFi/EXeJfrnmDnvE4YhtuCacbziaLRUao
         5jWu2LPSNlOZzAl2be6h0tUeu+8uiA6OptNvsaITMc/pK0BMq3WZTEzR5z6cO0mbT39x
         Iuccly+CsXP1RQzIw9Frady4CjRqxIHg2LcLsUak0nZVRzHa69lXn6FmOjakVBrg5bha
         UvYneHd302Yxdo/8nsXoV79mVvuAnrRvsEF7r1Ao7095Xd55LgJdRvmKWtrsy9ifZRkt
         mFuI/f45I1Zcpja8xIfbBcYBcB53ngk5uUnC7MvD14lDACGtN4eSJ4uxrxEJLjIVWgTn
         ZbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rGmMKwMLob/kIPEE18djDEF0ui32owc1tXczrBa6xgw=;
        b=JUPbO3CQMDoIc+KxeZ6rg4AVLplCyNS6A7S08Jo6fOct8UndfQ3ERgwJDZsOwhmG+8
         0XMElt1V15QyQMEZY85aK5l9EZ5mcDs8O+QnNVjZmkLqZq+d7gHqnzhaGw2Eh6zH9UCL
         AnaH/JBfIllkgZKfLAqw9mA0jzR1LV+Ua/PrHH25QtR34vfETehA13DYoIT+xBLuTpKk
         tCfnup1ekZBvnMpVg8TwNiCskhVhjhJUbQWdRtSqOD6VCUJWLGL2mwa70HMVYZ18nGqt
         uuYn3l4w/Y/2jfNSgt7WS1wOTAnIs1ZQMP0HoBtcYYdU7NyIdAGHwM7l7mg+RytWTIef
         DJ1g==
X-Gm-Message-State: AOAM531LQkZEuSdKWQtFJ1QSYqrYMK648Av04argMv+hORbFOoEdJxN6
        itvlgBgRpX1vyOxE9T1dJb0=
X-Google-Smtp-Source: ABdhPJy7kV8oOiISoqNrQQkHxUGjIP3F1T8PAuBCq0RHc7LM3iPvR/5Lx2gDFxGaCed7EMvMwFzdrg==
X-Received: by 2002:a05:651c:49d:: with SMTP id s29mr7999941ljc.279.1622908635430;
        Sat, 05 Jun 2021 08:57:15 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id w15sm146264lfq.94.2021.06.05.08.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 08:57:15 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 4/4] perf/x86/intel/uncore: Constify unmodified static extra_reg structs
Date:   Sat,  5 Jun 2021 17:56:53 +0200
Message-Id: <20210605155653.21850-5-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210605155653.21850-1-rikard.falkeborn@gmail.com>
References: <20210605155653.21850-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

These are never modified, so make them const to allow the compiler to
put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 arch/x86/events/intel/uncore_nhmex.c |  6 +++---
 arch/x86/events/intel/uncore_snbep.c | 20 ++++++++++----------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/uncore_nhmex.c b/arch/x86/events/intel/uncore_nhmex.c
index 5f7c27d7f428..b4567489580d 100644
--- a/arch/x86/events/intel/uncore_nhmex.c
+++ b/arch/x86/events/intel/uncore_nhmex.c
@@ -525,7 +525,7 @@ enum {
 	EXTRA_REG_NHMEX_M_ZDP_CTL_FVC,
 };
 
-static struct extra_reg nhmex_uncore_mbox_extra_regs[] = {
+static const struct extra_reg nhmex_uncore_mbox_extra_regs[] = {
 	MBOX_INC_SEL_EXTAR_REG(0x0, DSP),
 	MBOX_INC_SEL_EXTAR_REG(0x4, MSC_THR),
 	MBOX_INC_SEL_EXTAR_REG(0x5, MSC_THR),
@@ -755,7 +755,7 @@ static void nhmex_mbox_put_constraint(struct intel_uncore_box *box, struct perf_
 	}
 }
 
-static int nhmex_mbox_extra_reg_idx(struct extra_reg *er)
+static int nhmex_mbox_extra_reg_idx(const struct extra_reg *er)
 {
 	if (er->idx < EXTRA_REG_NHMEX_M_ZDP_CTL_FVC)
 		return er->idx;
@@ -767,7 +767,7 @@ static int nhmex_mbox_hw_config(struct intel_uncore_box *box, struct perf_event
 	struct intel_uncore_type *type = box->pmu->type;
 	struct hw_perf_event_extra *reg1 = &event->hw.extra_reg;
 	struct hw_perf_event_extra *reg2 = &event->hw.branch_reg;
-	struct extra_reg *er;
+	const struct extra_reg *er;
 	unsigned msr;
 	int reg_idx = 0;
 	/*
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 507bb83e1463..77b342637688 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -882,7 +882,7 @@ static struct intel_uncore_type snbep_uncore_ubox = {
 	.format_group	= &snbep_uncore_ubox_format_group,
 };
 
-static struct extra_reg snbep_uncore_cbox_extra_regs[] = {
+static const struct extra_reg snbep_uncore_cbox_extra_regs[] = {
 	SNBEP_CBO_EVENT_EXTRA_REG(SNBEP_CBO_PMON_CTL_TID_EN,
 				  SNBEP_CBO_PMON_CTL_TID_EN, 0x1),
 	SNBEP_CBO_EVENT_EXTRA_REG(0x0334, 0xffff, 0x4),
@@ -999,7 +999,7 @@ snbep_cbox_get_constraint(struct intel_uncore_box *box, struct perf_event *event
 static int snbep_cbox_hw_config(struct intel_uncore_box *box, struct perf_event *event)
 {
 	struct hw_perf_event_extra *reg1 = &event->hw.extra_reg;
-	struct extra_reg *er;
+	const struct extra_reg *er;
 	int idx = 0;
 
 	for (er = snbep_uncore_cbox_extra_regs; er->msr; er++) {
@@ -1653,7 +1653,7 @@ static struct intel_uncore_type ivbep_uncore_ubox = {
 	.format_group	= &ivbep_uncore_ubox_format_group,
 };
 
-static struct extra_reg ivbep_uncore_cbox_extra_regs[] = {
+static const struct extra_reg ivbep_uncore_cbox_extra_regs[] = {
 	SNBEP_CBO_EVENT_EXTRA_REG(SNBEP_CBO_PMON_CTL_TID_EN,
 				  SNBEP_CBO_PMON_CTL_TID_EN, 0x1),
 	SNBEP_CBO_EVENT_EXTRA_REG(0x1031, 0x10ff, 0x2),
@@ -1725,7 +1725,7 @@ ivbep_cbox_get_constraint(struct intel_uncore_box *box, struct perf_event *event
 static int ivbep_cbox_hw_config(struct intel_uncore_box *box, struct perf_event *event)
 {
 	struct hw_perf_event_extra *reg1 = &event->hw.extra_reg;
-	struct extra_reg *er;
+	const struct extra_reg *er;
 	int idx = 0;
 
 	for (er = ivbep_uncore_cbox_extra_regs; er->msr; er++) {
@@ -2121,7 +2121,7 @@ static struct event_constraint knl_uncore_cha_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
-static struct extra_reg knl_uncore_cha_extra_regs[] = {
+static const struct extra_reg knl_uncore_cha_extra_regs[] = {
 	SNBEP_CBO_EVENT_EXTRA_REG(SNBEP_CBO_PMON_CTL_TID_EN,
 				  SNBEP_CBO_PMON_CTL_TID_EN, 0x1),
 	SNBEP_CBO_EVENT_EXTRA_REG(0x3d, 0xff, 0x2),
@@ -2153,7 +2153,7 @@ static int knl_cha_hw_config(struct intel_uncore_box *box,
 			     struct perf_event *event)
 {
 	struct hw_perf_event_extra *reg1 = &event->hw.extra_reg;
-	struct extra_reg *er;
+	const struct extra_reg *er;
 	int idx = 0;
 
 	for (er = knl_uncore_cha_extra_regs; er->msr; er++) {
@@ -2637,7 +2637,7 @@ static struct event_constraint hswep_uncore_cbox_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
-static struct extra_reg hswep_uncore_cbox_extra_regs[] = {
+static const struct extra_reg hswep_uncore_cbox_extra_regs[] = {
 	SNBEP_CBO_EVENT_EXTRA_REG(SNBEP_CBO_PMON_CTL_TID_EN,
 				  SNBEP_CBO_PMON_CTL_TID_EN, 0x1),
 	SNBEP_CBO_EVENT_EXTRA_REG(0x0334, 0xffff, 0x4),
@@ -2708,7 +2708,7 @@ hswep_cbox_get_constraint(struct intel_uncore_box *box, struct perf_event *event
 static int hswep_cbox_hw_config(struct intel_uncore_box *box, struct perf_event *event)
 {
 	struct hw_perf_event_extra *reg1 = &event->hw.extra_reg;
-	struct extra_reg *er;
+	const struct extra_reg *er;
 	int idx = 0;
 
 	for (er = hswep_uncore_cbox_extra_regs; er->msr; er++) {
@@ -3547,7 +3547,7 @@ static struct event_constraint skx_uncore_chabox_constraints[] = {
 	EVENT_CONSTRAINT_END
 };
 
-static struct extra_reg skx_uncore_cha_extra_regs[] = {
+static const struct extra_reg skx_uncore_cha_extra_regs[] = {
 	SNBEP_CBO_EVENT_EXTRA_REG(0x0334, 0xffff, 0x4),
 	SNBEP_CBO_EVENT_EXTRA_REG(0x0534, 0xffff, 0x4),
 	SNBEP_CBO_EVENT_EXTRA_REG(0x0934, 0xffff, 0x4),
@@ -3593,7 +3593,7 @@ skx_cha_get_constraint(struct intel_uncore_box *box, struct perf_event *event)
 static int skx_cha_hw_config(struct intel_uncore_box *box, struct perf_event *event)
 {
 	struct hw_perf_event_extra *reg1 = &event->hw.extra_reg;
-	struct extra_reg *er;
+	const struct extra_reg *er;
 	int idx = 0;
 
 	for (er = skx_uncore_cha_extra_regs; er->msr; er++) {
-- 
2.31.1

