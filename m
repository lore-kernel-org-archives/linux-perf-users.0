Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67BE41D640
	for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786814861; cv=none; b=oEIN9U6cUaMF62q13Ji2bsrzrtfgtjcLv9JWWXXY+WTY1bIZzbcc9fUHM7reSQbARXN2mSjsPkaFGGQPHn28vXoHd1ShbOJNPF5yVGomDLCoMmHpcaQTz/FJcRHLGWdaqEyz+n1Np1M7ibTye3k6E6O+0zLNxx5LtkAf26uXDd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786814861; c=relaxed/simple;
	bh=XcuPryZi5vxKnvmr1EWQVUBwP7AXemVIKHhtgMQi2SM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zsi7QqYusTUWBTVKkBIe9acmW0ZqXqnI5d3q8YHAYteAjTos1XzyRH3UEYAbgGpJz2qRMjleRlJmgaYc9+sjjeyVXak5pCeVz8fLk3Q+10HiGjfTrGshHmqErb4dbnL2jy8p2qtbhJUp9pdDW50lhU8e2DBsJDklYv8t4w8CWq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KQxnK6c4; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KQxnK6c4"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e5a616d07so2326274a91.2
        for <linux-perf-users@vger.kernel.org>; Sat, 15 Aug 2026 10:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786814858; x=1787419658; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kuJrX+hh6aj9QgMYi/WEOovyFB3pT3s3ztYzQYDuAHI=;
        b=KQxnK6c4p/mDdJDkfO2mRJBrM5Y4V0zFya2hauto6PXzrF9UZTfLv+k1clto7v4uCn
         0rIiRkTtltHc6B6rVAhVHEQ5Wx/iqW6z+qPRqH1ObHfbpJww3lJtNgDF83LrD7Am+Hly
         vn23nJr9sZtdA4H+sSEQwg1WoFv6WMy+4OdzvxxLTPAIWivTyzJN3KhEFoUkj0tyH3jh
         iO6C0zQsjoaURjmaX44Hds+wi7DpXSQk6nLwv3FcGvS273bRCboy0dc5iHYDZ2IvrIm4
         MWviOnEztoRKcumLFW7xpnqxIU37/JxxT7bx0iDt6fqBOOKXsDBv+1KvJ7fb9RaUY+Eq
         KfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786814858; x=1787419658;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kuJrX+hh6aj9QgMYi/WEOovyFB3pT3s3ztYzQYDuAHI=;
        b=UTM8R20zo6mTmRorLcdElJhDoT3e4oRapu93xOV4C0wXdRmMVRZ2QrFJ5OqsscyIoq
         JwOKY84sZ/BgyvxU4U+6Rl+pPzx8yqLn3CY1OqjCjTVU+iUir29dd+1aPBTdOlg54sHm
         ZwP9g9PmRFrJf7fjqFG1OCJOuWKHpDbVDlAjOGu8kOyTsar3TAud7RSFSBMN6kurZW5W
         R5zPvQJNTxWBT3rCGxX9Z2oJtiEsT79wsOOItx0NxacvO42lXL1+KC8ig5mg8QXB85g8
         1nO3ZdVr9iEM5zPQhCetlrT+OOEyznjkNf9FFHh726H2gXd9/JHUnTA04wNxjaPyNQCM
         EA/A==
X-Forwarded-Encrypted: i=1; AHgh+RoSLDhRe9FA1sqn219l6l3KiJgaxJ22jYSUAk2tfzsxtw6rL80CkemS4Enj6U03W4DWH+vKuSHUpmcGz1+sGzkt@vger.kernel.org
X-Gm-Message-State: AOJu0YxevYuP+kx1M3e9Qg0aMoCgxfU2vgSuh/k1ALWaYW2wmKMVRSAw
	JoQVCQxE37VUyqGEG7BB3g3J4+KnLi8h34hTEq1guOQqLu0Ta0BD+thISMsSUCylN0ZWQQpqDbh
	LH9MoDMmgOA==
X-Received: from dlbvs14.prod.google.com ([2002:a05:7022:3f0e:b0:13d:2928:7996])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ed0:b0:38f:efed:5448
 with SMTP id 98e67ed59e1d1-3933b8768f6mr15936468a91.8.1786814857666; Sat, 15
 Aug 2026 10:27:37 -0700 (PDT)
Date: Sat, 15 Aug 2026 10:27:12 -0700
In-Reply-To: <20260815172712.50119-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260815082048.4043217-1-irogers@google.com> <20260815172712.50119-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260815172712.50119-4-irogers@google.com>
Subject: [PATCH v13 3/3] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, florian.fainelli@broadcom.com, 
	linux-perf-users@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	pbrobinson@gmail.com
Content-Type: text/plain; charset="UTF-8"

Initialize MMIO-based AXI Performance Counters natively for the BCM2712
architecture, dynamically bypassing the legacy VideoCore VPU Mailbox IPC
layer entirely for newer generation hardware loops.

Sysfs topology definitions natively expand into dynamically evaluated
legacy and modern mapping arrays, perfectly partitioning Pi 4 endpoints
from Pi 5 natively during PMU registration without relying on internal
legacy string visibility filters.

Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Ian Rogers <irogers@google.com>
[ v13: Strip misleading BCM2712 VPU reference from synchronous read comment ]
---
 drivers/perf/rpi_axi_pmu.c | 584 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 568 insertions(+), 16 deletions(-)

diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
index 95ee5a7cf56b..6e4711f6a051 100644
--- a/drivers/perf/rpi_axi_pmu.c
+++ b/drivers/perf/rpi_axi_pmu.c
@@ -6,6 +6,7 @@
  * This driver exposes the performance monitoring hardware on Raspberry Pi
  * System-on-Chips to the Linux perf subsystem:
  * - Raspberry Pi 1, 2, 3, 4, Compute Modules 1-4, Zero, Zero W (SoCs BCM2835/2836/2837/2711).
+ * - Raspberry Pi 5, Compute Module 5 (SoC BCM2712).
  *
  * Architecture Overview:
  * ----------------------
@@ -19,6 +20,7 @@
  *    Monitors VideoCore VPU buses (VPU0/1 Data/Instruction L2/UC, SDRAM, etc.).
  *    Accessible through VideoCore firmware mailbox IPC (RPI_FIRMWARE_SET/GET_PERIPH_REG).
  *    Read latency: ~10-100 microseconds (IPC over VPU mailbox).
