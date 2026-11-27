Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=139.138.61.253
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795757848;
	b=5IbZY6cVEtmSPP9QX8bdaZoE/LOMPk/rdtntzEqfA/2MZWdzJY9eX9w6zkO1fBzzbFx1
	 izY5fa5sRwftqYkFy0RowFCs9BnJAtiL9F8JjTwTdnORirbNCgnYqOKiz7wKqZQopIHzD
	 h/abJFhsI8zXjTGNqe2HJZTw4bZW5JjDiwRW3B0aX/r/S9D2FTfYPQhMDOhigB08HSiaG
	 ILyKLGlmSD9bZoKC8Msj5LJGkqRwEStieomYjrxZLrCnVUW/ch81OKrtk7MH/FN0QxCdT
	 MumBz6DUILESTd71bI6nYVX1XZWCzPuZkdAqyqwI8b17+/0wKDYhrINfKfmlvkSxfrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795757848;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=SC1dzg38tmfFOoUKwD0WOCR1qU5zAAB5z/g5TkovgI0=;
	b=Fd4GO5Z1h7TZOOFfW7GUiMaIpvxfdpvm1iuxAmzK1j7+tv6qvvnsKQVgObCCuhS85uef
	 HwlMGaZGrNxHZSKxHftqcDPNiZHNruA5W+KJB8tW0z9ovMtagIV5ApkisYc0KPdsdiY8q
	 UXOohXyNflV56J0yFY35jz9X93kIEXyY9xVyr2ycrKVWRYxVNdpDg8kYZNwDmt2v9iLW0
	 01dic4wH2R28XAzsQPg2XLHcern5aUeqcf9JRCWCYSfIBJYlkOKVijr9locPmcMhYV9km
	 tuxDaCy5drkUQt3WN1TGB8VmQXcMpA7VvAG7YiXPw3m7cFDywovNSkzjINRNe8vIVnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b="m/21vq5w";
	arc=none smtp.remote-ip=139.138.61.253
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D43606A32F;
	Fri, 27 Nov 2026 05:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30D43606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=m/21vq5w
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1795757855; x=1827293855;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=RpGsDpiAVD3WqMP1+3FHOIWafrnqy5vDJu7yd3Zvd8I=;
  b=m/21vq5w/P4mEjn6QOEmq8tgyCI6DagKQNL97+RKscuyUN+om58RdFh7
   TWLef6qDwM31mdKDxefVe8PL10agA5NJp5AH2/TmOmzRECTIzMZ8WQOzD
   +oe+aNk4EV3x+c16F/Z2MOBVA1qDO3ETDUMxAS/zsxwqlnxUdA/HS2ryb
   70GYR0US29cEPPg8nNgomM+UVqw/p6Cn/r6hpRL2oKEqSfDFM7xzekrKN
   m78vjisbYzSo994JeDwVML2vEwQ5Xf6LcNLGwh5V8FRf953EkIx2tErad
   UgzG709AHyPk6lVjEkYPwen79RPn/bLB9BRVfgU5wb3WEvNZQ+E6RNIuS
   Q==;
X-CSE-ConnectionGUID: Aj+tdOaxRNCMEpOWTEjcCQ==
X-CSE-MsgGUID: d6m1AGKoSVySPfQZLEXUlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="251279426"
X-IronPort-AV: E=Sophos;i="6.27,236,1786978800"; 
   d="scan'208";a="251279426"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 14:37:33 +0900
Received: from az2nlsmgm1.o.css.fujitsu.com (unknown [10.150.26.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 859FE4049D2;
	Fri, 27 Nov 2026 05:37:25 +0000 (UTC)
Received: from az2uksmom4.o.css.fujitsu.com (unknown [10.151.22.204])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id 25A25C0181B;
	Fri, 27 Nov 2026 05:37:25 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.124.178.20])
	by az2uksmom4.o.css.fujitsu.com (Postfix) with ESMTP id A47BE406873;
	Fri, 27 Nov 2026 05:37:17 +0000 (UTC)
