Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=139.138.61.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079124;
	b=hMExylUy/IpO8/r7FZyYcjjRrAid3ymgn12ild7mMgSfvPNqPYI6uCGZiKlRJnevXDmM
	 nrsau81MCcKARoadjql77Gqjklz/Y2bmfEbZ9yHcl6OLsh5rJGcFlzAKu9qm938IalW6B
	 wIrSobXVFLQPXzAh7lzDy5XBu9GLucxhOYpXhBAVygygyeHmDbQNZMWHrAmDzkBIlYHQ1
	 86ZarGifKjrMq/f+DeGw1C9fbMP4G+xcUceEfQv97zSx53yk9nGnxw1OLH77Ls6BQfsoe
	 JZx8e9CK3dAQP1TDvYgVcl9ztVMbJWksR04qCVHBHxroPjU9YwiZrrVhqdUYa4RiY2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079124;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=VQ/IR4gfjs4ztpghZWkr3QrsQftFY6FdwIRRKdzCS/0=;
	b=DDqO8RCWkefqlbDHWCOHGaG0LDfBeC6wSINXgo4/maccOBKcD1zW/lNhTzgSOh6h+S5N
	 o4O/M5E/JxBstR+ra6TQOtgoFdBotZbo4bnBGyHDls22L84ZI+bKXmpEBwK0j98nIeh+E
	 hFyOpNCPJa2fd4kAouHHs4yR+4NNInl5icfW7pFroROppn8K4V0TbOOiaEiQQRzOxJUca
	 huimalSJsuHoV6jjOmRrBUDrWyWRDW2khanLVuA9OSgqZ21yn5HWFgH9J51FjmUW2Hddu
	 2vyk938nCExpHxI4yW+7uUTGmxBbPrxOYYyrloUristlD1NTbuTDzerq7NO9UbQcg6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b="QFCA7/PX";
	arc=none smtp.remote-ip=139.138.61.252
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3885D60A260B;
	Thu, 19 Nov 2026 09:05:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3885D60A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=QFCA7/PX
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1795079123; x=1826615123;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=GNyLIrBeNfaWtsqx3sAkJwBbPb77cM5V2dmBCm/TUjQ=;
  b=QFCA7/PX6xVDnyE7quIQud3iOoVEr7zID1QXSOS8MyPhkzZUiWQ8hqBf
   QhI3D3kKmnMFo5OglDM3Yvoayspt18r58WKCB4o+GOqwIonVX0S1ugViB
   TUFbmPAsp3UFLmHeFXXtvgki0Irem7pbMNbSychdB6LjRkdueZHYCHDAh
   ZDLwut2hxqQnoEO6/Ycvl9shIhgui049F8zjdAN85/b/oFUVBjr+/5sMZ
   x7XuSjDH9pwZldUVV3EJwCRNtep/4uyZ39sR6C2vltyQ8yfHyDlFvDM0o
   cB7ZKTuCTGuGnFndLBUy/iERUwIvjJDNQgdT9Z+Mv//5LNfppIY5Hgrl/
   w==;
X-CSE-ConnectionGUID: Yloo23cmSnSw20+SIsCvsg==
X-CSE-MsgGUID: ErQKSaDASpimr+137TTOqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="241268948"
X-IronPort-AV: E=Sophos;i="6.27,220,1786978800"; 
   d="scan'208";a="241268948"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 18:05:16 +0900
