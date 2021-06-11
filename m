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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBD1C48BD1
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 20:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DFA061278
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 20:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhFKUxk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Jun 2021 16:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhFKUxk (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Jun 2021 16:53:40 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3497CC0613A2;
        Fri, 11 Jun 2021 13:51:34 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p17so10420908lfc.6;
        Fri, 11 Jun 2021 13:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qp6lxg9EERP3PQXD0xjPQqg+lbx3ZNQq2ocPFT5ueOw=;
        b=bsu3sCwjR29vmzo9EWlM6MYBXc21bVBae9hjP+Y25Yw45pNXNFfuOCzl7JI0zGTuuq
         VUnQ24kota3X7XXvP5/Rv6wxwAkhyD7+KuDkMOekQyf8IAG+rGbIrJcn0XnZIPjJ3PuI
         mth1V5LjiYRDsAKgbMOEO6yzoLG29edIxjQrDyLw0VWtkFDk2pQMmCcSxlLwh4kgW4nn
         W6o5WhePT9DliMjt6msEEcPRzbL8juUepTFFxxsemVdf2w5vOD2WqUmShL2aFtLxPMNx
         PFeHmN0T/jKNyjD5XVJ90iNM6RGql2lxTkR+Q5VyN/WGb/TxYvwsP9YuyOT+dO2+fNoR
         TenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qp6lxg9EERP3PQXD0xjPQqg+lbx3ZNQq2ocPFT5ueOw=;
        b=E8PjYKSTgf2soPN0NQO9eEogmUfPIfADgNZo03VrhWL07M0g3Fkg7/NBTiW7F+4IPn
         yt+elMbNL9haTwrmic+5PKGn64NPbLcCV9I+sWUmJDsdyT9nhrx0povb3RdYBLaLagrE
         6V6i3JA762z8yAmEkzQ1BWTpgucew3TRZ+tYtw1pN4aSrPvKHeYZXkkzoG7w+FFfnWHX
         yfTidvf5UP+3yJ7gFVnFfnjGqkqZjCb6I0URfV2Y5JjZM1aU07GGoOeidve+B+8AL5SA
         uK1c1LPk1tDL5KiNiz5/Exnn64DI88IXggJcDitCRSqp26wNsZ3S4GfnwNnf6opAyNUv
         iJpA==
X-Gm-Message-State: AOAM531y5hoRQ5u2ePvuuX5T+MMa7Hby3kYch6g8p9a5+YUGdgHpeJQd
        Hh35Nng06EgBABuWYOT9vM4=
X-Google-Smtp-Source: ABdhPJwjJI4EoOvDqnBWZHRAZv3TSYnJNRD2xYLOjT/VkER2BqdyzCztRN5PmdWU5Muanp2hJSssog==
X-Received: by 2002:ac2:5479:: with SMTP id e25mr3773385lfn.632.1623444692563;
        Fri, 11 Jun 2021 13:51:32 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id r7sm687118lfr.242.2021.06.11.13.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 13:51:32 -0700 (PDT)
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
Subject: [PATCH V2 4/4] perf/x86/intel/uncore: Constify unmodified static extra_reg structs
Date:   Fri, 11 Jun 2021 22:51:12 +0200
Message-Id: <20210611205112.27225-5-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210611205112.27225-1-rikard.falkeborn@gmail.com>
References: <20210611205112.27225-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

These are never modified, so make them const to allow the compiler to
put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
Changes since v1:
- None

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
2.32.0

