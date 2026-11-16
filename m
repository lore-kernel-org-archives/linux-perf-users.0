Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853354;
	b=ickUfEKx3nHTsY70tZuE6MGUIK0WA5NSddyoyNsoOGpyXdwJiIS9h7VoUA2TL3WoCWjc
	 G1/G6gFbirRDYgb7u32NO8FldD2H7fmvL5mhAzYQ7R4tucYjMZa3/N7/KmKOBaIVdA4fy
	 2ZFbm2h/ldsLR7kNPIR4ya5L5+LeKvW3kHPepdIYPQLAY/fhdkIKzmn7w4y8kl8jwt//V
	 M5Ue9oe62DpGGu9B2WAjCbxX66q7Eipee3iceiYa16rXuRoW7wYbQxd32lyV9zdJ8uvh7
	 q0F7XdE11KcP9vwQfQ5smeEHBMv/y54BzCPs8ZuL8nwj+jnLDGiBj4jAdfCCp3ODEaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853354;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=m63WKte4s9IORNVpxjjuH7OkpqsFGZBuR61gnyGpCgs=;
	b=rZlAd8KCOxB8r+w5SHjj9S7c6vPrLxCkUMe3Jd0xs0depc92V+03lIYww+JKk9OHwXRn
	 YFahpy4EdWP9vvOiGOpZP46uHKVOPpZDEfn4nrsSE6/S9eqrdjQj+ghIBrkH0qHAVE8nm
	 cNjVU4CnuzbEEroJYcK1YyX+gewYRRkpIrSgt6zeLDmmuy0A4wfe3bfOv18bTSMvagXav
	 M+d+vxkUyTCrCG483P7sPt4VGMrXo9DAnfiHAF4jeKUa2TFe0H+peoeGFAzxTUsrt3i5P
	 BEOarnRlu/Ky3zUFNwg9P4gqxdM+Q+7uVOJDcFzpb6jisxlaTxLZ96q+BPI9x/ArGGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dFp75XMZ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB64606A89D;
	Mon, 16 Nov 2026 18:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAB64606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dFp75XMZ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 262E81BB0;
	Mon, 16 Nov 2026 10:22:30 -0800 (PST)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18D363F632;
	Mon, 16 Nov 2026 10:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794853353; bh=XzdcfUdiPGJnByCnHUsJGwC84YDgumfkqI/RYHUEW9o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dFp75XMZmCvIFb7GzoTBYtubB4/B8P4utbI/gyydoxvNMcKb6m6WJosN9G02St+Z5
	 1j4TmT5UhcvMd+eumjFiev5Lw9jEH2Y7bi7hsTYgH2YlR0/Cfyp0WYPeW1L0y9W7OB
	 6eQKb3+NCjJaff2Ka8ikL3XaqLuQ8Mx8zu7xFT8c=
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 16 Nov 2026 18:21:32 +0000
Subject: [PATCH 5/8] perf/arm_pmu: Register ACPI CPU PMUs as platform
 devices
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
Message-Id: <20261116-acpi_arm_pmu_registration_hmp-v1-5-0371d4eca626@arm.com>
References: <20261116-acpi_arm_pmu_registration_hmp-v1-0-0371d4eca626@arm.com>
In-Reply-To: <20261116-acpi_arm_pmu_registration_hmp-v1-0-0371d4eca626@arm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Saravana Kannan <saravanak@kernel.org>, Will Deacon <will@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Hanjun Guo <guohanjun@huawei.com>, Jeremy Linton <jeremy.linton@arm.com>, 
 Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Sudeep Holla <sudeep.holla@kernel.org>, Rob Herring <robh@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@arm.com>, James Clark <james.clark@linaro.org>, 
 Anshuman Khandual <anshuman.khandual@arm.com>, Al Grant <al.grant@arm.com>, 
 "Johnny.Fan" <johnny.fan@cixtech.com>, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-perf-users@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794853327; l=13428;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=XzdcfUdiPGJnByCnHUsJGwC84YDgumfkqI/RYHUEW9o=;
 b=NSzGmwD7pzbX2ZXYGKt5XfYOGnryEIgahr32wRVsHVVkTqRZ9H9jV8Cy4DhoxT1QEX7CieEzy
 BKOxtWKpqm2AEgIFABmTvAHiGVp9+V1XRSkz51JMzp37An91Xypsyhc
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Register CPU PMU platform devices through arm_acpi_register_pmu_devices(),
reusing the common MIDR grouping, software-node IRQ affinity and IRQ
resource handling.

