Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31686331ED1
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 05:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786598680; cv=none; b=cg2xxgtXepcZqz80RWKSELJvln62ShEo3DU49/T1mK2Yv6YrIicP7BDr5zGHbTUeZzsgt6XkZIob65I0sQ3orN/Gr7jKVqIlHSXj04hw1DKvLS1kelmq9/tvWOsN7Wk+zFKPKsPFim2mjJbvFq2mhQhIiPHEVjzTpDdAxAjVhWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786598680; c=relaxed/simple;
	bh=C6T519CxdXc6NmXgLM+Mb6hJ4E0SAmAz01fF653GqCU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cIBQi7Ha8OISzAvuxhMHDpeS1GQBJcDaUWDJTos7ID6PK/qwTD8GscJW69u/Hq7k/mX2X5WW/f0oifZejJlb8yAzf8le9EfBM7zxkJOQ5TJhfw5g6X9Yab+Ok162SpE/25N6ohFLdvQO7ei0lFUBIRrUZrBv5ZY58lFd8gpMSSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vSEEmZ3l; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vSEEmZ3l"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84a3514f912so2898453b3a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 22:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786598666; x=1787203466; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ydkjDPY8OIg1uOSSajI8hORDW4sYt4UTkqDjJueQMEE=;
        b=vSEEmZ3leL9h/xY/lhn7uuRDLKMnwaq6mUlO502zU4g67v89NYvk9lDDShmafus+sL
         0pW1dGOvZihfIN1w3HV1SyeU60uPKsN73tNWQp/GQ5V9PNNKrIt5wGwOeq5m7F++PYh0
         xRBZojlicbYjRg/mkAI0C7XfLWd8CuGFPsCo8D0m/UiNrmm3+P+/Og0n1vhjzaODtBcE
         Ifg5YJk2RG7Z8usl3Z320jnkmNc3FeRflUZI5PhHhvRZQahfM8A86ST6jlLllcKT64E9
         U5gb0a9ufS+N9qx/NGhwinVBmeKREvki5VYCQ0Y5w1YBpdMDBQSQT2P8Z2k/Ll+CAaXg
         OKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786598666; x=1787203466;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ydkjDPY8OIg1uOSSajI8hORDW4sYt4UTkqDjJueQMEE=;
        b=Gtr4pDlDs4QaJe60+cFbsLq0Sf6o9IL9zP3yD+dmNdPiKqtZXYQ+B4atVBDm5TNnf8
         vK7JKlCnrifPC4WoEK50ENdswFW33CBaEZcaA8dmCztah9LjcA6/+k4SXw0fVHFBQ0+M
         nIjFeSH0YOCQnLK/kjlCe4mAn7ofOz9oqN7eu0+ywgwmQ6bmUEiaNW+szwFxD9RuevSr
         v0AgI1sV9a9Z6REUGEoDeZ0XAWsYhws3A4ltuhttfnG8CytWmnN9tsgiHDTGgR3EcN5u
         OSRH7R8pK+kM9dmtri/tn1SsgyHUDeWotDqZMD00FaHXj3qL8YoifG3GOVgdxBHMRfd6
         4y0w==
X-Forwarded-Encrypted: i=1; AHgh+RpfjWrpnfle654cKxk1efLh1F9IuXUGUygoDL0V+XyTP86t7ssamleXQVOC8NO4hhgCWrovf40PZ5zquY8WSrJg@vger.kernel.org
X-Gm-Message-State: AOJu0YyBFmrxamd23u4qnz0SvxzK9qNxdmShVs8MdM0yoS9m+oxX4XIF
	/J5On5sAcPXXC/VCl0zy6JBr8dwxfjE0QTd+XNrY5NolsKevjDxxIgBUpYwdYQOqAi/c69vF2RP
	UoQ2MQ2tAPg==
X-Received: from dlbvs14.prod.google.com ([2002:a05:7022:3f0e:b0:13d:2928:7996])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4cc3:b0:3c3:7cfe:b32a
 with SMTP id adf61e73a8af0-3cc55484a40mr4993845637.27.1786598666065; Wed, 12
 Aug 2026 22:24:26 -0700 (PDT)
