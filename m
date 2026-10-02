Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC2A47C10A;
	Fri,  2 Oct 2026 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936898; cv=none; b=ecBmGradAdMXGGFF977ddPVZdiG/W0nuzqq5dJe6Hs4xjUGCvDOPYlrVR/qGahHEqCu6uOhVPPLWwSOc0MwLTtcqCVI78SDZX/l3ywEMNWI6qHNmv2TSTxn2bGk09FqyQL4ZlcPhvWz6xwkQ9whpoGUlzGKK06muePwqiR+4Twc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936898; c=relaxed/simple;
	bh=Xqi6OaaaW1eG1O5rqaNPfGA7QBOWDo0BOw04yYs2hp0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kknfRrcXJu3tPnb4+hiBCPrnJ6evsGb7V8g5rNqYstDjPKA81usWftjbi2JIP9Y7atb2FqWFrX/pUus77W3rn+qwPQg3sBCpWQaZiggX669wjWAvqT8t6Qd/FnetEEoZNaBoEAl+YBkpxGfnn1eE6IP+LR3kbVN9JhqOIzFIZ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=H9coD+QA; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="H9coD+QA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1790936897; x=1822472897;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Xqi6OaaaW1eG1O5rqaNPfGA7QBOWDo0BOw04yYs2hp0=;
  b=H9coD+QA1D2ODtVBSKGhhRZ/7C2RYSXNRbA5oL5vFamObNrwbIEXdZyJ
   Flv28OHFPZqCxtn5QBbgXmonKqnqfUbPmJCw1I7hncqR+7/x9iL41XeHH
   JsC34F84Lq4R9lOSJL8cGZ7GI0X2m7Njgvdjz+uAZBRMZZ4ZJswkP2Muc
   yLt602GgaUajV4HRITlQjO7eyh2Dsd4M9mPWjbhqhblkZK/iR0HPTGMGC
   gXkRcCAwRwRPZ85eohA8N2d/JGC/mYwtwgl/C06sf7/4XxG/ZQ83Azywc
   2f9cY/XfwZcQ+h1qOXd+lCulSOCBSvLZjEwwWuVNDsHP7iRXonvIwPRlK
   Q==;
X-CSE-ConnectionGUID: MSfa78nfRQ+z7xoQcQ6b5w==
X-CSE-MsgGUID: t/Y/DX73SN+lcKeYmqREnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="234702585"
X-IronPort-AV: E=Sophos;i="6.27,136,1786978800"; 
   d="scan'208";a="234702585"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 19:28:08 +0900