Name the ACPI platform devices and the PMUv3 driver "arm,armv8-pmuv3".
This lets the following platform-probe change match the device name
against the OF table and select armv8_pmuv3_pmu_init(), preserving the
initializer previously passed directly to arm_pmu_acpi_probe().

Keep the platform-device name outside the ARM_PMU guard so common ACPI
enumeration can use it without the CPU PMU framework.

Remove the legacy ACPI probe, pre-probe IRQ setup, dedicated CPU hotplug
state and associated declarations. Register the PMUv3 platform driver
for both DT and ACPI; the following change adds ACPI support to the
common platform probe path.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 arch/arm64/include/asm/acpi.h |   3 +
 drivers/perf/arm_pmu_acpi.c   | 307 ++++--------------------------------------
 drivers/perf/arm_pmuv3.c      |   5 +-
 include/linux/cpuhotplug.h    |   1 -
 include/linux/perf/arm_pmu.h  |  12 +-
 5 files changed, 29 insertions(+), 299 deletions(-)

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
index 8a54ca6ba60282ef503e6f900201986b55227d77..80334baa25ca32a01a693076a9ce76f20a1f765a 100644
--- a/arch/arm64/include/asm/acpi.h
+++ b/arch/arm64/include/asm/acpi.h
@@ -40,6 +40,9 @@
 	(!(entry) || (entry)->header.length < ACPI_MADT_GICC_MIN_LENGTH || \
 	(unsigned long)(entry) + (entry)->header.length > (end))
 
+#define ACPI_MADT_GICC_PMU  offsetofend(struct acpi_madt_generic_interrupt, \
+	performance_interrupt)
+
 #define ACPI_MADT_GICC_SPE  (offsetof(struct acpi_madt_generic_interrupt, \
 	spe_interrupt) + sizeof(u16))
 
diff --git a/drivers/perf/arm_pmu_acpi.c b/drivers/perf/arm_pmu_acpi.c
index 6a7fa8d01f42b1b58e28541a374f005e1955598f..642d385458a05550c63f061bf301f623ecd72253 100644
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/irqdesc.h>
-#include <linux/percpu.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
@@ -19,59 +18,6 @@
 #include <linux/string.h>
 
 #include <asm/cpu.h>
-#include <asm/cputype.h>
-
-static DEFINE_PER_CPU(struct arm_pmu *, probed_pmus);
-static DEFINE_PER_CPU(int, pmu_irqs);
-
-static int arm_pmu_acpi_register_irq(int cpu)
-{
-	struct acpi_madt_generic_interrupt *gicc;
-	int gsi;
-
-	gicc = acpi_cpu_get_madt_gicc(cpu);
-
-	gsi = gicc->performance_interrupt;
-
-	/*
-	 * Per the ACPI spec, the MADT cannot describe a PMU that doesn't
-	 * have an interrupt. QEMU advertises this by using a GSI of zero,
-	 * which is not known to be valid on any hardware despite being
-	 * valid per the spec. Take the pragmatic approach and reject a
-	 * GSI of zero for now.
-	 */
-	if (!gsi)
-		return 0;
-
-	/*
-	 * Helpfully, the MADT GICC doesn't have a polarity flag for the
-	 * "performance interrupt". Luckily, on compliant GICs the polarity is
-	 * a fixed value in HW (for both SPIs and PPIs) that we cannot change
-	 * from SW.
-	 *
-	 * Here we pass in ACPI_ACTIVE_HIGH to keep the core code happy. This
-	 * may not match the real polarity, but that should not matter.
-	 *
-	 * Other interrupt controllers are not supported with ACPI.
-	 *
-	 * The spec also indicates that the PMU interrupt can be edge
-	 * triggered, which doesn't make any sense (SW needs to clear the
-	 * interrupt condition for the level to drop). Ignore the silly flag.
-	 */
-	return acpi_register_gsi(NULL, gsi, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_HIGH);
-}
-
-static void arm_pmu_acpi_unregister_irq(int cpu)
-{
-	struct acpi_madt_generic_interrupt *gicc;
-	int gsi;
-
-	gicc = acpi_cpu_get_madt_gicc(cpu);
-
-	gsi = gicc->performance_interrupt;
-	if (gsi)
-		acpi_unregister_gsi(gsi);
-}
 
 struct arm_pmu_acpi_device_info {
 	const char *name;
@@ -364,6 +310,29 @@ arm_acpi_register_pmu_devices(const struct arm_pmu_acpi_device_info *info)
 	return nr_devices ? 0 : last_err;
 }
 