Date: Wed, 12 Aug 2026 22:24:18 -0700
In-Reply-To: <20260813052419.2770841-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813043533.2744442-1-irogers@google.com> <20260813052419.2770841-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813052419.2770841-3-irogers@google.com>
Subject: [PATCH v7 2/2] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mark.rutland@arm.com, u.kleine-koenig@baylibre.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/perf/rpi_axi_pmu.c | 308 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 300 insertions(+), 8 deletions(-)

diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
index bd3c79dd2ff8..a843e8636d81 100644
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
@@ -126,6 +130,43 @@ enum bcm2835_system_bus {
 	BCM2835_SB__MAX
 };
 
+/**
+ * enum bcm2712_system_bus - AXI buses monitored by System Monitor on BCM2712 (RPi 5)
+ * @BCM2712_SB__DMA_L2: DMA engine L2 cache interconnect bus
+ * @BCM2712_SB__TRANS: Transposer engine bus
+ * @BCM2712_SB__JPEG: Hardware JPEG codec acceleration bus
+ * @BCM2712_SB__SYSTEM_UC: System Uncached memory bus
+ * @BCM2712_SB__DMA_UC: DMA Uncached memory bus
+ * @BCM2712_SB__SYSTEM_L2: System main L2 cache bus
+ * @BCM2712_SB__PCIE_RP1: PCIe 2.0 x4 RP1 Southbridge link bus (USB 3.0, Ethernet, I/O)
+ * @BCM2712_SB__HEVC_DEC: HEVC (H.265) hardware video decoder bus
+ * @BCM2712_SB__A76_DSU_L3: Quad-core Arm Cortex-A76 DynamIQ Shared Unit (DSU) L3 bus
+ * @BCM2712_SB__HVS: Hardware Video Scaler (HVS) display composition engine bus
+ * @BCM2712_SB__V3D7: VideoCore VII 3D graphics hardware pipeline bus
+ * @BCM2712_SB__ISP: Image Sensor Processor (ISP) camera pipeline bus
+ * @BCM2712_SB__PERIPHERAL: System peripherals bus
+ * @BCM2712_SB__CPU_UC: CPU Uncached memory bus
+ * @BCM2712_SB__CPU_L2: CPU L2 cache bus
+ * @BCM2712_SB__MAX: Total count of monitored system buses on BCM2712
+ */
+enum bcm2712_system_bus {
+	BCM2712_SB__DMA_L2 = 0,
+	BCM2712_SB__TRANS,
+	BCM2712_SB__JPEG,
+	BCM2712_SB__SYSTEM_UC,
+	BCM2712_SB__DMA_UC,
+	BCM2712_SB__SYSTEM_L2,
+	BCM2712_SB__PCIE_RP1,
+	BCM2712_SB__HEVC_DEC,
+	BCM2712_SB__A76_DSU_L3,
+	BCM2712_SB__HVS,
+	BCM2712_SB__V3D7,
+	BCM2712_SB__ISP,
+	BCM2712_SB__PERIPHERAL,
+	BCM2712_SB__CPU_UC,
+	BCM2712_SB__CPU_L2,
+	BCM2712_SB__MAX
+};
 
 /**
  * enum vpu_bus - AXI buses monitored by VPU Monitor on BCM2835-BCM2711 (RPi 1-4)
@@ -259,6 +300,93 @@ enum bcm2835_filter {
 	BCM2835_FLT__MAX
 };
 
+/**
+ * enum bcm2712_filter - AXI master ID filter options for BCM2712 (RPi 5)
+ * @BCM2712_FLT__NONE: Disable master ID filtering (monitor all traffic on bus)
+ * @BCM2712_FLT__VPU_UC0: VPU Uncached 0 master ID
+ * @BCM2712_FLT__VPU_IC0: VPU I-Cache 0 master ID
+ * @BCM2712_FLT__VPU_DC0: VPU D-Cache 0 master ID
+ * @BCM2712_FLT__VPU_UC1: VPU Uncached 1 master ID
+ * @BCM2712_FLT__VPU_IC1: VPU I-Cache 1 master ID
+ * @BCM2712_FLT__VPU_DC1: VPU D-Cache 1 master ID
+ * @BCM2712_FLT__VPU_L2: VPU L2 Cache master ID
+ * @BCM2712_FLT__DMA2: DMA2 master ID
+ * @BCM2712_FLT__VPU_DEBUG: VPU Debug master ID
+ * @BCM2712_FLT__ARM: Arm Quad-Core CPU Cluster master ID
+ * @BCM2712_FLT__DMA0: DMA0 master ID
+ * @BCM2712_FLT__DMA1: DMA1 master ID
+ * @BCM2712_FLT__RAAGA: RAAGA Audio Engine master ID
+ * @BCM2712_FLT__BBSI: BBSI master ID
+ * @BCM2712_FLT__PCIE0: RP1 PCIe Southbridge 0 master ID
+ * @BCM2712_FLT__PCIE1: PCIe 1 master ID
+ * @BCM2712_FLT__PCIE2: PCIe 2 master ID
+ * @BCM2712_FLT__UMR: UMR master ID
+ * @BCM2712_FLT__SAGE: SAGE master ID
+ * @BCM2712_FLT__HVDP: HVDP master ID
+ * @BCM2712_FLT__BSP: BSP master ID
+ * @BCM2712_FLT__HVS: Hardware Video Scaler (HVS) display engine master ID
+ * @BCM2712_FLT__HVS_WMK: HVS Watermark master ID
+ * @BCM2712_FLT__MOP0: MOP0 master ID
+ * @BCM2712_FLT__MOP1: MOP1 master ID
+ * @BCM2712_FLT__MBVN: MBVN master ID
+ * @BCM2712_FLT__DSI: DSI Display Interface master ID
+ * @BCM2712_FLT__XPT: XPT master ID
+ * @BCM2712_FLT__EMMC0: SD/eMMC Controller 0 master ID
+ * @BCM2712_FLT__GENET: Gigabit Ethernet Controller master ID
+ * @BCM2712_FLT__USB: USB Controller master ID
+ * @BCM2712_FLT__MAX: Maximum filter ID count for BCM2712
+ */
+enum bcm2712_filter {
+	BCM2712_FLT__NONE = 0,
+	BCM2712_FLT__VPU_UC0 = 1,
+	BCM2712_FLT__VPU_IC0 = 2,
+	BCM2712_FLT__VPU_DC0 = 3,
+	BCM2712_FLT__VPU_UC1 = 4,
+	BCM2712_FLT__VPU_IC1 = 5,
+	BCM2712_FLT__VPU_DC1 = 6,
+	BCM2712_FLT__VPU_L2 = 7,
+	BCM2712_FLT__DMA2 = 8,
+	BCM2712_FLT__VPU_DEBUG = 9,
+	BCM2712_FLT__ARM = 10,
+	BCM2712_FLT__DMA0 = 11,
+	BCM2712_FLT__DMA1 = 12,
+	BCM2712_FLT__RAAGA = 13,
+	BCM2712_FLT__BBSI = 14,
+	BCM2712_FLT__PCIE0 = 15,
+	BCM2712_FLT__PCIE1 = 16,
+	BCM2712_FLT__PCIE2 = 17,
+	BCM2712_FLT__UMR = 18,
+	BCM2712_FLT__SAGE = 19,
+	BCM2712_FLT__HVDP = 20,
+	BCM2712_FLT__BSP = 21,
+	BCM2712_FLT__HVS = 22,
+	BCM2712_FLT__HVS_WMK = 23,
+	BCM2712_FLT__MOP0 = 24,
+	BCM2712_FLT__MOP1 = 25,
+	BCM2712_FLT__MBVN = 26,
+	BCM2712_FLT__DSI = 27,
+	BCM2712_FLT__XPT = 28,
+	BCM2712_FLT__EMMC0 = 29,
+	BCM2712_FLT__GENET = 30,
+	BCM2712_FLT__USB = 31,
+	BCM2712_FLT__MAX = 32
+};
+
+/* Compile-time static assertions verifying cross-generation enum equivalence */
+static_assert((int)BCM2835_FLT__NONE == (int)BCM2712_FLT__NONE,
+	      "Filter NONE enum value mismatch across BCM2835 and BCM2712");
+static_assert((int)BCM2835_SB__DMA_L2 == (int)BCM2712_SB__DMA_L2,
+	      "DMA_L2 bus enum value mismatch across BCM2835 and BCM2712");
+static_assert((int)BCM2835_SB__TRANS == (int)BCM2712_SB__TRANS,
+	      "TRANS bus enum value mismatch across BCM2835 and BCM2712");
+static_assert((int)BCM2835_SB__JPEG == (int)BCM2712_SB__JPEG,
+	      "JPEG bus enum value mismatch across BCM2835 and BCM2712");
+static_assert((int)BCM2835_SB__SYSTEM_UC == (int)BCM2712_SB__SYSTEM_UC,
+	      "SYSTEM_UC bus enum value mismatch across BCM2835 and BCM2712");
+static_assert((int)BCM2835_SB__DMA_UC == (int)BCM2712_SB__DMA_UC,
+	      "DMA_UC bus enum value mismatch across BCM2835 and BCM2712");
+static_assert((int)BCM2835_SB__SYSTEM_L2 == (int)BCM2712_SB__SYSTEM_L2,
+	      "SYSTEM_L2 bus enum value mismatch across BCM2835 and BCM2712");
 
 /* Hardware register offsets & control bitwise constants */
 #define GEN_CTRL			0x00
