Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0B53C4176
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Oct 2026 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790963890; cv=none; b=V4zZo5VgH3ESTk2FZuvGhuH/wstQDIpn/SGtHeQjbc5FCqx9Dn/RTKXeIfMr3wZ5OXcFmVTFW8qW13GiJeOFBg6DY72d3TLWH7YBIT1AgQomUqXqOWNHm64dE1JdeuHRJRNMuspCYmAQc1dpcqKkle19xUS5vsdeENcftPnEjjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790963890; c=relaxed/simple;
	bh=FZm3YRoZutowTSGphmf7l1MumuCN+hnycUNV35Ztp2o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s3r8KUtXh463MlSzS6oXK6RhHVs5A2t53BKQT0re46XwL/PrrZQn4JWlv1AUsP66D4jL5bHOyx5jF0PWoGR0VpY43APT4SPaIXypDVW5NBqdrjvS/8lZbnMvZ9e4khmD45LY51IPmubl22vUOH8tMB+gc8xSCK8cYqvNmI51M44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=frokHPBZ; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="frokHPBZ"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-147be78cd56so8154373c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 10:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790963880; x=1791568680; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DuOJRxzEd2+FACdWVRDk//utgfeiIB44ZaTLC0WonWg=;
        b=frokHPBZG6SJTXNfs725TKD4iaWAQOH1Xz7Bs76Yw6PJVvFTH5PkjhCRK+zAoR4y8n
         /OmlZEh4hyFkaPR9Ap8bFk7dQkHsvjNN/6Go+jXHYawvx9NE5TZWMddeM2zMUqsYo9V0
         GV0h+75sK8K35l5fHm2PaH7gGaKVIngAW3QhHO50wV3eeaAsG2FMniQ1BPfibs3CV8XC
         irXPF8W7VzjqqT6BDGu+tc/mjdkd+oeYv1EGAPWbTJgiDze6MZfOvrXSje1H56iRLjyY
         nDj3VxNWJwMttvSAIiS9SLoA/wH9UpneTfPp7+T1ylz4tCEgzOm+4aC2yDCHZdlKLESl
         /g4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790963880; x=1791568680;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DuOJRxzEd2+FACdWVRDk//utgfeiIB44ZaTLC0WonWg=;
        b=LnHiHtmX0ic6cc/UrbSQCpIxsdqTm+wVzdIdAlS5yUva0/mKdmzxZboKMwNipAxhDr
         bsIDJFuhTfAYQ3o/L1EXAIkx0QgIvmvA8zkgpsAJd6TG4QPf/ORR12zHOpkfFktQLWfZ
         4BVMXndfD3oxQW0ma5WIcK1RS9VgU4o7BzBVsEEyz329zRJCS7a7uyk7vdD7p3bXFMp5
         99JT1H4ZwhFYtODa15EU9Qi1AO0RK0//tCJ+gU1QPo+NWSOiV116U+SBODMRSNa+ikTk
         wFgyGUZNp+BWvEydmFf5X4pqbpPv2gm1TQ8MikSXu1WjL1+VlQRlogjp2rql8eJwQzYI
         Eyhw==
X-Forwarded-Encrypted: i=1; AKwUvByRYVcLIs4xwazT3pzK6R87vkCRfkPbzsE4/IZ8/KBEHXs2SOagcdDulYlWONcTl+rWl1wPNm2JcXlk8J0lVx2B@vger.kernel.org
X-Gm-Message-State: AFuF++n/RUQBYfJw+MZXi8bq60V19D5S3HfKMtINN6GkUYx2bo+jGPwT
	Ky1uANJqqCj9VIuL48NKk2tlu8Y7WqwdhCjnp1nl6KIxe14KIX1sl1toqEesE3+vZq0grpJSxiE
	M1rqlPy45ag==
X-Received: from dlbti5.prod.google.com ([2002:a05:7022:1b05:b0:14d:d7f0:5394])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2906:b0:14d:c23e:c931
 with SMTP id a92af1059eb24-14f5b9fb5d0mr3499492c88.10.1790963878977; Fri, 02
 Oct 2026 10:57:58 -0700 (PDT)
Date: Fri,  2 Oct 2026 10:57:36 -0700
In-Reply-To: <20261002175738.3242646-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261002175738.3242646-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261002175738.3242646-4-irogers@google.com>
Subject: [PATCH v14 3/3] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support
From: Ian Rogers <irogers@google.com>
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	bcm-kernel-feedback-list@broadcom.com, 
	Kernel Maintenance <kernel-list@raspberrypi.com>, 
	"=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=" <ukleinek@kernel.org>, Peter Robinson <pbrobinson@gmail.com>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Extend the Raspberry Pi AXI PMU driver to support the Broadcom BCM2712
architecture used in the Raspberry Pi 5.

The BCM2712 SoC drops the legacy VideoCore VPU monitor and exposes a
unified System monitor via MMIO mapping distinctly different hardware
pipelines (such as DISPLAY_TOP, ARGON_TOP, BSTM_TOP, PCIE_01, and XPT)
and expanded 6-bit AXI master ID filter tables.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/perf/Kconfig       |   2 +-
 drivers/perf/rpi_axi_pmu.c | 470 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 469 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 0ead13195a57..af1b2359d234 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -333,7 +333,7 @@ config RPI_AXI_PMU
 	help
 	  Enable support for the Raspberry Pi AXI Performance Monitor.
 	  This provides access to the System and VideoCore performance
-	  counters on Broadcom BCM2835 and BCM2711 platforms.
+	  counters on Broadcom BCM2835, BCM2711, and BCM2712 platforms.
 
 	  Expect 100ms ping latencies to the VideoCore firmware mailbox
 	  when reading counters on these platforms.
diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
index 3dc0131ab450..eecd3073c158 100644
--- a/drivers/perf/rpi_axi_pmu.c
+++ b/drivers/perf/rpi_axi_pmu.c
@@ -6,12 +6,13 @@
  * This driver exposes the performance monitoring hardware on Raspberry Pi
  * System-on-Chips to the Linux perf subsystem:
  * - Raspberry Pi 1, 2, 3, 4, Compute Modules 1-4, Zero, Zero W (SoCs BCM2835/2836/2837/2711).
+ * - Raspberry Pi 5, Compute Module 5 (SoC BCM2712).
  *
  * Architecture Overview:
  * ----------------------
  * The Broadcom AXI performance hardware provides up to two independent monitors:
  * 1. System Monitor (MON_SYSTEM = 0):
- *    Monitors system-level AXI traffic (ARM CPU L2/UC, DMA, V3D, ISP, HVS).
+ *    Monitors system-level AXI traffic (ARM CPU L2/UC, DMA, V3D, ISP, HVS, PCIe/RP1).
  *    Directly memory-mapped via ARM physical IO memory space (MMIO).
  *    Read latency: ~10-20 nanoseconds (fast, atomic-safe, non-blocking).
  *
@@ -19,6 +20,7 @@
  *    Monitors VideoCore VPU buses (VPU0/1 Data/Instruction L2/UC, SDRAM, etc.).
  *    Accessible through VideoCore firmware mailbox IPC (RPI_FIRMWARE_SET/GET_PERIPH_REG).
  *    Read latency: ~10-100 microseconds (IPC over VPU mailbox).
+ *    On BCM2712 (RPi 5), only the System Monitor is exposed via MMIO.
  *
  * Synchronization & Concurrency Model:
  * ------------------------------------
@@ -60,10 +62,12 @@
  * enum rpi_axi_chip - Supported Broadcom SoC generations
  * @CHIP_BCM2835: BCM2835 / BCM2836 / BCM2837 (RPi 1-3, CM 1-3, Zero/W)
  * @CHIP_BCM2711: BCM2711 (RPi 4, CM 4)
+ * @CHIP_BCM2712: BCM2712 (RPi 5, CM 5)
  */
 enum rpi_axi_chip {
 	CHIP_BCM2835 = 0,
 	CHIP_BCM2711,
+	CHIP_BCM2712,
 };
 
 /**
@@ -121,6 +125,40 @@ enum bcm2835_system_bus {
 	BCM2835_SB_MAX,
 };
 
+/**
+ * enum bcm2712_system_bus - AXI buses monitored by System Monitor on BCM2712 (RPi 5)
+ * @BCM2712_SB_VPU_UC: VPU Uncached memory bus
+ * @BCM2712_SB_DISPLAY_TOP: Display top-level engine bus
+ * @BCM2712_SB_V3D: VideoCore VII 3D graphics hardware pipeline bus
+ * @BCM2712_SB_ARM: ARM cores subsystem bus
+ * @BCM2712_SB_XPT: Cross-Point (XPT) fabric bus
+ * @BCM2712_SB_BSTM_TOP: BSTM Top bus
+ * @BCM2712_SB_PCIE_01: PCIe 0/1 bus
+ * @BCM2712_SB_ARGON_TOP: Argon Top bus
+ * @BCM2712_SB_ARB3: ARB3 bus
+ * @BCM2712_SB_SRC: SRC bus
+ * @BCM2712_SB_HVDP: HVDP bus
+ * @BCM2712_SB_PER: Peripheral bus
+ * @BCM2712_SB_SYSTEM_L2: System L2 Cache bus
+ * @BCM2712_SB_MAX: Total count of monitored system buses on BCM2712
+ */
+enum bcm2712_system_bus {
+	BCM2712_SB_VPU_UC = 0,
+	BCM2712_SB_DISPLAY_TOP = 1,
+	BCM2712_SB_V3D = 2,
+	BCM2712_SB_ARM = 3,
+	BCM2712_SB_XPT = 4,
+	BCM2712_SB_BSTM_TOP = 5,
+	BCM2712_SB_PCIE_01 = 6,
+	BCM2712_SB_ARGON_TOP = 7,
+	BCM2712_SB_ARB3 = 8,
+	BCM2712_SB_SRC = 9,
+	BCM2712_SB_HVDP = 10,
+	BCM2712_SB_PER = 11,
+	BCM2712_SB_SYSTEM_L2 = 12,
+	BCM2712_SB_MAX,
+};
+
 /**
  * enum bcm2835_vpu_bus - AXI buses monitored by VPU Monitor on BCM2835 (RPi 1-3)
  * @BCM2835_VB_VPU1_D_L2: VideoCore VPU Core 1 Data L2 cache bus
@@ -403,6 +441,116 @@ enum bcm2711_filter {
 	BCM2711_FLT_MAX,
 };
 
+/**
+ * enum bcm2712_filter - AXI master ID filter options for BCM2712 (RPi 5)
+ * @BCM2712_FLT_0: Disable master ID filtering (monitor all traffic on bus)
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
+ * @BCM2712_FLT_ARGON: Argon master ID
+ * @BCM2712_FLT_UNICAM: Unicam master ID
+ * @BCM2712_FLT_PISP: ISP master ID
+ * @BCM2712_FLT_PISPFE: ISP Front End master ID
+ * @BCM2712_FLT_JPEG: JPEG decoder master ID
+ * @BCM2712_FLT_EMMC1: SD/eMMC 1 master ID
+ * @BCM2712_FLT_EMMC2: SD/eMMC 2 master ID
+ * @BCM2712_FLT_TRC: TRC master ID
+ * @BCM2712_FLT_BSTM0: BSTM0 master ID
+ * @BCM2712_FLT_BSTM1: BSTM1 master ID
+ * @BCM2712_FLT_BSTM0_SEC: BSTM0 Secure master ID
+ * @BCM2712_FLT_BSTM1_SEC: BSTM1 Secure master ID
+ * @BCM2712_FLT_AIO: AIO master ID
+ * @BCM2712_FLT_MAP: MAP master ID
+ * @BCM2712_FLT_SYS_DMA: System DMA master ID
+ * @BCM2712_FLT_MMUCACHE0: MMU Cache 0 master ID
+ * @BCM2712_FLT_MMUCACHE1: MMU Cache 1 master ID
+ * @BCM2712_FLT_MPUCACHE0: MPU Cache 0 master ID
+ * @BCM2712_FLT_MPUCACHE1: MPU Cache 1 master ID
+ * @BCM2712_FLT_MAX: Maximum filter ID count for BCM2712
+ */
+enum bcm2712_filter {
+	BCM2712_FLT_0 = 0,
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
+	BCM2712_FLT_ARGON = 32,
+	BCM2712_FLT_UNICAM = 33,
+	BCM2712_FLT_PISP = 34,
+	BCM2712_FLT_PISPFE = 35,
+	BCM2712_FLT_JPEG = 36,
+	BCM2712_FLT_EMMC1 = 37,
+	BCM2712_FLT_EMMC2 = 38,
+	BCM2712_FLT_TRC = 39,
+	BCM2712_FLT_BSTM0 = 40,
+	BCM2712_FLT_BSTM1 = 41,
+	BCM2712_FLT_BSTM0_SEC = 42,
+	BCM2712_FLT_BSTM1_SEC = 43,
+	BCM2712_FLT_AIO = 44,
+	BCM2712_FLT_MAP = 45,
+	BCM2712_FLT_SYS_DMA = 46,
+	BCM2712_FLT_MMUCACHE0 = 47,
+	BCM2712_FLT_MMUCACHE1 = 48,
+	BCM2712_FLT_MPUCACHE0 = 49,
+	BCM2712_FLT_MPUCACHE1 = 50,
+	BCM2712_FLT_MAX,
+};
+
 /* Hardware register offsets & control bitwise constants */
 #define GEN_CTRL			0x00
 #define GEN_CTL_ENABLE_BIT		BIT(0)
