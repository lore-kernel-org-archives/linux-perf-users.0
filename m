Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601EA3C062D;
	Fri, 16 Oct 2026 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144969; cv=none; b=gq5hMq1Dt7rVt8u8UmernfdVICxuUoMSI3EAbjBKsRtXWi9jhkVmG6Yroyl9GBEu2Y8Dkbz9juUnAuR5Nd7IORDI/+opf6MPkX83Jr1hVLPtHr5HzrNzydqN3ii0BPQhdp0nsbRzom3j3WzKlSSktUcfVMpBhZHP8k8Kj4qpXJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144969; c=relaxed/simple;
	bh=Yi6urKJkWyGCNstODXrwXoGfLB4RyuU7Y4hjLELW/wM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cPFRm5CXALMXG46BEALAUQXds5G5V8FxU+bCj6RwJTY5TRLP1Z2kvVJRZ34HoD1ZgBqMCmv027/L3LGdH6Vhn3rAPF2B3wB8o8U5youl3NVQaVIoEW3aHn3Id8SFWcjZqqJC7InwU4Xl4ekAi/rY+ulnBLd/0SlbTYNSJLV0Xa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=OlEJBjlp; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="OlEJBjlp"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1792144967; x=1823680967;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Yi6urKJkWyGCNstODXrwXoGfLB4RyuU7Y4hjLELW/wM=;
  b=OlEJBjlpBy0LsxjQaqYcWhWCEjeVsQ7q0VVyra+j+lTDPSlXKKII1GJr
   Z2lOGPB+yIqOH9GMLnWM16Grz0+rF1R0tH952tZId5Vg8F1T0TDoZz4+O
   YAMYNZjeniLVZOwt1ccWpPeS6YWMXhYjL34YG9gcvK0rLDD7wRew70IVW
   q54KgK5IdYoEn8Ecij9unhtrHKZ9ekvfS1MB51M+rZsp6QYYLHt2KF08a
   JotVC2NQKEbWBElZjCeMTDMUjpLBijTtwDXcZJIFX7eFiu4wyRQMAUUmC
   JYglWOcS31sxbTLBTljqnNoSnNM6XQs2Wlv/WlzkPI+V0GapSyHzd9seL
   g==;
X-CSE-ConnectionGUID: pm099nHrREiwUEnAuQTQVw==
X-CSE-MsgGUID: BlR6A5Z3SQCyAmRaVbQ8Pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="236179962"
X-IronPort-AV: E=Sophos;i="6.27,161,1786978800"; 
   d="scan'208";a="236179962"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 19:01:37 +0900