From: Tomohiro Misono <misono.tomohiro@fujitsu.com>
Date: Fri, 27 Nov 2026 14:36:31 +0900
Subject: [PATCH v4 2/5] arm64: tlb: Add tlbi workaround for FUJITSU-MONAKA
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
Message-Id: <20261127-monaka-fix-for-upstream-v4-2-3395c415bbe4@fujitsu.com>
References: <20261127-monaka-fix-for-upstream-v4-0-3395c415bbe4@fujitsu.com>
In-Reply-To: <20261127-monaka-fix-for-upstream-v4-0-3395c415bbe4@fujitsu.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795757822; l=6029;
 i=misono.tomohiro@fujitsu.com; s=20261002; h=from:subject:message-id;
 bh=RpGsDpiAVD3WqMP1+3FHOIWafrnqy5vDJu7yd3Zvd8I=;
 b=ZC+iJhuGH4xq2Hmw7kU/IsVfaZUjPMLI3EX220PAhc3VsHgdxi6EH/4zF0yqy2vme8NcWJYN4
 pJC6o6z1++0DhS1MvVESll+Np4SGb1Dvvdxo6/O2kih8chAxkNzIjs0
X-Developer-Key: i=misono.tomohiro@fujitsu.com; a=ed25519;
 pk=VLRxj5y4GJrHLmj3e2NBg30fX2U//ydi7c2G2qiNo10=

FUJITSU-MONAKA Erratum E#030001 affects FUJITSU-MONAKA CPU
when using TLBI range operations.

On affected FUJITSU-MONAKA CPUs, range-based TLBI operations
targeting a VA or IPA may fail to invalidate TLB entries when
addr[34:29] == all 1 && addr[28:0] == 0 for 512MB mappings.
The affected instructions are:
  RVA[L]E{1,2,3}*, RVAA[L]E1*, and RIPAS2[L]E1*.

Work around the erratum by dropping TLB range capability from
ID_AA64ISAR0_EL1 before detecting system capability. This means
TLB range operations are disabled on both host and guest.

Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>

---
Changes in v4:
 - rework patch to drop TLB range capability from ID_AA64ISAR0_EL1
   before detecting system capability so that both KVM/pKVM sees
   the sanitized reg value
Changes in v3:
 - disable TLB range operations on both host and guest
 - use ERRATA_MIDR_ALL_VERSIONS macro
---
 Documentation/arch/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                          | 18 ++++++++++++++++++
 arch/arm64/include/asm/cpucaps.h            |  2 ++
 arch/arm64/kernel/cpu_errata.c              |  7 +++++++
 arch/arm64/kernel/cpufeature.c              | 17 +++++++++++++++++
 arch/arm64/tools/cpucaps                    |  1 +
 6 files changed, 47 insertions(+)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index bffaa46c664b..751f478a71b7 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -399,6 +399,8 @@ stable kernels.
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
index a8a1a73ba1b8..caeb72935f2c 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -3998,8 +3998,25 @@ void __init setup_boot_cpu_features(void)
 	setup_boot_cpu_capabilities();
 }
 
+static void __init apply_fujitsu_030001_workaround(void)
+{
+	struct arm64_ftr_reg *regp;
+	u64 val;
+
+	if (!cpus_have_cap(ARM64_WORKAROUND_FUJITSU_030001))
+		return;
+
+	regp = get_arm64_ftr_reg(SYS_ID_AA64ISAR0_EL1);
+	/* disable TLBI range operation */
+	val = regp->sys_val & ~ID_AA64ISAR0_EL1_TLB_MASK;
+	val |= SYS_FIELD_PREP_ENUM(ID_AA64ISAR0_EL1, TLB, OS);
+	update_cpu_ftr_reg(regp, val);
+}
+
 static void __init setup_system_capabilities(void)
 {
+	/* Apply workaround before detecting system capabilies */
+	apply_fujitsu_030001_workaround();
 	/*
 	 * The system-wide safe feature register values have been finalized.
 	 * Detect, enable, and patch alternatives for the available system
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

