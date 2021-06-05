Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D33BC47082
	for <linux-perf-users@archiver.kernel.org>; Sat,  5 Jun 2021 15:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F15E2613F7
	for <linux-perf-users@archiver.kernel.org>; Sat,  5 Jun 2021 15:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhFEQAQ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 5 Jun 2021 12:00:16 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:42782 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbhFEQAQ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 5 Jun 2021 12:00:16 -0400
Received: by mail-lj1-f178.google.com with SMTP id a4so15628050ljq.9;
        Sat, 05 Jun 2021 08:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aRRCvMY37ES0ZS5+T7yZKmA/AIAiaewsTRWy+9hnPIA=;
        b=bmCtRJ861R8KCxFA94qIz0UgdrdlPs1dOk2+2E9nCgXgbQlX2HOKkwjgFmatww42Sq
         qaUR8NDm6z04w8kBHziH67Fk1lPrswB2F/5SV2yOWLQxL9tF4G4zNAmd/C2lIcayjfmX
         PUNR/N6nYII8C+tZwdGucPpQ+R1HOxRtRkxjXz93iG/t84k6JfemAgbNkZhwxfcaVW6b
         6MeBNDNaxexIMzobsq1uXBLrBrq4wZyGqt4+8BdbFo1fa9klypPWUvQMJNVq/Z800Um+
         +w38ppZVZbuLWefD5K10oEbQMkH9XLmSbEfHhMI280PaWy2Om4H4NaZ8LpIF8/NZ8/G0
         DiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aRRCvMY37ES0ZS5+T7yZKmA/AIAiaewsTRWy+9hnPIA=;
        b=e4AfcO8KIlg+eNOL2KTf6xD7MVkzss/BXB9mBQC3hf6pyrkHr6SqQt+IbXdch5xDxM
         BSPXBKac62sGULhsDNM8/iKFr+alh8BOSPhm+D+/QSguAwWIREWi5F7HCwIfBf5pgTRt
         juW5dbayrTU7rCiFJB4w7KAkRzMtHzG+Cnfg6g5JnH296mrxBOJ3NjjpqMYFHPc3sNW9
         /Sc92Hr9mR/wpXHd1LYb8nd0sCMuwbfH676dKhOae318xZdgPIsnRuA4sVx4ShfGyKUA
         mgxylSq5CnDByUqi0ZahYzuHuC86qA0k/qBI47QmIDQSyM3wLRGrBJ5OaxJM/mup6Iix
         VGdA==
X-Gm-Message-State: AOAM531/LnwE5/64WYEj7vb2PIHAcLT9JERnF4Mko+0ytXNKYYFvDtyh
        fhsbAOk+9+NgkpFY5lKbuO4=
X-Google-Smtp-Source: ABdhPJzYOackrK/4w+k6VCP2s0KmCSN4MKfGxARcjnx/et7lxxgodJCOzToURbPMwBT3vsb0EIbzmg==
X-Received: by 2002:a05:651c:1077:: with SMTP id y23mr7953831ljm.427.1622908631246;
        Sat, 05 Jun 2021 08:57:11 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id w15sm146264lfq.94.2021.06.05.08.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 08:57:10 -0700 (PDT)
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
Subject: [PATCH 2/4] perf/x86/intel: Constify static attribute_group structs
Date:   Sat,  5 Jun 2021 17:56:51 +0200
Message-Id: <20210605155653.21850-3-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210605155653.21850-1-rikard.falkeborn@gmail.com>
References: <20210605155653.21850-1-rikard.falkeborn@gmail.com>
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
index 5826cff568f4..3eff6f1a5b99 100644
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
2.31.1

