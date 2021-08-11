Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FB9C4320A
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 03:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D6A60EC0
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 03:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbhHKD0x (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 23:26:53 -0400
Received: from foss.arm.com ([217.140.110.172]:41308 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232795AbhHKD0x (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 Aug 2021 23:26:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EB561063;
        Tue, 10 Aug 2021 20:26:30 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.67.241])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EE33E3F40C;
        Tue, 10 Aug 2021 20:26:27 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64/perf: Replace '0xf' instances with ID_AA64DFR0_PMUVER_IMP_DEF
Date:   Wed, 11 Aug 2021 08:57:07 +0530
Message-Id: <1628652427-24695-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1628652427-24695-1-git-send-email-anshuman.khandual@arm.com>
References: <1628652427-24695-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

ID_AA64DFR0_PMUVER_IMP_DEF which indicate implementation defined PMU, never
actually gets used although there are '0xf' instances scattered all around.
Just do the macro replacement to improve readability.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.14-rc5

Changes in V2:

- Split out the arm64 part

Changes in V1:

https://lore.kernel.org/linux-perf-users/1628571998-13634-1-git-send-email-anshuman.khandual@arm.com/

 arch/arm64/include/asm/cpufeature.h | 2 +-
 arch/arm64/kernel/perf_event.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 9bb9d11750d7..54474e76ad86 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -552,7 +552,7 @@ cpuid_feature_cap_perfmon_field(u64 features, int field, u64 cap)
 	u64 mask = GENMASK_ULL(field + 3, field);
 
 	/* Treat IMPLEMENTATION DEFINED functionality as unimplemented */
-	if (val == 0xf)
+	if (val == ID_AA64DFR0_PMUVER_IMP_DEF)
 		val = 0;
 
 	if (val > cap) {
diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index d07788dad388..b4044469527e 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -1055,7 +1055,7 @@ static void __armv8pmu_probe_pmu(void *info)
 	dfr0 = read_sysreg(id_aa64dfr0_el1);
 	pmuver = cpuid_feature_extract_unsigned_field(dfr0,
 			ID_AA64DFR0_PMUVER_SHIFT);
-	if (pmuver == 0xf || pmuver == 0)
+	if (pmuver == ID_AA64DFR0_PMUVER_IMP_DEF || pmuver == 0)
 		return;
 
 	cpu_pmu->pmuver = pmuver;
-- 
2.20.1

