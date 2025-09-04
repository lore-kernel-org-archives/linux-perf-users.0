Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1596B1EBA07;
	Thu,  4 Sep 2025 02:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756952030; cv=none; b=teVXmMr32ndSlNQi0nxAZ6NGptgjkDPTiB6R987eUXLiMgGUhAji+b3Jg4DZ0ZshRXOeuMJG9NBBdUEXxcNEVTJ6awgEUV0MjBmTCF/UOXLRXjADdzGsnBJFFOXN4HGNQOr0m03b9o0oEJWKETYoClBHp45VicZmxQVu7GMmLGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756952030; c=relaxed/simple;
	bh=XifEQaEwL+l6vZkDls8pq+6stCZBSvWTzAx4W5FKgck=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=d9TvnX2BaS+WKgSkwmQ69PZKNi1GR7Oa84YDkNnGfO1/4uOMek3E3C1jRkM21svZnq/7wQHdpToCb+TQ0suziwO+Unb0MkGagAyvNa2uvBvPy8e3gbzAnCdrcA7JnnJeV7CibgIZGWs2G9V0Pjo8X+TQcB2UiRBIZu9BR3RYjig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=Zm3FlERj; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="Zm3FlERj"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1756952027; x=1788488027;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XifEQaEwL+l6vZkDls8pq+6stCZBSvWTzAx4W5FKgck=;
  b=Zm3FlERjIK5O2LjYqWa09XRkkGqUhrMBePtPq3WE5ypOuIcJEMgblcbl
   oMDuf/o8Zd5/Qme1AE2MhqsAfneKBszyLXsGjN+AutdJSNrKep+cn2drZ
   lr8k+b2tsbhNlw13N3mmFhjqIik7OICBsS4T3Xc0nY9U7IOjG6UpgtxXR
   N72/8BFXNIHmqlx2hf2puzsrb2rocPOamvLGHpx3Osg1rXrk6KsfgSpdi
   FbK0VaWqqL7mD0xYlsDgSXg1z9ogS3ejK+u/1rpBdk8EymnYyKBrSbNt2
   5ksy1g6noCzUeaPju3+N7mINhjsj8CFurTtARNBIV2NIQ3fsr57UnOT8x
   A==;
X-CSE-ConnectionGUID: iigUJMAuTdyJ4hIPhEcgtA==
X-CSE-MsgGUID: xv4n19xyRziAiW4PtIN+Iw==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="199600381"
X-IronPort-AV: E=Sophos;i="6.18,237,1751209200"; 
   d="scan'208";a="199600381"
