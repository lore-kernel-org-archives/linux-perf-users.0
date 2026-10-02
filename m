Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2465E47CC6B;
	Fri,  2 Oct 2026 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936897; cv=none; b=G9dKcmZV//OAYx8a0q57okJayY53p2i1MIBePWOvHUAjoRrP1+k2Q39+R1XCB+Cb7ZczYr/TJUMGPv23UkHPrIOGmDv4G2YuiA+gGPleffnwj1iDzsbn7U0izpI/w0NbHcaqjq/3iLmY5TRxS+7RMJEnqBV+E018y6hSD3s9UAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936897; c=relaxed/simple;
	bh=KtdDUJ8gI8pEplE4ZUe4invOYkX7dUJNfyBoNGTouOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QBPiwIfutQjz4S0gMbOBniE1QLSWelP1Lkh4VFrGZCt2P4cUxxU0YO7d2HyNWDB+tgaCtee4ww8EpAjV0BK39p/SuapeK3gzZQQdaL8ZK/h99s6/NFCXxUcrrzmuG6isy9puCQVI6kNs2jumKW1VF1U1xv16TpCOmrqjs8zvhLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=gnMsKTAK; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="gnMsKTAK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1790936895; x=1822472895;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KtdDUJ8gI8pEplE4ZUe4invOYkX7dUJNfyBoNGTouOM=;
  b=gnMsKTAK+VTIrNXYl2YjMZjjuDtxj0p7H2T1k+Y7z0g7y+P01u6m7Ybm
   Ge9vjEMAJy2egY98ASzeAqEmXaXPFHWNrwpKuGjN7kgiS0YXJdC84yf9n
   brAcUFSVaUhPWthnp3+OIb2ox6RCVzweXv4RxgxqvGk0T82Yb7eLOjxgL
   AbVWaU6E3k0nqv+brrGYgSrHzL+Y1LlLS7AT2aIZvOQZ305761DuAxYqP
   DYrx/dzR0ZQG7mFzy6SiBWClRdll5wdrh/fzIF3MPXZn6y+1VLblK7XLk
   6TN/jsFJKiU0SpoRmChaOMtPH9hRpxc6TtifymEoFsmmetIhrkKFiqs/W
   g==;
X-CSE-ConnectionGUID: 1gbaPxgBSv6knVgDyt9aTA==
X-CSE-MsgGUID: ZFjTULYdSuqauAptsf1/1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="255159831"
X-IronPort-AV: E=Sophos;i="6.27,136,1786978800"; 
   d="scan'208";a="255159831"
