Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF563BED79;
	Tue,  7 Apr 2026 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572216; cv=none; b=oVZHccz72ONcmQkWtLjoWO6ix1RCOTk+AsU2ApBFcrDQ+yCi7L+L15Q7dCTeQfXuFtQmwZ4GlXB7Ocmq7FNLNRqBNfVtbHRCHW/n2j7JChcPpC9ieMtUPaGJqtRf4GaY1FGxce8Q6jZ9D61TCP19UWFfZtRKS9kpPfzQ7KSalL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572216; c=relaxed/simple;
	bh=uUvq9MVXp8cNAvU8/2GcbzCtpuny4H9rPPxomu7v7sY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bXj9XSbSbbd8kIWZH7iNlgoEL1N4RAupmrG1PfRT36VZCIsd6qrEaKlHdggiWRd7iGV4av68TkQ3y8EKE3uFX1zI9r3m2HRbXTQwzyvKPhDqViWJeCjys9pXih9JCWM/XNhKAm8Y9XXZi4VBoU0A7S1VF27M37tZ+bT1SeYe0qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jy/SsEhE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jy/SsEhE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AE5C2BCB2;
	Tue,  7 Apr 2026 14:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775572215;
	bh=uUvq9MVXp8cNAvU8/2GcbzCtpuny4H9rPPxomu7v7sY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jy/SsEhEUWFlpfnTq1KI4r1d6pxJti65E4Z1yn9omGYV4MzOcFY8gZkxjuawQCxf1
	 CQYvaEMbRdpdqMQl9EZVxBq2fyZJ4AVEY+0rS3WmwSnNIV3E9WB5VJEFHCMDea2lvu
	 Z1nlthzoAQtoXaEB2jxZSQ51VxbZzwBA/34jzuXhinCjuUWz7SMwhqrfLTopdi9n6Z
	 TU/bL5LZShtuIzau4bkAoSoZlZmIozavChyCxCkEaIGUw8jTFpra6NbpLP603qlmCY
	 F7M6BC0qngv3ZR76nax53PV+PAkBdjj5ah/atADVYZVXHUC/JfKYjpokg4GwwbaikS
	 qJod4SznuhSZA==
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 07 Apr 2026 09:29:46 -0500
Subject: [PATCH v4 4/6] arm64/cpufeature: Add field details for
 ID_AA64DFR1_EL1 register
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-arm-debug-8-9-v4-4-a4864e69b0ea@kernel.org>
References: <20260407-arm-debug-8-9-v4-0-a4864e69b0ea@kernel.org>
In-Reply-To: <20260407-arm-debug-8-9-v4-0-a4864e69b0ea@kernel.org>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.15-dev

From: Anshuman Khandual <anshuman.khandual@arm.com>

This adds required field details for ID_AA64DFR1_EL1, and also drops dummy
ftr_raz[] array which is now redundant. These register fields will be used
to enable increased breakpoint and watchpoint registers via FEAT_Debugv8p9
later. The register fields have been marked as FTR_STRICT, unless there is
a known variation in practice.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/arm64/kernel/cpufeature.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index c31f8e17732a..24c8e9147e35 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -570,6 +570,21 @@ static const struct arm64_ftr_bits ftr_id_aa64dfr0[] = {
 	ARM64_FTR_END,
 };
 
+static const struct arm64_ftr_bits ftr_id_aa64dfr1[] = {
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_ABL_CMPs_SHIFT, 8, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_DPFZS_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_EBEP_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_ITE_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_ABLE_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_PMICNTR_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_SPMU_SHIFT, 4, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_CTX_CMPs_SHIFT, 8, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_WRPs_SHIFT, 8, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_BRPs_SHIFT, 8, 0),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64DFR1_EL1_SYSPMUID_SHIFT, 8, 0),
+	ARM64_FTR_END,
+};
+
 static const struct arm64_ftr_bits ftr_mvfr0[] = {
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_EL1_FPRound_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, MVFR0_EL1_FPShVec_SHIFT, 4, 0),
@@ -756,10 +771,6 @@ static const struct arm64_ftr_bits ftr_single32[] = {
 	ARM64_FTR_END,
 };
 
-static const struct arm64_ftr_bits ftr_raz[] = {
-	ARM64_FTR_END,
-};
-
 #define __ARM64_FTR_REG_OVERRIDE(id_str, id, table, ovr) {	\
 		.sys_id = id,					\
 		.reg = 	&(struct arm64_ftr_reg){		\
@@ -832,7 +843,7 @@ static const struct __ftr_reg_entry {
 
 	/* Op1 = 0, CRn = 0, CRm = 5 */
 	ARM64_FTR_REG(SYS_ID_AA64DFR0_EL1, ftr_id_aa64dfr0),
-	ARM64_FTR_REG(SYS_ID_AA64DFR1_EL1, ftr_raz),
+	ARM64_FTR_REG(SYS_ID_AA64DFR1_EL1, ftr_id_aa64dfr1),
 
 	/* Op1 = 0, CRn = 0, CRm = 6 */
 	ARM64_FTR_REG(SYS_ID_AA64ISAR0_EL1, ftr_id_aa64isar0),

-- 
2.53.0

