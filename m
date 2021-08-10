Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9879FC4338F
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 05:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71FF86056C
	for <linux-perf-users@archiver.kernel.org>; Tue, 10 Aug 2021 05:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbhHJFGY (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 01:06:24 -0400
Received: from foss.arm.com ([217.140.110.172]:47286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234999AbhHJFGX (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 10 Aug 2021 01:06:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 698FC6D;
        Mon,  9 Aug 2021 22:06:00 -0700 (PDT)
Received: from p8cg001049571a15.arm.com (unknown [10.163.67.89])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 06A653F40C;
        Mon,  9 Aug 2021 22:05:56 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        linux-perf-users@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/perf: Replace '0xf' instances with ID_AA64DFR0_PMUVER_IMP_DEF
Date:   Tue, 10 Aug 2021 10:36:38 +0530
Message-Id: <1628571998-13634-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
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
Cc: Marc Zyngier <maz@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.cs.columbia.edu
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v5.14-rc5

 arch/arm64/include/asm/cpufeature.h | 2 +-
 arch/arm64/kernel/perf_event.c      | 2 +-
 arch/arm64/kvm/perf.c               | 2 +-
 arch/arm64/kvm/pmu-emul.c           | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

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
diff --git a/arch/arm64/kvm/perf.c b/arch/arm64/kvm/perf.c
index 151c31fb9860..f9bb3b14130e 100644
--- a/arch/arm64/kvm/perf.c
+++ b/arch/arm64/kvm/perf.c
@@ -50,7 +50,7 @@ static struct perf_guest_info_callbacks kvm_guest_cbs = {
 
 int kvm_perf_init(void)
 {
-	if (kvm_pmu_probe_pmuver() != 0xf && !is_protected_kvm_enabled())
+	if (kvm_pmu_probe_pmuver() != ID_AA64DFR0_PMUVER_IMP_DEF && !is_protected_kvm_enabled())
 		static_branch_enable(&kvm_arm_pmu_available);
 
 	return perf_register_guest_info_callbacks(&kvm_guest_cbs);
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index f33825c995cb..60f89bdbeebb 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -745,7 +745,7 @@ int kvm_pmu_probe_pmuver(void)
 	struct perf_event_attr attr = { };
 	struct perf_event *event;
 	struct arm_pmu *pmu;
-	int pmuver = 0xf;
+	int pmuver = ID_AA64DFR0_PMUVER_IMP_DEF;
 
 	/*
 	 * Create a dummy event that only counts user cycles. As we'll never
@@ -770,7 +770,7 @@ int kvm_pmu_probe_pmuver(void)
 	if (IS_ERR(event)) {
 		pr_err_once("kvm: pmu event creation failed %ld\n",
 			    PTR_ERR(event));
-		return 0xf;
+		return ID_AA64DFR0_PMUVER_IMP_DEF;
 	}
 
 	if (event->pmu) {
@@ -923,7 +923,7 @@ int kvm_arm_pmu_v3_set_attr(struct kvm_vcpu *vcpu, struct kvm_device_attr *attr)
 	if (!vcpu->kvm->arch.pmuver)
 		vcpu->kvm->arch.pmuver = kvm_pmu_probe_pmuver();
 
-	if (vcpu->kvm->arch.pmuver == 0xf)
+	if (vcpu->kvm->arch.pmuver == ID_AA64DFR0_PMUVER_IMP_DEF)
 		return -ENODEV;
 
 	switch (attr->attr) {
-- 
2.20.1