@@ -684,6 +832,14 @@ static bool config_is_valid(struct rpi_axi_pmu *pmu, __u64 config)
 		if (filter >= BCM2711_FLT_MAX)
 			return false;
 		break;
+	case CHIP_BCM2712:
+		if (mon == MON_SYSTEM && bus >= BCM2712_SB_MAX)
+			return false;
+		if (mon == MON_VPU)
+			return false;
+		if (filter >= BCM2712_FLT_MAX)
+			return false;
+		break;
 	}
 
 	return counter < CNT_MAX;
@@ -2020,6 +2176,301 @@ static const struct attribute_group rpi_axi_pmu_bcm2711_events_group = {
 	.attrs = bcm2711_events,
 };
 
+PMU_EVENT_ATTR_STRING(vpu_uc_atwait, bcm2712_vpu_uc_atwait, "monitor=0,bus=0,counter=0");
+PMU_EVENT_ATTR_STRING(vpu_uc_atrans, bcm2712_vpu_uc_atrans, "monitor=0,bus=0,counter=1");
+PMU_EVENT_ATTR_STRING(vpu_uc_amax, bcm2712_vpu_uc_amax, "monitor=0,bus=0,counter=2");
+PMU_EVENT_ATTR_STRING(vpu_uc_wwait, bcm2712_vpu_uc_wwait, "monitor=0,bus=0,counter=3");
+PMU_EVENT_ATTR_STRING(vpu_uc_wtrans, bcm2712_vpu_uc_wtrans, "monitor=0,bus=0,counter=4");
+PMU_EVENT_ATTR_STRING(vpu_uc_wmax, bcm2712_vpu_uc_wmax, "monitor=0,bus=0,counter=5");
+PMU_EVENT_ATTR_STRING(vpu_uc_rwait, bcm2712_vpu_uc_rwait, "monitor=0,bus=0,counter=6");
+PMU_EVENT_ATTR_STRING(vpu_uc_rtrans, bcm2712_vpu_uc_rtrans, "monitor=0,bus=0,counter=7");
+PMU_EVENT_ATTR_STRING(vpu_uc_rmax, bcm2712_vpu_uc_rmax, "monitor=0,bus=0,counter=8");
+PMU_EVENT_ATTR_STRING(vpu_uc_rpend, bcm2712_vpu_uc_rpend, "monitor=0,bus=0,counter=9");
+PMU_EVENT_ATTR_STRING(vpu_uc_ratrans, bcm2712_vpu_uc_ratrans, "monitor=0,bus=0,counter=10");
+PMU_EVENT_ATTR_STRING(display_top_atwait, bcm2712_display_top_atwait, "monitor=0,bus=1,counter=0");
+PMU_EVENT_ATTR_STRING(display_top_atrans, bcm2712_display_top_atrans, "monitor=0,bus=1,counter=1");
+PMU_EVENT_ATTR_STRING(display_top_amax, bcm2712_display_top_amax, "monitor=0,bus=1,counter=2");
+PMU_EVENT_ATTR_STRING(display_top_wwait, bcm2712_display_top_wwait, "monitor=0,bus=1,counter=3");
+PMU_EVENT_ATTR_STRING(display_top_wtrans, bcm2712_display_top_wtrans, "monitor=0,bus=1,counter=4");
+PMU_EVENT_ATTR_STRING(display_top_wmax, bcm2712_display_top_wmax, "monitor=0,bus=1,counter=5");
+PMU_EVENT_ATTR_STRING(display_top_rwait, bcm2712_display_top_rwait, "monitor=0,bus=1,counter=6");
+PMU_EVENT_ATTR_STRING(display_top_rtrans, bcm2712_display_top_rtrans, "monitor=0,bus=1,counter=7");
+PMU_EVENT_ATTR_STRING(display_top_rmax, bcm2712_display_top_rmax, "monitor=0,bus=1,counter=8");
+PMU_EVENT_ATTR_STRING(display_top_rpend, bcm2712_display_top_rpend, "monitor=0,bus=1,counter=9");
+PMU_EVENT_ATTR_STRING(display_top_ratrans, bcm2712_display_top_ratrans, "monitor=0,bus=1,counter=10");
+PMU_EVENT_ATTR_STRING(v3d_atwait, bcm2712_v3d_atwait, "monitor=0,bus=2,counter=0");
+PMU_EVENT_ATTR_STRING(v3d_atrans, bcm2712_v3d_atrans, "monitor=0,bus=2,counter=1");
+PMU_EVENT_ATTR_STRING(v3d_amax, bcm2712_v3d_amax, "monitor=0,bus=2,counter=2");
+PMU_EVENT_ATTR_STRING(v3d_wwait, bcm2712_v3d_wwait, "monitor=0,bus=2,counter=3");
+PMU_EVENT_ATTR_STRING(v3d_wtrans, bcm2712_v3d_wtrans, "monitor=0,bus=2,counter=4");
+PMU_EVENT_ATTR_STRING(v3d_wmax, bcm2712_v3d_wmax, "monitor=0,bus=2,counter=5");
+PMU_EVENT_ATTR_STRING(v3d_rwait, bcm2712_v3d_rwait, "monitor=0,bus=2,counter=6");
+PMU_EVENT_ATTR_STRING(v3d_rtrans, bcm2712_v3d_rtrans, "monitor=0,bus=2,counter=7");
+PMU_EVENT_ATTR_STRING(v3d_rmax, bcm2712_v3d_rmax, "monitor=0,bus=2,counter=8");
+PMU_EVENT_ATTR_STRING(v3d_rpend, bcm2712_v3d_rpend, "monitor=0,bus=2,counter=9");
+PMU_EVENT_ATTR_STRING(v3d_ratrans, bcm2712_v3d_ratrans, "monitor=0,bus=2,counter=10");
+PMU_EVENT_ATTR_STRING(arm_atwait, bcm2712_arm_atwait, "monitor=0,bus=3,counter=0");
+PMU_EVENT_ATTR_STRING(arm_atrans, bcm2712_arm_atrans, "monitor=0,bus=3,counter=1");
+PMU_EVENT_ATTR_STRING(arm_amax, bcm2712_arm_amax, "monitor=0,bus=3,counter=2");
+PMU_EVENT_ATTR_STRING(arm_wwait, bcm2712_arm_wwait, "monitor=0,bus=3,counter=3");
+PMU_EVENT_ATTR_STRING(arm_wtrans, bcm2712_arm_wtrans, "monitor=0,bus=3,counter=4");
+PMU_EVENT_ATTR_STRING(arm_wmax, bcm2712_arm_wmax, "monitor=0,bus=3,counter=5");
+PMU_EVENT_ATTR_STRING(arm_rwait, bcm2712_arm_rwait, "monitor=0,bus=3,counter=6");
+PMU_EVENT_ATTR_STRING(arm_rtrans, bcm2712_arm_rtrans, "monitor=0,bus=3,counter=7");
+PMU_EVENT_ATTR_STRING(arm_rmax, bcm2712_arm_rmax, "monitor=0,bus=3,counter=8");
+PMU_EVENT_ATTR_STRING(arm_rpend, bcm2712_arm_rpend, "monitor=0,bus=3,counter=9");
+PMU_EVENT_ATTR_STRING(arm_ratrans, bcm2712_arm_ratrans, "monitor=0,bus=3,counter=10");
+PMU_EVENT_ATTR_STRING(xpt_atwait, bcm2712_xpt_atwait, "monitor=0,bus=4,counter=0");
+PMU_EVENT_ATTR_STRING(xpt_atrans, bcm2712_xpt_atrans, "monitor=0,bus=4,counter=1");
+PMU_EVENT_ATTR_STRING(xpt_amax, bcm2712_xpt_amax, "monitor=0,bus=4,counter=2");
+PMU_EVENT_ATTR_STRING(xpt_wwait, bcm2712_xpt_wwait, "monitor=0,bus=4,counter=3");
+PMU_EVENT_ATTR_STRING(xpt_wtrans, bcm2712_xpt_wtrans, "monitor=0,bus=4,counter=4");
+PMU_EVENT_ATTR_STRING(xpt_wmax, bcm2712_xpt_wmax, "monitor=0,bus=4,counter=5");
+PMU_EVENT_ATTR_STRING(xpt_rwait, bcm2712_xpt_rwait, "monitor=0,bus=4,counter=6");
+PMU_EVENT_ATTR_STRING(xpt_rtrans, bcm2712_xpt_rtrans, "monitor=0,bus=4,counter=7");
+PMU_EVENT_ATTR_STRING(xpt_rmax, bcm2712_xpt_rmax, "monitor=0,bus=4,counter=8");
+PMU_EVENT_ATTR_STRING(xpt_rpend, bcm2712_xpt_rpend, "monitor=0,bus=4,counter=9");
+PMU_EVENT_ATTR_STRING(xpt_ratrans, bcm2712_xpt_ratrans, "monitor=0,bus=4,counter=10");
+PMU_EVENT_ATTR_STRING(bstm_top_atwait, bcm2712_bstm_top_atwait, "monitor=0,bus=5,counter=0");
+PMU_EVENT_ATTR_STRING(bstm_top_atrans, bcm2712_bstm_top_atrans, "monitor=0,bus=5,counter=1");
+PMU_EVENT_ATTR_STRING(bstm_top_amax, bcm2712_bstm_top_amax, "monitor=0,bus=5,counter=2");
+PMU_EVENT_ATTR_STRING(bstm_top_wwait, bcm2712_bstm_top_wwait, "monitor=0,bus=5,counter=3");
+PMU_EVENT_ATTR_STRING(bstm_top_wtrans, bcm2712_bstm_top_wtrans, "monitor=0,bus=5,counter=4");
+PMU_EVENT_ATTR_STRING(bstm_top_wmax, bcm2712_bstm_top_wmax, "monitor=0,bus=5,counter=5");
+PMU_EVENT_ATTR_STRING(bstm_top_rwait, bcm2712_bstm_top_rwait, "monitor=0,bus=5,counter=6");
+PMU_EVENT_ATTR_STRING(bstm_top_rtrans, bcm2712_bstm_top_rtrans, "monitor=0,bus=5,counter=7");
+PMU_EVENT_ATTR_STRING(bstm_top_rmax, bcm2712_bstm_top_rmax, "monitor=0,bus=5,counter=8");
+PMU_EVENT_ATTR_STRING(bstm_top_rpend, bcm2712_bstm_top_rpend, "monitor=0,bus=5,counter=9");
+PMU_EVENT_ATTR_STRING(bstm_top_ratrans, bcm2712_bstm_top_ratrans, "monitor=0,bus=5,counter=10");
+PMU_EVENT_ATTR_STRING(pcie_01_atwait, bcm2712_pcie_01_atwait, "monitor=0,bus=6,counter=0");
+PMU_EVENT_ATTR_STRING(pcie_01_atrans, bcm2712_pcie_01_atrans, "monitor=0,bus=6,counter=1");
+PMU_EVENT_ATTR_STRING(pcie_01_amax, bcm2712_pcie_01_amax, "monitor=0,bus=6,counter=2");
+PMU_EVENT_ATTR_STRING(pcie_01_wwait, bcm2712_pcie_01_wwait, "monitor=0,bus=6,counter=3");
+PMU_EVENT_ATTR_STRING(pcie_01_wtrans, bcm2712_pcie_01_wtrans, "monitor=0,bus=6,counter=4");
+PMU_EVENT_ATTR_STRING(pcie_01_wmax, bcm2712_pcie_01_wmax, "monitor=0,bus=6,counter=5");
+PMU_EVENT_ATTR_STRING(pcie_01_rwait, bcm2712_pcie_01_rwait, "monitor=0,bus=6,counter=6");
+PMU_EVENT_ATTR_STRING(pcie_01_rtrans, bcm2712_pcie_01_rtrans, "monitor=0,bus=6,counter=7");
+PMU_EVENT_ATTR_STRING(pcie_01_rmax, bcm2712_pcie_01_rmax, "monitor=0,bus=6,counter=8");
+PMU_EVENT_ATTR_STRING(pcie_01_rpend, bcm2712_pcie_01_rpend, "monitor=0,bus=6,counter=9");
+PMU_EVENT_ATTR_STRING(pcie_01_ratrans, bcm2712_pcie_01_ratrans, "monitor=0,bus=6,counter=10");
+PMU_EVENT_ATTR_STRING(argon_top_atwait, bcm2712_argon_top_atwait, "monitor=0,bus=7,counter=0");
+PMU_EVENT_ATTR_STRING(argon_top_atrans, bcm2712_argon_top_atrans, "monitor=0,bus=7,counter=1");
+PMU_EVENT_ATTR_STRING(argon_top_amax, bcm2712_argon_top_amax, "monitor=0,bus=7,counter=2");
+PMU_EVENT_ATTR_STRING(argon_top_wwait, bcm2712_argon_top_wwait, "monitor=0,bus=7,counter=3");
+PMU_EVENT_ATTR_STRING(argon_top_wtrans, bcm2712_argon_top_wtrans, "monitor=0,bus=7,counter=4");
+PMU_EVENT_ATTR_STRING(argon_top_wmax, bcm2712_argon_top_wmax, "monitor=0,bus=7,counter=5");
+PMU_EVENT_ATTR_STRING(argon_top_rwait, bcm2712_argon_top_rwait, "monitor=0,bus=7,counter=6");
+PMU_EVENT_ATTR_STRING(argon_top_rtrans, bcm2712_argon_top_rtrans, "monitor=0,bus=7,counter=7");
+PMU_EVENT_ATTR_STRING(argon_top_rmax, bcm2712_argon_top_rmax, "monitor=0,bus=7,counter=8");
+PMU_EVENT_ATTR_STRING(argon_top_rpend, bcm2712_argon_top_rpend, "monitor=0,bus=7,counter=9");
+PMU_EVENT_ATTR_STRING(argon_top_ratrans, bcm2712_argon_top_ratrans, "monitor=0,bus=7,counter=10");
+PMU_EVENT_ATTR_STRING(arb3_atwait, bcm2712_arb3_atwait, "monitor=0,bus=8,counter=0");
+PMU_EVENT_ATTR_STRING(arb3_atrans, bcm2712_arb3_atrans, "monitor=0,bus=8,counter=1");
+PMU_EVENT_ATTR_STRING(arb3_amax, bcm2712_arb3_amax, "monitor=0,bus=8,counter=2");
+PMU_EVENT_ATTR_STRING(arb3_wwait, bcm2712_arb3_wwait, "monitor=0,bus=8,counter=3");
+PMU_EVENT_ATTR_STRING(arb3_wtrans, bcm2712_arb3_wtrans, "monitor=0,bus=8,counter=4");
+PMU_EVENT_ATTR_STRING(arb3_wmax, bcm2712_arb3_wmax, "monitor=0,bus=8,counter=5");
+PMU_EVENT_ATTR_STRING(arb3_rwait, bcm2712_arb3_rwait, "monitor=0,bus=8,counter=6");
+PMU_EVENT_ATTR_STRING(arb3_rtrans, bcm2712_arb3_rtrans, "monitor=0,bus=8,counter=7");
+PMU_EVENT_ATTR_STRING(arb3_rmax, bcm2712_arb3_rmax, "monitor=0,bus=8,counter=8");
+PMU_EVENT_ATTR_STRING(arb3_rpend, bcm2712_arb3_rpend, "monitor=0,bus=8,counter=9");
+PMU_EVENT_ATTR_STRING(arb3_ratrans, bcm2712_arb3_ratrans, "monitor=0,bus=8,counter=10");
+PMU_EVENT_ATTR_STRING(src_atwait, bcm2712_src_atwait, "monitor=0,bus=9,counter=0");
+PMU_EVENT_ATTR_STRING(src_atrans, bcm2712_src_atrans, "monitor=0,bus=9,counter=1");
+PMU_EVENT_ATTR_STRING(src_amax, bcm2712_src_amax, "monitor=0,bus=9,counter=2");
+PMU_EVENT_ATTR_STRING(src_wwait, bcm2712_src_wwait, "monitor=0,bus=9,counter=3");
+PMU_EVENT_ATTR_STRING(src_wtrans, bcm2712_src_wtrans, "monitor=0,bus=9,counter=4");
+PMU_EVENT_ATTR_STRING(src_wmax, bcm2712_src_wmax, "monitor=0,bus=9,counter=5");
+PMU_EVENT_ATTR_STRING(src_rwait, bcm2712_src_rwait, "monitor=0,bus=9,counter=6");
+PMU_EVENT_ATTR_STRING(src_rtrans, bcm2712_src_rtrans, "monitor=0,bus=9,counter=7");
+PMU_EVENT_ATTR_STRING(src_rmax, bcm2712_src_rmax, "monitor=0,bus=9,counter=8");
+PMU_EVENT_ATTR_STRING(src_rpend, bcm2712_src_rpend, "monitor=0,bus=9,counter=9");
+PMU_EVENT_ATTR_STRING(src_ratrans, bcm2712_src_ratrans, "monitor=0,bus=9,counter=10");
+PMU_EVENT_ATTR_STRING(hvdp_atwait, bcm2712_hvdp_atwait, "monitor=0,bus=10,counter=0");
+PMU_EVENT_ATTR_STRING(hvdp_atrans, bcm2712_hvdp_atrans, "monitor=0,bus=10,counter=1");
+PMU_EVENT_ATTR_STRING(hvdp_amax, bcm2712_hvdp_amax, "monitor=0,bus=10,counter=2");
+PMU_EVENT_ATTR_STRING(hvdp_wwait, bcm2712_hvdp_wwait, "monitor=0,bus=10,counter=3");
+PMU_EVENT_ATTR_STRING(hvdp_wtrans, bcm2712_hvdp_wtrans, "monitor=0,bus=10,counter=4");
+PMU_EVENT_ATTR_STRING(hvdp_wmax, bcm2712_hvdp_wmax, "monitor=0,bus=10,counter=5");
+PMU_EVENT_ATTR_STRING(hvdp_rwait, bcm2712_hvdp_rwait, "monitor=0,bus=10,counter=6");
+PMU_EVENT_ATTR_STRING(hvdp_rtrans, bcm2712_hvdp_rtrans, "monitor=0,bus=10,counter=7");
+PMU_EVENT_ATTR_STRING(hvdp_rmax, bcm2712_hvdp_rmax, "monitor=0,bus=10,counter=8");
+PMU_EVENT_ATTR_STRING(hvdp_rpend, bcm2712_hvdp_rpend, "monitor=0,bus=10,counter=9");
+PMU_EVENT_ATTR_STRING(hvdp_ratrans, bcm2712_hvdp_ratrans, "monitor=0,bus=10,counter=10");
+PMU_EVENT_ATTR_STRING(per_atwait, bcm2712_per_atwait, "monitor=0,bus=11,counter=0");
+PMU_EVENT_ATTR_STRING(per_atrans, bcm2712_per_atrans, "monitor=0,bus=11,counter=1");
+PMU_EVENT_ATTR_STRING(per_amax, bcm2712_per_amax, "monitor=0,bus=11,counter=2");
+PMU_EVENT_ATTR_STRING(per_wwait, bcm2712_per_wwait, "monitor=0,bus=11,counter=3");
+PMU_EVENT_ATTR_STRING(per_wtrans, bcm2712_per_wtrans, "monitor=0,bus=11,counter=4");
+PMU_EVENT_ATTR_STRING(per_wmax, bcm2712_per_wmax, "monitor=0,bus=11,counter=5");
+PMU_EVENT_ATTR_STRING(per_rwait, bcm2712_per_rwait, "monitor=0,bus=11,counter=6");
+PMU_EVENT_ATTR_STRING(per_rtrans, bcm2712_per_rtrans, "monitor=0,bus=11,counter=7");
+PMU_EVENT_ATTR_STRING(per_rmax, bcm2712_per_rmax, "monitor=0,bus=11,counter=8");
+PMU_EVENT_ATTR_STRING(per_rpend, bcm2712_per_rpend, "monitor=0,bus=11,counter=9");
+PMU_EVENT_ATTR_STRING(per_ratrans, bcm2712_per_ratrans, "monitor=0,bus=11,counter=10");
+PMU_EVENT_ATTR_STRING(system_l2_atwait, bcm2712_system_l2_atwait, "monitor=0,bus=12,counter=0");
+PMU_EVENT_ATTR_STRING(system_l2_atrans, bcm2712_system_l2_atrans, "monitor=0,bus=12,counter=1");
+PMU_EVENT_ATTR_STRING(system_l2_amax, bcm2712_system_l2_amax, "monitor=0,bus=12,counter=2");
+PMU_EVENT_ATTR_STRING(system_l2_wwait, bcm2712_system_l2_wwait, "monitor=0,bus=12,counter=3");
+PMU_EVENT_ATTR_STRING(system_l2_wtrans, bcm2712_system_l2_wtrans, "monitor=0,bus=12,counter=4");
+PMU_EVENT_ATTR_STRING(system_l2_wmax, bcm2712_system_l2_wmax, "monitor=0,bus=12,counter=5");
+PMU_EVENT_ATTR_STRING(system_l2_rwait, bcm2712_system_l2_rwait, "monitor=0,bus=12,counter=6");
+PMU_EVENT_ATTR_STRING(system_l2_rtrans, bcm2712_system_l2_rtrans, "monitor=0,bus=12,counter=7");
+PMU_EVENT_ATTR_STRING(system_l2_rmax, bcm2712_system_l2_rmax, "monitor=0,bus=12,counter=8");
+PMU_EVENT_ATTR_STRING(system_l2_rpend, bcm2712_system_l2_rpend, "monitor=0,bus=12,counter=9");
+PMU_EVENT_ATTR_STRING(system_l2_ratrans, bcm2712_system_l2_ratrans, "monitor=0,bus=12,counter=10");
+static struct attribute *bcm2712_events[] = {
+	&bcm2712_vpu_uc_atwait.attr.attr,
+	&bcm2712_vpu_uc_atrans.attr.attr,
+	&bcm2712_vpu_uc_amax.attr.attr,
+	&bcm2712_vpu_uc_wwait.attr.attr,
+	&bcm2712_vpu_uc_wtrans.attr.attr,
+	&bcm2712_vpu_uc_wmax.attr.attr,
+	&bcm2712_vpu_uc_rwait.attr.attr,
+	&bcm2712_vpu_uc_rtrans.attr.attr,
+	&bcm2712_vpu_uc_rmax.attr.attr,
+	&bcm2712_vpu_uc_rpend.attr.attr,
+	&bcm2712_vpu_uc_ratrans.attr.attr,
+	&bcm2712_display_top_atwait.attr.attr,
+	&bcm2712_display_top_atrans.attr.attr,
+	&bcm2712_display_top_amax.attr.attr,
+	&bcm2712_display_top_wwait.attr.attr,
+	&bcm2712_display_top_wtrans.attr.attr,
+	&bcm2712_display_top_wmax.attr.attr,
+	&bcm2712_display_top_rwait.attr.attr,
+	&bcm2712_display_top_rtrans.attr.attr,
+	&bcm2712_display_top_rmax.attr.attr,
+	&bcm2712_display_top_rpend.attr.attr,
+	&bcm2712_display_top_ratrans.attr.attr,
+	&bcm2712_v3d_atwait.attr.attr,
+	&bcm2712_v3d_atrans.attr.attr,
+	&bcm2712_v3d_amax.attr.attr,
+	&bcm2712_v3d_wwait.attr.attr,
+	&bcm2712_v3d_wtrans.attr.attr,
+	&bcm2712_v3d_wmax.attr.attr,
+	&bcm2712_v3d_rwait.attr.attr,
+	&bcm2712_v3d_rtrans.attr.attr,
+	&bcm2712_v3d_rmax.attr.attr,
+	&bcm2712_v3d_rpend.attr.attr,
+	&bcm2712_v3d_ratrans.attr.attr,
+	&bcm2712_arm_atwait.attr.attr,
+	&bcm2712_arm_atrans.attr.attr,
+	&bcm2712_arm_amax.attr.attr,
+	&bcm2712_arm_wwait.attr.attr,
+	&bcm2712_arm_wtrans.attr.attr,
+	&bcm2712_arm_wmax.attr.attr,
+	&bcm2712_arm_rwait.attr.attr,
+	&bcm2712_arm_rtrans.attr.attr,
+	&bcm2712_arm_rmax.attr.attr,
+	&bcm2712_arm_rpend.attr.attr,
+	&bcm2712_arm_ratrans.attr.attr,
+	&bcm2712_xpt_atwait.attr.attr,
+	&bcm2712_xpt_atrans.attr.attr,
+	&bcm2712_xpt_amax.attr.attr,
+	&bcm2712_xpt_wwait.attr.attr,
+	&bcm2712_xpt_wtrans.attr.attr,
+	&bcm2712_xpt_wmax.attr.attr,
+	&bcm2712_xpt_rwait.attr.attr,
+	&bcm2712_xpt_rtrans.attr.attr,
+	&bcm2712_xpt_rmax.attr.attr,
+	&bcm2712_xpt_rpend.attr.attr,
+	&bcm2712_xpt_ratrans.attr.attr,
+	&bcm2712_bstm_top_atwait.attr.attr,
+	&bcm2712_bstm_top_atrans.attr.attr,
+	&bcm2712_bstm_top_amax.attr.attr,
+	&bcm2712_bstm_top_wwait.attr.attr,
+	&bcm2712_bstm_top_wtrans.attr.attr,
+	&bcm2712_bstm_top_wmax.attr.attr,
+	&bcm2712_bstm_top_rwait.attr.attr,
+	&bcm2712_bstm_top_rtrans.attr.attr,
+	&bcm2712_bstm_top_rmax.attr.attr,
+	&bcm2712_bstm_top_rpend.attr.attr,
+	&bcm2712_bstm_top_ratrans.attr.attr,
+	&bcm2712_pcie_01_atwait.attr.attr,
+	&bcm2712_pcie_01_atrans.attr.attr,
+	&bcm2712_pcie_01_amax.attr.attr,
+	&bcm2712_pcie_01_wwait.attr.attr,
+	&bcm2712_pcie_01_wtrans.attr.attr,
+	&bcm2712_pcie_01_wmax.attr.attr,
+	&bcm2712_pcie_01_rwait.attr.attr,
+	&bcm2712_pcie_01_rtrans.attr.attr,
+	&bcm2712_pcie_01_rmax.attr.attr,
+	&bcm2712_pcie_01_rpend.attr.attr,
+	&bcm2712_pcie_01_ratrans.attr.attr,
+	&bcm2712_argon_top_atwait.attr.attr,
+	&bcm2712_argon_top_atrans.attr.attr,
+	&bcm2712_argon_top_amax.attr.attr,
+	&bcm2712_argon_top_wwait.attr.attr,
+	&bcm2712_argon_top_wtrans.attr.attr,
+	&bcm2712_argon_top_wmax.attr.attr,
+	&bcm2712_argon_top_rwait.attr.attr,
+	&bcm2712_argon_top_rtrans.attr.attr,
+	&bcm2712_argon_top_rmax.attr.attr,
+	&bcm2712_argon_top_rpend.attr.attr,
+	&bcm2712_argon_top_ratrans.attr.attr,
+	&bcm2712_arb3_atwait.attr.attr,
+	&bcm2712_arb3_atrans.attr.attr,
+	&bcm2712_arb3_amax.attr.attr,
+	&bcm2712_arb3_wwait.attr.attr,
+	&bcm2712_arb3_wtrans.attr.attr,
+	&bcm2712_arb3_wmax.attr.attr,
+	&bcm2712_arb3_rwait.attr.attr,
+	&bcm2712_arb3_rtrans.attr.attr,
+	&bcm2712_arb3_rmax.attr.attr,
+	&bcm2712_arb3_rpend.attr.attr,
+	&bcm2712_arb3_ratrans.attr.attr,
+	&bcm2712_src_atwait.attr.attr,
+	&bcm2712_src_atrans.attr.attr,
+	&bcm2712_src_amax.attr.attr,
+	&bcm2712_src_wwait.attr.attr,
+	&bcm2712_src_wtrans.attr.attr,
+	&bcm2712_src_wmax.attr.attr,
+	&bcm2712_src_rwait.attr.attr,
+	&bcm2712_src_rtrans.attr.attr,
+	&bcm2712_src_rmax.attr.attr,
+	&bcm2712_src_rpend.attr.attr,
+	&bcm2712_src_ratrans.attr.attr,
+	&bcm2712_hvdp_atwait.attr.attr,
+	&bcm2712_hvdp_atrans.attr.attr,
+	&bcm2712_hvdp_amax.attr.attr,
+	&bcm2712_hvdp_wwait.attr.attr,
+	&bcm2712_hvdp_wtrans.attr.attr,
+	&bcm2712_hvdp_wmax.attr.attr,
+	&bcm2712_hvdp_rwait.attr.attr,
+	&bcm2712_hvdp_rtrans.attr.attr,
+	&bcm2712_hvdp_rmax.attr.attr,
+	&bcm2712_hvdp_rpend.attr.attr,
+	&bcm2712_hvdp_ratrans.attr.attr,
+	&bcm2712_per_atwait.attr.attr,
+	&bcm2712_per_atrans.attr.attr,
+	&bcm2712_per_amax.attr.attr,
+	&bcm2712_per_wwait.attr.attr,
+	&bcm2712_per_wtrans.attr.attr,
+	&bcm2712_per_wmax.attr.attr,
+	&bcm2712_per_rwait.attr.attr,
+	&bcm2712_per_rtrans.attr.attr,
+	&bcm2712_per_rmax.attr.attr,
+	&bcm2712_per_rpend.attr.attr,
+	&bcm2712_per_ratrans.attr.attr,
+	&bcm2712_system_l2_atwait.attr.attr,
+	&bcm2712_system_l2_atrans.attr.attr,
+	&bcm2712_system_l2_amax.attr.attr,
+	&bcm2712_system_l2_wwait.attr.attr,
+	&bcm2712_system_l2_wtrans.attr.attr,
+	&bcm2712_system_l2_wmax.attr.attr,
+	&bcm2712_system_l2_rwait.attr.attr,
+	&bcm2712_system_l2_rtrans.attr.attr,
+	&bcm2712_system_l2_rmax.attr.attr,
+	&bcm2712_system_l2_rpend.attr.attr,
+	&bcm2712_system_l2_ratrans.attr.attr,
+	NULL,
+};
+
+static const struct attribute_group rpi_axi_pmu_bcm2712_events_group = {
+	.name = "events",
+	.attrs = bcm2712_events,
+};
+
 static const struct attribute_group *rpi_axi_pmu_bcm2835_attr_groups[] = {
 	&rpi_axi_pmu_format_group,
 	&rpi_axi_pmu_bcm2835_events_group,
@@ -2034,6 +2485,13 @@ static const struct attribute_group *rpi_axi_pmu_bcm2711_attr_groups[] = {
 	NULL,
 };
 
+static const struct attribute_group *rpi_axi_pmu_bcm2712_attr_groups[] = {
+	&rpi_axi_pmu_format_group,
+	&rpi_axi_pmu_bcm2712_events_group,
+	&rpi_axi_pmu_cpumask_group,
+	NULL,
+};
+
 /**
  * rpi_axi_pmu__validate_event() - Validates single event resource capability
  * @pmu: Pointer to core PMU struct
@@ -2760,6 +3218,8 @@ static int rpi_axi_pmu__init(struct rpi_axi_pmu *pmu, struct platform_device *pd
 
 	for (int i = 0; i < MON_MAX; i++) {
 		rpi_axi_hw_events__init(&pmu->monitor[i].hw_events);
+		if (pmu->chip == CHIP_BCM2712 && i == MON_VPU)
+			continue;
 		if (pmu->monitor[i].use_mailbox_interface) {
 			int addr_cells = of_n_addr_cells(dev->of_node);
 			int size_cells = of_n_size_cells(dev->of_node);
@@ -2792,7 +3252,9 @@ static int rpi_axi_pmu__init(struct rpi_axi_pmu *pmu, struct platform_device *pd
 		goto err_teardown;
 	}
 
-	if (pmu->chip == CHIP_BCM2711)
+	if (pmu->chip == CHIP_BCM2712)
+		pmu->pmu.attr_groups = (const struct attribute_group **)rpi_axi_pmu_bcm2712_attr_groups;
+	else if (pmu->chip == CHIP_BCM2711)
 		pmu->pmu.attr_groups = (const struct attribute_group **)rpi_axi_pmu_bcm2711_attr_groups;
 	else
 		pmu->pmu.attr_groups = (const struct attribute_group **)rpi_axi_pmu_bcm2835_attr_groups;
@@ -2878,6 +3340,10 @@ static const struct of_device_id rpi_axi_pmu_match[] = {
 		.compatible = "brcm,bcm2711-axiperf",
 		.data = (void *)CHIP_BCM2711,
 	},
+	{
+		.compatible = "brcm,bcm2712-axiperf",
+		.data = (void *)CHIP_BCM2712,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rpi_axi_pmu_match);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