Received: from az2uksmgm4.o.css.fujitsu.com (unknown [10.151.22.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 930B4821127;
	Fri,  2 Oct 2026 10:28:08 +0000 (UTC)
Received: from az2nlsmom4.fujitsu.com (unknown [10.150.26.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm4.o.css.fujitsu.com (Postfix) with ESMTPS id 4522A1401228;
	Fri,  2 Oct 2026 10:28:08 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.124.178.20])
	by az2nlsmom4.fujitsu.com (Postfix) with ESMTP id 16C25201F385;
	Fri,  2 Oct 2026 10:28:02 +0000 (UTC)
From: Tomohiro Misono <misono.tomohiro@fujitsu.com>
Date: Fri, 02 Oct 2026 19:26:50 +0900
Subject: [PATCH 2/4] arm64: tlb: Add tlbi workaround for FUJITSU-MONAKA
 Erratum E#030001
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-monaka-fix-for-upstream-v1-2-4aec0b0cbe34@fujitsu.com>
References: <20261002-monaka-fix-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com>
In-Reply-To: <20261002-monaka-fix-for-upstream-v1-0-4aec0b0cbe34@fujitsu.com>
To: Tomohiro Misono <misono.tomohiro@fujitsu.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Marc Zyngier <maz@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>
Cc: Kohei Enju <enju.kohei@fujitsu.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790936872; l=6562;
 i=misono.tomohiro@fujitsu.com; s=20261002; h=from:subject:message-id;
 bh=Xqi6OaaaW1eG1O5rqaNPfGA7QBOWDo0BOw04yYs2hp0=;
 b=haTsLoxBcGblWtg/2NIVSnt/+5mB7vT+Ssk2vlskNZ7bsTiu3hAWyWBIlsrx/4cKGu8BBfNwr
 0MknhFLBo4fDAYXmtA2lgqaPVv0XA/0yEyDRbaEZ8dhYRCrjkUOw8Ku
X-Developer-Key: i=misono.tomohiro@fujitsu.com; a=ed25519;
 pk=VLRxj5y4GJrHLmj3e2NBg30fX2U//ydi7c2G2qiNo10=

FUJITSU-MONAKA Erratum E#030001 affects FUJITSU-MONAKA CPU
when using 64k page size.

On affected FUJITSU-MONAKA CPUs, range-based TLBI operations
targeting a VA or IPA may fail to invalidate TLB entries when
addr[34:29] == all 1 && addr[28:0] == 0 for 512MB mappings.
The affected instructions are:
  RVA[L]E{1,2,3}*, RVAA[L]E1*, and RIPAS2[L]E1*.

Work around the erratum by issuing additional non-range
TLBI instructions corresponding to the affected VA or IPA
range-based TLBI operations.

Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>
---
 Documentation/arch/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                          | 19 +++++++++++++++++
 arch/arm64/include/asm/cpucaps.h            |  2 ++
 arch/arm64/include/asm/tlbflush.h           | 33 +++++++++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c              | 10 +++++++++
 arch/arm64/tools/cpucaps                    |  1 +
 6 files changed, 67 insertions(+)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index ac3248b9f2f3..8ab6284e3d10 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -373,6 +373,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
 +----------------+-----------------+-----------------+-----------------------------+
+| Fujitsu        | MONAKA          | E#030001        | FUJITSU_ERRATUM_030001      |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | ASR            | ASR8601         | #8601001        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b5a51b0ef944..38248a31d5f1 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1312,6 +1312,25 @@ config FUJITSU_ERRATUM_010001
 
 	  If unsure, say Y.
 
+config FUJITSU_ERRATUM_030001
+	bool "FUJITSU-MONAKA erratum E#030001: Range TLBI may fail to invalidate some entries"
+	depends on PAGE_SIZE_64KB
+	default y
+	help
+	  This option adds a workaround for FUJITSU-MONAKA erratum E#030001.
+	  On affected FUJITSU-MONAKA CPUs, range-based TLBI operation
+	  targeting a VA or IPA may fail to invalidate some TLB entries
+	  for 512MB mappings. The affected instructions are RVA[L]E{1,2,3}*,
+	  RVAA[L]E1*, and RIPAS2[L]E1*.
+
+	  Work around the erratum by issuing additional non-range TLBI
+	  instructions corresponding to the affected VA or IPA range-based
+	  TLBI operations.
+
+	  The erratum only affects the FUJITSU-MONAKA on 64k pagesize.
+
+	  If unsure, say Y.
+
 config HISILICON_ERRATUM_161600802
 	bool "Hip07 161600802: Erroneous redistributor VLPI base"
 	default y
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 76350b38f0d7..9220b917ec20 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -66,6 +66,8 @@ cpucap_is_possible(const unsigned int cap)
 		return IS_ENABLED(CONFIG_ARM64_ERRATUM_3194386);
 	case ARM64_WORKAROUND_4193714:
 		return IS_ENABLED(CONFIG_ARM64_ERRATUM_4193714);
+	case ARM64_WORKAROUND_FUJITSU_030001:
+		return IS_ENABLED(CONFIG_FUJITSU_ERRATUM_030001);
 	case ARM64_MPAM:
 		/*
 		 * KVM MPAM support doesn't rely on the host kernel supporting MPAM.
diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 14a78ac0f800..0487daec1652 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -487,6 +487,37 @@ static __always_inline void __tlbi_range(tlbi_op op, u64 addr,
 	op(arg);
 }
 
+#ifdef CONFIG_FUJITSU_ERRATUM_030001
+static inline void fujitsu_erratum_wa(tlbi_op lop, u64 start, u64 end, u16 asid)
+{
+	u64 addr;
+
+	if (!alternative_has_cap_unlikely(ARM64_WORKAROUND_FUJITSU_030001))
+		return;
+
+	/*
+	 * The erratum fails to invalidate TLBI entries in the range when
+	 * addr[34:29] == all 1 && addr[28:0] == all 0 for 512M hugepage.
+	 * However, since it cannot be determined reliably if the target
+	 * entry is hugepage or not here, always assume hugepage is used.
+	 * The workaround is to issue extra non-range TLBI ops corresponding
+	 * to the affected VA or IPA range-based ops in the range.
+	 */
+	addr = (start & GENMASK_ULL(63, 35)) | GENMASK_ULL(34, 29);
+	while (addr < end) {
+		__tlbi_level_asid(lop, addr, TLBI_TTL_UNKNOWN, asid);
+		if (addr + BIT_ULL(35) < addr)
+			/* overflow */
+			break;
+		addr += BIT_ULL(35);
+	}
+}
+#else
+static inline void fujitsu_erratum_wa(tlbi_op lop, u64 start, u64 end, u16 asid)
+{
+}
+#endif /* CONFIG_FUJITSU_ERRATUM_030001 */
+
 static __always_inline void __flush_tlb_range_op(tlbi_op lop, tlbi_op rop,
 						 u64 start, size_t pages,
 						 u64 stride, u16 asid,
@@ -518,6 +549,8 @@ static __always_inline void __flush_tlb_range_op(tlbi_op lop, tlbi_op rop,
 		__tlbi_level_asid(lop, addr, level, asid);
 		addr += stride;
 	}
+
+	fujitsu_erratum_wa(lop, start, end, asid);
 }
 
 #define __flush_s1_tlb_range_op(op, start, pages, stride, asid, tlb_level) \
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 8ec47d89b45b..5b9dea3c761d 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -1027,6 +1027,16 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.matches = has_impdef_pmuv3,
 		.cpu_enable = cpu_enable_impdef_pmuv3_traps,
 	},
+#ifdef CONFIG_FUJITSU_ERRATUM_030001
+	{
+		.desc = "FUJITSU-MONAKA Erratum E#030001",
+		.capability = ARM64_WORKAROUND_FUJITSU_030001,
+		ERRATA_MIDR_RANGE_LIST(((const struct midr_range[]) {
+					MIDR_ALL_VERSIONS(MIDR_FUJITSU_MONAKA),
+					{}
+				})),
+	},
+#endif
 	{
 		.desc = "Known broken GICv3 SEIS implementation",
 		.capability = ARM64_WORKAROUND_GICv3_BROKEN_SEIS,
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 2775ba3359cf..50a9aa0e2bf0 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -132,3 +132,4 @@ WORKAROUND_REPEAT_TLBI_SYNC
 WORKAROUND_SPECULATIVE_AT
 WORKAROUND_SPECULATIVE_SSBS
 WORKAROUND_SPECULATIVE_UNPRIV_LOAD
+WORKAROUND_FUJITSU_030001

-- 
2.43.0

