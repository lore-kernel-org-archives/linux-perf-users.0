Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8A6C636BD
	for <linux-perf-users@archiver.kernel.org>; Thu, 26 Jan 2023 20:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjAZUpA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 26 Jan 2023 15:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjAZUo6 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 26 Jan 2023 15:44:58 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF6D5954E
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Jan 2023 12:44:57 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id s4-20020a056a00194400b0058d9b9fecb6so1422521pfk.1
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Jan 2023 12:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pc5TcYpRDFD/GaxSdX4EpKqW7yOnqCnFySLcXs5p0NE=;
        b=XG/5RPIOY2xbpHWiZxLnjhSxlO2Lo/RmpmNDlnnM9SEq8+RevL/W4QoiizuPnqWhfy
         zj3x8N3DHPDVKTm8sv0RNFXAYhexNhLAEJsooNK5dTdMKW+TDX6meEp79ls8tqv4VVpF
         uhN37iG6WgVhJYK9KJkmka9EKycN5ez8ZHpxgiWwMBEQOay66JmNaYFm5SG2ArlE2AuM
         FhDTr4dr5yEcNMV7Pomy1P9Y8/6IgSEr1qlrsKhqcRsxObWavTTLL7WxpSEq7FVMGuid
         bVz8p5nPA56iEgtJ8M5AQ46OwX2z9EOMCct6jR0hWAXrDHqjBeXh4UaCHD21gPMkh/0n
         HCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pc5TcYpRDFD/GaxSdX4EpKqW7yOnqCnFySLcXs5p0NE=;
        b=kXpQ2bb4sEfT1/66bJFxbTO9rXDjuFB+VV0xPG4Wi6Eke9FCRCJfHLBtWEiyBY65J+
         dw8FWZn1ocFwAVPlR8+O62fvSJ6k9OzmYoLIz3SpiW63TyW81a9WYl5Ft1NucEQddU6A
         mkusaax/GE3vOPoW48km54I6ob4x0cl4QJTlRGZPSjM+nrw9jIs56XwO9GRKrUMVLDpF
         cn85O4BzHgJ5goVGUScp+SKd33p0oM/YwErgdIHsRxzd3Y7hxuiYWYwYQ8x5vPmhPV5h
         CvmHAUeuMY+33SXKwE7t0Zl1vajh4xUvuYJbdf+JS6cJiu/0duDkLB5FpomWdvNOF1fn
         P5jw==
X-Gm-Message-State: AFqh2kqL2fm5doeTJX2QTTwVw/xHpvemAX8dhxOiBhFAGNqLePzY6Xxb
        kDZBIAtMb/FcwLHNtBt3AiQkKLh3GE0CqXg=
X-Google-Smtp-Source: AMrXdXtNVs+moL/C/rg64NpGxn6FuIRzJANIZDss/dvz6sXSl/S/nyoLU+SxIFVuRzEA+DcjK28wODOWXS1A/rk=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a17:902:b111:b0:189:a50d:2a23 with SMTP
 id q17-20020a170902b11100b00189a50d2a23mr4276826plr.32.1674765897138; Thu, 26
 Jan 2023 12:44:57 -0800 (PST)
Date:   Thu, 26 Jan 2023 15:44:39 -0500
In-Reply-To: <20230126204444.2204061-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230126204444.2204061-1-zalbassam@google.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230126204444.2204061-4-zalbassam@google.com>
Subject: [PATCH 3/8] perf: pmuv3: Add common defines for the PMU version
From:   Zaid Al-Bassam <zalbassam@google.com>
To:     Jesus Sanchez-Palencia <jesussanp@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu
Cc:     Zaid Al-Bassam <zalbassam@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

The current PMU version defines are available for arm64 only,
As we want to add PMUv3 support to arm (32-bit), this patch makes
these defines available for both arm/arm64 by defining them in
the common arm_pmuv3.h header.

Signed-off-by: Zaid Al-Bassam <zalbassam@google.com>
---
 drivers/perf/arm_pmuv3.c       | 8 ++++----
 include/linux/perf/arm_pmuv3.h | 6 ++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 94e4098b662d..505f0758260c 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -392,7 +392,7 @@ static const struct attribute_group armv8_pmuv3_caps_attr_group = {
  */
 static bool armv8pmu_has_long_event(struct arm_pmu *cpu_pmu)
 {
-	return (cpu_pmu->pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P5);
+	return (cpu_pmu->pmuver >= ARMV8_PMU_DFR_VER_V3P5);
 }
 
 static inline bool armv8pmu_event_has_user_read(struct perf_event *event)
@@ -1082,8 +1082,8 @@ static void __armv8pmu_probe_pmu(void *info)
 	int pmuver;
 
 	pmuver = read_pmuver();
-	if (pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF ||
-	    pmuver == ID_AA64DFR0_EL1_PMUVer_NI)
+	if (pmuver == ARMV8_PMU_DFR_VER_IMP_DEF ||
+	    pmuver == ARMV8_PMU_DFR_VER_NI)
 		return;
 
 	cpu_pmu->pmuver = pmuver;
@@ -1109,7 +1109,7 @@ static void __armv8pmu_probe_pmu(void *info)
 			     pmceid, ARMV8_PMUV3_MAX_COMMON_EVENTS);
 
 	/* store PMMIR register for sysfs */
-	if (pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P4 && (pmceid_raw[1] & BIT(31)))
+	if (pmuver >= ARMV8_PMU_DFR_VER_V3P4 && (pmceid_raw[1] & BIT(31)))
 		cpu_pmu->reg_pmmir = read_pmmir();
 	else
 		cpu_pmu->reg_pmmir = 0;
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index 5bc9cd6826ea..18b29fde27fa 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -267,4 +267,10 @@
 #define ARMV8_PMU_BUS_WIDTH_SHIFT 16
 #define ARMV8_PMU_BUS_WIDTH_MASK 0xf
 
+/* PMU Version in DFR Register */
+#define ARMV8_PMU_DFR_VER_NI        0
+#define ARMV8_PMU_DFR_VER_V3P4      0x5
+#define ARMV8_PMU_DFR_VER_V3P5      0x6
+#define ARMV8_PMU_DFR_VER_IMP_DEF   0xF
+
 #endif
-- 
2.39.0.246.g2a6d74b583-goog