+#if IS_ENABLED(CONFIG_ARM_PMUV3)
+static u32 arm_pmu_parse_gsi(struct acpi_madt_generic_interrupt *gicc)
+{
+	return gicc->performance_interrupt;
+}
+
+static void arm_pmu_acpi_register_device(void)
+{
+	static const struct arm_pmu_acpi_device_info info = {
+		.name = ARMV8_PMU_PDEV_NAME,
+		.len = ACPI_MADT_GICC_PMU,
+		.parse_gsi = arm_pmu_parse_gsi,
+	};
+
+	if (arm_acpi_register_pmu_devices(&info))
+		pr_warn("ACPI: CPU PMU: Unable to register device\n");
+}
+#else
+static inline void arm_pmu_acpi_register_device(void)
+{
+}
+#endif
+
 #if IS_ENABLED(CONFIG_ARM_SPE_PMU)
 static u32 arm_spe_parse_gsi(struct acpi_madt_generic_interrupt *gicc)
 {
@@ -410,240 +379,12 @@ static inline void arm_trbe_acpi_register_device(void)
 }
 #endif /* CONFIG_CORESIGHT_TRBE */
 
-static int arm_pmu_acpi_parse_irqs(void)
-{
-	int irq, cpu, irq_cpu, err;
-
-	for_each_possible_cpu(cpu) {
-		irq = arm_pmu_acpi_register_irq(cpu);
-		if (irq < 0) {
-			err = irq;
-			pr_warn("Unable to parse ACPI PMU IRQ for CPU%d: %d\n",
-				cpu, err);
-			goto out_err;
-		} else if (irq == 0) {
-			pr_warn("No ACPI PMU IRQ for CPU%d\n", cpu);
-		}
-
-		/*
-		 * Log and request the IRQ so the core arm_pmu code can manage
-		 * it. We'll have to sanity-check IRQs later when we associate
-		 * them with their PMUs.
-		 */
-		per_cpu(pmu_irqs, cpu) = irq;
-		err = armpmu_request_irq(&probed_pmus, irq, cpu);
-		if (err)
-			goto out_err;
-	}
-
-	return 0;
-
-out_err:
-	for_each_possible_cpu(cpu) {
-		irq = per_cpu(pmu_irqs, cpu);
-		if (!irq)
-			continue;
-
-		arm_pmu_acpi_unregister_irq(cpu);
-
-		/*
-		 * Blat all copies of the IRQ so that we only unregister the
-		 * corresponding GSI once (e.g. when we have PPIs).
-		 */
-		for_each_possible_cpu(irq_cpu) {
-			if (per_cpu(pmu_irqs, irq_cpu) == irq)
-				per_cpu(pmu_irqs, irq_cpu) = 0;
-		}
-	}
-
-	return err;
-}
-
-static struct arm_pmu *arm_pmu_acpi_find_pmu(void)
-{
-	unsigned long cpuid = read_cpuid_id();
-	struct arm_pmu *pmu;
-	int cpu;
-
-	for_each_possible_cpu(cpu) {
-		pmu = per_cpu(probed_pmus, cpu);
-		if (!pmu || pmu->acpi_cpuid != cpuid)
-			continue;
-
-		return pmu;
-	}
-
-	return NULL;
-}
-
-/*
- * Check whether the new IRQ is compatible with those already associated with
- * the PMU (e.g. we don't have mismatched PPIs).
- */
-static bool pmu_irq_matches(struct arm_pmu *pmu, int irq)
-{
-	struct pmu_hw_events __percpu *hw_events = pmu->hw_events;
-	int cpu;
-
-	if (!irq)
-		return true;
-
-	for_each_cpu(cpu, &pmu->supported_cpus) {
-		int other_irq = per_cpu(hw_events->irq, cpu);
-		if (!other_irq)
-			continue;
-
-		if (irq == other_irq)
-			continue;
-		if (!irq_is_percpu_devid(irq) && !irq_is_percpu_devid(other_irq))
-			continue;
-
-		pr_warn("mismatched PPIs detected\n");
-		return false;
-	}
-
-	return true;
-}
-
-static void arm_pmu_acpi_associate_pmu_cpu(struct arm_pmu *pmu,
-					   unsigned int cpu)
-{
-	int irq = per_cpu(pmu_irqs, cpu);
-
-	per_cpu(probed_pmus, cpu) = pmu;
-
-	if (pmu_irq_matches(pmu, irq)) {
-		struct pmu_hw_events __percpu *hw_events;
-		hw_events = pmu->hw_events;
-		per_cpu(hw_events->irq, cpu) = irq;
-	}
-
-	cpumask_set_cpu(cpu, &pmu->supported_cpus);
-}
-
-/*
- * This must run before the common arm_pmu hotplug logic, so that we can
- * associate a CPU and its interrupt before the common code tries to manage the
- * affinity and so on.
- *
- * Note that hotplug events are serialized, so we cannot race with another CPU
- * coming up. The perf core won't open events while a hotplug event is in
- * progress.
- */
-static int arm_pmu_acpi_cpu_starting(unsigned int cpu)
-{
-	struct arm_pmu *pmu;
-
-	/* If we've already probed this CPU, we have nothing to do */
-	if (per_cpu(probed_pmus, cpu))
-		return 0;
-
-	pmu = arm_pmu_acpi_find_pmu();
-	if (!pmu) {
-		pr_warn_ratelimited("Unable to associate CPU%d with a PMU\n",
-				    cpu);
-		return 0;
-	}
-
-	arm_pmu_acpi_associate_pmu_cpu(pmu, cpu);
-	return 0;
-}
-
-static void arm_pmu_acpi_probe_matching_cpus(struct arm_pmu *pmu,
-					     unsigned long cpuid)
-{
-	int cpu;
-
-	for_each_online_cpu(cpu) {
-		unsigned long cpu_cpuid = per_cpu(cpu_data, cpu).reg_midr;
-
-		if (cpu_cpuid == cpuid)
-			arm_pmu_acpi_associate_pmu_cpu(pmu, cpu);
-	}
-}
-
-int arm_pmu_acpi_probe(armpmu_init_fn init_fn)
-{
-	int pmu_idx = 0;
-	unsigned int cpu;
-	int ret;
-
-	ret = arm_pmu_acpi_parse_irqs();
-	if (ret)
-		return ret;
-
-	ret = cpuhp_setup_state_nocalls(CPUHP_AP_PERF_ARM_ACPI_STARTING,
-					"perf/arm/pmu_acpi:starting",
-					arm_pmu_acpi_cpu_starting, NULL);
-	if (ret)
-		return ret;
-
-	/*
-	 * Initialise and register the set of PMUs which we know about right
-	 * now. Ideally we'd do this in arm_pmu_acpi_cpu_starting() so that we
-	 * could handle late hotplug, but this may lead to deadlock since we
-	 * might try to register a hotplug notifier instance from within a
-	 * hotplug notifier.
-	 *
-	 * There's also the problem of having access to the right init_fn,
-	 * without tying this too deeply into the "real" PMU driver.
-	 *
-	 * For the moment, as with the platform/DT case, we need at least one
-	 * of a PMU's CPUs to be online at probe time.
-	 */
-	for_each_online_cpu(cpu) {
-		struct arm_pmu *pmu = per_cpu(probed_pmus, cpu);
-		unsigned long cpuid;
-		char *base_name;
-
-		/* If we've already probed this CPU, we have nothing to do */
-		if (pmu)
-			continue;
-
-		pmu = armpmu_alloc();
-		if (!pmu) {
-			pr_warn("Unable to allocate PMU for CPU%d\n",
-				cpu);
-			return -ENOMEM;
-		}
-
-		cpuid = per_cpu(cpu_data, cpu).reg_midr;
-		pmu->acpi_cpuid = cpuid;
-
-		arm_pmu_acpi_probe_matching_cpus(pmu, cpuid);
-
-		ret = init_fn(pmu);
-		if (ret == -ENODEV) {
-			/* PMU not handled by this driver, or not present */
-			continue;
-		} else if (ret) {
-			pr_warn("Unable to initialise PMU for CPU%d\n", cpu);
-			return ret;
-		}
-
-		base_name = pmu->name;
-		pmu->name = kasprintf(GFP_KERNEL, "%s_%d", base_name, pmu_idx++);
-		if (!pmu->name) {
-			pr_warn("Unable to allocate PMU name for CPU%d\n", cpu);
-			return -ENOMEM;
-		}
-
-		ret = armpmu_register(pmu);
-		if (ret) {
-			pr_warn("Failed to register PMU for CPU%d\n", cpu);
-			kfree(pmu->name);
-			return ret;
-		}
-	}
-
-	return ret;
-}
-
 static int arm_pmu_acpi_init(void)
 {
 	if (acpi_disabled)
 		return 0;
 
+	arm_pmu_acpi_register_device();
 	arm_spe_acpi_register_device();
 	arm_trbe_acpi_register_device();
 
diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 03359e078301f85f3bb1beca2b346aa29c822cc8..b0ca236d37e1c8efd859b89a524910a42cf2b062 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1636,10 +1636,7 @@ static int __init armv8_pmu_driver_init(void)
 {
 	int ret;
 
-	if (acpi_disabled)
-		ret = platform_driver_register(&armv8_pmu_driver);
-	else
-		ret = arm_pmu_acpi_probe(armv8_pmuv3_pmu_init);
+	ret = platform_driver_register(&armv8_pmu_driver);
 
 	if (!ret)
 		lockup_detector_retry_init();
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 1b6dba159bb23cf5e6ba312d1e44c7665edadc88..9cefaecbecbe604def627fb07cc3411dee35c90c 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -154,7 +154,6 @@ enum cpuhp_state {
 	CPUHP_AP_ARM_VFP_STARTING,
 	CPUHP_AP_ARM64_DEBUG_MONITORS_STARTING,
 	CPUHP_AP_PERF_ARM_HW_BREAKPOINT_STARTING,
-	CPUHP_AP_PERF_ARM_ACPI_STARTING,
 	CPUHP_AP_PERF_ARM_STARTING,
 	CPUHP_AP_PERF_RISCV_STARTING,
 	CPUHP_AP_ARM_L2X0_STARTING,
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 02d2c7f45b527d024e60415b11359d346b63cfe8..28c8672b71e24c4298375c17c8788f6ccdae6040 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -126,9 +126,6 @@ struct arm_pmu {
 	DECLARE_BITMAP(pmceid_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
 #define ARMV8_PMUV3_EXT_COMMON_EVENT_BASE	0x4000
 	DECLARE_BITMAP(pmceid_ext_bitmap, ARMV8_PMUV3_MAX_COMMON_EVENTS);
-
-	/* Only to be used by ACPI probing code */
-	unsigned long acpi_cpuid;
 };
 
 #define to_arm_pmu(p) (container_of(p, struct arm_pmu, pmu))
@@ -171,12 +168,6 @@ int arm_pmu_device_probe(struct platform_device *pdev,
 			 const struct of_device_id *of_table,
 			 const struct pmu_probe_info *probe_table);
 
-#ifdef CONFIG_ACPI
-int arm_pmu_acpi_probe(armpmu_init_fn init_fn);
-#else
-static inline int arm_pmu_acpi_probe(armpmu_init_fn init_fn) { return 0; }
-#endif
-
 #ifdef CONFIG_KVM
 void kvm_host_pmu_init(struct arm_pmu *pmu);
 #else
@@ -192,10 +183,9 @@ int armpmu_register(struct arm_pmu *pmu);
 int armpmu_request_irq(struct arm_pmu * __percpu *armpmu, int irq, int cpu);
 void armpmu_free_irq(struct arm_pmu * __percpu *armpmu, int irq, int cpu);
 
-#define ARMV8_PMU_PDEV_NAME "armv8-pmu"
-
 #endif /* CONFIG_ARM_PMU */
 
+#define ARMV8_PMU_PDEV_NAME "arm,armv8-pmuv3"
 #define ARMV8_SPE_PDEV_NAME "arm,spe-v1"
 #define ARMV8_TRBE_PDEV_NAME "arm,trbe"
 

-- 
2.34.1

