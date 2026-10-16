Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EBB415F1F;
	Fri, 16 Oct 2026 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144978; cv=none; b=iRpfazUXKsIZFaEBp05rS4iHGRaAnLnfsgoDSgB8Psgj18KRAu+u2LYNu3x71GgD4Pny5iDe1ocVL40+Zm1f/4D97XbomOvkBZkx08SXQ1PqbyQUrVX+NkSfeQh+ytR5cOf6xhEI9yHVo40G8NaTAt+7QUqK+ickTqHusYv+I9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144978; c=relaxed/simple;
	bh=COlFLRoBfVMLjQUEyASCKsIINgA9dPGyboyYG0+99IM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eIS9rUTwYew0XU8HAV8cT0pBViHfvh6gZWj1ewFzl5ZHpB7pjI2ZKQvumeGZB42HAi/GvUZp+oGTL9xaueuiXdWAy8/aYs8j7WM/2JdeCVLsDwG8bWbSRb5r2xssQyzeddON9zr4NKXRFwA2rKQNxviQZmctZPBvVMvJw+9w7yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=epE+qVPy; arc=none smtp.client-ip=139.138.61.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="epE+qVPy"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1792144976; x=1823680976;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=COlFLRoBfVMLjQUEyASCKsIINgA9dPGyboyYG0+99IM=;
  b=epE+qVPyjg8BP3o2dVrDMgQJhT8E6vLnr7IEI38QO6IxDmxxFKz4swCy
   vyGU3QTqCJhbPivjxHEgQeetLXqXyGoYig4HGVhw/TASyjIAASWdBNU9s
   kdlUYLAWpRoYiturJIy3MWnOLSyczloMxMKSAXUloW+baAj/F2mroA16z
   mUKPidkWZL/bKmZCAXpmXluK/e12hA1SudVfqYIWkRuO7MoBh4vMlQIJe
   F551OEJQEpQOA29je8My7ZlIUU+sqsF1Eh5XLmyIi/vjDSBmVoKjUf2s2
   in64RgUMMs4PPsNGI+nv+2zM0Qlk38KUo3IpDhmYScUmIfrZFoMnw7dh1
   A==;
X-CSE-ConnectionGUID: 5s0raHtOTpOeORHjZptYGg==
X-CSE-MsgGUID: XYtgvdjoTiiJMZtwcj7ORw==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="237330245"
X-IronPort-AV: E=Sophos;i="6.27,161,1786978800"; 
   d="scan'208";a="237330245"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2026 19:01:44 +0900
Received: from az2uksmgm1.o.css.fujitsu.com (unknown [10.151.22.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 185CF821112;
	Fri, 16 Oct 2026 10:01:44 +0000 (UTC)
Received: from az2nlsmom3.fujitsu.com (unknown [10.150.26.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id BF4E992677E;
	Fri, 16 Oct 2026 10:01:43 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.124.178.20])
	by az2nlsmom3.fujitsu.com (Postfix) with ESMTP id 84854100150B;
	Fri, 16 Oct 2026 10:01:36 +0000 (UTC)
From: Tomohiro Misono <misono.tomohiro@fujitsu.com>
Date: Fri, 16 Oct 2026 19:00:47 +0900
Subject: [PATCH v2 3/4] perf: arm_pmu: Add workaround for FUJITSU-MONAKA
 Erratum E#030002
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-monaka-fix-for-upstream-v2-3-fc7ede7f9f48@fujitsu.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792144875; l=6036;
 i=misono.tomohiro@fujitsu.com; s=20261002; h=from:subject:message-id;
 bh=COlFLRoBfVMLjQUEyASCKsIINgA9dPGyboyYG0+99IM=;
 b=UGQzN9ynuh/n6haciNhTj+xEq3pai5qyEWFAOpE3tJtjrqMsfeVdp6CFr8kNwybZtu3LALqkO
 e4JYNQEpZGxAy8GnvS1lTJEp++DWy9oK+bk1DYukSrjoo1dHIF6Gbja
X-Developer-Key: i=misono.tomohiro@fujitsu.com; a=ed25519;
 pk=VLRxj5y4GJrHLmj3e2NBg30fX2U//ydi7c2G2qiNo10=

FUJITSU-MONAKA Erratum E#030002 affects FUJITSU-MONAKA CPU.

On affected FUJITSU-MONAKA CPUs, after a PMU event counter is
stopped at a value just before overflow, an overflow might still
be incorrectly detected, resulting interrupt storm in some case.

For example, if the following conditions are met:
  1) Running perf to count an event in user space only
  2) The event can also occur in kernel space
  3) The counter value is set just before the overflow
     (when using the -F option, initial counter value is -1)

when the kernel is about to return to user space after enabling
the count, an overflow interrupt is incorrectly triggered by an
event that occurred in kernel space. Since the counter value is
not updated (correctly), the interrupt handler does nothing and
returns with the same condition. This leads to another wrong interrupt
and results in an interrupt storm and eventually a softlockup.

Work around the erratum by avoiding programming PMU event counters
with values within five counts of overflow.

Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>

---
Changes in v2:
- Add user impact explanation in the commit message
---
---
 Documentation/arch/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                          | 17 +++++++++++++++++
 arch/arm64/include/asm/cpucaps.h            |  2 ++
 arch/arm64/kernel/cpu_errata.c              | 10 ++++++++++
 arch/arm64/tools/cpucaps                    |  1 +
 drivers/perf/arm_pmu.c                      | 13 +++++++++++++
 6 files changed, 45 insertions(+)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 527af20b26468..0efb24ec01b4c 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -377,6 +377,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Fujitsu        | MONAKA          | E#030001        | FUJITSU_ERRATUM_030001      |
 +----------------+-----------------+-----------------+-----------------------------+
+| Fujitsu        | MONAKA          | E#030002        | FUJITSU_ERRATUM_030002      |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | ASR            | ASR8601         | #8601001        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5d1a17ab0f593..43fd265156e46 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1361,6 +1361,23 @@ config FUJITSU_ERRATUM_030001
 
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
index 9220b917ec207..c0a0452daf949 100644
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
index a11135f83e858..6363b694b4478 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -1048,6 +1048,16 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
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
index 1e57a0105395b..ef8ce70ab7121 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -133,3 +133,4 @@ WORKAROUND_SPECULATIVE_SSBS
 WORKAROUND_SPECULATIVE_UNPRIV_LOAD
 WORKAROUND_BROKEN_AMU_CONSTCNT
 WORKAROUND_FUJITSU_030001
+WORKAROUND_FUJITSU_030002
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 1150695653892..c0b8580d80bae 100644
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

