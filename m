Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305102C15AF;
	Wed, 29 Oct 2025 21:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761773790; cv=none; b=UOIWU7cBVcnoa5Aj93E+oHdfsn7fuuo3PWpeHNw3LuWtSwhqHOW9CydFYrdTLsv2aCho43sgX8YJp0fpAlRwdAjo2LUoS1cNk3e8FtvaN3DFZXGpUTeAmJjhh7jcMOhhG9IX2BEZ5SMfYdr21IjvMeb65dsoeAvpCRp59Uno3vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761773790; c=relaxed/simple;
	bh=SiQp/ENWkBUhBR+c2XqLQgeyJNHs792zr2aN4XdNGHE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dPXVLtvU8jfohhFf3nm4gwcnZ6o2yf2cl8CuLEkGdsFspGi3eGM8pzr2eahDLdaKNAyhYjqf+k7tGQmP+a/EHAeQrbzDJEbDfQYQiksMREVVSILNWOH22oxnUmAfEI2shVFDEaUiCXEpDH+OkeONEaeGBZhvn/qQYYU9TW93USY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aG682G4e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG682G4e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE6EC4CEF7;
	Wed, 29 Oct 2025 21:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761773789;
	bh=SiQp/ENWkBUhBR+c2XqLQgeyJNHs792zr2aN4XdNGHE=;
	h=From:To:Cc:Subject:Date:From;
	b=aG682G4eIx2YeqDN/1oPrX6Dj4JDv2Zq4TRlmE4BDRS/AVIo4r2ZUTnTyaOF6Q5FW
	 FGatbLm1AZsVzl4SKpo7n8H/kCnn5dmOs4iVBAxowhunzP1D8IqMUos7bXre+2TKHR
	 LTD0NtXwzvsio8jdcOmJgoqfEtTNWO6ZD0eOODUFRs9bdE3tEGXsAywK7fqM5XY6Ot
	 M0TjKi34Tawfrk7fRbQEHkWIDzr50GwofXzs2r6Rf1UoodVuuxceDVLzv7SneN1tBo
	 TwthmEk28egzmGvujnyRm6Jj15APKMUSauN6KNGRgvtqbzbJayaUDbpGCXm3M92GLK
	 JDcOXUo6bguNQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf: arm_pmuv3: Add new Cortex and C1 CPU PMUs
Date: Wed, 29 Oct 2025 16:34:24 -0500
Message-ID: <20251029213424.2951519-2-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add CPU PMU compatible strings for Cortex-A320, Cortex-A520AE,
Cortex-A720AE, and C1 Nano/Premium/Pro/Ultra.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
The bindings landed in 6.18, but I forgot the driver side needs 
updating...

 drivers/perf/arm_pmuv3.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 69c5cc8f5606..64457b7f4013 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1465,6 +1465,10 @@ static int name##_pmu_init(struct arm_pmu *cpu_pmu)			\
 
 PMUV3_INIT_SIMPLE(armv8_pmuv3)
 
+PMUV3_INIT_SIMPLE(armv8_c1_nano)
+PMUV3_INIT_SIMPLE(armv8_c1_premium)
+PMUV3_INIT_SIMPLE(armv8_c1_pro)
+PMUV3_INIT_SIMPLE(armv8_c1_ultra)
 PMUV3_INIT_SIMPLE(armv8_cortex_a34)
 PMUV3_INIT_SIMPLE(armv8_cortex_a55)
 PMUV3_INIT_SIMPLE(armv8_cortex_a65)
@@ -1472,11 +1476,14 @@ PMUV3_INIT_SIMPLE(armv8_cortex_a75)
 PMUV3_INIT_SIMPLE(armv8_cortex_a76)
 PMUV3_INIT_SIMPLE(armv8_cortex_a77)
 PMUV3_INIT_SIMPLE(armv8_cortex_a78)
+PMUV3_INIT_SIMPLE(armv9_cortex_a320)
 PMUV3_INIT_SIMPLE(armv9_cortex_a510)
 PMUV3_INIT_SIMPLE(armv9_cortex_a520)
+PMUV3_INIT_SIMPLE(armv9_cortex_a520ae)
 PMUV3_INIT_SIMPLE(armv9_cortex_a710)
 PMUV3_INIT_SIMPLE(armv9_cortex_a715)
 PMUV3_INIT_SIMPLE(armv9_cortex_a720)
+PMUV3_INIT_SIMPLE(armv9_cortex_a720ae)
 PMUV3_INIT_SIMPLE(armv9_cortex_a725)
 PMUV3_INIT_SIMPLE(armv8_cortex_x1)
 PMUV3_INIT_SIMPLE(armv9_cortex_x2)
@@ -1508,6 +1515,10 @@ PMUV3_INIT_MAP_EVENT(armv8_brcm_vulcan, armv8_vulcan_map_event)
 
 static const struct of_device_id armv8_pmu_of_device_ids[] = {
 	{.compatible = "arm,armv8-pmuv3",	.data = armv8_pmuv3_pmu_init},
+	{.compatible = "arm,c1-nano-pmu",	.data = armv8_c1_nano_pmu_init},
+	{.compatible = "arm,c1-premium-pmu",	.data = armv8_c1_premium_pmu_init},
+	{.compatible = "arm,c1-pro-pmu",	.data = armv8_c1_pro_pmu_init},
+	{.compatible = "arm,c1-ultra-pmu",	.data = armv8_c1_ultra_pmu_init},
 	{.compatible = "arm,cortex-a34-pmu",	.data = armv8_cortex_a34_pmu_init},
 	{.compatible = "arm,cortex-a35-pmu",	.data = armv8_cortex_a35_pmu_init},
 	{.compatible = "arm,cortex-a53-pmu",	.data = armv8_cortex_a53_pmu_init},
@@ -1520,11 +1531,14 @@ static const struct of_device_id armv8_pmu_of_device_ids[] = {
 	{.compatible = "arm,cortex-a76-pmu",	.data = armv8_cortex_a76_pmu_init},
 	{.compatible = "arm,cortex-a77-pmu",	.data = armv8_cortex_a77_pmu_init},
 	{.compatible = "arm,cortex-a78-pmu",	.data = armv8_cortex_a78_pmu_init},
+	{.compatible = "arm,cortex-a320-pmu",	.data = armv9_cortex_a320_pmu_init},
 	{.compatible = "arm,cortex-a510-pmu",	.data = armv9_cortex_a510_pmu_init},
 	{.compatible = "arm,cortex-a520-pmu",	.data = armv9_cortex_a520_pmu_init},
+	{.compatible = "arm,cortex-a520ae-pmu",	.data = armv9_cortex_a520ae_pmu_init},
 	{.compatible = "arm,cortex-a710-pmu",	.data = armv9_cortex_a710_pmu_init},
 	{.compatible = "arm,cortex-a715-pmu",	.data = armv9_cortex_a715_pmu_init},
 	{.compatible = "arm,cortex-a720-pmu",	.data = armv9_cortex_a720_pmu_init},
+	{.compatible = "arm,cortex-a720ae-pmu",	.data = armv9_cortex_a720ae_pmu_init},
 	{.compatible = "arm,cortex-a725-pmu",	.data = armv9_cortex_a725_pmu_init},
 	{.compatible = "arm,cortex-x1-pmu",	.data = armv8_cortex_x1_pmu_init},
 	{.compatible = "arm,cortex-x2-pmu",	.data = armv9_cortex_x2_pmu_init},
-- 
2.51.0

