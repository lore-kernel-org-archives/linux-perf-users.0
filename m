Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795114339;
	b=LV0a3o5iDNKIpUvZEdvDMbxjUlcbwQZh2xiopMTl3+TnewbfdMB5FPZZFUAfRFVTx404
	 qJBIYPgjzm8cl6Zk2bHhK/zcmv7kjHJ8ILM4bp3ELRRSXzLVF5kX5XpcjNIMZ1JGBE1Uc
	 Kje55gzbn+hgtoHIJAvy4Q72/l/J4BldQWumnQKsIdNKj9Plj9UpUblZvxA8tgSiZS3MG
	 IotiIqEqg7sBq3R2boOM/PXzYmFAjf7nZuXubcZkVOLAHA/ytb3OMeSXWwcOP788EqvgX
	 eKEKBqgUs+8ezFKSeC3pG6ovKzadWQ4KvPkIPGcxksBpa3eRoDVPcc4qL50ow2uq7AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795114339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=JnPyo9Uuk9yDsv0rmtMWzSN2FAMU1ZcFas4I3l5JKQU=;
	b=H7bls58Dgqeoj3mK/QT58ZpsQNBb5DASpG2YLTTeTES/AlYE733+lz9lz3IW0di4DiVL
	 NVgPtoNB205pLWYxyeDrdpeOJqj0h6p3m30fSDE+UYVSx/iMgMAFRzqsn7P5vfOPdkQKK
	 7lzNjYp3tjwtP5xUF3X6lSOVM3yNjPt9zpPCBVKulVBN8SUDQUSDNYU1GKgIcOmLn8NCt
	 k8ZW9YiEVoTCb057o6oWYY4MeaIqCaiFqqK/jocN1AnFiyuRf/H4tH+xi4Rx88Hc/gW30
	 jr7LaSJ3rHTVy3Odo5DsG+O0qxzpP+95Ay6fBuI2Q1jXjb8hiMsqVTo88Wi1Fa49waA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NDuUiAWT;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A26F606A33A
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 18:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A26F606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NDuUiAWT
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-547ae874949so209451b6e.2
        for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 10:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795114337; x=1795719137; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JnPyo9Uuk9yDsv0rmtMWzSN2FAMU1ZcFas4I3l5JKQU=;
        b=NDuUiAWT9m/Y4X19rNLr0nz/0UpRH7ZGRaLVNJYZAvxS+/6c5AJvHdtvnFsR5FI8jz
         BStrIGf7dy3qQxCg10sphhy3FCEOVhsAdzskadPNBG+kHR9UwXt2jyJy50nzD9vKz6Uc
         VrUe1FpLxxfyw9bymPVlBZ5S45flUex1i/S3l9hISl7IasJDuavS39eiWJuDAYC5ZV1d
         53PcsHNSukSfdQwWFRHTo4OK9yM+UIW4a+O2XA9mJJ9Ht9j3lnXRftP5yTJfdciAoBhr
         JcH0bumPuXEkEkASId4VOMlQgzABKJgJZOTDXhy0jSLDYu0HPiDng/GKp1y/iYPuD3oW
         p8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795114337; x=1795719137;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JnPyo9Uuk9yDsv0rmtMWzSN2FAMU1ZcFas4I3l5JKQU=;
        b=bjBAGx75O7T9Iqd4mOWcsftn4vM5xCnurKVFiJ/O/tgq12334EkVvkTQvCLJJhDT32
         UvUXQ7Mf4PL0jJ0hTQyjEO1Ce+yDYDADZckU2MiMZTSmUMuubb0F8JET7aeCQoCFJKRe
         N2/W9YoNXsqBvad4dobDmPSGX2LaTWpI004qRYrLyAXqtnI8fvyN1kffAOk9GpivJnQU
         OAxYbZMdBMylR8JtfUi3wCOG5M7r1Bggstc7WLEXKJMJocT+MOa/PPdO8R0b7KFoV8F/
         YYwLWjVkGh2bjnmHfHFV49TsfBfFLPBfWvSnVxlFWmz0Zb+bNSAApCmCnLcLTjWkHV9w
         OQCQ==
X-Forwarded-Encrypted: i=1; AL+hErENBJK5YkPQx15p6QBs76/8Slzxx3E1k+ortbOmJFtb0oc9m7PV7WuRyS9PYFBKPQ/p7jvfdXMfcyqzFholZFs3@vger.kernel.org
X-Gm-Message-State: APuU4Z8ED0iznKeqeUS8XIBizch3MgMRa0UpoV5mimJE9sSQK2vMHiXl
	CU/FTgYsl0s3fN8Zaa9WdIGW1PSEYLk657TTj10cyAy9IsHrADzRCHLPAxAQvz2ubpNGH2o1jl9
	sUID+0hzKANhhaz95B7FDRcJH0g==
X-Received: from iok14-n2.prod.google.com ([2002:a05:6602:c60e:20b0:9b4:c92a:b174])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:308b:b0:4f1:6c9c:78d3 with SMTP id 5614622812f47-57a0a92272dmr980283b6e.26.1795114337076;
 Thu, 19 Nov 2026 10:52:17 -0800 (PST)
