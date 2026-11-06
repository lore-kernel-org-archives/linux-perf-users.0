Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990990;
	b=tmyS7mrhikYi/57R/ED3sbMhiJ9o4AaAmfkL00mGsWvDA1/37U67X9QlFa/HT3EJUfxw
	 jeEpAF5FzjI0vz+UHee7Hu2fQ5kiTD1Wy/TiMeZn2JEG4tCdnZ6zBQ//5zrIyTNxReQg+
	 QJdjq/VsYMQ0xc/UuNrpR63WVdqV+yeSGKiOMHFFfybA9J5I+YfvOpaZq7O4SSmwnyUBk
	 fIsk32LC28HkGR5tb540Dr7UsM2+0EN/PJvqxDSXiKnNtG6wDS+ZG4n6ucRdwZmG4G1qJ
	 k0Z0gJ0B4qXkSTvJwwqQaOIYCFYAyExidy90anUxVTv3ZBkcdiyww7bKmVyALxOKcsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990990;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=iOSfLb86QY08ej0RawPxXcRECun5ow2DaAauKLhZvic=;
	b=f0eGhzjrHgDZMRTF9vX1zWBOAfSxFYgiVrvTtFJUk3c3e4sopgeJz9qtBGqL0lsvqEgb
	 hGpQ9R7f6icZs5BBErRMUTE3e2RyHlFMd3hiMGT3VTlWzy8Ec5EhfDRHcxvyAGDXhmvuZ
	 PIeRQJ592esfgJRMv32wa2zyUyUzkDDi+rg7sarICi6oBmrobDanM4Epf0FlDuhT3jaiQ
	 lNhm+duvWf8iokphBGZLTba42hZsffsEKbhNGRRM6mQXHix4brnpmfCA8EOOeFjAiz3bl
	 TTfPxhCWac8s/O8XydsgH/KRYrBndic1C5wGtWOK5YgBNqtv8KxXCqS9JwEBeiOEaCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nfnStZQD;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C58606A326
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 18:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24C58606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nfnStZQD
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CD0C1650;
	Fri,  6 Nov 2026 10:49:46 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.2.212.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 91F3B3F673;
	Fri,  6 Nov 2026 10:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793990989; bh=KnzE4VmiVmM6UAdxWSUgepdIWMCIhJvuARplG3Gxblo=;
	h=From:To:Cc:Subject:Date:From;
	b=nfnStZQDrWiZp7Q9DdPQCjg52ets9l5SI+kta8RUw8uP44rkLlmEJT5d5HW2LfKER
	 Zh3jwXbIpvMty/DzDvO6nHZ0+CPj/kvieBqnu/JTlhv0jEApQH3LzYqZnUAcxaIZFC
	 YAugKva6TeScAyGIfU/eZi/QFe3t+UTel7+TizRA=
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org
Cc: mark.rutland@arm.com,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] perf: Process subdirectory Makefiles unconditionally
Date: Fri,  6 Nov 2026 18:49:37 +0000
Message-ID: <4b2e518499270b2a6cab3e04a1123458d82d2759.1793990977.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.54.0.dirty
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Our subdirectories here are purely for file-level organisation rather
than any particular build structure, and everything in the Makefiles
is already conditional on the appropriate config options. Plus they're
not exactly big and complex, so for simplicity let's just drop the
top-level conditions.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/perf/Makefile | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index eb8a022dad9a..8c3146c604ce 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-y += amlogic/ arm_cspmu/ hisilicon/
 obj-$(CONFIG_ARM_CCI_PMU) += arm-cci.o
 obj-$(CONFIG_ARM_CCN) += arm-ccn.o
 obj-$(CONFIG_ARM_CMN) += arm-cmn.o
@@ -14,7 +15,6 @@ obj-$(CONFIG_ARM_SMMU_V3_PMU) += arm_smmuv3_pmu.o
 obj-$(CONFIG_FSL_IMX8_DDR_PMU) += fsl_imx8_ddr_perf.o
 obj-$(CONFIG_FSL_IMX9_DDR_PMU) += fsl_imx9_ddr_perf.o
 obj-$(CONFIG_FUJITSU_UNCORE_PMU) += fujitsu_uncore_pmu.o
-obj-$(CONFIG_HISI_PMU) += hisilicon/
 obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
 obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
@@ -32,8 +32,6 @@ obj-$(CONFIG_MARVELL_PEM_PMU) += marvell_pem_pmu.o
 obj-$(CONFIG_APPLE_M1_CPU_PMU) += apple_m1_cpu_pmu.o
 obj-$(CONFIG_ALIBABA_UNCORE_DRW_PMU) += alibaba_uncore_drw_pmu.o
 obj-$(CONFIG_DWC_PCIE_PMU) += dwc_pcie_pmu.o
-obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu/
-obj-$(CONFIG_MESON_DDR_PMU) += amlogic/
 obj-$(CONFIG_CXL_PMU) += cxl_pmu.o
 obj-$(CONFIG_NVIDIA_TEGRA410_CMEM_LATENCY_PMU) += nvidia_t410_cmem_latency_pmu.o
 obj-$(CONFIG_NVIDIA_TEGRA410_C2C_PMU) += nvidia_t410_c2c_pmu.o
-- 
2.54.0.dirty