+ *    On BCM2712 (RPi 5), VPU Mailbox IPC is replaced by direct PCIe and MMIO mapping.
  *
  * Synchronization & Concurrency Model:
  * ------------------------------------
@@ -72,9 +74,11 @@ static inline void rpi_hrtimer_setup(struct hrtimer *timer,
 /**
  * enum rpi_axi_chip - Supported Broadcom SoC generations
  * @CHIP_BCM2835: BCM2835 / BCM2836 / BCM2837 / BCM2711 (RPi 1-4, CM 1-4, Zero/W)
+ * @CHIP_BCM2712: BCM2712 (RPi 5, CM 5)
  */
 enum rpi_axi_chip {
 	CHIP_BCM2835 = 0,
+	CHIP_BCM2712,
 };
 
 enum monitor {
@@ -126,6 +130,44 @@ enum bcm2835_system_bus {
 	BCM2835_SB_MAX
 };
 
+/**
+ * enum bcm2712_system_bus - AXI buses monitored by System Monitor on BCM2712 (RPi 5)
+ * @BCM2712_SB_DMA_L2: DMA engine L2 cache interconnect bus
+ * @BCM2712_SB_TRANS: Transposer engine bus
+ * @BCM2712_SB_JPEG: Hardware JPEG codec acceleration bus
+ * @BCM2712_SB_SYSTEM_UC: System Uncached memory bus
+ * @BCM2712_SB_DMA_UC: DMA Uncached memory bus
+ * @BCM2712_SB_SYSTEM_L2: System main L2 cache bus
+ * @BCM2712_SB_PCIE_RP1: PCIe 2.0 x4 RP1 Southbridge link bus (USB 3.0, Ethernet, I/O)
+ * @BCM2712_SB_HEVC_DEC: HEVC (H.265) hardware video decoder bus
+ * @BCM2712_SB_A76_DSU_L3: Quad-core Arm Cortex-A76 DynamIQ Shared Unit (DSU) L3 bus
+ * @BCM2712_SB_HVS: Hardware Video Scaler (HVS) display composition engine bus
+ * @BCM2712_SB_V3D7: VideoCore VII 3D graphics hardware pipeline bus
+ * @BCM2712_SB_ISP: Image Sensor Processor (ISP) camera pipeline bus
+ * @BCM2712_SB_PERIPHERAL: System peripherals bus
+ * @BCM2712_SB_CPU_UC: CPU Uncached memory bus
+ * @BCM2712_SB_CPU_L2: CPU L2 cache bus
+ * @BCM2712_SB_MAX: Total count of monitored system buses on BCM2712
+ */
+enum bcm2712_system_bus {
+	BCM2712_SB_DMA_L2 = 0,
+	BCM2712_SB_TRANS,
+	BCM2712_SB_JPEG,
+	BCM2712_SB_SYSTEM_UC,
+	BCM2712_SB_DMA_UC,
+	BCM2712_SB_SYSTEM_L2,
+	BCM2712_SB_PCIE_RP1,
+	BCM2712_SB_HEVC_DEC,
+	BCM2712_SB_A76_DSU_L3,
+	BCM2712_SB_HVS,
+	BCM2712_SB_V3D7,
+	BCM2712_SB_ISP,
+	BCM2712_SB_PERIPHERAL,
+	BCM2712_SB_CPU_UC,
+	BCM2712_SB_CPU_L2,
+	BCM2712_SB_MAX
+};
+
 /**
  * enum vpu_bus - AXI buses monitored by VPU Monitor on BCM2835-BCM2711 (RPi 1-4)
  * @VPU__VPU1_D_L2: VideoCore VPU Core 1 Data L2 cache bus
@@ -258,6 +300,94 @@ enum bcm2835_filter {
 	BCM2835_FLT_MAX
 };
 
+/**
+ * enum bcm2712_filter - AXI master ID filter options for BCM2712 (RPi 5)
+ * @BCM2712_FLT_NONE: Disable master ID filtering (monitor all traffic on bus)
+ * @BCM2712_FLT_VPU_UC0: VPU Uncached 0 master ID
+ * @BCM2712_FLT_VPU_IC0: VPU I-Cache 0 master ID
+ * @BCM2712_FLT_VPU_DC0: VPU D-Cache 0 master ID
+ * @BCM2712_FLT_VPU_UC1: VPU Uncached 1 master ID
+ * @BCM2712_FLT_VPU_IC1: VPU I-Cache 1 master ID
+ * @BCM2712_FLT_VPU_DC1: VPU D-Cache 1 master ID
+ * @BCM2712_FLT_VPU_L2: VPU L2 Cache master ID
+ * @BCM2712_FLT_DMA2: DMA2 master ID
+ * @BCM2712_FLT_VPU_DEBUG: VPU Debug master ID
+ * @BCM2712_FLT_ARM: Arm Quad-Core CPU Cluster master ID
+ * @BCM2712_FLT_DMA0: DMA0 master ID
+ * @BCM2712_FLT_DMA1: DMA1 master ID
+ * @BCM2712_FLT_RAAGA: RAAGA Audio Engine master ID
+ * @BCM2712_FLT_BBSI: BBSI master ID
+ * @BCM2712_FLT_PCIE0: RP1 PCIe Southbridge 0 master ID
+ * @BCM2712_FLT_PCIE1: PCIe 1 master ID
+ * @BCM2712_FLT_PCIE2: PCIe 2 master ID
+ * @BCM2712_FLT_UMR: UMR master ID
+ * @BCM2712_FLT_SAGE: SAGE master ID
+ * @BCM2712_FLT_HVDP: HVDP master ID
+ * @BCM2712_FLT_BSP: BSP master ID
+ * @BCM2712_FLT_HVS: Hardware Video Scaler (HVS) display engine master ID
+ * @BCM2712_FLT_HVS_WMK: HVS Watermark master ID
+ * @BCM2712_FLT_MOP0: MOP0 master ID
+ * @BCM2712_FLT_MOP1: MOP1 master ID
+ * @BCM2712_FLT_MBVN: MBVN master ID
+ * @BCM2712_FLT_DSI: DSI Display Interface master ID
+ * @BCM2712_FLT_XPT: XPT master ID
+ * @BCM2712_FLT_EMMC0: SD/eMMC Controller 0 master ID
+ * @BCM2712_FLT_GENET: Gigabit Ethernet Controller master ID
+ * @BCM2712_FLT_USB: USB Controller master ID
+ * @BCM2712_FLT_MAX: Maximum filter ID count for BCM2712
+ */
+enum bcm2712_filter {
+	BCM2712_FLT_NONE = 0,
+	BCM2712_FLT_VPU_UC0 = 1,
+	BCM2712_FLT_VPU_IC0 = 2,
+	BCM2712_FLT_VPU_DC0 = 3,
+	BCM2712_FLT_VPU_UC1 = 4,
+	BCM2712_FLT_VPU_IC1 = 5,
+	BCM2712_FLT_VPU_DC1 = 6,
+	BCM2712_FLT_VPU_L2 = 7,
+	BCM2712_FLT_DMA2 = 8,
+	BCM2712_FLT_VPU_DEBUG = 9,
+	BCM2712_FLT_ARM = 10,
+	BCM2712_FLT_DMA0 = 11,
+	BCM2712_FLT_DMA1 = 12,
+	BCM2712_FLT_RAAGA = 13,
+	BCM2712_FLT_BBSI = 14,
+	BCM2712_FLT_PCIE0 = 15,
+	BCM2712_FLT_PCIE1 = 16,
+	BCM2712_FLT_PCIE2 = 17,
+	BCM2712_FLT_UMR = 18,
+	BCM2712_FLT_SAGE = 19,
+	BCM2712_FLT_HVDP = 20,
+	BCM2712_FLT_BSP = 21,
+	BCM2712_FLT_HVS = 22,
+	BCM2712_FLT_HVS_WMK = 23,
+	BCM2712_FLT_MOP0 = 24,
+	BCM2712_FLT_MOP1 = 25,
+	BCM2712_FLT_MBVN = 26,
+	BCM2712_FLT_DSI = 27,
+	BCM2712_FLT_XPT = 28,
+	BCM2712_FLT_EMMC0 = 29,
+	BCM2712_FLT_GENET = 30,
+	BCM2712_FLT_USB = 31,
+	BCM2712_FLT_MAX = 32
+};
+
+/* Compile-time static assertions verifying cross-generation enum equivalence */
+static_assert((int)BCM2835_FLT_NONE == (int)BCM2712_FLT_NONE,
+	      "Filter NONE enum value mismatch across BCM2835 and BCM2712");
+static_assert((int)BCM2835_SB_DMA_L2 == (int)BCM2712_SB_DMA_L2,
+	      "DMA_L2 bus enum value mismatch across BCM2835 and BCM2712");
+static_assert((int)BCM2835_SB_TRANS == (int)BCM2712_SB_TRANS,
+	      "TRANS bus enum value mismatch across BCM2835 and BCM2712");
+static_assert((int)BCM2835_SB_JPEG == (int)BCM2712_SB_JPEG,
+	      "JPEG bus enum value mismatch across BCM2835 and BCM2712");
+static_assert((int)BCM2835_SB_SYSTEM_UC == (int)BCM2712_SB_SYSTEM_UC,
+	      "SYSTEM_UC bus enum value mismatch across BCM2835 and BCM2712");
+static_assert((int)BCM2835_SB_DMA_UC == (int)BCM2712_SB_DMA_UC,
+	      "DMA_UC bus enum value mismatch across BCM2835 and BCM2712");
+static_assert((int)BCM2835_SB_SYSTEM_L2 == (int)BCM2712_SB_SYSTEM_L2,
+	      "SYSTEM_L2 bus enum value mismatch across BCM2835 and BCM2712");
+
 /* Hardware register offsets & control bitwise constants */
 #define GEN_CTRL			0x00
 #define GEN_CTL_ENABLE_BIT		BIT(0)
@@ -463,7 +593,7 @@ static int rpi_axi_hw_events__get_alloc_event_idx(struct rpi_axi_hw_events *hw_e
  * struct rpi_axi_pmu - Root PMU driver context
  * @pmu: Core Linux perf PMU structure
  * @pdev: Owning platform_device pointer
- * @chip: Detected Broadcom SoC generation
+ * @chip: Detected Broadcom SoC generation (CHIP_BCM2835 or CHIP_BCM2712)
  * @firmware: Raspberry Pi firmware handle for VideoCore mailbox calls (BCM2835-BCM2711)
  * @cpu: CPU core assigned to process uncore PMU events
  * @cpuhp_node: Dynamic CPU hotplug instance node
@@ -525,15 +655,25 @@ static bool config_is_valid(struct rpi_axi_pmu *pmu, __u64 config)
 	if (!pmu->monitor[mon].use_mailbox_interface && !pmu->monitor[mon].base_address)
 		return false;
 
-	if (mon == MON_SYSTEM) {
-		if (bus >= BCM2835_SB_MAX)
+	if (pmu->chip == CHIP_BCM2712) {
+		if (mon != MON_SYSTEM)
+			return false;
+		if (bus >= BCM2712_SB_MAX)
+			return false;
+		if (filter >= BCM2712_FLT_MAX)
 			return false;
 	} else {
-		if (bus >= VPU_MAX)
+		if (mon == MON_SYSTEM) {
+			if (bus >= BCM2835_SB_MAX)
+				return false;
+		} else {
+			if (bus >= VPU_MAX)
+				return false;
+		}
+		if (filter >= BCM2835_FLT_MAX)
 			return false;
 	}
-	if (filter >= BCM2835_FLT_MAX)
-		return false;
+
 	return counter < CNT_MAX;
 }
 
@@ -559,7 +699,7 @@ static const struct attribute_group rpi_axi_pmu_format_group = {
  * Event Attribute Scaling & Unit Definitions:
  *
  * Uncore AXI bus transaction events (_rtrans, _wtrans, _atrans) report hardware
- * transaction beats. On Broadcom BCM2835 AXI interconnects, single-beat
+ * transaction beats. On Broadcom BCM2835-BCM2712 AXI interconnects, single-beat
  * transactions transfer 32 bytes per beat, while contiguous DMA page bursts may
  * use 64-byte double-beats. Setting .scale="32" and .unit="Bytes" provides a
  * close (~95%) byte throughput approximation in perf stat output (accounting for
@@ -796,6 +936,30 @@ PMU_EVENT_ATTR_STRING(h264_rtwait, rpi_axi_pmu_event_h264_rtwait,
 		      "monitor=0,bus=10,counter=5");
 
 /* Image Sensor Processor Camera Pipeline Bus Events (bus=11, BCM2835_SB_ISP) */
+PMU_EVENT_ATTR_STRING(isp_atrans, rpi_axi_pmu_event_isp_atrans,
+		      "monitor=0,bus=11,counter=0");
+PMU_EVENT_ATTR_STRING(isp_atrans.scale, rpi_axi_pmu_event_isp_atrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(isp_atrans.unit, rpi_axi_pmu_event_isp_atrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(isp_atwait, rpi_axi_pmu_event_isp_atwait,
+		      "monitor=0,bus=11,counter=1");
+PMU_EVENT_ATTR_STRING(isp_wtrans, rpi_axi_pmu_event_isp_wtrans,
+		      "monitor=0,bus=11,counter=2");
+PMU_EVENT_ATTR_STRING(isp_wtrans.scale, rpi_axi_pmu_event_isp_wtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(isp_wtrans.unit, rpi_axi_pmu_event_isp_wtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(isp_wtwait, rpi_axi_pmu_event_isp_wtwait,
+		      "monitor=0,bus=11,counter=3");
+PMU_EVENT_ATTR_STRING(isp_rtrans, rpi_axi_pmu_event_isp_rtrans,
+		      "monitor=0,bus=11,counter=4");
+PMU_EVENT_ATTR_STRING(isp_rtrans.scale, rpi_axi_pmu_event_isp_rtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(isp_rtrans.unit, rpi_axi_pmu_event_isp_rtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(isp_rtwait, rpi_axi_pmu_event_isp_rtwait,
+		      "monitor=0,bus=11,counter=5");
 
 /* VideoCore V3D 3D Graphics Hardware Pipeline Bus Events (bus=12, BCM2835_SB_V3D) */
 PMU_EVENT_ATTR_STRING(v3d_atrans, rpi_axi_pmu_event_v3d_atrans,
@@ -824,8 +988,38 @@ PMU_EVENT_ATTR_STRING(v3d_rtwait, rpi_axi_pmu_event_v3d_rtwait,
 		      "monitor=0,bus=12,counter=5");
 
 /* Low-Speed Peripherals Bus Events (bus=13, BCM2835_SB_PERIPHERAL: UART, SPI, I2C, GPIO) */
+PMU_EVENT_ATTR_STRING(peripheral_atrans, rpi_axi_pmu_event_peripheral_atrans,
+		      "monitor=0,bus=13,counter=0");
+PMU_EVENT_ATTR_STRING(peripheral_atrans.scale, rpi_axi_pmu_event_peripheral_atrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(peripheral_atrans.unit, rpi_axi_pmu_event_peripheral_atrans_unit,
+		      "Bytes");
 
 /* CPU Uncached Memory Bus Events (bus=14, BCM2835_SB_CPU_UC) */
+PMU_EVENT_ATTR_STRING(cpu_uc_atrans, rpi_axi_pmu_event_cpu_uc_atrans,
+		      "monitor=0,bus=14,counter=0");
+PMU_EVENT_ATTR_STRING(cpu_uc_atrans.scale, rpi_axi_pmu_event_cpu_uc_atrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(cpu_uc_atrans.unit, rpi_axi_pmu_event_cpu_uc_atrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(cpu_uc_atwait, rpi_axi_pmu_event_cpu_uc_atwait,
+		      "monitor=0,bus=14,counter=1");
+PMU_EVENT_ATTR_STRING(cpu_uc_wtrans, rpi_axi_pmu_event_cpu_uc_wtrans,
+		      "monitor=0,bus=14,counter=2");
+PMU_EVENT_ATTR_STRING(cpu_uc_wtrans.scale, rpi_axi_pmu_event_cpu_uc_wtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(cpu_uc_wtrans.unit, rpi_axi_pmu_event_cpu_uc_wtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(cpu_uc_wtwait, rpi_axi_pmu_event_cpu_uc_wtwait,
+		      "monitor=0,bus=14,counter=3");
+PMU_EVENT_ATTR_STRING(cpu_uc_rtrans, rpi_axi_pmu_event_cpu_uc_rtrans,
+		      "monitor=0,bus=14,counter=4");
+PMU_EVENT_ATTR_STRING(cpu_uc_rtrans.scale, rpi_axi_pmu_event_cpu_uc_rtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(cpu_uc_rtrans.unit, rpi_axi_pmu_event_cpu_uc_rtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(cpu_uc_rtwait, rpi_axi_pmu_event_cpu_uc_rtwait,
+		      "monitor=0,bus=14,counter=5");
 
 /* CPU L2 Cache Bus Events (bus=15, BCM2835_SB_CPU_L2) */
 PMU_EVENT_ATTR_STRING(cpu_l2_atrans, rpi_axi_pmu_event_cpu_l2_atrans,
@@ -1114,6 +1308,18 @@ PMU_EVENT_ATTR_STRING(hvs_system_l2_wtrans.scale, rpi_axi_pmu_event_hvs_system_l
 		      "32");
 PMU_EVENT_ATTR_STRING(hvs_system_l2_wtrans.unit, rpi_axi_pmu_event_hvs_system_l2_wtrans_unit,
 		      "Bytes");
+PMU_EVENT_ATTR_STRING(isp_system_l2_rtrans, rpi_axi_pmu_event_isp_system_l2_rtrans,
+		      "monitor=0,bus=5,counter=4,filter=11");
+PMU_EVENT_ATTR_STRING(isp_system_l2_rtrans.scale, rpi_axi_pmu_event_isp_system_l2_rtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(isp_system_l2_rtrans.unit, rpi_axi_pmu_event_isp_system_l2_rtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(isp_system_l2_wtrans, rpi_axi_pmu_event_isp_system_l2_wtrans,
+		      "monitor=0,bus=5,counter=2,filter=11");
+PMU_EVENT_ATTR_STRING(isp_system_l2_wtrans.scale, rpi_axi_pmu_event_isp_system_l2_wtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(isp_system_l2_wtrans.unit, rpi_axi_pmu_event_isp_system_l2_wtrans_unit,
+		      "Bytes");
 PMU_EVENT_ATTR_STRING(usb_system_l2_rtrans, rpi_axi_pmu_event_usb_system_l2_rtrans,
 		      "monitor=0,bus=5,counter=4,filter=24");
 PMU_EVENT_ATTR_STRING(usb_system_l2_rtrans.scale, rpi_axi_pmu_event_usb_system_l2_rtrans_scale,
@@ -1127,8 +1333,205 @@ PMU_EVENT_ATTR_STRING(usb_system_l2_wtrans.scale, rpi_axi_pmu_event_usb_system_l
 PMU_EVENT_ATTR_STRING(usb_system_l2_wtrans.unit, rpi_axi_pmu_event_usb_system_l2_wtrans_unit,
 		      "Bytes");
 
-static struct attribute *rpi_axi_pmu_events_attrs[] = {
-	/* System Monitor events */
+/* --- RASPBERRY PI 5 (BCM2712) EXPANDED EVENT ALIASES ---------------------- */
+
+/* PCIe 2.0 x4 RP1 Southbridge Link Bus Events & Stall Wait Cycles (bus=6, BCM2712_SB_PCIE_RP1) */
+
+/* HEVC (H.265) Hardware Video Decoder Bus Events (bus=7, BCM2712_SB_HEVC_DEC) */
+
+
+/* VideoCore VII 3D Graphics Pipeline Bus Events (bus=10, BCM2712_SB_V3D7) */
+
+/*
+ * Quad-Core Arm Cortex-A76 Cores 0-3 I-Cache & D-Cache Filtered Events
+ * (bus=14, BCM2712_SB_CPU_L2)
+ */
+PMU_EVENT_ATTR_STRING(dma_l2_rtrans, rpi_axi_pmu_event_bcm2712_dma_l2_rtrans,
+		      "monitor=0,bus=0,counter=4");
+PMU_EVENT_ATTR_STRING(dma_l2_rtrans.scale, rpi_axi_pmu_event_bcm2712_dma_l2_rtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(dma_l2_rtrans.unit, rpi_axi_pmu_event_bcm2712_dma_l2_rtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(dma_l2_wtrans, rpi_axi_pmu_event_bcm2712_dma_l2_wtrans,
+		      "monitor=0,bus=0,counter=2");
+PMU_EVENT_ATTR_STRING(dma_l2_wtrans.scale, rpi_axi_pmu_event_bcm2712_dma_l2_wtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(dma_l2_wtrans.unit, rpi_axi_pmu_event_bcm2712_dma_l2_wtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(trans_rtrans, rpi_axi_pmu_event_bcm2712_trans_rtrans,
+		      "monitor=0,bus=1,counter=4");
+PMU_EVENT_ATTR_STRING(trans_rtrans.scale, rpi_axi_pmu_event_bcm2712_trans_rtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(trans_rtrans.unit, rpi_axi_pmu_event_bcm2712_trans_rtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(trans_wtrans, rpi_axi_pmu_event_bcm2712_trans_wtrans,
+		      "monitor=0,bus=1,counter=2");
+PMU_EVENT_ATTR_STRING(trans_wtrans.scale, rpi_axi_pmu_event_bcm2712_trans_wtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(trans_wtrans.unit, rpi_axi_pmu_event_bcm2712_trans_wtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(jpeg_rtrans, rpi_axi_pmu_event_bcm2712_jpeg_rtrans,
+		      "monitor=0,bus=2,counter=4");
+PMU_EVENT_ATTR_STRING(jpeg_rtrans.scale, rpi_axi_pmu_event_bcm2712_jpeg_rtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(jpeg_rtrans.unit, rpi_axi_pmu_event_bcm2712_jpeg_rtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(jpeg_wtrans, rpi_axi_pmu_event_bcm2712_jpeg_wtrans,
+		      "monitor=0,bus=2,counter=2");
+PMU_EVENT_ATTR_STRING(jpeg_wtrans.scale, rpi_axi_pmu_event_bcm2712_jpeg_wtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(jpeg_wtrans.unit, rpi_axi_pmu_event_bcm2712_jpeg_wtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(system_uc_rtrans, rpi_axi_pmu_event_bcm2712_system_uc_rtrans,
+		      "monitor=0,bus=3,counter=4");
+PMU_EVENT_ATTR_STRING(system_uc_rtrans.scale, rpi_axi_pmu_event_bcm2712_system_uc_rtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(system_uc_rtrans.unit, rpi_axi_pmu_event_bcm2712_system_uc_rtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(system_uc_wtrans, rpi_axi_pmu_event_bcm2712_system_uc_wtrans,
+		      "monitor=0,bus=3,counter=2");
+PMU_EVENT_ATTR_STRING(system_uc_wtrans.scale, rpi_axi_pmu_event_bcm2712_system_uc_wtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(system_uc_wtrans.unit, rpi_axi_pmu_event_bcm2712_system_uc_wtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(dma_uc_rtrans, rpi_axi_pmu_event_bcm2712_dma_uc_rtrans,
+		      "monitor=0,bus=4,counter=4");
+PMU_EVENT_ATTR_STRING(dma_uc_rtrans.scale, rpi_axi_pmu_event_bcm2712_dma_uc_rtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(dma_uc_rtrans.unit, rpi_axi_pmu_event_bcm2712_dma_uc_rtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(dma_uc_wtrans, rpi_axi_pmu_event_bcm2712_dma_uc_wtrans,
+		      "monitor=0,bus=4,counter=2");
+PMU_EVENT_ATTR_STRING(dma_uc_wtrans.scale, rpi_axi_pmu_event_bcm2712_dma_uc_wtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(dma_uc_wtrans.unit, rpi_axi_pmu_event_bcm2712_dma_uc_wtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(system_l2_rtrans, rpi_axi_pmu_event_bcm2712_system_l2_rtrans,
+		      "monitor=0,bus=5,counter=4");
+PMU_EVENT_ATTR_STRING(system_l2_rtrans.scale, rpi_axi_pmu_event_bcm2712_system_l2_rtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(system_l2_rtrans.unit, rpi_axi_pmu_event_bcm2712_system_l2_rtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(system_l2_wtrans, rpi_axi_pmu_event_bcm2712_system_l2_wtrans,
+		      "monitor=0,bus=5,counter=2");
+PMU_EVENT_ATTR_STRING(system_l2_wtrans.scale, rpi_axi_pmu_event_bcm2712_system_l2_wtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(system_l2_wtrans.unit, rpi_axi_pmu_event_bcm2712_system_l2_wtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(pcie_rp1_rtrans, rpi_axi_pmu_event_bcm2712_pcie_rp1_rtrans,
+		      "monitor=0,bus=6,counter=4");
+PMU_EVENT_ATTR_STRING(pcie_rp1_rtrans.scale, rpi_axi_pmu_event_bcm2712_pcie_rp1_rtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(pcie_rp1_rtrans.unit, rpi_axi_pmu_event_bcm2712_pcie_rp1_rtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(pcie_rp1_wtrans, rpi_axi_pmu_event_bcm2712_pcie_rp1_wtrans,
+		      "monitor=0,bus=6,counter=2");
+PMU_EVENT_ATTR_STRING(pcie_rp1_wtrans.scale, rpi_axi_pmu_event_bcm2712_pcie_rp1_wtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(pcie_rp1_wtrans.unit, rpi_axi_pmu_event_bcm2712_pcie_rp1_wtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(hevc_dec_rtrans, rpi_axi_pmu_event_bcm2712_hevc_dec_rtrans,
+		      "monitor=0,bus=7,counter=4");
+PMU_EVENT_ATTR_STRING(hevc_dec_rtrans.scale, rpi_axi_pmu_event_bcm2712_hevc_dec_rtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(hevc_dec_rtrans.unit, rpi_axi_pmu_event_bcm2712_hevc_dec_rtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(hevc_dec_wtrans, rpi_axi_pmu_event_bcm2712_hevc_dec_wtrans,
+		      "monitor=0,bus=7,counter=2");
+PMU_EVENT_ATTR_STRING(hevc_dec_wtrans.scale, rpi_axi_pmu_event_bcm2712_hevc_dec_wtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(hevc_dec_wtrans.unit, rpi_axi_pmu_event_bcm2712_hevc_dec_wtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(a76_dsu_l3_rtrans, rpi_axi_pmu_event_bcm2712_a76_dsu_l3_rtrans,
+		      "monitor=0,bus=8,counter=4");
+PMU_EVENT_ATTR_STRING(a76_dsu_l3_rtrans.scale, rpi_axi_pmu_event_bcm2712_a76_dsu_l3_rtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(a76_dsu_l3_rtrans.unit, rpi_axi_pmu_event_bcm2712_a76_dsu_l3_rtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(a76_dsu_l3_wtrans, rpi_axi_pmu_event_bcm2712_a76_dsu_l3_wtrans,
+		      "monitor=0,bus=8,counter=2");
+PMU_EVENT_ATTR_STRING(a76_dsu_l3_wtrans.scale, rpi_axi_pmu_event_bcm2712_a76_dsu_l3_wtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(a76_dsu_l3_wtrans.unit, rpi_axi_pmu_event_bcm2712_a76_dsu_l3_wtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(hvs_rtrans, rpi_axi_pmu_event_bcm2712_hvs_rtrans,
+		      "monitor=0,bus=9,counter=4");
+PMU_EVENT_ATTR_STRING(hvs_rtrans.scale, rpi_axi_pmu_event_bcm2712_hvs_rtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(hvs_rtrans.unit, rpi_axi_pmu_event_bcm2712_hvs_rtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(hvs_wtrans, rpi_axi_pmu_event_bcm2712_hvs_wtrans,
+		      "monitor=0,bus=9,counter=2");
+PMU_EVENT_ATTR_STRING(hvs_wtrans.scale, rpi_axi_pmu_event_bcm2712_hvs_wtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(hvs_wtrans.unit, rpi_axi_pmu_event_bcm2712_hvs_wtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(v3d7_rtrans, rpi_axi_pmu_event_bcm2712_v3d7_rtrans,
+		      "monitor=0,bus=10,counter=4");
+PMU_EVENT_ATTR_STRING(v3d7_rtrans.scale, rpi_axi_pmu_event_bcm2712_v3d7_rtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(v3d7_rtrans.unit, rpi_axi_pmu_event_bcm2712_v3d7_rtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(v3d7_wtrans, rpi_axi_pmu_event_bcm2712_v3d7_wtrans,
+		      "monitor=0,bus=10,counter=2");
+PMU_EVENT_ATTR_STRING(v3d7_wtrans.scale, rpi_axi_pmu_event_bcm2712_v3d7_wtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(v3d7_wtrans.unit, rpi_axi_pmu_event_bcm2712_v3d7_wtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(isp_rtrans, rpi_axi_pmu_event_bcm2712_isp_rtrans,
+		      "monitor=0,bus=11,counter=4");
+PMU_EVENT_ATTR_STRING(isp_rtrans.scale, rpi_axi_pmu_event_bcm2712_isp_rtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(isp_rtrans.unit, rpi_axi_pmu_event_bcm2712_isp_rtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(isp_wtrans, rpi_axi_pmu_event_bcm2712_isp_wtrans,
+		      "monitor=0,bus=11,counter=2");
+PMU_EVENT_ATTR_STRING(isp_wtrans.scale, rpi_axi_pmu_event_bcm2712_isp_wtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(isp_wtrans.unit, rpi_axi_pmu_event_bcm2712_isp_wtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(peripheral_rtrans, rpi_axi_pmu_event_bcm2712_peripheral_rtrans,
+		      "monitor=0,bus=12,counter=4");
+PMU_EVENT_ATTR_STRING(peripheral_rtrans.scale,
+		      rpi_axi_pmu_event_bcm2712_peripheral_rtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(peripheral_rtrans.unit,
+		      rpi_axi_pmu_event_bcm2712_peripheral_rtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(peripheral_wtrans, rpi_axi_pmu_event_bcm2712_peripheral_wtrans,
+		      "monitor=0,bus=12,counter=2");
+PMU_EVENT_ATTR_STRING(peripheral_wtrans.scale,
+		      rpi_axi_pmu_event_bcm2712_peripheral_wtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(peripheral_wtrans.unit,
+		      rpi_axi_pmu_event_bcm2712_peripheral_wtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(cpu_uc_rtrans, rpi_axi_pmu_event_bcm2712_cpu_uc_rtrans,
+		      "monitor=0,bus=13,counter=4");
+PMU_EVENT_ATTR_STRING(cpu_uc_rtrans.scale, rpi_axi_pmu_event_bcm2712_cpu_uc_rtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(cpu_uc_rtrans.unit, rpi_axi_pmu_event_bcm2712_cpu_uc_rtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(cpu_uc_wtrans, rpi_axi_pmu_event_bcm2712_cpu_uc_wtrans,
+		      "monitor=0,bus=13,counter=2");
+PMU_EVENT_ATTR_STRING(cpu_uc_wtrans.scale, rpi_axi_pmu_event_bcm2712_cpu_uc_wtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(cpu_uc_wtrans.unit, rpi_axi_pmu_event_bcm2712_cpu_uc_wtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(cpu_l2_rtrans, rpi_axi_pmu_event_bcm2712_cpu_l2_rtrans,
+		      "monitor=0,bus=14,counter=4");
+PMU_EVENT_ATTR_STRING(cpu_l2_rtrans.scale, rpi_axi_pmu_event_bcm2712_cpu_l2_rtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(cpu_l2_rtrans.unit, rpi_axi_pmu_event_bcm2712_cpu_l2_rtrans_unit,
+		      "Bytes");
+PMU_EVENT_ATTR_STRING(cpu_l2_wtrans, rpi_axi_pmu_event_bcm2712_cpu_l2_wtrans,
+		      "monitor=0,bus=14,counter=2");
+PMU_EVENT_ATTR_STRING(cpu_l2_wtrans.scale, rpi_axi_pmu_event_bcm2712_cpu_l2_wtrans_scale,
+		      "32");
+PMU_EVENT_ATTR_STRING(cpu_l2_wtrans.unit, rpi_axi_pmu_event_bcm2712_cpu_l2_wtrans_unit,
+		      "Bytes");
+
+static struct attribute *rpi_axi_pmu_bcm2835_events[] = {
 	&rpi_axi_pmu_event_dma_l2_atrans.attr.attr,
 	&rpi_axi_pmu_event_dma_l2_atrans_scale.attr.attr,
 	&rpi_axi_pmu_event_dma_l2_atrans_unit.attr.attr,
@@ -1234,6 +1637,18 @@ static struct attribute *rpi_axi_pmu_events_attrs[] = {
 	&rpi_axi_pmu_event_h264_rtrans_scale.attr.attr,
 	&rpi_axi_pmu_event_h264_rtrans_unit.attr.attr,
 	&rpi_axi_pmu_event_h264_rtwait.attr.attr,
+	&rpi_axi_pmu_event_isp_atrans.attr.attr,
+	&rpi_axi_pmu_event_isp_atrans_scale.attr.attr,
+	&rpi_axi_pmu_event_isp_atrans_unit.attr.attr,
+	&rpi_axi_pmu_event_isp_atwait.attr.attr,
+	&rpi_axi_pmu_event_isp_wtrans.attr.attr,
+	&rpi_axi_pmu_event_isp_wtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_isp_wtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_isp_wtwait.attr.attr,
+	&rpi_axi_pmu_event_isp_rtrans.attr.attr,
+	&rpi_axi_pmu_event_isp_rtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_isp_rtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_isp_rtwait.attr.attr,
 	&rpi_axi_pmu_event_v3d_atrans.attr.attr,
 	&rpi_axi_pmu_event_v3d_atrans_scale.attr.attr,
 	&rpi_axi_pmu_event_v3d_atrans_unit.attr.attr,
@@ -1246,6 +1661,21 @@ static struct attribute *rpi_axi_pmu_events_attrs[] = {
 	&rpi_axi_pmu_event_v3d_rtrans_scale.attr.attr,
 	&rpi_axi_pmu_event_v3d_rtrans_unit.attr.attr,
 	&rpi_axi_pmu_event_v3d_rtwait.attr.attr,
+	&rpi_axi_pmu_event_peripheral_atrans.attr.attr,
+	&rpi_axi_pmu_event_peripheral_atrans_scale.attr.attr,
+	&rpi_axi_pmu_event_peripheral_atrans_unit.attr.attr,
+	&rpi_axi_pmu_event_cpu_uc_atrans.attr.attr,
+	&rpi_axi_pmu_event_cpu_uc_atrans_scale.attr.attr,
+	&rpi_axi_pmu_event_cpu_uc_atrans_unit.attr.attr,
+	&rpi_axi_pmu_event_cpu_uc_atwait.attr.attr,
+	&rpi_axi_pmu_event_cpu_uc_wtrans.attr.attr,
+	&rpi_axi_pmu_event_cpu_uc_wtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_cpu_uc_wtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_cpu_uc_wtwait.attr.attr,
+	&rpi_axi_pmu_event_cpu_uc_rtrans.attr.attr,
+	&rpi_axi_pmu_event_cpu_uc_rtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_cpu_uc_rtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_cpu_uc_rtwait.attr.attr,
 	&rpi_axi_pmu_event_cpu_l2_atrans.attr.attr,
 	&rpi_axi_pmu_event_cpu_l2_atrans_scale.attr.attr,
 	&rpi_axi_pmu_event_cpu_l2_atrans_unit.attr.attr,
@@ -1258,7 +1688,7 @@ static struct attribute *rpi_axi_pmu_events_attrs[] = {
 	&rpi_axi_pmu_event_cpu_l2_rtrans_scale.attr.attr,
 	&rpi_axi_pmu_event_cpu_l2_rtrans_unit.attr.attr,
 	&rpi_axi_pmu_event_cpu_l2_rtwait.attr.attr,
-	/* VPU Monitor events (RPi 1-4) */
+
 	&rpi_axi_pmu_event_vpu1_d_l2_atrans.attr.attr,
 	&rpi_axi_pmu_event_vpu1_d_l2_atrans_scale.attr.attr,
 	&rpi_axi_pmu_event_vpu1_d_l2_atrans_unit.attr.attr,
@@ -1328,7 +1758,7 @@ static struct attribute *rpi_axi_pmu_events_attrs[] = {
 	&rpi_axi_pmu_event_vpu_l2_in_atrans.attr.attr,
 	&rpi_axi_pmu_event_vpu_l2_in_atrans_scale.attr.attr,
 	&rpi_axi_pmu_event_vpu_l2_in_atrans_unit.attr.attr,
-	/* Filtered Event Aliases (RPi 1-4) */
+
 	&rpi_axi_pmu_event_cpu0_icache_rtrans.attr.attr,
 	&rpi_axi_pmu_event_cpu0_icache_rtrans_scale.attr.attr,
 	&rpi_axi_pmu_event_cpu0_icache_rtrans_unit.attr.attr,
@@ -1377,6 +1807,12 @@ static struct attribute *rpi_axi_pmu_events_attrs[] = {
 	&rpi_axi_pmu_event_hvs_system_l2_wtrans.attr.attr,
 	&rpi_axi_pmu_event_hvs_system_l2_wtrans_scale.attr.attr,
 	&rpi_axi_pmu_event_hvs_system_l2_wtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_isp_system_l2_rtrans.attr.attr,
+	&rpi_axi_pmu_event_isp_system_l2_rtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_isp_system_l2_rtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_isp_system_l2_wtrans.attr.attr,
+	&rpi_axi_pmu_event_isp_system_l2_wtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_isp_system_l2_wtrans_unit.attr.attr,
 	&rpi_axi_pmu_event_usb_system_l2_rtrans.attr.attr,
 	&rpi_axi_pmu_event_usb_system_l2_rtrans_scale.attr.attr,
 	&rpi_axi_pmu_event_usb_system_l2_rtrans_unit.attr.attr,
@@ -1384,11 +1820,111 @@ static struct attribute *rpi_axi_pmu_events_attrs[] = {
 	&rpi_axi_pmu_event_usb_system_l2_wtrans_scale.attr.attr,
 	&rpi_axi_pmu_event_usb_system_l2_wtrans_unit.attr.attr,
 	NULL,
+	NULL,
+};
+
+static struct attribute *rpi_axi_pmu_bcm2712_events[] = {
+	&rpi_axi_pmu_event_bcm2712_dma_l2_rtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_dma_l2_rtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_dma_l2_rtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_dma_l2_wtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_dma_l2_wtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_dma_l2_wtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_trans_rtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_trans_rtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_trans_rtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_trans_wtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_trans_wtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_trans_wtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_jpeg_rtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_jpeg_rtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_jpeg_rtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_jpeg_wtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_jpeg_wtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_jpeg_wtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_system_uc_rtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_system_uc_rtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_system_uc_rtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_system_uc_wtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_system_uc_wtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_system_uc_wtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_dma_uc_rtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_dma_uc_rtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_dma_uc_rtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_dma_uc_wtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_dma_uc_wtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_dma_uc_wtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_system_l2_rtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_system_l2_rtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_system_l2_rtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_system_l2_wtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_system_l2_wtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_system_l2_wtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_pcie_rp1_rtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_pcie_rp1_rtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_pcie_rp1_rtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_pcie_rp1_wtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_pcie_rp1_wtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_pcie_rp1_wtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_hevc_dec_rtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_hevc_dec_rtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_hevc_dec_rtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_hevc_dec_wtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_hevc_dec_wtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_hevc_dec_wtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_a76_dsu_l3_rtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_a76_dsu_l3_rtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_a76_dsu_l3_rtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_a76_dsu_l3_wtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_a76_dsu_l3_wtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_a76_dsu_l3_wtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_hvs_rtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_hvs_rtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_hvs_rtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_hvs_wtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_hvs_wtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_hvs_wtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_v3d7_rtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_v3d7_rtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_v3d7_rtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_v3d7_wtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_v3d7_wtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_v3d7_wtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_isp_rtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_isp_rtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_isp_rtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_isp_wtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_isp_wtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_isp_wtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_peripheral_rtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_peripheral_rtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_peripheral_rtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_peripheral_wtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_peripheral_wtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_peripheral_wtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_cpu_uc_rtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_cpu_uc_rtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_cpu_uc_rtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_cpu_uc_wtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_cpu_uc_wtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_cpu_uc_wtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_cpu_l2_rtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_cpu_l2_rtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_cpu_l2_rtrans_unit.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_cpu_l2_wtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_cpu_l2_wtrans_scale.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_cpu_l2_wtrans_unit.attr.attr,
+	NULL,
 };
 
-static const struct attribute_group rpi_axi_pmu_events_group = {
+static const struct attribute_group rpi_axi_pmu_bcm2835_events_group = {
 	.name = "events",
-	.attrs = rpi_axi_pmu_events_attrs,
+	.attrs = rpi_axi_pmu_bcm2835_events,
+};
+
+static const struct attribute_group rpi_axi_pmu_bcm2712_events_group = {
+	.name = "events",
+	.attrs = rpi_axi_pmu_bcm2712_events,
 };
 
 /**
@@ -1417,9 +1953,16 @@ static const struct attribute_group rpi_axi_pmu_cpumask_group = {
 	.attrs = rpi_axi_pmu_cpumask_attrs,
 };
 
-static const struct attribute_group *rpi_axi_pmu_attr_groups[] = {
+static const struct attribute_group *rpi_axi_pmu_bcm2835_attr_groups[] = {
 	&rpi_axi_pmu_format_group,
-	&rpi_axi_pmu_events_group,
+	&rpi_axi_pmu_bcm2835_events_group,
+	&rpi_axi_pmu_cpumask_group,
+	NULL,
+};
+
+static const struct attribute_group *rpi_axi_pmu_bcm2712_attr_groups[] = {
+	&rpi_axi_pmu_format_group,
+	&rpi_axi_pmu_bcm2712_events_group,
 	&rpi_axi_pmu_cpumask_group,
 	NULL,
 };
@@ -2140,7 +2683,6 @@ static int rpi_axi_pmu__init(struct rpi_axi_pmu *pmu, struct platform_device *pd
 
 	pmu->pmu = (struct pmu) {
 		.module = THIS_MODULE,
-		.attr_groups	= rpi_axi_pmu_attr_groups,
 		.task_ctx_nr    = perf_invalid_context,
 		.event_init     = rpi_axi_pmu_event_init,
 		.add            = rpi_axi_pmu_add,
@@ -2205,6 +2747,12 @@ static int rpi_axi_pmu__init(struct rpi_axi_pmu *pmu, struct platform_device *pd
 	}
 
 	cpus_read_lock();
+
+	if (pmu->chip == CHIP_BCM2712)
+		pmu->pmu.attr_groups = rpi_axi_pmu_bcm2712_attr_groups;
+	else
+		pmu->pmu.attr_groups = rpi_axi_pmu_bcm2835_attr_groups;
+
 	ret = perf_pmu_register(&pmu->pmu, PMU_NAME, /*type=*/-1);
 	if (ret) {
 		cpus_read_unlock();
@@ -2294,6 +2842,10 @@ static const struct of_device_id rpi_axi_pmu_match[] = {
 		.compatible = "brcm,bcm2711-axiperf",
 		.data = (void *)CHIP_BCM2835,
 	},
+	{
+		.compatible = "brcm,bcm2712-axiperf",
+		.data = (void *)CHIP_BCM2712,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rpi_axi_pmu_match);
-- 
2.55.0.691.gc56d675ccc-goog

