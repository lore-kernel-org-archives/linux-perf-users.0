Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=139.138.61.253
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079134;
	b=v/THHoaC/2QfJDYxaTV+J/aVUR6sCki1Kn5aGuWFRDXpkVzI01H3vvJRmcpjEepBAhEF
	 tO2NNmK+NM5W4pdnIsMEIzv5LvTItTzAzCeHl/q+/1QwLrbi81hEh4wB0HpdwF8FeBwyN
	 igyE0BxdiEbPqDHrFW39X+46SzPYmdV6jshfK/90W5h9YtDqeIVHHUJB34vHDWirUW0+Q
	 2xaeaRmrL388dHW8q1QNIehirAqSE6gmLV4xzvW5Q39QpUKUDNHXWhwb/FI7YNLSUVeKF
	 hUNP2jZkbgGc5JS/hrEJpe3xGH3qBMRXRVmvzIeI8wPw/AATeysXGejbwXEymJkHR4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079134;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Received:Received:From:
	 Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=FF/80+RBUBxw5mWtW2KS5XSxoiO6Z7IYFbfOuIvu2Ac=;
	b=o48mGD98hUPBFIU8LJ4cEB3d3iy95X5JkIsEiq0nzq7PhI8uHaP9+HcJVgNE0+0BebNi
	 1OPusDviHchF/PXD9pRAzjA6Yzz5dufntNto2KtgdUkGPN3u9aaf5U1LMtaeZ7y2yCsSl
	 AYyL93aVzMRv0KQocHmveGHBXxcgXnZ/MdEBv8B1cjW6hzZqKh4lR/1xwz0gn3+HuB+Ta
	 OiKG7fPWaS1ZZ5PDlVqfPsz8XAHSjTwT5rNMizb3smOVeF4jK2DFjPiSX5/Py5uJxU8A4
	 PC7Iu+53B9asxSXVlG3gc4wB1cY/SaoVZ+7D45C/05j2Nin4NEGy/NZhn6j+LGhWgSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fujitsu.com;
	spf=pass smtp.mailfrom=fujitsu.com;
	dkim=pass header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=OoemFBw3;
	arc=none smtp.remote-ip=139.138.61.253
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0120160A2614;
	Thu, 19 Nov 2026 09:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0120160A2614
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=OoemFBw3
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1795079140; x=1826615140;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=doMhYgkYumk/+/XY9c0OXwpBFMZB2Q8qiBe5sUKK3+Q=;
  b=OoemFBw3GYgwcAS3ACRilget7E8dlgQU6Cp7INXqc64xC6f4iTaqXb8l
   LanTvlaGj1iaGxJBXm3hbztyb52ae+OVOd36k+cbZZpdWeY2a1dSMsPjO
   rR15k35NWaiMaW/lvTAcBmWy3FEQdGvXbA32LNOPKbfN/o6n9bXWeqDaY
   vYcjc3kH6cNeLdYGX4mhr312BSiAxUQiXwdDyV6HIGsTUceaBWbtp8I/w
   lhybvn9/8FGcWTGPrvsoF9C/Kmwk7K+9n/x1w+slQayjSv+jeme5IMtoH
   4S5KA3j8nVjMiIcASts9+aZ7Y33qne9FJ6JwSVDGk+6TLRmrqKxoEQ6fz
   g==;
X-CSE-ConnectionGUID: ehIC+nLiQMqOOCJn8KyFDQ==
X-CSE-MsgGUID: f6kNwwncRuOaAPFYXxQedg==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="250354582"
X-IronPort-AV: E=Sophos;i="6.27,220,1786978800"; 
   d="scan'208";a="250354582"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 18:05:38 +0900
