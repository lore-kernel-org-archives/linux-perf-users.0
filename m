Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C8F3803EF
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Aug 2026 04:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786595744; cv=none; b=jmDklPqG+zL/OklanNRF5j0ofRWc9RX3L4YUet2YQj+XIGo+9iCq+DeBIPV+IrmjtVv818VxfV8gkybg2a/5m570DeFwjS7SJoSXcrQGSmbGC8tEblxobhDpRbDOPBznMLGijHumTWMdiwRHftoXewgV7NAZ/lySpRe9zHTU7Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786595744; c=relaxed/simple;
	bh=bmkL/TNQCZzsT/qrNuIICgZvTdOClwrKa4/orcoKLx4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mJER51fUfYhP/68jBsfznJ5eVhv89h2eGA97TzB4bzRQNxl/aWN0L1wr4nQkhaYi9xgqT2SI/VG/+p+1F1gjmR+ZixC5wTRUjJ7+t8kxPNCWyfg/hTOUdYKWjbfjTQyp6sjPSkRTDmqoGCqyUze0m44wq2aP2adnCBE27gm3TO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jREeUY66; arc=none smtp.client-ip=209.85.215.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jREeUY66"
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cb7d6ba548eso1908692a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 21:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786595740; x=1787200540; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vi6pmQRSoSSoYX6fDs7+Q3vw4/qRlgra1PI6yFSmRvI=;
        b=jREeUY66+evj4cAqc8bSZLsWmIYlqe0Wq0S6HWjS8UPwHU1J+hda6Wzh7dQhWmHCmM
         M7/C33+FLe2IKtXjoKZ3HsCsWDzEV5YcWDjW2wzQ1wxqupVwFIgLoOOdRHMm/GaVTLx+
         PGi0cUQQk36erJzSU8Fd5GaeKV+2pwn4mHx85eV6xkzV/Q6BW8bVlR23HgyOcVVHrbC+
         VZNNl8FVWSxFwHP3z3CL/gCHM/pIsYU77eCSq55xmyBCzzA+jQ/zUlYfQvxsaOWKFVR1
         hjdEEMytCBF+t0G8ae/YyELUA57/febaNpXoT1jOFSZ2UXXjE3UDx/GN0G5aU8v8JMiK
         M9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786595740; x=1787200540;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vi6pmQRSoSSoYX6fDs7+Q3vw4/qRlgra1PI6yFSmRvI=;
        b=BiNDhLg58gk2bIqdAa7Kg5EDzunOa2ow5fkYUIrKbgRn9Kzzo2BpcDk5VLrO7NrMzr
         BCRsFz5sojpnb5r+WHr26Sjp8l+RBZgxlHZEQo+MEqkjfcuIsK2ObmayuhugOqnQ4pcp
         VhsJfYReet2bNOBXDRbSscvdFIhUTaqDLXfns0fa9G9nBD6vYwf3ewImq3ruCb0DYnkX
         XndSPV8GLRAAA5xWQkTSaB/Wp7lXeMI3+nd871WgfjhWrqiUwzxIapJpAokxBJoBgdoB
         FO6P8jld+a41xwY6cSaXrNkBzfbjX5Hry6K6z9fUFCLn+PVP9buNu6P89fa3wuUeAtlH
         edNw==
X-Forwarded-Encrypted: i=1; AHgh+RohMclxZnL+EDHfWjSygPfhvS1prIQAS++AsGLZtv3DyqlPspwbpEYKW/IbeLO41X/qgr8y5Tfh02jAxnXINXNi@vger.kernel.org
X-Gm-Message-State: AOJu0YxopvOlJ2/0g+BclnbMAPuZtNKY8EFS+3zi4l6B/FHzA+Bv3csM
	Frwke6T+U2spci320MnHYr9HtRZIhObzRqF+4lfTDkGCa2fPhw7SRgbCpBqIJyOwNm8bvKDKkOD
	RdjivCBrAfQ==
X-Received: from dlbsi12.prod.google.com ([2002:a05:7022:b88c:b0:13f:9a34:1f84])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:408a:b0:3a0:bc61:62e6
 with SMTP id adf61e73a8af0-3cc55062a03mr4398242637.8.1786595740299; Wed, 12
 Aug 2026 21:35:40 -0700 (PDT)
