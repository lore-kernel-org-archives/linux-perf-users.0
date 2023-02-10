Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7D0C64EC5
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Feb 2023 16:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbjBJQzZ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Feb 2023 11:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjBJQzW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Feb 2023 11:55:22 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83CB795FA
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Feb 2023 08:55:21 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-517f8be4b00so54547567b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Feb 2023 08:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kuqd8aKGFN2CV03gkQhrTrP9ypZWMzDmupE6s/vqEQU=;
        b=Mj4llc7r4TE1Psp1WbHhff1ITU7nmoXIKcouxYz7KlG52Lf1tuIE3fc0FfU6g8YGrN
         ee+LSpWn3bjvIRl6t1ubF/dWC/lZoffknGJJ2BFAdmvAWqTrb+5vEos3mLHEQeJmthS0
         JGw6S12VbHrvBdCqPfGM4D9m7OyO4J8g6cobPPN2wIKvFecqH8c7gZRZn9904qXHaGp9
         pldMHAqY6CYyWkemCPLBKV8Ysg9+Z9DeiRS3JFtW48PKlBQjuXd7bEhGsdmpBnbb+Y4+
         xdoUq0QsJTuSV4LhypLgv3gZUtYNy8mPPdV1N25gCTpRTVfClYNew7UUEj1CcWG+ZLNy
         p+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kuqd8aKGFN2CV03gkQhrTrP9ypZWMzDmupE6s/vqEQU=;
        b=RmaVW1plmA0jw4h/kc3sLOLoNXhNUOn0cc/qlfCnl2LSpmFo8bA+iP8GUWZF9ccgC5
         lTQhbUeW3XiPfAco7FyLn1xy5onmHPhFrZrbnFhPj1bIoaP3m0myjMZ+tARwTqH/0Bi+
         7tG/y7/hkEwVMs1o5Iv25Qk/+2Lpm7ejRp6WWr9HszamRdXIIqrDMTXHNG1XCr/dt200
         oilotvvv8Qy+o2g0k07vLHrTJyqsRKEtcgHSXjbHyMhPj2pvgERqp2LLsgJ2DJ7enToF
         rOefRvP1mF1XfJQU4yhMqNiJpfBI5ruEHTfjzINKt+mOt4I3heOZlo24Wc/F3mpaxjPq
         MPDg==
X-Gm-Message-State: AO0yUKVu0dPb5EAJEw0tbTyuxM6PfJwfqqVLb3oBWHvzkAI4WkAThr0I
        pCsWLxiF6clflia5287ygxujiTUDbc85A/o=
X-Google-Smtp-Source: AK7set95kgEkOn0GptcPe78CQldah+t6r+6yk+m9LDfKih/kuOv0lwByCZJ2taqHxVmwrrxZ8Wd+ivgkNRe5Wjs=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a0d:c343:0:b0:52b:fda2:14bd with SMTP id
 f64-20020a0dc343000000b0052bfda214bdmr1075054ywd.188.1676048120799; Fri, 10
 Feb 2023 08:55:20 -0800 (PST)
Date:   Fri, 10 Feb 2023 11:54:55 -0500
In-Reply-To: <20230210165500.2292608-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230210165500.2292608-1-zalbassam@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230210165500.2292608-4-zalbassam@google.com>
Subject: [PATCH v2 3/8] perf: pmuv3: Abstract PMU version checks
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

The current PMU version definitions are available for arm64 only,
As we want to add PMUv3 support to arm (32-bit), abstracts
these definitions by using arch-specific helpers.

Signed-off-by: Zaid Al-Bassam <zalbassam@google.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20230126204444.2204061-4-zalbassam@google.com
---
 arch/arm64/include/asm/arm_pmuv3.h | 16 ++++++++++++++++
 drivers/perf/arm_pmuv3.c           |  7 +++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index eb204adb8dee2..b13651a06adf9 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -146,4 +146,20 @@ static inline u32 read_pmceid1(void)
 	return read_sysreg(pmceid1_el0);
 }
 
+static inline bool pmuv3_implemented(int pmuver)
+{
+	return !(pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF ||
+		 pmuver == ID_AA64DFR0_EL1_PMUVer_NI);
+}
+
+static inline bool is_pmuv3p4(int pmuver)
+{
+	return pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P4;
+}
+
+static inline bool is_pmuv3p5(int pmuver)
+{
+	return pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P5;
+}
+
 #endif
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 94e4098b662d3..46e89e92f8236 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -392,7 +392,7 @@ static const struct attribute_group armv8_pmuv3_caps_attr_group = {
  */
 static bool armv8pmu_has_long_event(struct arm_pmu *cpu_pmu)
 {
-	return (cpu_pmu->pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P5);
+	return (is_pmuv3p5(cpu_pmu->pmuver));
 }
 
 static inline bool armv8pmu_event_has_user_read(struct perf_event *event)
@@ -1082,8 +1082,7 @@ static void __armv8pmu_probe_pmu(void *info)
 	int pmuver;
 
 	pmuver = read_pmuver();
-	if (pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF ||
-	    pmuver == ID_AA64DFR0_EL1_PMUVer_NI)
+	if (!pmuv3_implemented(pmuver))
 		return;
 
 	cpu_pmu->pmuver = pmuver;
@@ -1109,7 +1108,7 @@ static void __armv8pmu_probe_pmu(void *info)
 			     pmceid, ARMV8_PMUV3_MAX_COMMON_EVENTS);
 
 	/* store PMMIR register for sysfs */
-	if (pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P4 && (pmceid_raw[1] & BIT(31)))
+	if (is_pmuv3p4(pmuver) && (pmceid_raw[1] & BIT(31)))
 		cpu_pmu->reg_pmmir = read_pmmir();
 	else
 		cpu_pmu->reg_pmmir = 0;
-- 
2.39.1.581.gbfd45094c4-goog