Received: from az2nlsmgm4.fujitsu.com (unknown [10.150.26.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 0896A1C0622B;
	Thu, 19 Nov 2026 09:05:16 +0000 (UTC)
Received: from az2uksmom3.o.css.fujitsu.com (unknown [10.151.22.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm4.fujitsu.com (Postfix) with ESMTPS id AA4CC1007120;
	Thu, 19 Nov 2026 09:05:15 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.124.178.20])
	by az2uksmom3.o.css.fujitsu.com (Postfix) with ESMTP id 09F74100116B;
	Thu, 19 Nov 2026 09:05:07 +0000 (UTC)
From: Tomohiro Misono <misono.tomohiro@fujitsu.com>
Date: Thu, 19 Nov 2026 18:04:34 +0900
Subject: [PATCH v3 2/5] arm64: tlb: Add tlbi workaround for FUJITSU-MONAKA
 Erratum E#030001
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-monaka-fix-for-upstream-v3-2-057df4d2ca3c@fujitsu.com>
References: <20261119-monaka-fix-for-upstream-v3-0-057df4d2ca3c@fujitsu.com>
In-Reply-To: <20261119-monaka-fix-for-upstream-v3-0-057df4d2ca3c@fujitsu.com>
To: Tomohiro Misono <misono.tomohiro@fujitsu.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Marc Zyngier <maz@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Oliver Upton <oupton@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Zenghui Yu <yuzenghui@huawei.com>, 
 Vladimir Murzin <vladimir.murzin@arm.com>
Cc: Kohei Enju <enju.kohei@fujitsu.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 kvmarm@lists.linux.dev
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795079092; l=6576;
 i=misono.tomohiro@fujitsu.com; s=20261002; h=from:subject:message-id;
 bh=GNyLIrBeNfaWtsqx3sAkJwBbPb77cM5V2dmBCm/TUjQ=;
 b=cDc5mEfbJ/poB4Qc+ue4ZDq1y/fix+JN8FiC5kWDlkT4FZyXC04/K2lf/xSLWW7O18IE2WQpW
 be92IHsLalZA4wr2oxVrXlHfQgYp1FWLDFYZcxHqOYFks7GkuJcYTwi
X-Developer-Key: i=misono.tomohiro@fujitsu.com; a=ed25519;
 pk=VLRxj5y4GJrHLmj3e2NBg30fX2U//ydi7c2G2qiNo10=

FUJITSU-MONAKA Erratum E#030001 affects FUJITSU-MONAKA CPU
when using TLBI range operations.

On affected FUJITSU-MONAKA CPUs, range-based TLBI operations
targeting a VA or IPA may fail to invalidate TLB entries when
addr[34:29] == all 1 && addr[28:0] == 0 for 512MB mappings.
The affected instructions are:
  RVA[L]E{1,2,3}*, RVAA[L]E1*, and RIPAS2[L]E1*.

Work around the erratum by disabling TLB range operations on
both host and guest.

Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>

---
Changes in v3:
 - rework patch to disable TLB range operations on both host and guest
 - use ERRATA_MIDR_ALL_VERSIONS macro
---
 Documentation/arch/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                          | 18 ++++++++++++++++++
 arch/arm64/include/asm/cpucaps.h            |  2 ++
 arch/arm64/kernel/cpu_errata.c              |  7 +++++++
 arch/arm64/kernel/cpufeature.c              | 11 ++++++++++-
 arch/arm64/kvm/sys_regs.c                   |  8 ++++++++
 arch/arm64/tools/cpucaps                    |  1 +
 7 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index dc4144ac895b..bd9ac993495b 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -393,6 +393,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Fujitsu        | A64FX           | E#010001        | FUJITSU_ERRATUM_010001      |
 +----------------+-----------------+-----------------+-----------------------------+
+| Fujitsu        | MONAKA          | E#030001        | FUJITSU_ERRATUM_030001      |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | ASR            | ASR8601         | #8601001        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9b08b2457a55..8a0c94a0c879 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1384,6 +1384,24 @@ config FUJITSU_ERRATUM_010001
 
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
+	  Work around the erratum by disabling TLB range operations on both
+	  host and guest.
+
+	  The erratum only affects the FUJITSU-MONAKA.
+
+	  If unsure, say Y.
+
 config HISILICON_ERRATUM_161600802
 	bool "Hip07 161600802: Erroneous redistributor VLPI base"
 	default y
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 0c3bfbe99aad..7c73a739eee1 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -68,6 +68,8 @@ cpucap_is_possible(const unsigned int cap)
 		return IS_ENABLED(CONFIG_ARM64_ERRATUM_4193714);
 	case ARM64_WORKAROUND_NXP_ERR050104:
 		return IS_ENABLED(CONFIG_NXP_IMX8QM_ERRATUM_ERR050104);
+	case ARM64_WORKAROUND_FUJITSU_030001:
+		return IS_ENABLED(CONFIG_FUJITSU_ERRATUM_030001);
 	case ARM64_MPAM:
 		/*
 		 * KVM MPAM support doesn't rely on the host kernel supporting MPAM.
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index ca31d33152e9..c8a0ea73ec1a 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -1096,6 +1096,13 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.matches = has_impdef_pmuv3,
 		.cpu_enable = cpu_enable_impdef_pmuv3_traps,
 	},
+#ifdef CONFIG_FUJITSU_ERRATUM_030001
+	{
+		.desc = "FUJITSU-MONAKA Erratum E#030001",
+		.capability = ARM64_WORKAROUND_FUJITSU_030001,
+		ERRATA_MIDR_ALL_VERSIONS(MIDR_FUJITSU_MONAKA),
+	},
+#endif
 	{
 		.desc = "Known broken GICv3 SEIS implementation",
 		.capability = ARM64_WORKAROUND_GICv3_BROKEN_SEIS,
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index c9c9a6889455..097d283169a0 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1662,6 +1662,15 @@ static bool has_cache_dic(const struct arm64_cpu_capabilities *entry,
 	return ctr & BIT(CTR_EL0_DIC_SHIFT);
 }
 
+static bool has_tlb_range(const struct arm64_cpu_capabilities *entry,
+			  int scope)
+{
+	if (cpus_have_cap(ARM64_WORKAROUND_FUJITSU_030001))
+		return false;
+
+	return has_cpuid_feature(entry, scope);
+}
+
 static bool __maybe_unused
 has_useable_cnp(const struct arm64_cpu_capabilities *entry, int scope)
 {
@@ -2638,7 +2647,7 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.desc = "TLB range maintenance instructions",
 		.capability = ARM64_HAS_TLB_RANGE,
 		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
-		.matches = has_cpuid_feature,
+		.matches = has_tlb_range,
 		ARM64_CPUID_FIELDS(ID_AA64ISAR0_EL1, TLB, RANGE)
 	},
 #ifdef CONFIG_ARM64_HW_AFDBM
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c7d91138a6d4..2e8965b7702e 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1949,6 +1949,14 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 	case SYS_ID_AA64PFR2_EL1:
 		val = sanitise_id_aa64pfr2_el1(vcpu, val);
 		break;
+	case SYS_ID_AA64ISAR0_EL1:
+		if (cpus_have_final_cap(ARM64_WORKAROUND_FUJITSU_030001)) {
+			/* disable TLBI range operatoins on guest */
+			val &= ~ID_AA64ISAR0_EL1_TLB_MASK;
+			val |= SYS_FIELD_PREP(ID_AA64ISAR0_EL1, TLB,
+				ID_AA64ISAR0_EL1_TLB_OS);
+		}
+		break;
 	case SYS_ID_AA64ISAR1_EL1:
 		if (!vcpu_has_ptrauth(vcpu))
 			val &= ~(ID_AA64ISAR1_EL1_APA |
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 3125695122a0..1a199502614d 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -134,3 +134,4 @@ WORKAROUND_SPECULATIVE_SSBS
 WORKAROUND_SPECULATIVE_UNPRIV_LOAD
 WORKAROUND_BROKEN_AMU_CONSTCNT
 WORKAROUND_BROKEN_AMU_CORECNT
+WORKAROUND_FUJITSU_030001

-- 
2.43.0

