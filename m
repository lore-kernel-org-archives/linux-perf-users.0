Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB77233722;
	Mon, 23 Jun 2025 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671001; cv=none; b=DBzdGqASlas4401QN7fEGHul/lEm47gOqxFtw2JHAns29uOWJrs1julwzomEEF8Z5/UeLVHllMP6FDXgw8vXtE/+jZIluWf9hAFyCe/n8nGs+ZsIoHUV0pUqa4Cnnl92v7DX6QBBnviq0R1bvbnrg4QUoy4va6ueOElNHx6+kA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671001; c=relaxed/simple;
	bh=WR2nn99oRtkTnSZ2SlyuWLFzELsSDiZdzTX63mcOHA8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=YkzSGv9kxO+V6y4lBSQYPMXdO3PWFSjl+7Iqq7EqYTjHCc1jPehrPetxxlwE6bECNSfcs26l8/rHQCcLXPN7lGdFZNXGqtaH+L1+7fpyEYMmb/kPqLpkDo2SmyKCfd9gpWpc2UkbOabEneh4NRbna8t9vblIbOC+lhIVNSFanso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=bNwUveSW; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="bNwUveSW"
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N8swqj011088;
	Mon, 23 Jun 2025 11:29:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=pfOir4ecl8ee1I6IoTA4SW
	3MSW1FhLPJ2AAoMv1lBVo=; b=bNwUveSWYjtHQBMM1/hOzqx9Bp3NwBCqXHAS17
	u2MrUumsYbWgSla4q2Tr4pGCMTEgkVYf0RGA7w5gRYirFmSJPVDAA2+BhN+LnIB7
	A/8hxo/dpj0CWns3PcmKSI+nmua27t8nSThbmPScY/mSgmUA60s/uocEu0XAnM30
	aQdmyQs5HQnxzvKEJD2RTdHmfpgbLf2uzC4nmXHamdn+Eh8BKuPVXZEnm+x9r0GN
	Co6WwTrVngV20SkVlI3WqjpYhQkBNhods3Sv6G7BngPq0RfMsa5xVK2+J37dLDmQ
	3gXRBC4rndYYEM2vbEd33SCdg9PizR/HG/NzPuW+jw9rJ88w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 47e6a6cjpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Jun 2025 11:29:39 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 25F6640049;
	Mon, 23 Jun 2025 11:28:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C65DE562948;
	Mon, 23 Jun 2025 11:27:20 +0200 (CEST)
Received: from localhost (10.252.18.29) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:27:20 +0200
From: =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
Subject: [PATCH 00/13] Introduce STM32 DDR PMU for STM32MP platforms
Date: Mon, 23 Jun 2025 11:27:05 +0200
Message-ID: <20250623-ddrperfm-upstream-v1-0-7dffff168090@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOkdWWgC/x3MQQqAIBBA0avErBNMMKGrRAvLsWahyVgRiHdPW
 r7F/wUyMmGGqSvA+FCmMzYMfQfbYeOOglwzKKm01GoUznFC9kHcKV+MNojVS+O1MUY7C61LjJ7
 e/zkvtX6z1g3LYwAAAA==
X-Change-ID: 20250526-ddrperfm-upstream-bf07f57775da
To: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel
	<p.zabel@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Gatien Chevallier
	<gatien.chevallier@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Gabriel Fernandez
	<gabriel.fernandez@foss.st.com>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-perf-users@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        =?utf-8?q?Cl=C3=A9ment_Le_Goffic?= <clement.legoffic@foss.st.com>
X-Mailer: b4 0.15-dev-c25d1
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01

This patch series introduces the DDR Performance Monitor (DDRPERFM) support for
STM32MP platforms.

The series firstly improves the STM32MP25 RCC driver to make it usable
as an access controller, needed for driver probe.

It also includes the addition of device tree bindings, the HDP driver,
documentation and updates to the device tree files for
STM32MP13, STM32MP15 and STM32MP25 SoCs.
The series also updates the MAINTAINERS file to include myself as the
maintainer for the STM32 DDR PMU driver.

Signed-off-by: Clément Le Goffic <clement.legoffic@foss.st.com>
---
Clément Le Goffic (13):
      bus: firewall: move stm32_firewall header file in include folder
      dt-bindings: stm32: stm32mp25: add `access-controller-cell` property
      clk: stm32mp25: add firewall grant_access ops
      arm64: dts: st: set rcc as an access-controller
      dt-bindings: perf: stm32: introduce DDRPERFM dt-bindings
      perf: stm32: introduce DDRPERFM driver
      Documentation: perf: stm32: add ddrperfm support
      MAINTAINERS: add myself as STM32 DDR PMU maintainer
      ARM: dts: stm32: add ddrperfm on stm32mp131
      ARM: dts: stm32: add ddrperfm on stm32mp151
      arm64: dts: st: add ddrperfm on stm32mp251
      arm64: dts: st: support ddrperfm on stm32mp257f-dk
      arm64: dts: st: support ddrperfm on stm32mp257f-ev1

 Documentation/admin-guide/perf/index.rst           |   1 +
 Documentation/admin-guide/perf/stm32-ddr-pmu.rst   |  86 ++
 .../bindings/clock/st,stm32mp25-rcc.yaml           |   6 +
 .../devicetree/bindings/perf/st,stm32-ddr-pmu.yaml |  93 +++
 MAINTAINERS                                        |   7 +
 arch/arm/boot/dts/st/stm32mp131.dtsi               |   7 +
 arch/arm/boot/dts/st/stm32mp151.dtsi               |   7 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi             |   8 +
 arch/arm64/boot/dts/st/stm32mp257f-dk.dts          |   5 +
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts         |   5 +
 drivers/bus/stm32_etzpc.c                          |   3 +-
 drivers/bus/stm32_firewall.c                       |   3 +-
 drivers/bus/stm32_rifsc.c                          |   3 +-
 drivers/clk/stm32/clk-stm32mp25.c                  |  40 +-
 drivers/perf/Kconfig                               |  11 +
 drivers/perf/Makefile                              |   1 +
 drivers/perf/stm32_ddr_pmu.c                       | 893 +++++++++++++++++++++
 {drivers => include/linux}/bus/stm32_firewall.h    |   0
 18 files changed, 1172 insertions(+), 7 deletions(-)
---
base-commit: 86731a2a651e58953fc949573895f2fa6d456841
change-id: 20250526-ddrperfm-upstream-bf07f57775da

Best regards,
-- 
Clément Le Goffic <clement.legoffic@foss.st.com>