Received: from unknown (HELO az2uksmgr2.o.css.fujitsu.com) ([52.151.125.128])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 11:13:45 +0900
Received: from az2uksmgm4.o.css.fujitsu.com (unknown [10.151.22.201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgr2.o.css.fujitsu.com (Postfix) with ESMTPS id 161068204CC;
	Thu,  4 Sep 2025 02:13:45 +0000 (UTC)
Received: from az2uksmom2.o.css.fujitsu.com (az2uksmom2.o.css.fujitsu.com [10.151.22.203])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by az2uksmgm4.o.css.fujitsu.com (Postfix) with ESMTPS id C940314A5034;
	Thu,  4 Sep 2025 02:13:44 +0000 (UTC)
Received: from sm-arm-grace07.ssoft.mng.com (sm-x86-stp01.soft.fujitsu.com [10.124.178.20])
	by az2uksmom2.o.css.fujitsu.com (Postfix) with ESMTP id CD60414002E7;
	Thu,  4 Sep 2025 02:13:38 +0000 (UTC)
From: Koichi Okuno <fj2767dz@fujitsu.com>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Gowthami Thiagarajan <gthiagarajan@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Koichi Okuno <fj2767dz@fujitsu.com>
Subject: [PATCH v8] perf: Fujitsu: Add the Uncore PMU driver
Date: Thu,  4 Sep 2025 11:12:31 +0900
Message-ID: <20250904021315.353541-1-fj2767dz@fujitsu.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds a new dynamic PMU to the Perf Events framework to program and
control the Uncore PMUs in Fujitsu chips.

This driver exports formatting and event information to sysfs so it can
be used by the perf user space tools with the syntaxes:

perf stat -e pci_iod0_pci0/ea-pci/ ls
perf stat -e pci_iod0_pci0/event=0x80/ ls
perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
perf stat -e mac_iod0_mac0_ch0/event=0x80/ ls

FUJITSU-MONAKA PMU Events Specification v1.1 URL:
https://github.com/fujitsu/FUJITSU-MONAKA

Signed-off-by: Koichi Okuno <fj2767dz@fujitsu.com>
---
Changes in v8:
- Modify the code as suggested.
  - This driver has been modularized.
  - The MAC PMU driver and PCI PMU driver have been integrated into a single driver.
  - Adding irq_set_affinity() Calls.
  - I have addressed the other feedback.
- Link to v7: https://lore.kernel.org/all/20250815034751.3726963-1-fj2767dz@fujitsu.com/

 .../admin-guide/perf/fujitsu_uncore_pmu.rst   | 110 ++++
 Documentation/admin-guide/perf/index.rst      |   1 +
 drivers/perf/Kconfig                          |   9 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/fujitsu_uncore_pmu.c             | 611 ++++++++++++++++++
 5 files changed, 732 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst
 create mode 100644 drivers/perf/fujitsu_uncore_pmu.c

diff --git a/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst b/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst
new file mode 100644
index 000000000000..46595b788d3a
--- /dev/null
+++ b/Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst
@@ -0,0 +1,110 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+================================================
+Fujitsu Uncore Performance Monitoring Unit (PMU)
+================================================
+
+This driver supports the Uncore MAC PMUs and the Uncore PCI PMUs found
+in Fujitsu chips.
+Each MAC PMU on these chips is exposed as a uncore perf PMU with device name
+mac_iod<iod>_mac<mac>_ch<ch>.
+And each PCI PMU on these chips is exposed as a uncore perf PMU with device name
+pci_iod<iod>_pci<pci>.
+
+The driver provides a description of its available events and configuration
+options in sysfs, see /sys/bus/event_sources/devices/mac_iod<iod>_mac<mac>_ch<ch>/
+and /sys/bus/event_sources/devices/pci_iod<iod>_pci<pci>/.
+This driver exports:
+- formats, used by perf user space and other tools to configure events
+- events, used by perf user space and other tools to create events
+  symbolically, e.g.:
+    perf stat -a -e mac_iod0_mac0_ch0/event=0x21/ ls
+    perf stat -a -e pci_iod0_pci0/event=0x24/ ls
+- cpumask, used by perf user space and other tools to know on which CPUs
+  to open the events
+
+This driver supports the following events for MAC:
+- cycles
+  This event counts MAC cycles at MAC frequency.
+- read-count
+  This event counts the number of read requests to MAC.
+- read-count-request
+  This event counts the number of read requests including retry to MAC.
+- read-count-return
+  This event counts the number of responses to read requests to MAC.
+- read-count-request-pftgt
+  This event counts the number of read requests including retry with PFTGT
+  flag.
+- read-count-request-normal
+  This event counts the number of read requests including retry without PFTGT
+  flag.
+- read-count-return-pftgt-hit
+  This event counts the number of responses to read requests which hit the
+  PFTGT buffer.
+- read-count-return-pftgt-miss
+  This event counts the number of responses to read requests which miss the
+  PFTGT buffer.
+- read-wait
+  This event counts outstanding read requests issued by DDR memory controller
+  per cycle.
+- write-count
+  This event counts the number of write requests to MAC (including zero write,
+  full write, partial write, write cancel).
+- write-count-write
+  This event counts the number of full write requests to MAC (not including
+  zero write).
+- write-count-pwrite
+  This event counts the number of partial write requests to MAC.
+- memory-read-count
+  This event counts the number of read requests from MAC to memory.
+- memory-write-count
+  This event counts the number of full write requests from MAC to memory.
+- memory-pwrite-count
+  This event counts the number of partial write requests from MAC to memory.
+- ea-mac
+  This event counts energy consumption of MAC.
+- ea-memory
+  This event counts energy consumption of memory.
+- ea-memory-mac-write
+  This event counts the number of write requests from MAC to memory.
+- ea-ha
+  This event counts energy consumption of HA.
+
+  'ea' is the abbreviation for 'Energy Analyzer'.
+
+Examples for use with perf::
+
+  perf stat -e mac_iod0_mac0_ch0/ea-mac/ ls
+
+And, this driver supports the following events for PCI:
+- pci-port0-cycles
+  This event counts PCI cycles at PCI frequency in port0.
+- pci-port0-read-count
+  This event counts read transactions for data transfer in port0.
+- pci-port0-read-count-bus
+  This event counts read transactions for bus usage in port0.
+- pci-port0-write-count
+  This event counts write transactions for data transfer in port0.
+- pci-port0-write-count-bus
+  This event counts write transactions for bus usage in port0.
+- pci-port1-cycles
+  This event counts PCI cycles at PCI frequency in port1.
+- pci-port1-read-count
+  This event counts read transactions for data transfer in port1.
+- pci-port1-read-count-bus
+  This event counts read transactions for bus usage in port1.
+- pci-port1-write-count
+  This event counts write transactions for data transfer in port1.
+- pci-port1-write-count-bus
+  This event counts write transactions for bus usage in port1.
+- ea-pci
+  This event counts energy consumption of PCI.
+
+  'ea' is the abbreviation for 'Energy Analyzer'.
+
+Examples for use with perf::
+
+  perf stat -e pci_iod0_pci0/ea-pci/ ls
+
+Given that these are uncore PMUs the driver does not support sampling, therefore
+"perf record" will not work. Per-task perf sessions are not supported.
diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index 072b510385c4..47d9a3df6329 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -29,3 +29,4 @@ Performance monitor support
    cxl
    ampere_cspmu
    mrvl-pem-pmu
+   fujitsu_uncore_pmu
diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index a9188dec36fe..638321fc9800 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -178,6 +178,15 @@ config FSL_IMX9_DDR_PMU
 	 can give information about memory throughput and other related
 	 events.
 
+config FUJITSU_UNCORE_PMU
+	tristate "Fujitsu Uncore PMU"
+	depends on (ARM64 && ACPI) || (COMPILE_TEST && 64BIT)
+	 help
+	 Provides support for the Uncore performance monitor unit (PMU)
+	 in Fujitsu processors.
+	 Adds the Uncore PMU into the perf events subsystem for
+	 monitoring Uncore events.
+
 config QCOM_L2_PMU
 	bool "Qualcomm Technologies L2-cache PMU"
 	depends on ARCH_QCOM && ARM64 && ACPI
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 192fc8b16204..ea52711a87e3 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_ARM_XSCALE_PMU) += arm_xscale_pmu.o
 obj-$(CONFIG_ARM_SMMU_V3_PMU) += arm_smmuv3_pmu.o
 obj-$(CONFIG_FSL_IMX8_DDR_PMU) += fsl_imx8_ddr_perf.o
 obj-$(CONFIG_FSL_IMX9_DDR_PMU) += fsl_imx9_ddr_perf.o
+obj-$(CONFIG_FUJITSU_UNCORE_PMU) += fujitsu_uncore_pmu.o
 obj-$(CONFIG_HISI_PMU) += hisilicon/
 obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
diff --git a/drivers/perf/fujitsu_uncore_pmu.c b/drivers/perf/fujitsu_uncore_pmu.c
new file mode 100644
index 000000000000..e0ea9f4cd82d
--- /dev/null
+++ b/drivers/perf/fujitsu_uncore_pmu.c
@@ -0,0 +1,611 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for the Uncore PMUs in Fujitsu chips.
+ *
+ * See Documentation/admin-guide/perf/fujitsu_uncore_pmu.rst for more details.
+ *
+ * Copyright (c) 2025 Fujitsu. All rights reserved.
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/list.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/perf_event.h>
+#include <linux/platform_device.h>
+
+/* Number of counters on each PMU */
+#define MAC_NUM_COUNTERS  8
+#define PCI_NUM_COUNTERS  8
+/* Mask for the event type field within perf_event_attr.config and EVTYPE reg */
+#define UNCORE_EVTYPE_MASK   0xFF
+
+/* Perfmon registers */
+#define PM_EVCNTR(__cntr)           (0x000 + (__cntr) * 8)
+#define PM_CNTCTL(__cntr)           (0x100 + (__cntr) * 8)
+#define PM_CNTCTL_RESET             0
+#define PM_EVTYPE(__cntr)           (0x200 + (__cntr) * 8)
+#define PM_EVTYPE_EVSEL(__val)      FIELD_GET(UNCORE_EVTYPE_MASK, __val)
+#define PM_CR                       0x400
+#define PM_CR_RESET                 BIT(1)
+#define PM_CR_ENABLE                BIT(0)
+#define PM_CNTENSET                 0x410
+#define PM_CNTENSET_IDX(__cntr)     BIT(__cntr)
+#define PM_CNTENCLR                 0x418
+#define PM_CNTENCLR_IDX(__cntr)     BIT(__cntr)
+#define PM_CNTENCLR_RESET           0xFF
+#define PM_INTENSET                 0x420
+#define PM_INTENSET_IDX(__cntr)     BIT(__cntr)
+#define PM_INTENCLR                 0x428
+#define PM_INTENCLR_IDX(__cntr)     BIT(__cntr)
+#define PM_INTENCLR_RESET           0xFF
+#define PM_OVSR                     0x440
+#define PM_OVSR_OVSRCLR_RESET       0xFF
+
+enum fujitsu_uncore_pmu {
+	FUJITSU_UNCORE_PMU_MAC = 1,
+	FUJITSU_UNCORE_PMU_PCI = 2,
+};
+
+struct uncore_pmu {
+	int			num_counters;
+	struct pmu		pmu;
+	struct hlist_node	node;
+	void __iomem		*regs;
+	struct perf_event	**events;
+	unsigned long		*used_mask;
+	int			cpu;
+	int			irq;
+	struct device		*dev;
+};
+
+#define to_uncore_pmu(p) (container_of(p, struct uncore_pmu, pmu))
+
+static int uncore_pmu_cpuhp_state;
+
+static void fujitsu_uncore_counter_start(struct perf_event *event)
+{
+	struct uncore_pmu *uncorepmu = to_uncore_pmu(event->pmu);
+	int idx = event->hw.idx;
+
+	/* Initialize the hardware counter and reset prev_count*/
+	local64_set(&event->hw.prev_count, 0);
+	writeq_relaxed(0, uncorepmu->regs + PM_EVCNTR(idx));
+
+	/* Set the event type */
+	writeq_relaxed(PM_EVTYPE_EVSEL(event->attr.config), uncorepmu->regs + PM_EVTYPE(idx));
+
+	/* Enable interrupt generation by this counter */
+	writeq_relaxed(PM_INTENSET_IDX(idx), uncorepmu->regs + PM_INTENSET);
+
+	/* Finally, enable the counter */
+	writeq_relaxed(PM_CNTCTL_RESET, uncorepmu->regs + PM_CNTCTL(idx));
+	writeq_relaxed(PM_CNTENSET_IDX(idx), uncorepmu->regs + PM_CNTENSET);
+}
+
+static void fujitsu_uncore_counter_stop(struct perf_event *event)
+{
+	struct uncore_pmu *uncorepmu = to_uncore_pmu(event->pmu);
+	int idx = event->hw.idx;
+
+	/* Disable the counter */
+	writeq_relaxed(PM_CNTENCLR_IDX(idx), uncorepmu->regs + PM_CNTENCLR);
+
+	/* Disable interrupt generation by this counter */
+	writeq_relaxed(PM_INTENCLR_IDX(idx), uncorepmu->regs + PM_INTENCLR);
+}
+
+static void fujitsu_uncore_counter_update(struct perf_event *event)
+{
+	struct uncore_pmu *uncorepmu = to_uncore_pmu(event->pmu);
+	int idx = event->hw.idx;
+	u64 prev, new;
+
+	do {
+		prev = local64_read(&event->hw.prev_count);
+		new = readq_relaxed(uncorepmu->regs + PM_EVCNTR(idx));
+	} while (local64_cmpxchg(&event->hw.prev_count, prev, new) != prev);
+
+	local64_add(new - prev, &event->count);
+}
+
+static inline void fujitsu_uncore_init(struct uncore_pmu *uncorepmu)
+{
+	int i;
+
+	writeq_relaxed(PM_CR_RESET, uncorepmu->regs + PM_CR);
+
+	writeq_relaxed(PM_CNTENCLR_RESET, uncorepmu->regs + PM_CNTENCLR);
+	writeq_relaxed(PM_INTENCLR_RESET, uncorepmu->regs + PM_INTENCLR);
+	writeq_relaxed(PM_OVSR_OVSRCLR_RESET, uncorepmu->regs + PM_OVSR);
+
+	for (i = 0; i < uncorepmu->num_counters; ++i) {
+		writeq_relaxed(PM_CNTCTL_RESET, uncorepmu->regs + PM_CNTCTL(i));
+		writeq_relaxed(PM_EVTYPE_EVSEL(0), uncorepmu->regs + PM_EVTYPE(i));
+	}
+}
+
+static irqreturn_t fujitsu_uncore_handle_irq(int irq_num, void *data)
+{
+	struct uncore_pmu *uncorepmu = data;
+	/* Read the overflow status register */
+	long status = readq_relaxed(uncorepmu->regs + PM_OVSR);
+	int idx;
+
+	if (status == 0)
+		return IRQ_NONE;
+
+	/* Clear the bits we read on the overflow status register */
+	writeq_relaxed(status, uncorepmu->regs + PM_OVSR);
+
+	for_each_set_bit(idx, &status, uncorepmu->num_counters) {
+		struct perf_event *event;
+
+		event = uncorepmu->events[idx];
+		if (!event)
+			continue;
+
+		fujitsu_uncore_counter_update(event);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void fujitsu_uncore_pmu_enable(struct pmu *pmu)
+{
+	writeq_relaxed(PM_CR_ENABLE, to_uncore_pmu(pmu)->regs + PM_CR);
+}
+
+static void fujitsu_uncore_pmu_disable(struct pmu *pmu)
+{
+	writeq_relaxed(0, to_uncore_pmu(pmu)->regs + PM_CR);
+}
+
+static bool fujitsu_uncore_validate_event_group(struct perf_event *event)
+{
+	struct uncore_pmu *uncorepmu = to_uncore_pmu(event->pmu);
+	struct perf_event *leader = event->group_leader;
+	struct perf_event *sibling;
+	int counters = 1;
+
+	if (leader == event)
+		return true;
+
+	if (leader->pmu == event->pmu)
+		counters++;
+
+	for_each_sibling_event(sibling, leader) {
+		if (sibling->pmu == event->pmu)
+			counters++;
+	}
+
+	/*
+	 * If the group requires more counters than the HW has, it
+	 * cannot ever be scheduled.
+	 */
+	return counters <= uncorepmu->num_counters;
+}
+
+static int fujitsu_uncore_event_init(struct perf_event *event)
+{
+	struct uncore_pmu *uncorepmu = to_uncore_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	/* Is the event for this PMU? */
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/*
+	 * Sampling not supported since these events are not
+	 * core-attributable.
+	 */
+	if (hwc->sample_period)
+		return -EINVAL;
+
+	/*
+	 * Task mode not available, we run the counters as socket counters,
+	 * not attributable to any CPU and therefore cannot attribute per-task.
+	 */
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	/* Validate the group */
+	if (!fujitsu_uncore_validate_event_group(event))
+		return -EINVAL;
+
+	hwc->idx = -1;
+
+	event->cpu = uncorepmu->cpu;
+
+	return 0;
+}
+
+static void fujitsu_uncore_event_start(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	hwc->state = 0;
+	fujitsu_uncore_counter_start(event);
+}
+
+static void fujitsu_uncore_event_stop(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (hwc->state & PERF_HES_STOPPED)
+		return;
+
+	fujitsu_uncore_counter_stop(event);
+	if (flags & PERF_EF_UPDATE)
+		fujitsu_uncore_counter_update(event);
+	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+static int fujitsu_uncore_event_add(struct perf_event *event, int flags)
+{
+	struct uncore_pmu *uncorepmu = to_uncore_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+
+	/* Try to allocate a counter. */
+	idx = bitmap_find_free_region(uncorepmu->used_mask, uncorepmu->num_counters, 0);
+	if (idx < 0)
+		/* The counters are all in use. */
+		return -EAGAIN;
+
+	hwc->idx = idx;
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+	uncorepmu->events[idx] = event;
+
+	if (flags & PERF_EF_START)
+		fujitsu_uncore_event_start(event, 0);
+
+	/* Propagate changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+static void fujitsu_uncore_event_del(struct perf_event *event, int flags)
+{
+	struct uncore_pmu *uncorepmu = to_uncore_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+
+	/* Stop and clean up */
+	fujitsu_uncore_event_stop(event, flags | PERF_EF_UPDATE);
+	uncorepmu->events[hwc->idx] = NULL;
+	bitmap_release_region(uncorepmu->used_mask, hwc->idx, 0);
+
+	/* Propagate changes to the userspace mapping. */
+	perf_event_update_userpage(event);
+}
+
+static void fujitsu_uncore_event_read(struct perf_event *event)
+{
+	fujitsu_uncore_counter_update(event);
+}
+
+#define UNCORE_PMU_FORMAT_ATTR(_name, _config)				      \
+	(&((struct dev_ext_attribute[]) {				      \
+		{ .attr = __ATTR(_name, 0444, device_show_string, NULL),      \
+		  .var = (void *)_config, }				      \
+	})[0].attr.attr)
+
+static struct attribute *fujitsu_uncore_pmu_formats[] = {
+	UNCORE_PMU_FORMAT_ATTR(event, "config:0-7"),
+	NULL
+};
+
+static const struct attribute_group fujitsu_uncore_pmu_format_group = {
+	.name = "format",
+	.attrs = fujitsu_uncore_pmu_formats,
+};
+
+static ssize_t fujitsu_uncore_pmu_event_show(struct device *dev,
+					     struct device_attribute *attr, char *page)
+{
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr);
+	return sysfs_emit(page, "event=0x%02llx\n", pmu_attr->id);
+}
+
+#define MAC_EVENT_ATTR(_name, _id)					     \
+	PMU_EVENT_ATTR_ID(_name, fujitsu_uncore_pmu_event_show, _id)
+
+static struct attribute *fujitsu_uncore_mac_pmu_events[] = {
+	MAC_EVENT_ATTR(cycles,				0x00),
+	MAC_EVENT_ATTR(read-count,			0x10),
+	MAC_EVENT_ATTR(read-count-request,		0x11),
+	MAC_EVENT_ATTR(read-count-return,		0x12),
+	MAC_EVENT_ATTR(read-count-request-pftgt,	0x13),
+	MAC_EVENT_ATTR(read-count-request-normal,	0x14),
+	MAC_EVENT_ATTR(read-count-return-pftgt-hit,	0x15),
+	MAC_EVENT_ATTR(read-count-return-pftgt-miss,	0x16),
+	MAC_EVENT_ATTR(read-wait,			0x17),
+	MAC_EVENT_ATTR(write-count,			0x20),
+	MAC_EVENT_ATTR(write-count-write,		0x21),
+	MAC_EVENT_ATTR(write-count-pwrite,		0x22),
+	MAC_EVENT_ATTR(memory-read-count,		0x40),
+	MAC_EVENT_ATTR(memory-write-count,		0x50),
+	MAC_EVENT_ATTR(memory-pwrite-count,		0x60),
+	MAC_EVENT_ATTR(ea-mac,				0x80),
+	MAC_EVENT_ATTR(ea-memory,			0x90),
+	MAC_EVENT_ATTR(ea-memory-mac-write,		0x92),
+	MAC_EVENT_ATTR(ea-ha,				0xa0),
+	NULL
+};
+
+#define PCI_EVENT_ATTR(_name, _id)					     \
+	PMU_EVENT_ATTR_ID(_name, fujitsu_uncore_pmu_event_show, _id)
+
+static struct attribute *fujitsu_uncore_pci_pmu_events[] = {
+	PCI_EVENT_ATTR(pci-port0-cycles,		0x00),
+	PCI_EVENT_ATTR(pci-port0-read-count,		0x10),
+	PCI_EVENT_ATTR(pci-port0-read-count-bus,	0x14),
+	PCI_EVENT_ATTR(pci-port0-write-count,		0x20),
+	PCI_EVENT_ATTR(pci-port0-write-count-bus,	0x24),
+	PCI_EVENT_ATTR(pci-port1-cycles,		0x40),
+	PCI_EVENT_ATTR(pci-port1-read-count,		0x50),
+	PCI_EVENT_ATTR(pci-port1-read-count-bus,	0x54),
+	PCI_EVENT_ATTR(pci-port1-write-count,		0x60),
+	PCI_EVENT_ATTR(pci-port1-write-count-bus,	0x64),
+	PCI_EVENT_ATTR(ea-pci,				0x80),
+	NULL
+};
+
+static const struct attribute_group fujitsu_uncore_mac_pmu_events_group = {
+	.name = "events",
+	.attrs = fujitsu_uncore_mac_pmu_events,
+};
+
+static const struct attribute_group fujitsu_uncore_pci_pmu_events_group = {
+	.name = "events",
+	.attrs = fujitsu_uncore_pci_pmu_events,
+};
+
+static ssize_t cpumask_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct uncore_pmu *uncorepmu = to_uncore_pmu(dev_get_drvdata(dev));
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(uncorepmu->cpu));
+}
+static DEVICE_ATTR_RO(cpumask);
+
+static struct attribute *fujitsu_uncore_pmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL
+};
+
+static const struct attribute_group fujitsu_uncore_pmu_cpumask_attr_group = {
+	.attrs = fujitsu_uncore_pmu_cpumask_attrs,
+};
+
+static const struct attribute_group *fujitsu_uncore_mac_pmu_attr_grps[] = {
+	&fujitsu_uncore_pmu_format_group,
+	&fujitsu_uncore_mac_pmu_events_group,
+	&fujitsu_uncore_pmu_cpumask_attr_group,
+	NULL
+};
+
+static const struct attribute_group *fujitsu_uncore_pci_pmu_attr_grps[] = {
+	&fujitsu_uncore_pmu_format_group,
+	&fujitsu_uncore_pci_pmu_events_group,
+	&fujitsu_uncore_pmu_cpumask_attr_group,
+	NULL
+};
+
+static void fujitsu_uncore_pmu_migrate(struct uncore_pmu *uncorepmu, unsigned int cpu)
+{
+	perf_pmu_migrate_context(&uncorepmu->pmu, uncorepmu->cpu, cpu);
+	irq_set_affinity(uncorepmu->irq, cpumask_of(cpu));
+	uncorepmu->cpu = cpu;
+}
+
+static int fujitsu_uncore_pmu_online_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
+{
+	struct uncore_pmu *uncorepmu;
+	int node;
+
+	uncorepmu = hlist_entry_safe(cpuhp_node, struct uncore_pmu, node);
+	node = dev_to_node(uncorepmu->dev);
+	if (cpu_to_node(uncorepmu->cpu) != node && cpu_to_node(cpu) == node)
+		fujitsu_uncore_pmu_migrate(uncorepmu, cpu);
+
+	return 0;
+}
+
+static int fujitsu_uncore_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
+{
+	struct uncore_pmu *uncorepmu;
+	unsigned int target;
+	int node;
+
+	uncorepmu = hlist_entry_safe(cpuhp_node, struct uncore_pmu, node);
+	if (cpu != uncorepmu->cpu)
+		return 0;
+
+	node = dev_to_node(uncorepmu->dev);
+	target = cpumask_any_and_but(cpumask_of_node(node), cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		target = cpumask_any_but(cpu_online_mask, cpu);
+
+	if (target < nr_cpu_ids)
+		fujitsu_uncore_pmu_migrate(uncorepmu, target);
+
+	return 0;
+}
+
+static int fujitsu_uncore_pmu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	unsigned long device_type = (unsigned long)device_get_match_data(dev);
+	const struct attribute_group **attr_groups;
+	struct uncore_pmu *uncorepmu;
+	struct resource *memrc;
+	size_t alloc_size;
+	char *name;
+	int ret;
+	int irq;
+	u64 uid;
+
+	ret = acpi_dev_uid_to_integer(ACPI_COMPANION(dev), &uid);
+	if (ret)
+		return dev_err_probe(dev, ret, "unable to read ACPI uid\n");
+
+	uncorepmu = devm_kzalloc(dev, sizeof(*uncorepmu), GFP_KERNEL);
+	if (!uncorepmu)
+		return -ENOMEM;
+	uncorepmu->dev = dev;
+	uncorepmu->cpu = cpumask_local_spread(0, dev_to_node(dev));
+	platform_set_drvdata(pdev, uncorepmu);
+
+	switch (device_type) {
+	case FUJITSU_UNCORE_PMU_MAC:
+		uncorepmu->num_counters = MAC_NUM_COUNTERS;
+		attr_groups = fujitsu_uncore_mac_pmu_attr_grps;
+		name = devm_kasprintf(dev, GFP_KERNEL, "mac_iod%llu_mac%llu_ch%llu",
+				      (uid >> 8) & 0xF, (uid >> 4) & 0xF, uid & 0xF);
+		break;
+	case FUJITSU_UNCORE_PMU_PCI:
+		uncorepmu->num_counters = PCI_NUM_COUNTERS;
+		attr_groups = fujitsu_uncore_pci_pmu_attr_grps;
+		name = devm_kasprintf(dev, GFP_KERNEL, "pci_iod%llu_pci%llu",
+				      (uid >> 4) & 0xF, uid & 0xF);
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL, "illegal device type: %lu\n", device_type);
+	}
+	if (!name)
+		return -ENOMEM;
+
+	uncorepmu->pmu = (struct pmu) {
+		.parent		= dev,
+		.task_ctx_nr	= perf_invalid_context,
+
+		.attr_groups	= attr_groups,
+
+		.pmu_enable	= fujitsu_uncore_pmu_enable,
+		.pmu_disable	= fujitsu_uncore_pmu_disable,
+		.event_init	= fujitsu_uncore_event_init,
+		.add		= fujitsu_uncore_event_add,
+		.del		= fujitsu_uncore_event_del,
+		.start		= fujitsu_uncore_event_start,
+		.stop		= fujitsu_uncore_event_stop,
+		.read		= fujitsu_uncore_event_read,
+
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+	};
+
+	alloc_size = sizeof(uncorepmu->events[0]) * uncorepmu->num_counters;
+	uncorepmu->events = devm_kzalloc(dev, alloc_size, GFP_KERNEL);
+	if (!uncorepmu->events)
+		return -ENOMEM;
+
+	alloc_size = sizeof(uncorepmu->used_mask[0]) * BITS_TO_LONGS(uncorepmu->num_counters);
+	uncorepmu->used_mask = devm_kzalloc(dev, alloc_size, GFP_KERNEL);
+	if (!uncorepmu->used_mask)
+		return -ENOMEM;
+
+	uncorepmu->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &memrc);
+	if (IS_ERR(uncorepmu->regs))
+		return PTR_ERR(uncorepmu->regs);
+
+	fujitsu_uncore_init(uncorepmu);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	ret = devm_request_irq(dev, irq, fujitsu_uncore_handle_irq, 0,
+			       name, uncorepmu);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request IRQ:%d\n", irq);
+
+	ret = irq_set_affinity(irq, cpumask_of(uncorepmu->cpu));
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to set irq affinity:%d\n", irq);
+
+	uncorepmu->irq = irq;
+
+	/* Add this instance to the list used by the offline callback */
+	ret = cpuhp_state_add_instance(uncore_pmu_cpuhp_state, &uncorepmu->node);
+	if (ret)
+		return dev_err_probe(dev, ret, "Error registering hotplug");
+
+	ret = perf_pmu_register(&uncorepmu->pmu, name, -1);
+	if (ret < 0) {
+		cpuhp_state_remove_instance_nocalls(uncore_pmu_cpuhp_state, &uncorepmu->node);
+		return dev_err_probe(dev, ret, "Failed to register %s PMU\n", name);
+	}
+
+	dev_dbg(dev, "Registered %s, type: %d\n", name, uncorepmu->pmu.type);
+
+	return 0;
+}
+
+static void fujitsu_uncore_pmu_remove(struct platform_device *pdev)
+{
+	struct uncore_pmu *uncorepmu = platform_get_drvdata(pdev);
+
+	writeq_relaxed(0, uncorepmu->regs + PM_CR);
+
+	perf_pmu_unregister(&uncorepmu->pmu);
+	cpuhp_state_remove_instance_nocalls(uncore_pmu_cpuhp_state, &uncorepmu->node);
+}
+
+static const struct acpi_device_id fujitsu_uncore_pmu_acpi_match[] = {
+	{ "FUJI200C", FUJITSU_UNCORE_PMU_MAC },
+	{ "FUJI200D", FUJITSU_UNCORE_PMU_PCI },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, fujitsu_uncore_pmu_acpi_match);
+
+static struct platform_driver fujitsu_uncore_pmu_driver = {
+	.driver = {
+		.name = "fujitsu-uncore-pmu",
+		.acpi_match_table = fujitsu_uncore_pmu_acpi_match,
+		.suppress_bind_attrs = true,
+	},
+	.probe = fujitsu_uncore_pmu_probe,
+	.remove = fujitsu_uncore_pmu_remove,
+};
+
+static int __init fujitsu_uncore_pmu_init(void)
+{
+	int ret;
+
+	/* Install a hook to update the reader CPU in case it goes offline */
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+				      "perf/fujitsu/uncore:online",
+				      fujitsu_uncore_pmu_online_cpu,
+				      fujitsu_uncore_pmu_offline_cpu);
+	if (ret < 0)
+		return ret;
+
+	uncore_pmu_cpuhp_state = ret;
+
+	ret = platform_driver_register(&fujitsu_uncore_pmu_driver);
+	if (ret)
+		cpuhp_remove_multi_state(uncore_pmu_cpuhp_state);
+
+	return ret;
+}
+
+static void __exit fujitsu_uncore_pmu_exit(void)
+{
+	platform_driver_unregister(&fujitsu_uncore_pmu_driver);
+	cpuhp_remove_multi_state(uncore_pmu_cpuhp_state);
+}
+
+module_init(fujitsu_uncore_pmu_init);
+module_exit(fujitsu_uncore_pmu_exit);
+
+MODULE_AUTHOR("Koichi Okuno <fj2767dz@fujitsu.com>");
+MODULE_DESCRIPTION("Fujitsu Uncore PMU driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0