@@ -435,7 +563,7 @@ static int rpi_axi_hw_events__get_alloc_event_idx(struct rpi_axi_hw_events *hw_e
  * struct rpi_axi_pmu - Root PMU driver context
  * @pmu: Core Linux perf PMU structure
  * @pdev: Owning platform_device pointer
- * @chip: Detected Broadcom SoC generation
+ * @chip: Detected Broadcom SoC generation (CHIP_BCM2835 or CHIP_BCM2712)
  * @firmware: Raspberry Pi firmware handle for VideoCore mailbox calls (BCM2835-BCM2711)
  * @cpu: CPU core assigned to process uncore PMU events
  * @cpuhp_node: Dynamic CPU hotplug instance node
@@ -495,15 +623,24 @@ static bool config_is_valid(struct rpi_axi_pmu *pmu, __u64 config)
 	if (!pmu->monitor[mon].use_mailbox_interface && !pmu->monitor[mon].base_address)
 		return false;
 
-	if (mon == MON__SYSTEM) {
-		if (bus >= BCM2835_SB__MAX)
+	if (pmu->chip == CHIP_BCM2712) {
+		if (mon != MON__SYSTEM)
+			return false;
+		if (bus >= BCM2712_SB__MAX)
+			return false;
+		if (filter >= BCM2712_FLT__MAX)
 			return false;
 	} else {
-		if (bus >= VPU__MAX)
+		if (mon == MON__SYSTEM) {
+			if (bus >= BCM2835_SB__MAX)
+				return false;
+		} else {
+			if (bus >= VPU__MAX)
+				return false;
+		}
+		if (filter >= BCM2835_FLT__MAX)
 			return false;
 	}
-	if (filter >= BCM2835_FLT__MAX)
-		return false;
 	return counter < CNT__MAX;
 }
 
@@ -529,7 +666,7 @@ static const struct attribute_group rpi_axi_pmu_format_group = {
  * Event Attribute Scaling & Unit Definitions:
  *
  * Uncore AXI bus transaction events (_rtrans, _wtrans, _atrans) report hardware
- * transaction beats. On Broadcom BCM2835 AXI interconnects, single-beat
+ * transaction beats. On Broadcom BCM2835-BCM2712 AXI interconnects, single-beat
  * transactions transfer 32 bytes per beat, while contiguous DMA page bursts may
  * use 64-byte double-beats. Setting .scale="32" and .unit="Bytes" provides a
  * close (~95%) byte throughput approximation in perf stat output (accounting for
@@ -867,6 +1004,75 @@ PMU_EVENT_ATTR_STRING(usb_system_l2_rtrans, rpi_axi_pmu_event_usb_system_l2_rtra
 PMU_EVENT_ATTR_STRING(usb_system_l2_wtrans, rpi_axi_pmu_event_usb_system_l2_wtrans,
 		      "monitor=0,bus=5,counter=2,filter=24");
 
+/* --- RASPBERRY PI 5 (BCM2712) EXPANDED EVENT ALIASES ---------------------- */
+
+/* PCIe 2.0 x4 RP1 Southbridge Link Bus Events & Stall Wait Cycles (bus=6, BCM2712_SB__PCIE_RP1) */
+PMU_EVENT_ATTR_STRING(pcie_rp1_atrans, rpi_axi_pmu_event_pcie_rp1_atrans,
+		      "monitor=0,bus=6,counter=0");
+PMU_EVENT_ATTR_STRING(pcie_rp1_atwait, rpi_axi_pmu_event_pcie_rp1_atwait,
+		      "monitor=0,bus=6,counter=1");
+PMU_EVENT_ATTR_STRING(pcie_rp1_wtrans, rpi_axi_pmu_event_pcie_rp1_wtrans,
+		      "monitor=0,bus=6,counter=2");
+PMU_EVENT_ATTR_STRING(pcie_rp1_wtwait, rpi_axi_pmu_event_pcie_rp1_wtwait,
+		      "monitor=0,bus=6,counter=3");
+PMU_EVENT_ATTR_STRING(pcie_rp1_rtrans, rpi_axi_pmu_event_pcie_rp1_rtrans,
+		      "monitor=0,bus=6,counter=4");
+PMU_EVENT_ATTR_STRING(pcie_rp1_rtwait, rpi_axi_pmu_event_pcie_rp1_rtwait,
+		      "monitor=0,bus=6,counter=5");
+
+/* HEVC (H.265) Hardware Video Decoder Bus Events (bus=7, BCM2712_SB__HEVC_DEC) */
+PMU_EVENT_ATTR_STRING(hevc_dec_atrans, rpi_axi_pmu_event_hevc_dec_atrans,
+		      "monitor=0,bus=7,counter=0");
+PMU_EVENT_ATTR_STRING(hevc_dec_wtrans, rpi_axi_pmu_event_hevc_dec_wtrans,
+		      "monitor=0,bus=7,counter=2");
+PMU_EVENT_ATTR_STRING(hevc_dec_rtrans, rpi_axi_pmu_event_hevc_dec_rtrans,
+		      "monitor=0,bus=7,counter=4");
+
+/* Arm Cortex-A76 DSU L3 Interconnect Bus Events (bus=8, BCM2712_SB__A76_DSU_L3) */
+PMU_EVENT_ATTR_STRING(a76_dsu_l3_atrans, rpi_axi_pmu_event_a76_dsu_l3_atrans,
+		      "monitor=0,bus=8,counter=0");
+PMU_EVENT_ATTR_STRING(a76_dsu_l3_wtrans, rpi_axi_pmu_event_a76_dsu_l3_wtrans,
+		      "monitor=0,bus=8,counter=2");
+PMU_EVENT_ATTR_STRING(a76_dsu_l3_rtrans, rpi_axi_pmu_event_a76_dsu_l3_rtrans,
+		      "monitor=0,bus=8,counter=4");
+
+/* VideoCore VII 3D Graphics Pipeline Bus Events (bus=10, BCM2712_SB__V3D7) */
+PMU_EVENT_ATTR_STRING(v3d7_atrans, rpi_axi_pmu_event_v3d7_atrans,
+		      "monitor=0,bus=10,counter=0");
+PMU_EVENT_ATTR_STRING(v3d7_wtrans, rpi_axi_pmu_event_v3d7_wtrans,
+		      "monitor=0,bus=10,counter=2");
+PMU_EVENT_ATTR_STRING(v3d7_rtrans, rpi_axi_pmu_event_v3d7_rtrans,
+		      "monitor=0,bus=10,counter=4");
+
+/*
+ * Quad-Core Arm Cortex-A76 Cores 0-3 I-Cache & D-Cache Filtered Events
+ * (bus=14, BCM2712_SB__CPU_L2)
+ */
+PMU_EVENT_ATTR_STRING(bcm2712_peripheral_rtrans, rpi_axi_pmu_event_bcm2712_peripheral_rtrans,
+		      "monitor=0,bus=12,counter=4");
+PMU_EVENT_ATTR_STRING(bcm2712_peripheral_wtrans, rpi_axi_pmu_event_bcm2712_peripheral_wtrans,
+		      "monitor=0,bus=12,counter=2");
+PMU_EVENT_ATTR_STRING(bcm2712_cpu_uc_rtrans, rpi_axi_pmu_event_bcm2712_cpu_uc_rtrans,
+		      "monitor=0,bus=13,counter=4");
+PMU_EVENT_ATTR_STRING(bcm2712_cpu_uc_wtrans, rpi_axi_pmu_event_bcm2712_cpu_uc_wtrans,
+		      "monitor=0,bus=13,counter=2");
+
+/* BCM2712 Master ID Filtered Events */
+PMU_EVENT_ATTR_STRING(arm_rtrans, rpi_axi_pmu_event_arm_rtrans,
+		      "monitor=0,bus=14,counter=4,filter=10");
+PMU_EVENT_ATTR_STRING(arm_wtrans, rpi_axi_pmu_event_arm_wtrans,
+		      "monitor=0,bus=14,counter=2,filter=10");
+PMU_EVENT_ATTR_STRING(pcie0_rtrans, rpi_axi_pmu_event_pcie0_rtrans,
+		      "monitor=0,bus=6,counter=4,filter=15");
+PMU_EVENT_ATTR_STRING(pcie0_wtrans, rpi_axi_pmu_event_pcie0_wtrans,
+		      "monitor=0,bus=6,counter=2,filter=15");
+PMU_EVENT_ATTR_STRING(hvs_filtered_rtrans, rpi_axi_pmu_event_hvs_filtered_rtrans,
+		      "monitor=0,bus=9,counter=4,filter=22");
+PMU_EVENT_ATTR_STRING(emmc0_rtrans, rpi_axi_pmu_event_emmc0_rtrans,
+		      "monitor=0,bus=5,counter=4,filter=29");
+PMU_EVENT_ATTR_STRING(emmc0_wtrans, rpi_axi_pmu_event_emmc0_wtrans,
+		      "monitor=0,bus=5,counter=2,filter=29");
+
 static struct attribute *rpi_axi_pmu_events_attrs[] = {
 	/* System Monitor events */
 	&rpi_axi_pmu_event_dma_l2_atrans.attr.attr,
@@ -1024,6 +1230,38 @@ static struct attribute *rpi_axi_pmu_events_attrs[] = {
 	&rpi_axi_pmu_event_usb_system_l2_rtrans.attr.attr,
 	&rpi_axi_pmu_event_usb_system_l2_wtrans.attr.attr,
 
+	/* RPi 5 (BCM2712) Expanded Event Aliases */
+	&rpi_axi_pmu_event_pcie_rp1_atrans.attr.attr,
+	&rpi_axi_pmu_event_pcie_rp1_atwait.attr.attr,
+	&rpi_axi_pmu_event_pcie_rp1_wtrans.attr.attr,
+	&rpi_axi_pmu_event_pcie_rp1_wtwait.attr.attr,
+	&rpi_axi_pmu_event_pcie_rp1_rtrans.attr.attr,
+	&rpi_axi_pmu_event_pcie_rp1_rtwait.attr.attr,
+
+	&rpi_axi_pmu_event_hevc_dec_atrans.attr.attr,
+	&rpi_axi_pmu_event_hevc_dec_wtrans.attr.attr,
+	&rpi_axi_pmu_event_hevc_dec_rtrans.attr.attr,
+
+	&rpi_axi_pmu_event_a76_dsu_l3_atrans.attr.attr,
+	&rpi_axi_pmu_event_a76_dsu_l3_wtrans.attr.attr,
+	&rpi_axi_pmu_event_a76_dsu_l3_rtrans.attr.attr,
+
+	&rpi_axi_pmu_event_v3d7_atrans.attr.attr,
+	&rpi_axi_pmu_event_v3d7_wtrans.attr.attr,
+	&rpi_axi_pmu_event_v3d7_rtrans.attr.attr,
+
+	&rpi_axi_pmu_event_bcm2712_peripheral_rtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_peripheral_wtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_cpu_uc_rtrans.attr.attr,
+	&rpi_axi_pmu_event_bcm2712_cpu_uc_wtrans.attr.attr,
+
+	&rpi_axi_pmu_event_arm_rtrans.attr.attr,
+	&rpi_axi_pmu_event_arm_wtrans.attr.attr,
+	&rpi_axi_pmu_event_pcie0_rtrans.attr.attr,
+	&rpi_axi_pmu_event_pcie0_wtrans.attr.attr,
+	&rpi_axi_pmu_event_hvs_filtered_rtrans.attr.attr,
+	&rpi_axi_pmu_event_emmc0_rtrans.attr.attr,
+	&rpi_axi_pmu_event_emmc0_wtrans.attr.attr,
 	NULL,
 };
 
@@ -1034,12 +1272,62 @@ static struct attribute *rpi_axi_pmu_events_attrs[] = {
  * @unused: Index (unused)
  *
  * Dynamically filters sysfs event aliases based on the detected Broadcom SoC generation:
+ * - On BCM2712 (RPi 5): Hides VideoCore VPU Mailbox IPC events (monitor=1).
+ * - On BCM2835-BCM2711 (RPi 1-4): Hides Cortex-A76 and RP1 PCIe specific events.
  *
  * Return: attr->mode (0444) if visible on current SoC, 0 to hide.
  */
 static umode_t rpi_axi_pmu_events_is_visible(struct kobject *kobj,
 					      struct attribute *attr, int unused)
 {
+	struct device *dev = kobj_to_dev(kobj);
+	struct pmu *pmu = dev_get_drvdata(dev);
+	struct rpi_axi_pmu *rpi_pmu = pmu_to_rpi_axi_pmu(pmu);
+	struct perf_pmu_events_attr *pmu_attr;
+
+	pmu_attr = container_of(attr, struct perf_pmu_events_attr, attr.attr);
+
+	if (rpi_pmu->chip == CHIP_BCM2712) {
+		/*
+		 * On RPi 5 (BCM2712), hide legacy VPU Mailbox IPC events (monitor=1)
+		 * and legacy RPi 1-4 System Monitor aliases
+		 */
+		if (strstr(pmu_attr->event_str, "monitor=1") ||
+		    strstr(attr->name, "cpu0_") ||
+		    strstr(attr->name, "cpu1_") ||
+		    strstr(attr->name, "dma0_") ||
+		    strstr(attr->name, "dma1_") ||
+		    strstr(attr->name, "v3d0_") ||
+		    strstr(attr->name, "v3d1_") ||
+		    strstr(attr->name, "hvs_system") ||
+		    strstr(attr->name, "isp_system") ||
+		    strstr(attr->name, "usb_system") ||
+		    strstr(attr->name, "ccp2tx_") ||
+		    strstr(attr->name, "mphi_") ||
+		    strstr(attr->name, "h264_") ||
+		    strstr(attr->name, "v3d_") ||
+		    (strstr(attr->name, "peripheral_") && !strstr(attr->name, "bcm2712_")) ||
+		    (strstr(attr->name, "cpu_uc_") && !strstr(attr->name, "bcm2712_")) ||
+		    strstr(attr->name, "cpu_l2_") ||
+		    strstr(attr->name, "l2_control_") ||
+		    strstr(attr->name, "system_control_") ||
+		    strstr(attr->name, "direct_control_") ||
+		    strstr(attr->name, "direct_data_"))
+			return 0;
+	} else {
+		/* On RPi 1-4 (BCM2835-BCM2711), hide RPi 5 specific events */
+		if (strstr(attr->name, "pcie_rp1") ||
+		    strstr(attr->name, "a76_") ||
+		    strstr(attr->name, "v3d7_") ||
+		    strstr(attr->name, "hevc_dec") ||
+		    strstr(attr->name, "arm_") ||
+		    strstr(attr->name, "pcie0_") ||
+		    strstr(attr->name, "hvs_filtered") ||
+		    strstr(attr->name, "emmc0_") ||
+		    strstr(attr->name, "bcm2712_"))
+			return 0;
+	}
+
 	return attr->mode;
 }
 
@@ -1370,7 +1658,7 @@ static void rpi_axi_pmu_read(struct perf_event *event)
 	u32 delta;
 
 	/* Mailbox VPU counters are polled asynchronously in background vpu_work.
-	 * MMIO monitors (System) are read synchronously.
+	 * MMIO monitors (System and BCM2712 VPU) are read synchronously.
 	 */
 	if (event->hw.idx < 0)
 		return;
@@ -1938,6 +2226,10 @@ static const struct of_device_id rpi_axi_pmu_match[] = {
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

