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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AFEC48BD1
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 20:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304FD611B0
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Jun 2021 20:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhFKUyq (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Jun 2021 16:54:46 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:45721 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbhFKUyq (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Jun 2021 16:54:46 -0400
Received: by mail-lf1-f47.google.com with SMTP id a1so10370792lfr.12;
        Fri, 11 Jun 2021 13:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FJMRTqSs/Kom7t2BcrRbR29IGY5GYuNHPeYqcdCiO/o=;
        b=L2aywsZ0O2WLQ5CHKfBkqvxwx2weLRbArBkc4yCz+XJQhLNMPj27K3KnDEua3+DxTS
         N50CwMcDi/AsWeEThjvMdvjIJP3IZ7ynmD3zs7rs8+l1Cbra/Qat7t6s5+n27GCDhsVN
         3S1lwQovVjQxJP5oqrFxCZ09AD+yAhuNSTnWSX6/WB2dhmBW1QBDuKdWonVDvaVLSj3W
         3CcXu40RuYLes5gdSrPTe82D2yRGvyKLgzePy0qcQzQZve/u1G5knnQpwsGVyTkuwnL6
         nk3kFMXSef6jeSGb20miOOZjnklzShGgUn8tn1z3iwV72LBNMtbyNQ6EJdK/5fPSXB+2
         DYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FJMRTqSs/Kom7t2BcrRbR29IGY5GYuNHPeYqcdCiO/o=;
        b=FSN59VcnUKDl9MwNMAZJLmYTzB0NPNCJs7oGHGg+iyCUv9BX8zbVCqIUUdZ8TOlaEk
         QtK497+2yuGdtUHpUZtBMxvu6IQW/H3TgFeH5P7XRUFB0YeIF9WGxrCn3NDm1nTJj4Yq
         LBJI/+eOiX6XyXvgkY+EthtSoVWh9RMCHK/MC6W0vFCwKAZYU4hzRjSyu7XI6QHpEYl3
         qji2xip6w5ryuD6WQvy140snokrBAHE7UlzFlqi6RAxiUD3YQ7Dq3VEvItH03jyiy5he
         Q+8+7VDQx3U5yz8oWaKAGmJAZR6lfwoGTUBnZcBwBS9a7hdyGMA40FGYKCxhPU6FmEom
         J8VA==
X-Gm-Message-State: AOAM531z/SGivnDS+tLD8TED0FpazVG1jnGgdTW+bXJGxh5aNNJIl9ZF
        wDAWD14rfhQIHjzP3kPBhEw=
X-Google-Smtp-Source: ABdhPJyB1/0irCI1T0Hrvja4Za5wi91MbIFasLoDCP0rZKkjVPgITsMPFuKDKV0VckcQatveeGxCbg==
X-Received: by 2002:ac2:548e:: with SMTP id t14mr3675650lfk.141.1623444690707;
        Fri, 11 Jun 2021 13:51:30 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id r7sm687118lfr.242.2021.06.11.13.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 13:51:30 -0700 (PDT)
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
Subject: [PATCH V2 2/4] perf/x86/intel: Constify static attribute_group structs
Date:   Fri, 11 Jun 2021 22:51:10 +0200
Message-Id: <20210611205112.27225-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210611205112.27225-1-rikard.falkeborn@gmail.com>
References: <20210611205112.27225-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

These either have their address put in an array of pointers to const
attribute structs, or (in uncore_snb.c and uncore_snbep.c) have their
address assigned to at pointer to const field in the intel_uncore_type
struct.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
Changes since v1:
- None

 arch/x86/events/intel/core.c         |  8 ++++----
 arch/x86/events/intel/cstate.c       | 10 +++++-----
 arch/x86/events/intel/pt.c           |  4 ++--
 arch/x86/events/intel/uncore_snb.c   |  2 +-
 arch/x86/events/intel/uncore_snbep.c |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index e28892270c58..b07d832f304e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5164,12 +5164,12 @@ static struct attribute_group group_events_tsx = {
 	.is_visible = tsx_is_visible,
 };
 
-static struct attribute_group group_caps_gen = {
+static const struct attribute_group group_caps_gen = {
 	.name  = "caps",
 	.attrs = intel_pmu_caps_attrs,
 };
 
-static struct attribute_group group_caps_lbr = {
+static const struct attribute_group group_caps_lbr = {
 	.name       = "caps",
 	.attrs	    = lbr_attrs,
 	.is_visible = lbr_is_visible,
@@ -5185,7 +5185,7 @@ static struct attribute_group group_format_extra_skl = {
 	.is_visible = exra_is_visible,
 };
 
-static struct attribute_group group_default = {
+static const struct attribute_group group_default = {
 	.attrs      = intel_pmu_attrs,
 	.is_visible = default_is_visible,
 };
@@ -5364,7 +5364,7 @@ static struct attribute *intel_hybrid_cpus_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group hybrid_group_cpus = {
+static const struct attribute_group hybrid_group_cpus = {
 	.attrs		= intel_hybrid_cpus_attrs,
 };
 
diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 433399069e27..089f71ac83f5 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -187,7 +187,7 @@ static struct attribute *attrs_empty[] = {
  * "events" group (with empty attrs) before updating
  * it with detected events.
  */
-static struct attribute_group core_events_attr_group = {
+static const struct attribute_group core_events_attr_group = {
 	.name = "events",
 	.attrs = attrs_empty,
 };
@@ -198,7 +198,7 @@ static struct attribute *core_format_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group core_format_attr_group = {
+static const struct attribute_group core_format_attr_group = {
 	.name = "format",
 	.attrs = core_format_attrs,
 };
@@ -211,7 +211,7 @@ static struct attribute *cstate_cpumask_attrs[] = {
 	NULL,
 };
 
-static struct attribute_group cpumask_attr_group = {
+static const struct attribute_group cpumask_attr_group = {
 	.attrs = cstate_cpumask_attrs,
 };
 
@@ -266,7 +266,7 @@ static struct perf_msr pkg_msr[] = {
 	[PERF_CSTATE_PKG_C10_RES] = { MSR_PKG_C10_RESIDENCY,	&group_cstate_pkg_c10,	test_msr },
 };
 
-static struct attribute_group pkg_events_attr_group = {
+static const struct attribute_group pkg_events_attr_group = {
 	.name = "events",
 	.attrs = attrs_empty,
 };
@@ -276,7 +276,7 @@ static struct attribute *pkg_format_attrs[] = {
 	&format_attr_pkg_event.attr,
 	NULL,
 };
-static struct attribute_group pkg_format_attr_group = {
+static const struct attribute_group pkg_format_attr_group = {
 	.name = "format",
 	.attrs = pkg_format_attrs,
 };
diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 915847655c06..83ccf106ed13 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -128,7 +128,7 @@ static struct attribute *pt_formats_attr[] = {
 	NULL,
 };
 
-static struct attribute_group pt_format_group = {
+static const struct attribute_group pt_format_group = {
 	.name	= "format",
 	.attrs	= pt_formats_attr,
 };
@@ -165,7 +165,7 @@ static struct attribute *pt_timing_attr[] = {
 	NULL,
 };
 
-static struct attribute_group pt_timing_group = {
+static const struct attribute_group pt_timing_group = {
 	.attrs	= pt_timing_attr,
 };
 
diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncore_snb.c
index 2938679f0002..e30b69fba939 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -369,7 +369,7 @@ static struct attribute *icl_uncore_clock_formats_attr[] = {
 	NULL,
 };
 
-static struct attribute_group icl_uncore_clock_format_group = {
+static const struct attribute_group icl_uncore_clock_format_group = {
 	.name = "format",
 	.attrs = icl_uncore_clock_formats_attr,
 };
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 43eabe8d37dc..b5b22fe473d8 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -4001,7 +4001,7 @@ static struct attribute *skx_uncore_pcu_formats_attr[] = {
 	NULL,
 };
 
-static struct attribute_group skx_uncore_pcu_format_group = {
+static const struct attribute_group skx_uncore_pcu_format_group = {
 	.name = "format",
 	.attrs = skx_uncore_pcu_formats_attr,
 };
-- 
2.32.0