Received: from az2uksmgm1.o.css.fujitsu.com (unknown [10.151.22.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 62E27C0368F;
	Thu, 19 Nov 2026 09:05:30 +0000 (UTC)
Received: from az2uksmom3.o.css.fujitsu.com (unknown [10.151.22.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm1.o.css.fujitsu.com (Postfix) with ESMTPS id 0A1D68D29E5;
	Thu, 19 Nov 2026 09:05:30 +0000 (UTC)
Received: from [127.0.1.1] (unknown [10.124.178.20])
	by az2uksmom3.o.css.fujitsu.com (Postfix) with ESMTP id 729FA1001166;
	Thu, 19 Nov 2026 09:05:22 +0000 (UTC)
From: Tomohiro Misono <misono.tomohiro@fujitsu.com>
Date: Thu, 19 Nov 2026 18:04:36 +0900
Subject: [PATCH v3 4/5] irqchip/gicv3: Add workaround for FUJITSU-MONAKA
 Erratum E#030003
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
Message-Id: <20261119-monaka-fix-for-upstream-v3-4-057df4d2ca3c@fujitsu.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795079092; l=5351;
 i=misono.tomohiro@fujitsu.com; s=20261002; h=from:subject:message-id;
 bh=BC5dTRfHfZlF2iCc7SBol6JXhnpQnG/aQ//ezaBWl+I=;
 b=vfU+0IA2fhy3UzVfpXqM9u6G3+iNGf0bGLxODcXQALoi+CiZGnSTZDpOOpNkV7t/FmzvCzBox
 mTGQewl0/AQBGE46EzU4OlPsJLCOZ7huh6dNfizInM/urs5eICGiPXn
X-Developer-Key: i=misono.tomohiro@fujitsu.com; a=ed25519;
 pk=VLRxj5y4GJrHLmj3e2NBg30fX2U//ydi7c2G2qiNo10=

From: Kohei Enju <enju.kohei@fujitsu.com>

On affected FUJITSU-MONAKA CPUs, the erratum may occur when an SGI is
generated by writing to ICC_SGI0R_EL1, ICC_SGI1R_EL1, or ICC_ASGI1R_EL1,
if the operation races with CPU interface processing triggered by the
arrival of a higher-priority interrupt, an update to a pending
interrupt, or a transition of the PE to the Sleep state. When the
erratum occurs, the SGI is lost and the system register write does not
complete, causing the issuing core to hang.

Guest accesses to these registers are not affected by this erratum, as
they are trapped to EL2 and handled without issuing the affected system
register write.

Work around the erratum by writing 1 to the bit corresponding to the
target SGI INTID in GICR_ISPENDR0 of each target PE's GIC Redistributor,
instead of writing to the affected system registers.

Accessing a target PE's GICR_ISPENDR0 requires its Redistributor base to
have been discovered. Affected platforms conform to SBBR, which requires
PSCI for secondary CPU boot. They therefore do not use the ACPI Parking
protocol, which sends an IPI before the secondary CPU has initialized
its Redistributor. With PSCI, a secondary CPU discovers its
Redistributor before becoming an IPI target.

Signed-off-by: Kohei Enju <enju.kohei@fujitsu.com>
Signed-off-by: Tomohiro Misono <misono.tomohiro@fujitsu.com>
---
Changes in v3:
- Remove the unnecessary DSB after writes to GICR_ISPENDR0.
- Fix build issue when CONFIG_ARM=y.
- Add an SoB of Tomohiro.

Changes in v2:
- Clarify the erratum description and document that virtual accesses are
  unaffected.
- Remove the gic_send_sgi_via_rdist() helper.
- Remove the write-count rationale.
- Use the CPU MIDR instead of the SoC ID for filtering.
---
 Documentation/arch/arm64/silicon-errata.rst |  2 ++
 drivers/irqchip/irq-gic-v3.c                | 35 +++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index 65bbdaf1f925..df57078d3727 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -397,6 +397,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Fujitsu        | MONAKA          | E#030002        | FUJITSU_ERRATUM_030002      |
 +----------------+-----------------+-----------------+-----------------------------+
+| Fujitsu        | MONAKA GICv3/v4 | E#030003        | N/A                         |
++----------------+-----------------+-----------------+-----------------------------+
 +----------------+-----------------+-----------------+-----------------------------+
 | ASR            | ASR8601         | #8601001        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 94873646d46f..18f8b2b40543 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -80,6 +80,8 @@ static DEFINE_STATIC_KEY_FALSE(gic_nvidia_t241_erratum);
 
 static DEFINE_STATIC_KEY_FALSE(gic_arm64_2941627_erratum);
 
+static DEFINE_STATIC_KEY_FALSE(gic_fujitsu_030003_erratum);
+
 static struct gic_chip_data gic_data __read_mostly;
 static DEFINE_STATIC_KEY_TRUE(supports_deactivate_key);
 
@@ -240,6 +242,9 @@ static DEFINE_PER_CPU(bool, has_rss);
 #define gic_data_rdist()		(this_cpu_ptr(gic_data.rdists.rdist))
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
 #define gic_data_rdist_sgi_base()	(gic_data_rdist_rd_base() + SZ_64K)
+#define gic_data_rdist_cpu(cpu)		(per_cpu_ptr(gic_data.rdists.rdist, cpu))
+#define gic_data_rdist_rd_base_cpu(cpu)	(gic_data_rdist_cpu(cpu)->rd_base)
+#define gic_data_rdist_sgi_base_cpu(cpu)	(gic_data_rdist_rd_base_cpu(cpu) + SZ_64K)
 
 /* Our default, arbitrary priority value. Linux only uses one anyway. */
 #define DEFAULT_PMR_VALUE	0xf0
@@ -1388,6 +1393,16 @@ static void gic_ipi_send_mask(struct irq_data *d, const struct cpumask *mask)
 	 */
 	dsb(ishst);
 
+	if (static_branch_unlikely(&gic_fujitsu_030003_erratum)) {
+		for_each_cpu(cpu, mask) {
+			void __iomem *base = gic_data_rdist_sgi_base_cpu(cpu);
+
+			writel_relaxed(BIT(d->hwirq), base + GICR_ISPENDR0);
+		}
+
+		return;
+	}
+
 	for_each_cpu(cpu, mask) {
 		u64 cluster_id = MPIDR_TO_SGI_CLUSTER_ID(gic_cpu_to_affinity(cpu));
 		u16 tlist;
@@ -1874,6 +1889,18 @@ static bool gic_enable_quirk_rk3399(void *data)
 	return false;
 }
 
+#ifdef CONFIG_ARM64
+static bool gic_enable_quirk_fujitsu_030003(void *data)
+{
+	if (read_cpuid_implementor() != ARM_CPU_IMP_FUJITSU ||
+	    read_cpuid_part_number() != FUJITSU_CPU_PART_MONAKA)
+		return false;
+
+	static_branch_enable(&gic_fujitsu_030003_erratum);
+	return true;
+}
+#endif
+
 static bool rd_set_non_coherent(void *data)
 {
 	struct gic_chip_data *d = data;
@@ -1954,6 +1981,14 @@ static const struct gic_quirk gic_quirks[] = {
 		.mask	= 0xff000fff,
 		.init	= gic_enable_quirk_rk3399,
 	},
+#ifdef CONFIG_ARM64
+	{
+		.desc	= "GICv3: FUJITSU-MONAKA Erratum E#030003",
+		.iidr	= 0x0403043b,
+		.mask	= 0xffffffff,
+		.init	= gic_enable_quirk_fujitsu_030003,
+	},
+#endif
 	{
 	}
 };

-- 
2.43.0