Date: Wed, 12 Aug 2026 21:35:33 -0700
In-Reply-To: <20260813043533.2744442-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812230145.2644281-1-irogers@google.com> <20260813043533.2744442-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813043533.2744442-3-irogers@google.com>
Subject: [PATCH v6 2/2] perf: Add Raspberry Pi 5 (BCM2712) AXI PMU support
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mark.rutland@arm.com, u.kleine-koenig@baylibre.com, will@kernel.org
Content-Type: text/plain; charset="UTF-8"

Expand the Raspberry Pi AXI PMU driver to support Broadcom BCM2712
(Raspberry Pi 5) system monitors, PCIe RP1 Southbridge links, HEVC decoder,
and Cortex-A76 DSU L3 interconnects.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 drivers/perf/rpi_axi_pmu.c | 120 +++++++++++++++++++++++++++++++++++--
 1 file changed, 115 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/rpi_axi_pmu.c b/drivers/perf/rpi_axi_pmu.c
index f7e5520d02eb..4c1b19c6cc2e 100644
--- a/drivers/perf/rpi_axi_pmu.c
+++ b/drivers/perf/rpi_axi_pmu.c
@@ -867,19 +867,45 @@ PMU_EVENT_ATTR_STRING(usb_system_l2_wtrans, rpi_axi_pmu_event_usb_system_l2_wtra
 /* --- RASPBERRY PI 5 (BCM2712) EXPANDED EVENT ALIASES ---------------------- */
 
 /* PCIe 2.0 x4 RP1 Southbridge Link Bus Events & Stall Wait Cycles (bus=6, BCM2712_SB__PCIE_RP1) */
+PMU_EVENT_ATTR_STRING(pcie_rp1_atrans,        rpi_axi_pmu_event_pcie_rp1_atrans,        "monitor=0,bus=6,counter=0");
+PMU_EVENT_ATTR_STRING(pcie_rp1_atwait,        rpi_axi_pmu_event_pcie_rp1_atwait,        "monitor=0,bus=6,counter=1");
+PMU_EVENT_ATTR_STRING(pcie_rp1_wtrans,        rpi_axi_pmu_event_pcie_rp1_wtrans,        "monitor=0,bus=6,counter=2");
+PMU_EVENT_ATTR_STRING(pcie_rp1_wtwait,        rpi_axi_pmu_event_pcie_rp1_wtwait,        "monitor=0,bus=6,counter=3");
+PMU_EVENT_ATTR_STRING(pcie_rp1_rtrans,        rpi_axi_pmu_event_pcie_rp1_rtrans,        "monitor=0,bus=6,counter=4");
+PMU_EVENT_ATTR_STRING(pcie_rp1_rtwait,        rpi_axi_pmu_event_pcie_rp1_rtwait,        "monitor=0,bus=6,counter=5");
 
 /* HEVC (H.265) Hardware Video Decoder Bus Events (bus=7, BCM2712_SB__HEVC_DEC) */
+PMU_EVENT_ATTR_STRING(hevc_dec_atrans,        rpi_axi_pmu_event_hevc_dec_atrans,        "monitor=0,bus=7,counter=0");
+PMU_EVENT_ATTR_STRING(hevc_dec_wtrans,        rpi_axi_pmu_event_hevc_dec_wtrans,        "monitor=0,bus=7,counter=2");
+PMU_EVENT_ATTR_STRING(hevc_dec_rtrans,        rpi_axi_pmu_event_hevc_dec_rtrans,        "monitor=0,bus=7,counter=4");
 
 /* Arm Cortex-A76 DSU L3 Interconnect Bus Events (bus=8, BCM2712_SB__A76_DSU_L3) */
+PMU_EVENT_ATTR_STRING(a76_dsu_l3_atrans,      rpi_axi_pmu_event_a76_dsu_l3_atrans,      "monitor=0,bus=8,counter=0");
+PMU_EVENT_ATTR_STRING(a76_dsu_l3_wtrans,      rpi_axi_pmu_event_a76_dsu_l3_wtrans,      "monitor=0,bus=8,counter=2");
+PMU_EVENT_ATTR_STRING(a76_dsu_l3_rtrans,      rpi_axi_pmu_event_a76_dsu_l3_rtrans,      "monitor=0,bus=8,counter=4");
 
 /* VideoCore VII 3D Graphics Pipeline Bus Events (bus=10, BCM2712_SB__V3D7) */
+PMU_EVENT_ATTR_STRING(v3d7_atrans,            rpi_axi_pmu_event_v3d7_atrans,            "monitor=0,bus=10,counter=0");
+PMU_EVENT_ATTR_STRING(v3d7_wtrans,            rpi_axi_pmu_event_v3d7_wtrans,            "monitor=0,bus=10,counter=2");
+PMU_EVENT_ATTR_STRING(v3d7_rtrans,            rpi_axi_pmu_event_v3d7_rtrans,            "monitor=0,bus=10,counter=4");
 
 /*
  * Quad-Core Arm Cortex-A76 Cores 0-3 I-Cache & D-Cache Filtered Events
  * (bus=14, BCM2712_SB__CPU_L2)
  */
+PMU_EVENT_ATTR_STRING(bcm2712_peripheral_rtrans, rpi_axi_pmu_event_bcm2712_peripheral_rtrans, "monitor=0,bus=12,counter=4");
+PMU_EVENT_ATTR_STRING(bcm2712_peripheral_wtrans, rpi_axi_pmu_event_bcm2712_peripheral_wtrans, "monitor=0,bus=12,counter=2");
+PMU_EVENT_ATTR_STRING(bcm2712_cpu_uc_rtrans,     rpi_axi_pmu_event_bcm2712_cpu_uc_rtrans,     "monitor=0,bus=13,counter=4");
+PMU_EVENT_ATTR_STRING(bcm2712_cpu_uc_wtrans,     rpi_axi_pmu_event_bcm2712_cpu_uc_wtrans,     "monitor=0,bus=13,counter=2");
 
 /* BCM2712 Master ID Filtered Events */
+PMU_EVENT_ATTR_STRING(arm_rtrans,              rpi_axi_pmu_event_arm_rtrans,              "monitor=0,bus=14,counter=4,filter=10");
+PMU_EVENT_ATTR_STRING(arm_wtrans,              rpi_axi_pmu_event_arm_wtrans,              "monitor=0,bus=14,counter=2,filter=10");
+PMU_EVENT_ATTR_STRING(pcie0_rtrans,            rpi_axi_pmu_event_pcie0_rtrans,            "monitor=0,bus=6,counter=4,filter=15");
+PMU_EVENT_ATTR_STRING(pcie0_wtrans,            rpi_axi_pmu_event_pcie0_wtrans,            "monitor=0,bus=6,counter=2,filter=15");
+PMU_EVENT_ATTR_STRING(hvs_filtered_rtrans,     rpi_axi_pmu_event_hvs_filtered_rtrans,     "monitor=0,bus=9,counter=4,filter=22");
+PMU_EVENT_ATTR_STRING(emmc0_rtrans,            rpi_axi_pmu_event_emmc0_rtrans,            "monitor=0,bus=5,counter=4,filter=29");
+PMU_EVENT_ATTR_STRING(emmc0_wtrans,            rpi_axi_pmu_event_emmc0_wtrans,            "monitor=0,bus=5,counter=2,filter=29");
 
 static struct attribute *rpi_axi_pmu_events_attrs[] = {
 	/* System Monitor events */
@@ -1039,11 +1065,37 @@ static struct attribute *rpi_axi_pmu_events_attrs[] = {
 	&rpi_axi_pmu_event_usb_system_l2_wtrans.attr.attr,
 
 	/* RPi 5 (BCM2712) Expanded Event Aliases */
-
-
-
-
-
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
 
@@ -1059,10 +1111,64 @@ static struct attribute *rpi_axi_pmu_events_attrs[] = {
  *
  * Return: attr->mode (0444) if visible on current SoC, 0 to hide.
  */
+static umode_t rpi_axi_pmu_events_is_visible(struct kobject *kobj,
+					      struct attribute *attr, int unused)
+{
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
+	return attr->mode;
+}
 
 static const struct attribute_group rpi_axi_pmu_events_group = {
 	.name = "events",
 	.attrs = rpi_axi_pmu_events_attrs,
+	.is_visible = rpi_axi_pmu_events_is_visible,
 };
 
 /**
@@ -1954,6 +2060,10 @@ static const struct of_device_id rpi_axi_pmu_match[] = {
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

