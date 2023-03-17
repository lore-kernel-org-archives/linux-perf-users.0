Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32370C74A5B
	for <linux-perf-users@archiver.kernel.org>; Fri, 17 Mar 2023 19:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbjCQTut (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 17 Mar 2023 15:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjCQTup (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 17 Mar 2023 15:50:45 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2553B647
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Mar 2023 12:50:40 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5411f21f849so56367757b3.16
        for <linux-perf-users@vger.kernel.org>; Fri, 17 Mar 2023 12:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679082640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OZanjZTFt34uWWoDx9vYeq6DUks9Yoj2omylf+sLhU4=;
        b=AMW9j8tEbrj6MYXjN/b9FSnbh3fXQMLX9tfkHPC9F7jJwZ01YPGtwz24YpzidXMxi8
         m23kArz9p6kSzERBd2BZZgJtAaqxUhE1fopBbA6P/8gifMnmxYA31QHRnU+Xuw9WvPia
         LnU1zmz2HjxpvvTRn9Dbd0mJq4we5lMcS9Imz9njG7aY8oq85MLILdgvs43ttQJksVdV
         aWOasMGp+Nq5xvEuKpvIhvXGETdp6T5Imq1vxkzauSSxEnASzPELMrpy6nTH4aZD4IXv
         2um0iht5fCU9hvi3UAu+2otk8U/0a0YV+It10xKBO9pQoNVoOYOvjbpO5ykdWfeTXWXT
         ARbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679082640;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZanjZTFt34uWWoDx9vYeq6DUks9Yoj2omylf+sLhU4=;
        b=xOKE77QpjR9WvmSrN+ZSYEJHh7zsvGWtPDDNhdyVYpNl5DvehEsRf/BXSidnmMouuq
         KI82iMgvvvtShhrr1dlcL13wJPZsqQEidqKJEzyZddwPbbylznheF3wy3XrFqsUqfCxH
         8eIJpIjTJ6SKEWgX6qrx/2G+S8u0GTZ+Jx7ZMoRxvsC1cLI6zYUkKz0M5LTWm9Q1AZmi
         5uubUU6ZjCgmCzOV8YDFRmmGbWjc9jcPLqB79dHp+SyYr+cKppt47Vum7OAHkESTVBqj
         3p2cI6gqaHU34qSu0Dnm4ZOsHfeXYF08CqwEbuM/mwJR//40a6PWVcOUjbly7Bg+2q+P
         3Pnw==
X-Gm-Message-State: AO0yUKVS6Os29bc+3mUT73BjDHdFrL5ci2F37+azAtJNz0ThZZraR30q
        S/DCTEGyP37PjrqDscmwIf3MFSECt1s0C5Q=
X-Google-Smtp-Source: AK7set/Hzrn9jsLu0odq0bRYnz52oqZFiiyGaEtR50yaGkrnqBm1Rhj7V03foPPkwfNFt5/UASXDJH3oMcMZMQU=
X-Received: from zaidcloud.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5325])
 (user=zalbassam job=sendgmr) by 2002:a05:6902:1004:b0:b54:c2d4:71cf with SMTP
 id w4-20020a056902100400b00b54c2d471cfmr549327ybt.3.1679082639729; Fri, 17
 Mar 2023 12:50:39 -0700 (PDT)
Date:   Fri, 17 Mar 2023 15:50:22 -0400
In-Reply-To: <20230317195027.3746949-1-zalbassam@google.com>
Mime-Version: 1.0
References: <20230317195027.3746949-1-zalbassam@google.com>
X-Mailer: git-send-email 2.40.0.rc2.332.ga46443480c-goog
Message-ID: <20230317195027.3746949-4-zalbassam@google.com>
Subject: [PATCH v4 3/8] perf: pmuv3: Abstract PMU version checks
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
        kvmarm@lists.cs.columbia.edu, f.fainelli@gmail.com
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
---
 arch/arm64/include/asm/arm_pmuv3.h | 16 ++++++++++++++++
 drivers/perf/arm_pmuv3.c           |  7 +++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index c444cbfb3acd..80cdfa4c3e88 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -134,4 +134,20 @@ static inline u32 read_pmceid1(void)
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
index f783f068d612..f7d890af8cc1 100644
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
@@ -1084,8 +1084,7 @@ static void __armv8pmu_probe_pmu(void *info)
 	int pmuver;
 
 	pmuver = read_pmuver();
-	if (pmuver == ID_AA64DFR0_EL1_PMUVer_IMP_DEF ||
-	    pmuver == ID_AA64DFR0_EL1_PMUVer_NI)
+	if (!pmuv3_implemented(pmuver))
 		return;
 
 	cpu_pmu->pmuver = pmuver;
@@ -1111,7 +1110,7 @@ static void __armv8pmu_probe_pmu(void *info)
 			     pmceid, ARMV8_PMUV3_MAX_COMMON_EVENTS);
 
 	/* store PMMIR register for sysfs */
-	if (pmuver >= ID_AA64DFR0_EL1_PMUVer_V3P4 && (pmceid_raw[1] & BIT(31)))
+	if (is_pmuv3p4(pmuver) && (pmceid_raw[1] & BIT(31)))
 		cpu_pmu->reg_pmmir = read_pmmir();
 	else
 		cpu_pmu->reg_pmmir = 0;
-- 
2.40.0.rc2.332.ga46443480c-goog