Received: from az2nlsmgm1.o.css.fujitsu.com (unknown [10.150.26.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 2ED71406C75;
	Fri, 16 Oct 2026 10:01:37 +0000 (UTC)
Received: from az2nlsmom3.fujitsu.com (unknown [10.150.26.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id D63C6C01EEB;
	Fri, 16 Oct 2026 10:01:36 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.124.178.20])
	by az2nlsmom3.fujitsu.com (Postfix) with ESMTP id B4CA0101BB55;
	Fri, 16 Oct 2026 10:01:29 +0000 (UTC)
From: Tomohiro Misono <misono.tomohiro@fujitsu.com>
Date: Fri, 16 Oct 2026 19:00:46 +0900
Subject: [PATCH v2 2/4] arm64: tlb: Add tlbi workaround for FUJITSU-MONAKA
 Erratum E#030001
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-monaka-fix-for-upstream-v2-2-fc7ede7f9f48@fujitsu.com>
References: <20261016-monaka-fix-for-upstream-v2-0-fc7ede7f9f48@fujitsu.com>
In-Reply-To: <20261016-monaka-fix-for-upstream-v2-0-fc7ede7f9f48@fujitsu.com>
To: Tomohiro Misono <misono.tomohiro@fujitsu.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Marc Zyngier <maz@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Oliver Upton <oupton@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>
Cc: Kohei Enju <enju.kohei@fujitsu.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 kvmarm@lists.linux.dev
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792144875; l=9554;
 i=misono.tomohiro@fujitsu.com; s=20261002; h=from:subject:message-id;
 bh=Yi6urKJkWyGCNstODXrwXoGfLB4RyuU7Y4hjLELW/wM=;
 b=qp1UVSOaM3F9bn8D0Bx+xQZIVImT8ji3Eod68CZr1PHSJIVMWHZU5hzwZ+C4jgOarcQTdAl/H
 D99ggrAZYjgBnH29g0AZcb8509NY2ebvDSe4EIpG4kEVb66hT/mX3bo
X-Developer-Key: i=misono.tomohiro@fujitsu.com; a=ed25519;
 pk=VLRxj5y4GJrHLmj3e2NBg30fX2U//ydi7c2G2qiNo10=

FUJITSU-MONAKA Erratum E#030001 affects FUJITSU-MONAKA CPU
when using TLBI range operations.

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
Changes in v2:
 - remove page size restrictions as this errata affects both S1 and S2 tables
 - use __always_inline instead of inline
 - call workaround from NV TLBI operations too (comment by sashiko)
  - TODO: test using NV
---
---
 Documentation/arch/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                          | 19 +++++++++++++
 arch/arm64/include/asm/cpucaps.h            |  2 ++
 arch/arm64/include/asm/tlbflush.h           | 35 +++++++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c              | 10 +++++++
 arch/arm64/kvm/hyp/vhe/tlb.c                | 44 +++++++++++++++++++++++++++++
 arch/arm64/tools/cpucaps                    |  1 +
 7 files changed, 113 insertions(+)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 99a1eb4b833dd..527af20b26468 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -375,6 +375,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
 +----------------+-----------------+-----------------+-----------------------------+
+| Fujitsu        | MONAKA          | E#030001        | FUJITSU_ERRATUM_030001      |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | ASR            | ASR8601         | #8601001        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cab741a695f52..5d1a17ab0f593 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1342,6 +1342,25 @@ config FUJITSU_ERRATUM_010001
 
 	  If unsure, say Y.
 
+config FUJITSU_ERRATUM_030001
+	bool "FUJITSU-MONAKA erratum E#030001: Range TLBI may fail to invalidate some entries"
+	default y
+	help
+	  This option adds a workaround for FUJITSU-MONAKA erratum E#030001.
+	  On affected FUJITSU-MONAKA CPUs, range-based TLBI operation
+	  targeting a VA or IPA may fail to invalidate some TLB entries
+	  when hugepage is used in a certain condition. The affected
+	  instructions are RVA[L]E{1,2,3}*, RVAA[L]E1*, and RIPAS2[L]E1*
+	  and this affects on both S1 and S2 tables.
+
+	  Work around the erratum by issuing additional non-range TLBI
+	  instructions corresponding to the affected VA or IPA range-based
+	  TLBI operations.
+
+	  The erratum only affects the FUJITSU-MONAKA.
+
+	  If unsure, say Y.
+
 config HISILICON_ERRATUM_161600802
 	bool "Hip07 161600802: Erroneous redistributor VLPI base"
 	default y
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 76350b38f0d7a..9220b917ec207 100644
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
index 14a78ac0f8009..2636c273b8111 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -487,6 +487,39 @@ static __always_inline void __tlbi_range(tlbi_op op, u64 addr,
 	op(arg);
 }
 
+#ifdef CONFIG_FUJITSU_ERRATUM_030001
+static __always_inline void fujitsu_erratum_wa(tlbi_op lop, u64 start, u64 end, u16 asid)
+{
+	u64 addr;
+
+	if (!alternative_has_cap_unlikely(ARM64_WORKAROUND_FUJITSU_030001))
+		return;
+
+	/*
+	 * The erratum fails to invalidate TLBI entries in the range when
+	 * addr[34:29] == all 1 && addr[28:0] == all 0 for 512M hugepage.
+	 * This affects both on S1 and S2 tables and 4k guest may be affected
+	 * if host uses 64k page size. Therefore it cannot be determined
+	 * reliably if the target entry is affected or not here. So, always
+	 * assume hugepage is used.
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
+static __always_inline void fujitsu_erratum_wa(tlbi_op lop, u64 start, u64 end, u16 asid)
+{
+}
+#endif /* CONFIG_FUJITSU_ERRATUM_030001 */
+
 static __always_inline void __flush_tlb_range_op(tlbi_op lop, tlbi_op rop,
 						 u64 start, size_t pages,
 						 u64 stride, u16 asid,
@@ -518,6 +551,8 @@ static __always_inline void __flush_tlb_range_op(tlbi_op lop, tlbi_op rop,
 		__tlbi_level_asid(lop, addr, level, asid);
 		addr += stride;
 	}
+
+	fujitsu_erratum_wa(lop, start, end, asid);
 }
 
 #define __flush_s1_tlb_range_op(op, start, pages, stride, asid, tlb_level) \
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index e0c09402540ce..a11135f83e858 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -1039,6 +1039,16 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
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
diff --git a/arch/arm64/kvm/hyp/vhe/tlb.c b/arch/arm64/kvm/hyp/vhe/tlb.c
index c386d9f1c1016..2f1a7fab5eb97 100644
--- a/arch/arm64/kvm/hyp/vhe/tlb.c
+++ b/arch/arm64/kvm/hyp/vhe/tlb.c
@@ -8,6 +8,7 @@
 
 #include <asm/kvm_hyp.h>
 #include <asm/kvm_mmu.h>
+#include <asm/kvm_nested.h>
 #include <asm/tlbflush.h>
 
 struct tlb_inv_context {
@@ -218,6 +219,45 @@ void __kvm_flush_vm_context(void)
 	__tlbi_sync_s1ish_hyp();
 }
 
+#ifdef CONFIG_FUJITSU_ERRATUM_030001
+static __always_inline void __vae1is(u64 arg)
+{
+	__tlbi(vae1is, arg);
+}
+static __always_inline void __vale1is(u64 arg)
+{
+	__tlbi(vale1is, arg);
+}
+static __always_inline void __vaae1is(u64 arg)
+{
+	__tlbi(vaae1is, arg);
+}
+static __always_inline void __fujitsu_erratum_wa(tlbi_op op, u64 va)
+{
+	u64 start, size;
+	u16 asid;
+
+	if (!alternative_has_cap_unlikely(ARM64_WORKAROUND_FUJITSU_030001))
+		return;
+
+	start = decode_range_tlbi(va, &size, &asid);
+	fujitsu_erratum_wa(op, start, start + size, asid);
+}
+#else
+static __always_inline void __vae1is(u64 arg)
+{
+}
+static __always_inline void __vale1is(u64 arg)
+{
+}
+static __always_inline void __vaae1is(u64 arg)
+{
+}
+static __always_inline void __fujitsu_erratum_wa(tlbi_op op, u64 va)
+{
+}
+#endif
+
 /*
  * TLB invalidation emulation for NV. For any given instruction, we
  * perform the following transformtions:
@@ -322,6 +362,7 @@ int __kvm_tlbi_s1e2(struct kvm_s2_mmu *mmu, u64 va, u64 sys_encoding)
 	case OP_TLBI_RVAE1ISNXS:
 	case OP_TLBI_RVAE1OSNXS:
 		__tlbi(rvae1is, va);
+		__fujitsu_erratum_wa(__vae1is, va);
 		break;
 	case OP_TLBI_RVALE2:
 	case OP_TLBI_RVALE2IS:
@@ -336,6 +377,7 @@ int __kvm_tlbi_s1e2(struct kvm_s2_mmu *mmu, u64 va, u64 sys_encoding)
 	case OP_TLBI_RVALE1ISNXS:
 	case OP_TLBI_RVALE1OSNXS:
 		__tlbi(rvale1is, va);
+		__fujitsu_erratum_wa(__vale1is, va);
 		break;
 	case OP_TLBI_RVAAE1:
 	case OP_TLBI_RVAAE1IS:
@@ -344,6 +386,7 @@ int __kvm_tlbi_s1e2(struct kvm_s2_mmu *mmu, u64 va, u64 sys_encoding)
 	case OP_TLBI_RVAAE1ISNXS:
 	case OP_TLBI_RVAAE1OSNXS:
 		__tlbi(rvaae1is, va);
+		__fujitsu_erratum_wa(__vaae1is, va);
 		break;
 	case OP_TLBI_RVAALE1:
 	case OP_TLBI_RVAALE1IS:
@@ -352,6 +395,7 @@ int __kvm_tlbi_s1e2(struct kvm_s2_mmu *mmu, u64 va, u64 sys_encoding)
 	case OP_TLBI_RVAALE1ISNXS:
 	case OP_TLBI_RVAALE1OSNXS:
 		__tlbi(rvaale1is, va);
+		__fujitsu_erratum_wa(vaale1is, va);
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 58b6c084f9f25..1e57a0105395b 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -132,3 +132,4 @@ WORKAROUND_SPECULATIVE_AT
 WORKAROUND_SPECULATIVE_SSBS
 WORKAROUND_SPECULATIVE_UNPRIV_LOAD
 WORKAROUND_BROKEN_AMU_CONSTCNT
+WORKAROUND_FUJITSU_030001

-- 
2.43.0