Date: Thu, 19 Nov 2026 18:51:43 +0000
In-Reply-To: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261119185215.632334-1-coltonlewis@google.com>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
Message-ID: <20261119185215.632334-2-coltonlewis@google.com>
Subject: [PATCH v10 01/33] arm64: cpufeature: Add cpucap for HPMN0
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, James Clark <james.clark@linaro.org>, 
	Alexandru Elisei <alexandru.elisei@arm.com>, Mingwei Zhang <mizhang@google.com>, 
	Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a capability for FEAT_HPMN0, whether MDCR_EL2.HPMN can specify 0
counters reserved for the guest.

This required changing HPMN0 to an UnsignedEnum in tools/sysreg
because otherwise not all the appropriate macros are generated to add
it to arm64_cpu_capabilities_arm64_features.

Acked-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Colton Lewis <coltonlewis@google.com>
---
 arch/arm64/kernel/cpufeature.c | 11 ++++++++++-
 arch/arm64/kvm/sys_regs.c      |  5 ++++-
 arch/arm64/tools/cpucaps       |  1 +
 arch/arm64/tools/sysreg        |  6 +++---
 4 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index c9c9a6889455c..023b98e6be2d1 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -77,7 +77,7 @@
 #include <linux/percpu.h>
 #include <linux/sched/isolation.h>
 
-#include <asm/arm_pmuv3.h>
+#include <linux/perf/arm_pmuv3.h>
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_ops.h>
@@ -566,6 +566,7 @@ static const struct arm64_ftr_bits ftr_id_mmfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_HPMN0_SHIFT, 4, 0),
 	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_DoubleLock_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_PMSVer_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR0_EL1_CTX_CMPs_SHIFT, 4, 0),
@@ -730,6 +731,7 @@ static const struct arm64_ftr_bits ftr_id_dfr0[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_dfr1[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_DFR1_EL1_HPMN0_SHIFT, 4, 0),
 	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_DFR1_EL1_MTPMU_SHIFT, 4, 0),
 	ARM64_FTR_END,
 };
@@ -2863,6 +2865,13 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = has_cpuid_feature,
 		ARM64_CPUID_FIELDS(ID_AA64MMFR0_EL1, FGT, FGT2)
 	},
+	{
+		.desc = "HPMN0",
+		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
+		.capability = ARM64_HAS_HPMN0,
+		.matches = has_cpuid_feature,
+		ARM64_CPUID_FIELDS(ID_AA64DFR0_EL1, HPMN0, IMP)
+	},
 #ifdef CONFIG_ARM64_SME
 	{
 		.desc = "Scalable Matrix Extension",
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c7d91138a6d49..04947bfbd0ee5 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2218,6 +2218,8 @@ static u64 sanitise_id_aa64dfr0_el1(const struct kvm_vcpu *vcpu, u64 val)
 	if (kvm_vcpu_has_pmu(vcpu))
 		val |= SYS_FIELD_PREP(ID_AA64DFR0_EL1, PMUVer,
 				      kvm_arm_pmu_get_pmuver_limit());
+	else
+		val &= ~ID_AA64DFR0_EL1_HPMN0_MASK;
 
 	/* Hide SPE from guests */
 	val &= ~ID_AA64DFR0_EL1_PMSVer_MASK;
@@ -3417,7 +3419,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 		    ID_AA64DFR0_EL1_DoubleLock_MASK |
 		    ID_AA64DFR0_EL1_WRPs_MASK |
 		    ID_AA64DFR0_EL1_PMUVer_MASK |
-		    ID_AA64DFR0_EL1_DebugVer_MASK),
+		    ID_AA64DFR0_EL1_DebugVer_MASK |
+		    ID_AA64DFR0_EL1_HPMN0_MASK),
 	ID_SANITISED(ID_AA64DFR1_EL1),
 	ID_UNALLOCATED(5,2),
 	ID_UNALLOCATED(5,3),
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 3125695122a0a..1603a0dd19764 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -43,6 +43,7 @@ HAS_GIC_PRIO_MASKING
 HAS_GIC_PRIO_RELAXED_SYNC
 HAS_ICH_HCR_EL2_TDIR
 HAS_HCR_NV1
+HAS_HPMN0
 HAS_HCX
 HAS_LDAPR
 HAS_LPA2
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 997c62ab72e68..7230a9cd46e53 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1726,9 +1726,9 @@ EndEnum
 EndSysreg
 
 Sysreg	ID_AA64DFR0_EL1	3	0	0	5	0
-Enum	63:60	HPMN0
-	0b0000	UNPREDICTABLE
-	0b0001	DEF
+UnsignedEnum	63:60	HPMN0
+	0b0000	NI
+	0b0001	IMP
 EndEnum
 UnsignedEnum	59:56	ExtTrcBuff
 	0b0000	NI
-- 
2.56.1.708.g77570a6a1d-goog