Received: from gmgwnl01.global.fujitsu.com ([52.143.17.124])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 19:28:13 +0900
Received: from az2nlsmgm2.o.css.fujitsu.com (unknown [10.150.26.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwnl01.global.fujitsu.com (Postfix) with ESMTPS id 426D81C000DA;
	Fri,  2 Oct 2026 10:28:13 +0000 (UTC)
Received: from az2nlsmom4.fujitsu.com (unknown [10.150.26.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2nlsmgm2.o.css.fujitsu.com (Postfix) with ESMTPS id E3CD01C00293;
	Fri,  2 Oct 2026 10:28:12 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.124.178.20])
	by az2nlsmom4.fujitsu.com (Postfix) with ESMTP id CBB7E2018B2A;
	Fri,  2 Oct 2026 10:28:07 +0000 (UTC)
From: Tomohiro Misono <misono.tomohiro@fujitsu.com>
Date: Fri, 02 Oct 2026 19:26:51 +0900
Subject: [PATCH 3/4] perf: arm_pmu: Add workaround for FUJITSU-MONAKA
 Erratum E#030002
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-monaka-fix-for-upstream-v1-3-4aec0b0cbe34@fujitsu.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790936872; l=5266;
 i=misono.tomohiro@fujitsu.com; s=20261002; h=from:subject:message-id;
 bh=KtdDUJ8gI8pEplE4ZUe4invOYkX7dUJNfyBoNGTouOM=;
 b=Zu5m0tw/hNVRmVOGSpdfnrD/xOtTgnH/ejTt2JL3+5NNwLgeaga3J3SuPDCKNmkuvUmLU2KBQ
 GmOc9J31AFKA9zhkVsoAlAWDFiiCqoT1taG/otqc3SZj8LxMcws+O+9
X-Developer-Key: i=misono.tomohiro@fujitsu.com; a=ed25519;
 pk=VLRxj5y4GJrHLmj3e2NBg30fX2U//ydi7c2G2qiNo10=

FUJITSU-MONAKA Erratum E#030002 affects FUJITSU-MONAKA CPU.

On affected FUJITSU-MONAKA CPUs, after a PMU event counter is
stopped at a value just before overflow, an overflow might still
be incorrectly detected, resulting interrupt storm in some case.

Work around the erratum by avoiding programming PMU event counters
with values within five counts of overflow.

Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>
---
 Documentation/arch/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                          | 17 +++++++++++++++++
 arch/arm64/include/asm/cpucaps.h            |  2 ++
 arch/arm64/kernel/cpu_errata.c              | 10 ++++++++++
 arch/arm64/tools/cpucaps                    |  1 +
 drivers/perf/arm_pmu.c                      | 13 +++++++++++++
 6 files changed, 45 insertions(+)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 8ab6284e3d10..429bdf9a3d9d 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -375,6 +375,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Fujitsu        | MONAKA          | E#030001        | FUJITSU_ERRATUM_030001      |
 +----------------+-----------------+-----------------+-----------------------------+
+| Fujitsu        | MONAKA          | E#030002        | FUJITSU_ERRATUM_030002      |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | ASR            | ASR8601         | #8601001        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 38248a31d5f1..348d9836d2c2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1331,6 +1331,23 @@ config FUJITSU_ERRATUM_030001
 
 	  If unsure, say Y.
 
+config FUJITSU_ERRATUM_030002
+	bool "FUJITSU-MONAKA erratum E#030002: PMU overflow may be incorrectly detected"
+	depends on ARM_PMUV3
+	default y
+	help
+	  This option adds a workaround for FUJITSU-MONAKA erratum E#030002.
+	  On affected FUJITSU-MONAKA CPUs, after a PMU event counter is
+	  stopped at a value just before overflow, an overflow might still
+	  be incorrectly detected.
+
+	  Work around the erratum by avoiding programming PMU event counters
+	  with values within five counts of overflow.
+
+	  The workaround only affects the FUJITSU-MONAKA.
+
+	  If unsure, say Y.
+
 config HISILICON_ERRATUM_161600802
 	bool "Hip07 161600802: Erroneous redistributor VLPI base"
 	default y
diff --git a/arch/arm64/include/asm/cpucaps.h b/arch/arm64/include/asm/cpucaps.h
index 9220b917ec20..c0a0452daf94 100644
--- a/arch/arm64/include/asm/cpucaps.h
+++ b/arch/arm64/include/asm/cpucaps.h
@@ -68,6 +68,8 @@ cpucap_is_possible(const unsigned int cap)
 		return IS_ENABLED(CONFIG_ARM64_ERRATUM_4193714);
 	case ARM64_WORKAROUND_FUJITSU_030001:
 		return IS_ENABLED(CONFIG_FUJITSU_ERRATUM_030001);
+	case ARM64_WORKAROUND_FUJITSU_030002:
+		return IS_ENABLED(CONFIG_FUJITSU_ERRATUM_030002);
 	case ARM64_MPAM:
 		/*
 		 * KVM MPAM support doesn't rely on the host kernel supporting MPAM.
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 5b9dea3c761d..aa1dd1ae0f92 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -1036,6 +1036,16 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 					{}
 				})),
 	},
+#endif
+#ifdef CONFIG_FUJITSU_ERRATUM_030002
+	{
+		.desc = "FUJITSU-MONAKA Erratum E#030002",
+		.capability = ARM64_WORKAROUND_FUJITSU_030002,
+		ERRATA_MIDR_RANGE_LIST(((const struct midr_range[]) {
+					MIDR_ALL_VERSIONS(MIDR_FUJITSU_MONAKA),
+					{}
+				})),
+	},
 #endif
 	{
 		.desc = "Known broken GICv3 SEIS implementation",
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index 50a9aa0e2bf0..6bf19fc68def 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -133,3 +133,4 @@ WORKAROUND_SPECULATIVE_AT
 WORKAROUND_SPECULATIVE_SSBS
 WORKAROUND_SPECULATIVE_UNPRIV_LOAD
 WORKAROUND_FUJITSU_030001
+WORKAROUND_FUJITSU_030002
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 115069565389..c0b8580d80ba 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -234,6 +234,19 @@ int armpmu_event_set_period(struct perf_event *event)
 	if (left > (max_period >> 1))
 		left = (max_period >> 1);
 
+#if IS_ENABLED(CONFIG_ARM64)
+	if (alternative_has_cap_unlikely(ARM64_WORKAROUND_FUJITSU_030002)) {
+		/*
+		 * Due to the errata, overflow might be incorrectly detected in the handler
+		 * when the counter is about to overflow in a single increment, resulting
+		 * interrupt storm in some case. As the counter can increase by up to
+		 * 5 at a time, set 6 here to prevent the condition.
+		 */
+		if (left > 0 && left < 6)
+			left = 6;
+	}
+#endif
+
 	local64_set(&hwc->prev_count, (u64)-left);
 
 	armpmu->write_counter(event, (u64)(-left) & max_period);

-- 
2.43.0

