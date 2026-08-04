Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5D946C4C5;
	Tue,  4 Aug 2026 23:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887928; cv=none; b=lc2dh1rMqor3EVW6L8o0AHPuGdanBZiA92FdJzTDZKBm7eiOVFowmvVm/qwKKtxtExHXHen0leaIx6lVrvonkysSvRDZsrQoQ9O3u71LyGamaxZCGvUGrwOZORmpu64NhqfP0VPfOSSc/WAamrWO+w66RnpDLO/qXzA7dN2RwVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887928; c=relaxed/simple;
	bh=XXi6jIjCTmRH1LpOLQjaawpsH5HLOLho6P862ym8RvI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dCxHi380AeKavgd59MscacIW3tiJZ7lQxaU2fZnXcZIcgRNA5g95NceZPcm/atv8GEuWBNCAyMgb0dtjgAzu3EK8VdycOKvUpekHFiWcJg02vz0nhl6hG/zEyRCehUzqAWI9pJCfhBDb/MUGJOsbeAcBK5LeHAb6YG96QA+sWjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYTk4rkz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYTk4rkz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148E71F00A3D;
	Tue,  4 Aug 2026 23:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785887926;
	bh=SCVhMTFo9ZCIqfgdJ+B+IzrzbBtMPPk2WY1IBkcWtfU=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=YYTk4rkz3f7zh1LLjCQt/arT1XMQFHNw7GR48lndg5vQnIHUmlmY67d4Sb/sAS4/W
	 3p9tfajAwvLR0QA0eWoDDnrwf3ePfa7+L2BfxW7sTZkk+C24aOVlrK1Omj7mrmzJdR
	 FV/Zc0wELT/GHKmADlbsFMp2mJqVz8e9cvFznhVwBmAlY5Arg+k1IbvOiseciPyniw
	 hqAgkMaKkGOA57swioeIJn+Jw1Ry4jviHHhIYnXHSAFZoy4FP80l1qh7bu1AGIP6bz
	 yrCSOeOuA1kjpoEpN5gIOAKMZvmJRCl5Zyma67IsfXPYEvJFHYh4+mHISvWs0kYhW1
	 c3Iz2QL6JSM5g==
Date: Tue, 4 Aug 2026 17:58:34 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Atish Patra <atish.patra@linux.dev>
cc: Jiri Olsa <jolsa@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
    Anup Patel <anup@brainfault.org>, Namhyung Kim <namhyung@kernel.org>, 
    Arnaldo Carvalho de Melo <acme@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, Ian Rogers <irogers@google.com>, 
    Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
    linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
    linux-perf-users@vger.kernel.org, Conor Dooley <conor@kernel.org>
Subject: Re: [PATCH v8 03/22] RISC-V: Add Sxcsrind ISA extension definition
 and parsing
In-Reply-To: <20260701-counter_delegation-v8-3-7909f863a645@meta.com>
Message-ID: <f488451d-a8bf-f6d4-3f34-c820a0171019@kernel.org>
References: <20260701-counter_delegation-v8-0-7909f863a645@meta.com> <20260701-counter_delegation-v8-3-7909f863a645@meta.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 1 Jul 2026, Atish Patra wrote:

> From: Atish Patra <atishp@rivosinc.com>
> 
> The S[m|s]csrind extension extends the indirect CSR access mechanism
> defined in Smaia/Ssaia extensions.
> 
> This patch just enables the definition and parsing.
> 
> Signed-off-by: Atish Patra <atishp@rivosinc.com>

Thanks, Similarly to my comments on patch 2, the following is what's been 
queued for v7.3.


- Paul


From: Atish Patra <atishp@rivosinc.com>

RISC-V: Add Smcsrind and Sscsrind ISA extension definition and parsing

The S[m|s]csrind extensions extend the indirect CSR access mechanism
defined in Smaia/Ssaia extensions.

This patch just enables the definition and parsing.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Link: https://patch.msgid.link/20260701-counter_delegation-v8-3-7909f863a645@meta.com
[pjw@kernel.org: use official RISC-V extension names in the patch description]
Signed-off-by: Paul Walmsley <pjw@kernel.org>
---
 arch/riscv/include/asm/hwcap.h | 4 ++++
 arch/riscv/kernel/cpufeature.c | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 7ef8e5f55c8d..d4a7b90e2d78 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -112,6 +112,8 @@
 #define RISCV_ISA_EXT_ZCLSD		103
 #define RISCV_ISA_EXT_ZICFILP		104
 #define RISCV_ISA_EXT_ZICFISS		105
+#define RISCV_ISA_EXT_SSCSRIND		106
+#define RISCV_ISA_EXT_SMCSRIND		107
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
@@ -121,9 +123,11 @@
 #ifdef CONFIG_RISCV_M_MODE
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
 #define RISCV_ISA_EXT_SUPM		RISCV_ISA_EXT_SMNPM
+#define RISCV_ISA_EXT_SxCSRIND		RISCV_ISA_EXT_SMCSRIND
 #else
 #define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
 #define RISCV_ISA_EXT_SUPM		RISCV_ISA_EXT_SSNPM
+#define RISCV_ISA_EXT_SxCSRIND		RISCV_ISA_EXT_SSCSRIND
 #endif
 
 #endif /* _ASM_RISCV_HWCAP_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index f46aa5602d74..3fa0a563fb21 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -576,11 +576,13 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_BUNDLE_VALIDATE(zvksg, riscv_zvksg_bundled_exts, riscv_ext_vector_crypto_validate),
 	__RISCV_ISA_EXT_DATA_VALIDATE(zvkt, RISCV_ISA_EXT_ZVKT, riscv_ext_vector_crypto_validate),
 	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
+	__RISCV_ISA_EXT_DATA(smcsrind, RISCV_ISA_EXT_SMCSRIND),
 	__RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
 	__RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
+	__RISCV_ISA_EXT_DATA(sscsrind, RISCV_ISA_EXT_SSCSRIND),
 	__RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinuxenvcfg_exts),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svade, RISCV_ISA_EXT_SVADE),
-- 
2.53.0

